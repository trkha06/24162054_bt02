package vn.iotstar.controller.auth;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.OtpModel;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;
import vn.iotstar.util.EmailUtil;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/forgot-password", "/reset-password", "/resend-forgot-otp"})
public class ForgotPasswordController extends HttpServlet {
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/resend-forgot-otp".equals(path)) {
            resendForgotOtp(req, resp);
            return;
        }

        if ("/reset-password".equals(path)) {
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute(Constant.SESSION_OTP) == null) {
                resp.sendRedirect(req.getContextPath() + "/forgot-password");
                return;
            }
            req.getRequestDispatcher(Constant.Path.RESET_PASSWORD).forward(req, resp);
            return;
        }

        req.getRequestDispatcher(Constant.Path.FORGOT_PASSWORD).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String path = req.getServletPath();
        if ("/reset-password".equals(path)) {
            handleResetPassword(req, resp);
        } else {
            handleForgotPassword(req, resp);
        }
    }

    private void handleForgotPassword(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String accountInput = req.getParameter("account");
        if (accountInput == null || accountInput.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập tên tài khoản hoặc email.");
            req.getRequestDispatcher(Constant.Path.FORGOT_PASSWORD).forward(req, resp);
            return;
        }

        accountInput = accountInput.trim();
        User user = userService.get(accountInput);
        if (user == null) {
            user = userService.findByEmail(accountInput);
        }

        if (user == null) {
            req.setAttribute("alert", "Không tìm thấy tài khoản với thông tin đã cung cấp.");
            req.getRequestDispatcher(Constant.Path.FORGOT_PASSWORD).forward(req, resp);
            return;
        }

        String userEmail = user.getEmail();
        if (userEmail == null || userEmail.isBlank() || !EmailUtil.isValidEmail(userEmail)) {
            req.setAttribute("alert", "Tài khoản chưa có email hợp lệ để nhận mã xác thực OTP.");
            req.getRequestDispatcher(Constant.Path.FORGOT_PASSWORD).forward(req, resp);
            return;
        }

        String otp = EmailUtil.generateOtp();
        long expireTime = System.currentTimeMillis() + (5 * 60 * 1000);
        OtpModel otpModel = new OtpModel(userEmail, otp, expireTime, "FORGOT_PASSWORD", user);

        if (!EmailUtil.sendOtpEmail(userEmail, otp, "Mã OTP khôi phục mật khẩu tài khoản")) {
            req.setAttribute("alert", "Không thể gửi mã OTP. Vui lòng kiểm tra cấu hình email của hệ thống và thử lại.");
            req.getRequestDispatcher(Constant.Path.FORGOT_PASSWORD).forward(req, resp);
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute(Constant.SESSION_OTP, otpModel);

        resp.sendRedirect(req.getContextPath() + "/reset-password");
    }

    private void handleResetPassword(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute(Constant.SESSION_OTP) == null) {
            resp.sendRedirect(req.getContextPath() + "/forgot-password");
            return;
        }

        OtpModel otpModel = (OtpModel) session.getAttribute(Constant.SESSION_OTP);
        if (!"FORGOT_PASSWORD".equals(otpModel.getType())) {
            resp.sendRedirect(req.getContextPath() + "/forgot-password");
            return;
        }
        String inputOtp = req.getParameter("otp");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (inputOtp != null) {
            inputOtp = inputOtp.trim();
        }

        if (otpModel.isExpired()) {
            req.setAttribute("alert", "Mã OTP đã hết hiệu lực. Vui lòng yêu cầu lại mã mới.");
            req.getRequestDispatcher(Constant.Path.RESET_PASSWORD).forward(req, resp);
            return;
        }

        if (inputOtp == null || !inputOtp.equals(otpModel.getOtp())) {
            req.setAttribute("alert", "Mã OTP không chính xác. Vui lòng kiểm tra lại mã đã nhận.");
            req.getRequestDispatcher(Constant.Path.RESET_PASSWORD).forward(req, resp);
            return;
        }

        if (newPassword == null || newPassword.isBlank() || confirmPassword == null || confirmPassword.isBlank()) {
            req.setAttribute("alert", "Vui lòng nhập đầy đủ mật khẩu mới.");
            req.getRequestDispatcher(Constant.Path.RESET_PASSWORD).forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("alert", "Xác nhận mật khẩu mới không trùng khớp.");
            req.getRequestDispatcher(Constant.Path.RESET_PASSWORD).forward(req, resp);
            return;
        }

        userService.updatePassword(otpModel.getEmail(), newPassword);
        session.removeAttribute(Constant.SESSION_OTP);

        resp.sendRedirect(req.getContextPath() + "/login?resetSuccess=1");
    }

    private void resendForgotOtp(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute(Constant.SESSION_OTP) != null) {
            OtpModel otpModel = (OtpModel) session.getAttribute(Constant.SESSION_OTP);
            String newOtp = EmailUtil.generateOtp();

            if ("FORGOT_PASSWORD".equals(otpModel.getType())
                    && EmailUtil.sendOtpEmail(otpModel.getEmail(), newOtp, "Gửi lại mã OTP khôi phục mật khẩu")) {
                otpModel.setOtp(newOtp);
                otpModel.setExpireTime(System.currentTimeMillis() + (5 * 60 * 1000));
                session.setAttribute(Constant.SESSION_OTP, otpModel);
                session.setAttribute("otpResentMessage", "Mã OTP mới đã được gửi lại đến địa chỉ đã đăng ký.");
            } else {
                session.setAttribute("otpResentMessage", "Không thể gửi lại mã OTP. Vui lòng thử lại sau.");
            }
        }
        resp.sendRedirect(req.getContextPath() + "/reset-password");
    }
}
