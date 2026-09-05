package vn.iotstar.controller.web;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.services.ICategoryService;
import vn.iotstar.services.IProductService;
import vn.iotstar.services.impl.CategoryServiceImpl;
import vn.iotstar.services.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/product", "/products", "/product/detail"})
public class ProductSiteController extends HttpServlet {

    private static final int PAGE_SIZE = 6;
    private final IProductService productService = new ProductServiceImpl();
    private final ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String servletPath = req.getServletPath();
        if ("/product/detail".equals(servletPath)) {
            showDetail(req, resp);
        } else {
            showList(req, resp);
        }
    }

    private void showList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = parsePositiveInt(req.getParameter("page"), 1);
        int categoryId = parsePositiveInt(req.getParameter("cid"), 0);
        String keyword = req.getParameter("q");
        keyword = keyword == null ? "" : keyword.trim();

        List<Product> products;
        int totalItems;

        if (!keyword.isEmpty()) {
            products = productService.searchByName(keyword);
            totalItems = products.size();
        } else if (categoryId > 0) {
            totalItems = productService.countByCategoryId(categoryId);
            int totalPages = Math.max(1, (int) Math.ceil(totalItems / (double) PAGE_SIZE));
            page = Math.min(page, totalPages);
            products = productService.findByCategoryId(categoryId, page - 1, PAGE_SIZE);
        } else {
            totalItems = productService.count();
            int totalPages = Math.max(1, (int) Math.ceil(totalItems / (double) PAGE_SIZE));
            page = Math.min(page, totalPages);
            products = productService.findAll(page - 1, PAGE_SIZE);
        }

        int totalPages = Math.max(1, (int) Math.ceil(totalItems / (double) PAGE_SIZE));
        List<Category> categories = categoryService.findAll();

        req.setAttribute("products", products);
        req.setAttribute("categories", categories);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalItems", totalItems);
        req.setAttribute("pageSize", PAGE_SIZE);
        req.setAttribute("selectedCid", categoryId);
        req.setAttribute("keyword", keyword);

        req.getRequestDispatcher(Constant.Path.PRODUCT_LIST).forward(req, resp);
    }

    private void showDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = parsePositiveInt(req.getParameter("id"), 0);
        if (productId <= 0) {
            resp.sendRedirect(req.getContextPath() + "/product");
            return;
        }

        Product product = productService.findById(productId);
        if (product == null) {
            resp.sendRedirect(req.getContextPath() + "/product");
            return;
        }

        List<Product> relatedProducts = List.of();
        if (product.getCategory() != null) {
            relatedProducts = productService.findByCategoryId(product.getCategory().getCategoryid(), 0, 4)
                    .stream()
                    .filter(p -> p.getProductId() != product.getProductId())
                    .toList();
        }

        req.setAttribute("product", product);
        req.setAttribute("relatedProducts", relatedProducts);
        req.getRequestDispatcher(Constant.Path.PRODUCT_DETAIL).forward(req, resp);
    }

    private int parsePositiveInt(String value, int fallback) {
        try {
            int parsed = Integer.parseInt(value);
            return parsed > 0 ? parsed : fallback;
        } catch (Exception e) {
            return fallback;
        }
    }
}
