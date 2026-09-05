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

        if (image.startsWith(uploadDirectory) && Files.isRegularFile(image)) {
            String contentType = getServletContext().getMimeType(image.getFileName().toString());
            response.setContentType(contentType == null ? "application/octet-stream" : contentType);
            response.setContentLengthLong(Files.size(image));
            response.setHeader("Cache-Control", "public, max-age=86400");
            Files.copy(image, response.getOutputStream());
            return;
        }

        Path assetPlaceholder = Path.of(getServletContext().getRealPath("/assets/img/category-placeholder.svg"));
        if (Files.isRegularFile(assetPlaceholder)) {
            response.setContentType("image/svg+xml");
            response.setHeader("Cache-Control", "public, max-age=86400");
            Files.copy(assetPlaceholder, response.getOutputStream());
            return;
        }

        String svg = "<svg xmlns='http://www.w3.org/2000/svg' width='150' height='150' viewBox='0 0 150 150'>"
                + "<rect width='100%' height='100%' fill='#0d6efd'/>"
                + "<text x='50%' y='52%' fill='#ffffff' font-family='sans-serif' font-size='48' font-weight='bold' text-anchor='middle' dominant-baseline='middle'>U</text>"
                + "</svg>";
        response.setContentType("image/svg+xml");
        response.setHeader("Cache-Control", "public, max-age=86400");
        response.getWriter().write(svg);
    }
}
