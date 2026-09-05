package vn.iotstar.controller.admin;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.Date;
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
import vn.iotstar.entity.Product;
import vn.iotstar.services.ICategoryService;
import vn.iotstar.services.IProductService;
import vn.iotstar.services.impl.CategoryServiceImpl;
import vn.iotstar.services.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;

@MultipartConfig(fileSizeThreshold = 2 * 1024 * 1024, maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 12 * 1024 * 1024)
@WebServlet(urlPatterns = {
        "/admin/products",
        "/admin/product/add",
        "/admin/product/insert",
        "/admin/product/edit",
        "/admin/product/update",
        "/admin/product/delete"
})
public class AdminProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 8;
    private static final Set<String> IMAGE_EXTENSIONS = Set.of("jpg", "jpeg", "png", "gif", "webp");

    private final IProductService productService = new ProductServiceImpl();
    private final ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        switch (request.getServletPath()) {
            case "/admin/products" -> showList(request, response);
            case "/admin/product/add" -> showAdd(request, response);
            case "/admin/product/edit" -> showEdit(request, response);
            case "/admin/product/delete" -> delete(request, response);
            default -> response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        switch (request.getServletPath()) {
            case "/admin/product/insert" -> insert(request, response);
            case "/admin/product/update" -> update(request, response);
            default -> response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }

    private void showList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = value(request.getParameter("q"));
        int requestedPage = parsePositiveInt(request.getParameter("page"), 1);
        List<Product> products;
        int totalPages;
        int currentPage;

        if (keyword.isEmpty()) {
            int totalItems = productService.count();
            totalPages = Math.max(1, (int) Math.ceil(totalItems / (double) PAGE_SIZE));
            currentPage = Math.min(requestedPage, totalPages);
            products = productService.findAll(currentPage - 1, PAGE_SIZE);
            request.setAttribute("totalItems", totalItems);
        } else {
            products = productService.searchByName(keyword);
            totalPages = 1;
            currentPage = 1;
            request.setAttribute("totalItems", products.size());
        }

        moveFlashMessage(request, "success");
        moveFlashMessage(request, "alert");
        request.setAttribute("listProducts", products);
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageSize", PAGE_SIZE);
        request.getRequestDispatcher(Constant.Path.ADMIN_PRODUCT_LIST).forward(request, response);
    }

    private void showAdd(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categories = categoryService.findAll();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher(Constant.Path.ADMIN_PRODUCT_ADD).forward(request, response);
    }

    private void showEdit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = parsePositiveInt(request.getParameter("id"), -1);
        Product product = id > 0 ? productService.findById(id) : null;
        if (product == null) {
            flash(request, "alert", "Không tìm thấy sản phẩm cần sửa.");
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }
        List<Category> categories = categoryService.findAll();
        request.setAttribute("product", product);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher(Constant.Path.ADMIN_PRODUCT_EDIT).forward(request, response);
    }

    private void insert(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Product product = new Product();
        product.setCreateDate(new Date());

        try {
            populateProduct(request, product);
            product.setImages(resolveImage(request, Constant.DEFAULT_IMAGE));
            productService.insert(product);
            flash(request, "success", "Đã thêm sản phẩm mới thành công.");
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (IllegalArgumentException exception) {
            request.setAttribute("alert", exception.getMessage());
            request.setAttribute("product", product);
            request.setAttribute("categories", categoryService.findAll());
            request.getRequestDispatcher(Constant.Path.ADMIN_PRODUCT_ADD).forward(request, response);
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = parsePositiveInt(request.getParameter("productid"), -1);
        Product product = id > 0 ? productService.findById(id) : null;
        if (product == null) {
            flash(request, "alert", "Không tìm thấy sản phẩm cần cập nhật.");
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        try {
            populateProduct(request, product);
            product.setImages(resolveImage(request, product.getImages()));
            productService.update(product);
            flash(request, "success", "Đã cập nhật sản phẩm thành công.");
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (IllegalArgumentException exception) {
            request.setAttribute("alert", exception.getMessage());
            request.setAttribute("product", product);
            request.setAttribute("categories", categoryService.findAll());
            request.getRequestDispatcher(Constant.Path.ADMIN_PRODUCT_EDIT).forward(request, response);
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = parsePositiveInt(request.getParameter("id"), -1);
        try {
            if (id < 1) {
                throw new IllegalArgumentException("Mã sản phẩm không hợp lệ.");
            }
            productService.delete(id);
            flash(request, "success", "Đã xóa sản phẩm thành công.");
        } catch (Exception exception) {
            flash(request, "alert", exception.getMessage() == null
                    ? "Không thể xóa sản phẩm." : exception.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/products");
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

    private void populateProduct(HttpServletRequest request, Product product) {
        String name = value(request.getParameter("productname"));
        if (name.length() < 2 || name.length() > 200) {
            throw new IllegalArgumentException("Tên sản phẩm phải có độ dài từ 2 đến 200 ký tự.");
        }

        int categoryId = parseRequiredPositiveInt(request.getParameter("categoryid"), "Danh mục");
        Category category = categoryService.findById(categoryId);
        if (category == null) {
            throw new IllegalArgumentException("Danh mục đã chọn không tồn tại.");
        }

        double price = parseRequiredNonNegativeDouble(request.getParameter("price"), "Đơn giá");
        int quantity = parseRequiredNonNegativeInt(request.getParameter("quantity"), "Số lượng");
        String description = value(request.getParameter("description"));
        if (description.length() > 2000) {
            throw new IllegalArgumentException("Mô tả sản phẩm không được quá 2.000 ký tự.");
        }

        String status = request.getParameter("status");
        if (!"0".equals(status) && !"1".equals(status)) {
            throw new IllegalArgumentException("Vui lòng chọn trạng thái bán hàng hợp lệ.");
        }

        product.setProductName(name);
        product.setCategory(category);
        product.setPrice(price);
        product.setQuantity(quantity);
        product.setDescription(description);
        product.setStatus(Integer.parseInt(status));
    }

    private int parseRequiredPositiveInt(String rawValue, String fieldName) {
        int parsed = parseRequiredNonNegativeInt(rawValue, fieldName);
        if (parsed < 1) {
            throw new IllegalArgumentException(fieldName + " phải là một giá trị hợp lệ.");
        }
        return parsed;
    }

    private int parseRequiredNonNegativeInt(String rawValue, String fieldName) {
        String raw = value(rawValue);
        if (!raw.matches("\\d+")) {
            throw new IllegalArgumentException(fieldName + " phải là số nguyên không âm.");
        }
        try {
            return Integer.parseInt(raw);
        } catch (NumberFormatException exception) {
            throw new IllegalArgumentException(fieldName + " vượt quá giá trị cho phép.");
        }
    }

    private double parseRequiredNonNegativeDouble(String rawValue, String fieldName) {
        String raw = value(rawValue);
        try {
            double parsed = Double.parseDouble(raw);
            if (!Double.isFinite(parsed) || parsed < 0) {
                throw new IllegalArgumentException(fieldName + " phải là số không âm.");
            }
            return parsed;
        } catch (NumberFormatException exception) {
            throw new IllegalArgumentException(fieldName + " phải là số không âm.");
        }
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
