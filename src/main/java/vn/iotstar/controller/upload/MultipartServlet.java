package vn.iotstar.controller.upload;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.util.Constant;

@WebServlet(
    name = "MultiPartServlet",
    urlPatterns = {"/multiPartServlet", "/uploadFile"}
)
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class MultipartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(Constant.Path.UPLOAD_DEMO).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Part part = request.getPart("multiPartServlet");
            if (part == null || part.getSize() == 0 || part.getSubmittedFileName() == null
                    || part.getSubmittedFileName().isBlank()) {
                request.setAttribute("message", "Vui lòng chọn tệp để tải lên.");
            } else {
                String originalName = Path.of(part.getSubmittedFileName()).getFileName().toString();
                Path uploadDirectory = Path.of(Constant.DIR).toAbsolutePath().normalize();
                Files.createDirectories(uploadDirectory);
                String storedName = UUID.randomUUID() + "_" + originalName;
                Path target = uploadDirectory.resolve(storedName).normalize();
                if (!target.startsWith(uploadDirectory)) {
                    throw new IllegalArgumentException("Tên tệp không hợp lệ.");
                }
                try (var input = part.getInputStream()) {
                    Files.copy(input, target, StandardCopyOption.REPLACE_EXISTING);
                }
                request.setAttribute("message", "Đã tải tệp " + originalName + " lên thành công.");
            }
        } catch (Exception exception) {
            request.setAttribute("message", "Không thể tải tệp lên: " + exception.getMessage());
        }
        getServletContext().getRequestDispatcher(Constant.Path.RESULT).forward(request, response);
    }
}
