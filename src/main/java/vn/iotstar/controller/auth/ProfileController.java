package vn.iotstar.controller.auth;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.Locale;
import java.util.Set;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

@MultipartConfig(fileSizeThreshold = 2 * 1024 * 1024, maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 12 * 1024 * 1024)
@WebServlet(urlPatterns = { "/profile", "/user/profile", "/my-profile" })
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Set<String> IMAGE_EXTENSIONS = Set.of("jpg", "jpeg", "png", "gif", "webp");

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User sessionUser = session == null ? null : (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = userService.findById(sessionUser.getId());
        if (user == null) {
            user = userService.get(sessionUser.getUserName());
        }
        if (user == null) {
            user = sessionUser;
        }

        // Refresh session
        session.setAttribute(Constant.SESSION_ACCOUNT, user);
        request.setAttribute("user", user);

        moveFlashMessage(request, "success");
        moveFlashMessage(request, "alert");

        request.getRequestDispatcher(Constant.Path.PROFILE).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User sessionUser = session == null ? null : (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = userService.findById(sessionUser.getId());
        if (user == null) {
            user = userService.get(sessionUser.getUserName());
        }
        if (user == null) {
            user = sessionUser;
        }

        String fullname = value(request.getParameter("fullname"));
        String phone = value(request.getParameter("phone"));

        if (fullname.isEmpty()) {
            request.setAttribute("alert", "Họ và tên không được để trống.");
            request.setAttribute("user", user);
            request.getRequestDispatcher(Constant.Path.PROFILE).forward(request, response);
            return;
        }

        if (!phone.isEmpty()) {
            if (!phone.matches("^(0|\\+84)[0-9]{9,10}$")) {
                request.setAttribute("alert", "Số điện thoại không đúng định dạng (ví dụ: 0901234567).");
                request.setAttribute("user", user);
                request.getRequestDispatcher(Constant.Path.PROFILE).forward(request, response);
                return;
            }
            if (userService.checkExistPhoneExceptUser(phone, user.getId())) {
                request.setAttribute("alert", "Số điện thoại này đã được sử dụng bởi tài khoản khác.");
                request.setAttribute("user", user);
                request.getRequestDispatcher(Constant.Path.PROFILE).forward(request, response);
                return;
            }
        }

        try {
            String newAvatar = resolveImage(request, user.getAvatar());
            user.setFullName(fullname);
            user.setPhone(phone.isEmpty() ? null : phone);
            user.setAvatar(newAvatar);

            userService.update(user);

            // Update session with updated entity
            session.setAttribute(Constant.SESSION_ACCOUNT, user);
            session.setAttribute(Constant.SESSION_USERNAME, user.getUserName());

            flash(request, "success", "Cập nhật thông tin tài khoản thành công!");
            response.sendRedirect(request.getContextPath() + "/profile");
        } catch (IllegalArgumentException exception) {
            request.setAttribute("alert", exception.getMessage());
            request.setAttribute("user", user);
            request.getRequestDispatcher(Constant.Path.PROFILE).forward(request, response);
        } catch (Exception exception) {
            request.setAttribute("alert", "Lỗi trong quá trình cập nhật: " + exception.getMessage());
            request.setAttribute("user", user);
            request.getRequestDispatcher(Constant.Path.PROFILE).forward(request, response);
        }
    }

    private String resolveImage(HttpServletRequest request, String currentImage)
            throws IOException, ServletException {
        // Priority 1: Check multipart uploaded file
        Part imagePart = request.getPart("images1");
        if (imagePart == null || imagePart.getSize() == 0) {
            imagePart = request.getPart("avatar");
        }
        if (imagePart == null || imagePart.getSize() == 0) {
            imagePart = request.getPart("image");
        }

        if (imagePart != null && imagePart.getSize() > 0) {
            if (imagePart.getContentType() == null || !imagePart.getContentType().startsWith("image/")) {
                throw new IllegalArgumentException("Tệp tải lên phải là hình ảnh (JPG, PNG, GIF, WEBP).");
            }
            String submittedName = Path.of(imagePart.getSubmittedFileName()).getFileName().toString();
            int dotIndex = submittedName.lastIndexOf('.');
            String extension = dotIndex >= 0 ? submittedName.substring(dotIndex + 1).toLowerCase(Locale.ROOT) : "";
            if (!IMAGE_EXTENSIONS.contains(extension)) {
                throw new IllegalArgumentException("Chỉ chấp nhận ảnh định dạng JPG, PNG, GIF hoặc WEBP.");
            }

            Path uploadDirectory = Path.of(Constant.DIR).toAbsolutePath().normalize();
            Files.createDirectories(uploadDirectory);
            String storedName = UUID.randomUUID() + "." + extension;
            Path target = uploadDirectory.resolve(storedName).normalize();
            try (var input = imagePart.getInputStream()) {
                Files.copy(input, target, StandardCopyOption.REPLACE_EXISTING);
            }
            return storedName;
        }

        // Priority 2: Check URL link
        String imageUrl = value(request.getParameter("images"));
        if (imageUrl.isEmpty()) {
            imageUrl = value(request.getParameter("avatarUrl"));
        }
        if (!imageUrl.isEmpty()) {
            if (!imageUrl.startsWith("http://") && !imageUrl.startsWith("https://")) {
                throw new IllegalArgumentException("Đường dẫn ảnh phải bắt đầu bằng http:// hoặc https://.");
            }
            return imageUrl;
        }

        // Fallback to current image
        return currentImage;
    }

    private String value(String value) {
        return value == null ? "" : value.trim();
    }

    private void flash(HttpServletRequest request, String name, String message) {
        request.getSession(true).setAttribute(name, message);
    }

    private void moveFlashMessage(HttpServletRequest request, String name) {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute(name) != null) {
            request.setAttribute(name, session.getAttribute(name));
            session.removeAttribute(name);
        }
    }
}