package vn.iotstar.controller.admin;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.util.Constant;

@WebServlet(urlPatterns = { "/image", "/image/*" })
public class DownloadImageController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String requestedName = request.getParameter("fname");
        String safeName = requestedName == null || requestedName.isBlank()
                ? Constant.DEFAULT_IMAGE
                : Path.of(requestedName).getFileName().toString();

        Path uploadDirectory = Path.of(Constant.DIR).toAbsolutePath().normalize();
        Path image = uploadDirectory.resolve(safeName).normalize();
        if (!image.startsWith(uploadDirectory) || !Files.isRegularFile(image)) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String contentType = getServletContext().getMimeType(image.getFileName().toString());
        response.setContentType(contentType == null ? "application/octet-stream" : contentType);
        response.setContentLengthLong(Files.size(image));
        response.setHeader("Cache-Control", "public, max-age=86400");
        Files.copy(image, response.getOutputStream());
    }
}
