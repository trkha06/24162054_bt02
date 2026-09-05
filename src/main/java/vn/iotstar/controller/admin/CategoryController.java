package vn.iotstar.controller.admin;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.List;
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
import vn.iotstar.entity.Category;
import vn.iotstar.services.ICategoryService;
import vn.iotstar.services.IProductService;
import vn.iotstar.services.impl.CategoryServiceImpl;
import vn.iotstar.services.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;

@MultipartConfig(fileSizeThreshold = 2 * 1024 * 1024, maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 12 * 1024 * 1024)
@WebServlet(urlPatterns = {
        "/admin/categories",
        "/admin/category/add",
        "/admin/category/insert",
        "/admin/category/edit",
        "/admin/category/update",
        "/admin/category/delete"
})
public class CategoryController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 5;
    private static final Set<String> IMAGE_EXTENSIONS = Set.of("jpg", "jpeg", "png", "gif", "webp");

    private final ICategoryService categoryService = new CategoryServiceImpl();
    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        switch (request.getServletPath()) {
            case "/admin/categories" -> showList(request, response);
            case "/admin/category/add" -> request.getRequestDispatcher(Constant.Path.CATEGORY_ADD)
                    .forward(request, response);
            case "/admin/category/edit" -> showEdit(request, response);
            case "/admin/category/delete" -> delete(request, response);
            default -> response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        switch (request.getServletPath()) {
            case "/admin/category/insert" -> insert(request, response);
            case "/admin/category/update" -> update(request, response);
            default -> response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }

    private void showList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = value(request.getParameter("q"));
        int requestedPage = parsePositiveInt(request.getParameter("page"), 1);
        List<Category> categories;
        int totalPages;
        int currentPage;

        if (keyword.isEmpty()) {
            int totalItems = categoryService.count();
            totalPages = Math.max(1, (int) Math.ceil(totalItems / (double) PAGE_SIZE));
            currentPage = Math.min(requestedPage, totalPages);
            categories = categoryService.findAll(currentPage - 1, PAGE_SIZE);
            request.setAttribute("totalItems", totalItems);
        } else {
            categories = categoryService.searchByName(keyword);
            totalPages = 1;
            currentPage = 1;
            request.setAttribute("totalItems", categories.size());
        }

        moveFlashMessage(request, "success");
        moveFlashMessage(request, "alert");
        request.setAttribute("listcate", categories);
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageSize", PAGE_SIZE);
        request.getRequestDispatcher(Constant.Path.CATEGORY_LIST).forward(request, response);
    }

    private void showEdit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = parsePositiveInt(request.getParameter("id"), -1);
        Category category = id > 0 ? categoryService.findById(id) : null;
        if (category == null) {
            flash(request, "alert", "Không tìm thấy danh mục cần sửa.");
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            return;
        }
        request.setAttribute("cate", category);
        request.getRequestDispatcher(Constant.Path.CATEGORY_EDIT).forward(request, response);
    }

    private void insert(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Category category = new Category();
        try {
            populateCategory(request, category);
            category.setImages(resolveImage(request, Constant.DEFAULT_IMAGE));
            categoryService.insert(category);
            flash(request, "success", "Đã thêm danh mục thành công.");
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } catch (IllegalArgumentException exception) {
            request.setAttribute("alert", exception.getMessage());
            request.setAttribute("formCategory", category);
            request.getRequestDispatcher(Constant.Path.CATEGORY_ADD).forward(request, response);
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = parsePositiveInt(request.getParameter("categoryid"), -1);
        Category category = id > 0 ? categoryService.findById(id) : null;
        if (category == null) {
            flash(request, "alert", "Không tìm thấy danh mục cần cập nhật.");
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            return;
        }

        try {
            populateCategory(request, category);
            category.setImages(resolveImage(request, category.getImages()));
            categoryService.update(category);
            flash(request, "success", "Đã cập nhật danh mục thành công.");
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } catch (IllegalArgumentException exception) {
            request.setAttribute("alert", exception.getMessage());
            request.setAttribute("cate", category);
            request.getRequestDispatcher(Constant.Path.CATEGORY_EDIT).forward(request, response);
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = parsePositiveInt(request.getParameter("id"), -1);
        try {
            if (id < 1) {
                throw new IllegalArgumentException("Mã danh mục không hợp lệ.");
            }
            int productCount = productService.countByCategoryId(id);
            if (productCount > 0) {
                throw new IllegalArgumentException("Danh mục đang có " + productCount
                        + " sản phẩm. Hãy chuyển hoặc xóa các sản phẩm đó trước.");
            }
            categoryService.delete(id);
            flash(request, "success", "Đã xóa danh mục thành công.");
        } catch (Exception exception) {
            flash(request, "alert", exception.getMessage() == null
                    ? "Không thể xóa danh mục." : exception.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }

    private String resolveImage(HttpServletRequest request, String currentImage)
            throws IOException, ServletException {
        Part imagePart = request.getPart("images1");
        if (imagePart != null && imagePart.getSize() > 0) {
            if (imagePart.getContentType() == null || !imagePart.getContentType().startsWith("image/")) {
                throw new IllegalArgumentException("Tệp tải lên phải là hình ảnh.");
            }
            String submittedName = Path.of(imagePart.getSubmittedFileName()).getFileName().toString();
            int dotIndex = submittedName.lastIndexOf('.');
            String extension = dotIndex >= 0 ? submittedName.substring(dotIndex + 1).toLowerCase(Locale.ROOT) : "";
            if (!IMAGE_EXTENSIONS.contains(extension)) {
                throw new IllegalArgumentException("Chỉ chấp nhận ảnh JPG, PNG, GIF hoặc WEBP.");
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

        String imageUrl = value(request.getParameter("images"));
        if (!imageUrl.isEmpty()) {
            if (!imageUrl.startsWith("http://") && !imageUrl.startsWith("https://")) {
                throw new IllegalArgumentException("Link ảnh phải bắt đầu bằng http:// hoặc https://.");
            }
            return imageUrl;
        }
        return currentImage == null || currentImage.isBlank() ? Constant.DEFAULT_IMAGE : currentImage;
    }

    private void populateCategory(HttpServletRequest request, Category category) {
        String name = value(request.getParameter("categoryname"));
        if (name.isEmpty() || name.length() > 100) {
            throw new IllegalArgumentException("Tên danh mục là bắt buộc và không được quá 100 ký tự.");
        }

        String status = request.getParameter("status");
        if (!"0".equals(status) && !"1".equals(status)) {
            throw new IllegalArgumentException("Vui lòng chọn trạng thái hợp lệ cho danh mục.");
        }

        category.setCategoryname(name);
        category.setStatus(Integer.parseInt(status));
    }

    private int parsePositiveInt(String value, int fallback) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException exception) {
            return fallback;
        }
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
