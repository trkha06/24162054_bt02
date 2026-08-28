package vn.iotstar.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;
import vn.iotstar.util.Constant;

@WebFilter(urlPatterns = { "/admin/*", "/manager/*", "/home" })
public class AuthorizationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        User account = session == null ? null : (User) session.getAttribute(Constant.SESSION_ACCOUNT);

        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String path = req.getRequestURI().substring(req.getContextPath().length());
        if (path.startsWith("/admin/") && account.getRoleid() != 1) {
            session.setAttribute("flashError", "Bạn không có quyền truy cập khu vực quản trị.");
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }
        if (path.startsWith("/manager/") && account.getRoleid() != 2) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        chain.doFilter(request, response);
    }
}
