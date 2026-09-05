package vn.iotstar.controller.auth;

import java.io.IOException;
import java.sql.Date;
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
@WebServlet(urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {
    private final UserService service = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute(Constant.SESSION_ACCOUNT) != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }
        req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        username = username == null ? "" : username.trim();
        email = email == null ? "" : email.trim();
        fullname = fullname == null ? "" : fullname.trim();
        phone = phone == null ? "" : phone.trim();

        if (username.isEmpty() || password == null || password.isBlank()
                || email.isEmpty() || fullname.isEmpty() || phone.isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập đầy đủ thông tin đăng ký.");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        if (!EmailUtil.isValidEmail(email)) {
            req.setAttribute("alert", "Địa chỉ email không đúng định dạng hợp lệ (vd: user@example.com)!");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        if (service.checkExistEmail(email)) {
            req.setAttribute("alert", "Email đã tồn tại trong hệ thống!");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        if (service.checkExistUsername(username)) {
            req.setAttribute("alert", "Tài khoản (username) đã tồn tại!");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        if (service.checkExistPhone(phone)) {
            req.setAttribute("alert", "Số điện thoại đã tồn tại!");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        String otp = EmailUtil.generateOtp();
        long expireTime = System.currentTimeMillis() + (5 * 60 * 1000);
        User pendingUser = new User(email, username, fullname, password, null, 5, phone, new Date(System.currentTimeMillis()));

        OtpModel otpModel = new OtpModel(email, otp, expireTime, "REGISTER", pendingUser);
        HttpSession session = req.getSession(true);
        if (!EmailUtil.sendOtpEmail(email, otp, "Mã OTP kích hoạt tài khoản đăng ký")) {
            req.setAttribute("alert", "Không thể gửi mã OTP. Vui lòng kiểm tra cấu hình email của hệ thống và thử lại.");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }
        session.setAttribute(Constant.SESSION_OTP, otpModel);

        resp.sendRedirect(req.getContextPath() + "/verify-otp");
    }
}
