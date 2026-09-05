package vn.iotstar.controller.auth;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.OtpModel;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;
import vn.iotstar.util.EmailUtil;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/verify-otp", "/resend-otp"})
public class VerifyOtpController extends HttpServlet {
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/resend-otp".equals(path)) {
            resendOtp(req, resp);
            return;
        }

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute(Constant.SESSION_OTP) == null) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }

        req.getRequestDispatcher(Constant.Path.VERIFY_OTP).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute(Constant.SESSION_OTP) == null) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }

        OtpModel otpModel = (OtpModel) session.getAttribute(Constant.SESSION_OTP);
        String inputOtp = req.getParameter("otp");
        if (inputOtp != null) {
            inputOtp = inputOtp.trim();
        }

        if (otpModel.isExpired()) {
            req.setAttribute("alert", "Mã OTP đã hết hiệu lực (quá 5 phút). Vui lòng bấm gửi lại mã OTP mới.");
            req.getRequestDispatcher(Constant.Path.VERIFY_OTP).forward(req, resp);
            return;
        }

        if (inputOtp == null || !inputOtp.equals(otpModel.getOtp())) {
            req.setAttribute("alert", "Mã OTP không chính xác. Vui lòng kiểm tra lại mã đã nhận.");
            req.getRequestDispatcher(Constant.Path.VERIFY_OTP).forward(req, resp);
            return;
        }

        if ("REGISTER".equals(otpModel.getType()) && otpModel.getPendingUser() != null) {
            userService.insert(otpModel.getPendingUser());
            session.removeAttribute(Constant.SESSION_OTP);
            resp.sendRedirect(req.getContextPath() + "/login?activated=1");
        } else {
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    private void resendOtp(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute(Constant.SESSION_OTP) != null) {
            OtpModel otpModel = (OtpModel) session.getAttribute(Constant.SESSION_OTP);
            String newOtp = EmailUtil.generateOtp();

            if ("REGISTER".equals(otpModel.getType())
                    && EmailUtil.sendOtpEmail(otpModel.getEmail(), newOtp, "Gửi lại mã OTP kích hoạt tài khoản")) {
                otpModel.setOtp(newOtp);
                otpModel.setExpireTime(System.currentTimeMillis() + (5 * 60 * 1000));
                session.setAttribute(Constant.SESSION_OTP, otpModel);
                session.setAttribute("otpResentMessage", "Mã OTP mới đã được gửi đến địa chỉ đã đăng ký.");
            } else {
                session.setAttribute("otpResentMessage", "Không thể gửi lại mã OTP. Vui lòng thử lại sau.");
            }
        }
        resp.sendRedirect(req.getContextPath() + "/verify-otp");
    }
}
