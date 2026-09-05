<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title">Quản Trị Hệ Thống - Admin Dashboard</sitemesh:write></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --admin-primary: #dc2626;
            --admin-dark: #0f172a;
            --admin-sidebar: #1e293b;
            --admin-bg: #f1f5f9;
        }
        body {
            background-color: var(--admin-bg);
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #334155;
        }
        .admin-header {
            background-color: var(--admin-dark);
            border-bottom: 2px solid #dc2626;
        }
        .admin-brand {
            font-weight: 800;
            font-size: 1.25rem;
            color: #ffffff !important;
            letter-spacing: 0.5px;
        }
        .admin-nav .nav-link {
            color: #cbd5e1 !important;
            font-weight: 500;
            padding: 0.6rem 1rem;
            border-radius: 8px;
            transition: all 0.2s ease;
        }
        .admin-nav .nav-link:hover, .admin-nav .nav-link.active {
            color: #ffffff !important;
            background-color: rgba(220, 38, 38, 0.2);
        }
        .card-custom {
            background: #ffffff;
            border-radius: 14px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.05);
            border: 1px solid #e2e8f0;
        }
        main {
            flex: 1 0 auto;
        }
        .admin-footer {
            background: #0f172a;
            color: #94a3b8;
            border-top: 1px solid #1e293b;
        }
    </style>
    <sitemesh:write property="head" />
</head>
<body>
    <header class="admin-header shadow-sm sticky-top">
        <div class="container-fluid px-lg-5">
            <nav class="navbar navbar-expand-lg navbar-dark py-2">
                <a class="navbar-brand admin-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/admin/home">
                    <span class="badge bg-danger p-2"><i class="fa fa-user-shield"></i></span>
                    <span>ADMIN PORTAL <small class="fw-normal text-white-50 fs-6">| shopbanhangcuakha</small></span>
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="adminNavbar">
                    <ul class="navbar-nav admin-nav me-auto mb-2 mb-lg-0 ms-lg-3">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/home">
                                <i class="fa fa-tachometer-alt me-1 text-danger"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="fa fa-folder me-1 text-warning"></i> Quản Lý Category
                            </a>
                            <ul class="dropdown-menu shadow border-0">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/categories"><i class="fa fa-list me-2"></i> Danh sách Category</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/category/add"><i class="fa fa-plus-circle me-2 text-success"></i> Thêm Category mới</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="fa fa-boxes-stacked me-1 text-info"></i> Quản Lý Product
                            </a>
                            <ul class="dropdown-menu shadow border-0">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/products"><i class="fa fa-list me-2"></i> Danh sách Sản phẩm</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/product/add"><i class="fa fa-plus-circle me-2 text-success"></i> Thêm Sản phẩm mới</a></li>
                            </ul>
                        </li>
                    </ul>

                    <div class="d-flex align-items-center gap-3">
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light btn-sm">
                            <i class="fa fa-globe me-1"></i> Xem Trang User
                        </a>
                        <div class="dropdown">
                            <button class="btn btn-dark btn-sm dropdown-toggle text-light d-flex align-items-center gap-2 border-secondary" type="button" data-bs-toggle="dropdown">
                                <i class="fa fa-user-circle text-danger"></i>
                                <span>${sessionScope.account != null ? sessionScope.account.fullName : 'Admin'}</span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                                <li><span class="dropdown-item-text text-muted small"><i class="fa fa-store me-1"></i> shopbanhangcuakha</span></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="fa fa-user-edit me-2"></i> Hồ sơ cá nhân</a></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fa fa-sign-out-alt me-2"></i> Đăng xuất</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
    </header>

    <main class="py-4">
        <div class="container-fluid px-lg-5">
            <c:if test="${not empty sessionScope.flashSuccess or not empty requestScope.success}">
                <div class="alert alert-success alert-dismissible fade show shadow-sm border-0 d-flex align-items-center gap-2" role="alert">
                    <i class="fa fa-check-circle fs-5"></i>
                    <div>${not empty sessionScope.flashSuccess ? sessionScope.flashSuccess : requestScope.success}</div>
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty sessionScope.flashError or not empty requestScope.alert}">
                <div class="alert alert-danger alert-dismissible fade show shadow-sm border-0 d-flex align-items-center gap-2" role="alert">
                    <i class="fa fa-exclamation-triangle fs-5"></i>
                    <div>${not empty sessionScope.flashError ? sessionScope.flashError : requestScope.alert}</div>
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <sitemesh:write property="body">
                ${body}
            </sitemesh:write>
        </div>
    </main>

    <footer class="admin-footer py-3 mt-auto">
        <div class="container-fluid px-lg-5 text-center text-md-between d-md-flex justify-content-between align-items-center small">
            <div>
                &copy; 2026 <b>shopbanhangcuakha</b> | Quản Trị Hệ Thống MVC 3-Tier
            </div>
            <div class="text-secondary">
                Jakarta Servlet 6.0 &bull; Hibernate JPA &bull; SiteMesh 3 Decorator &bull; Bootstrap 5
            </div>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/assets/js/form-validation.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
