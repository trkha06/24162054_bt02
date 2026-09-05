<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title">Cửa Hàng Trực Tuyến - MVC 3-Tier</sitemesh:write></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-color: #2563eb;
            --primary-dark: #1d4ed8;
            --secondary-color: #0f172a;
            --accent-color: #f59e0b;
            --bg-light: #f8fafc;
        }
        body {
            background-color: var(--bg-light);
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #334155;
        }
        .topbar-box {
            background: #0f172a;
            color: #94a3b8;
            font-size: 0.875rem;
            border-bottom: 1px solid rgba(255,255,255,0.08);
        }
        .topbar-box a {
            color: #cbd5e1;
            text-decoration: none;
            transition: color 0.2s ease;
        }
        .topbar-box a:hover {
            color: #ffffff;
        }
        .main-navbar {
            background: #ffffff;
            box-shadow: 0 4px 20px -2px rgba(0,0,0,0.05);
            border-bottom: 1px solid #e2e8f0;
        }
        .navbar-brand-custom {
            font-weight: 800;
            font-size: 1.35rem;
            color: var(--primary-color) !important;
            letter-spacing: -0.5px;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .nav-link-custom {
            font-weight: 600;
            color: #475569 !important;
            padding: 0.5rem 1rem !important;
            border-radius: 8px;
            transition: all 0.2s ease;
        }
        .nav-link-custom:hover, .nav-link-custom.active {
            color: var(--primary-color) !important;
            background-color: #eff6ff;
        }
        .card-custom {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.01);
            border: 1px solid #f1f5f9;
        }
        main {
            flex: 1 0 auto;
        }
        .footer-custom {
            background: #0f172a;
            color: #94a3b8;
            border-top: 1px solid #1e293b;
        }
        .footer-custom a {
            color: #cbd5e1;
            text-decoration: none;
            transition: color 0.2s;
        }
        .footer-custom a:hover {
            color: #38bdf8;
        }
        .badge-role {
            font-weight: 600;
            padding: 0.35rem 0.65rem;
            border-radius: 6px;
        }
    </style>
    <sitemesh:write property="head" />
</head>
<body>
    <div class="topbar-box py-2">
        <div class="container d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div class="d-flex align-items-center gap-3">
                <span><i class="fa fa-phone me-1 text-warning"></i> Hotline: <b>0901.234.567</b></span>
                <span class="d-none d-md-inline"><i class="fa fa-envelope me-1 text-info"></i> support@ute.edu.vn</span>
                <span class="d-none d-lg-inline text-secondary">|</span>
                <span class="d-none d-lg-inline text-light"><i class="fa fa-store me-1 text-success"></i> shopbanhangcuakha</span>
            </div>
            <div class="d-flex align-items-center gap-3">
                <c:choose>
                    <c:when test="${sessionScope.account == null}">
                        <a href="${pageContext.request.contextPath}/login" class="text-white fw-semibold">
                            <i class="fa fa-sign-in-alt me-1"></i> Đăng nhập
                        </a>
                        <span class="text-secondary">/</span>
                        <a href="${pageContext.request.contextPath}/register" class="text-warning fw-semibold">
                            <i class="fa fa-user-plus me-1"></i> Đăng ký
                        </a>
                    </c:when>
                    <c:otherwise>
                        <span class="text-light">
                            <i class="fa fa-user-circle me-1 text-info"></i> Xin chào: <b>${sessionScope.account.fullName}</b>
                        </span>
                        <c:if test="${sessionScope.account.roleid == 1}">
                            <a href="${pageContext.request.contextPath}/admin/home" class="badge bg-danger text-white text-decoration-none">
                                <i class="fa fa-shield-alt me-1"></i> Admin Portal
                            </a>
                        </c:if>
                        <c:if test="${sessionScope.account.roleid == 2}">
                            <a href="${pageContext.request.contextPath}/manager/home" class="badge bg-warning text-dark text-decoration-none">
                                <i class="fa fa-tasks me-1"></i> Manager
                            </a>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/profile" class="text-light">
                            <i class="fa fa-id-badge me-1"></i> Hồ sơ
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="text-danger">
                            <i class="fa fa-sign-out-alt me-1"></i> Đăng xuất
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <nav class="navbar navbar-expand-lg main-navbar sticky-top">
        <div class="container">
            <a class="navbar-brand navbar-brand-custom" href="${pageContext.request.contextPath}/home">
                <div class="bg-primary text-white rounded-3 p-2 d-inline-flex align-items-center justify-content-center" style="width: 38px; height: 38px;">
                    <i class="fa fa-store"></i>
                </div>
                <span>shopbanhangcuakha</span>
            </a>

            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-3">
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="${pageContext.request.contextPath}/home">
                            <i class="fa fa-home me-1 text-primary"></i> Trang Chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="${pageContext.request.contextPath}/product">
                            <i class="fa fa-box-open me-1 text-success"></i> Sản Phẩm
                        </a>
                    </li>
                    <c:if test="${sessionScope.account != null}">
                        <li class="nav-item">
                            <a class="nav-link nav-link-custom" href="${pageContext.request.contextPath}/profile">
                                <i class="fa fa-user-gear me-1 text-info"></i> Hồ Sơ Cá Nhân
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link nav-link-custom" href="${pageContext.request.contextPath}/multiPartServlet">
                                <i class="fa fa-cloud-upload-alt me-1 text-secondary"></i> Upload File Demo
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.account.roleid == 1}">
                        <li class="nav-item dropdown">
                            <a class="nav-link nav-link-custom dropdown-toggle text-danger" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="fa fa-cogs me-1"></i> Quản Trị Hệ Thống
                            </a>
                            <ul class="dropdown-menu shadow-sm border-0">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/home"><i class="fa fa-tachometer-alt me-2 text-primary"></i> Dashboard</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/categories"><i class="fa fa-folder me-2 text-warning"></i> Quản lý Category</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/category/add"><i class="fa fa-folder-plus me-2 text-success"></i> Thêm Category</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/products"><i class="fa fa-boxes-stacked me-2 text-info"></i> Quản lý Product</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/product/add"><i class="fa fa-plus-circle me-2 text-success"></i> Thêm Product</a></li>
                            </ul>
                        </li>
                    </c:if>
                </ul>

                <form action="${pageContext.request.contextPath}/product" method="get" class="d-flex my-2 my-lg-0 me-lg-3">
                    <div class="input-group">
                        <input class="form-control form-control-sm border-end-0 bg-light" type="search" name="q" maxlength="100" placeholder="Tìm sản phẩm..." style="border-radius: 20px 0 0 20px;">
                        <button class="btn btn-sm btn-light border border-start-0 text-primary" type="submit" style="border-radius: 0 20px 20px 0;">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </nav>

    <main class="py-4">
        <div class="container">
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

    <footer class="footer-custom pt-5 pb-4 mt-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <h5 class="text-white fw-bold mb-3 d-flex align-items-center gap-2">
                        <i class="fa fa-cubes text-primary"></i> MVC 3-TIER WEB SYSTEM
                    </h5>
                    <p class="small text-secondary">
                        Đồ án môn học Lập trình Web. Hệ thống xây dựng trên kiến trúc MVC 3 lớp, kết hợp Jakarta Servlet 6.0, JPA Hibernate, SiteMesh 3 Decorator và Bootstrap 5.
                    </p>
                    <div class="d-flex gap-2">
                        <span class="badge bg-primary">Jakarta EE 10</span>
                        <span class="badge bg-success">Hibernate 6</span>
                        <span class="badge bg-info text-dark">SiteMesh 3</span>
                        <span class="badge bg-warning text-dark">Bootstrap 5</span>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6">
                    <h6 class="text-white fw-bold mb-3">Liên Kết Nhanh</h6>
                    <ul class="list-unstyled small d-flex flex-column gap-2">
                        <li><a href="${pageContext.request.contextPath}/home"><i class="fa fa-angle-right me-1 text-primary"></i> Trang Chủ</a></li>
                        <li><a href="${pageContext.request.contextPath}/product"><i class="fa fa-angle-right me-1 text-primary"></i> Tất Cả Sản Phẩm</a></li>
                        <li><a href="${pageContext.request.contextPath}/profile"><i class="fa fa-angle-right me-1 text-primary"></i> Hồ Sơ Cá Nhân</a></li>
                        <li><a href="${pageContext.request.contextPath}/login"><i class="fa fa-angle-right me-1 text-primary"></i> Đăng Nhập</a></li>
                        <li><a href="${pageContext.request.contextPath}/register"><i class="fa fa-angle-right me-1 text-primary"></i> Đăng Ký</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h6 class="text-white fw-bold mb-3">Chức Năng Hệ Thống</h6>
                    <ul class="list-unstyled small d-flex flex-column gap-2">
                        <li><span class="text-secondary"><i class="fa fa-check text-success me-1"></i> Xác thực OTP qua Email</span></li>
                        <li><span class="text-secondary"><i class="fa fa-check text-success me-1"></i> Quản lý CRUD Category & Product</span></li>
                        <li><span class="text-secondary"><i class="fa fa-check text-success me-1"></i> Upload ảnh Multipart / JPA</span></li>
                        <li><span class="text-secondary"><i class="fa fa-check text-success me-1"></i> Validation Form chuẩn mực</span></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h6 class="text-white fw-bold mb-3">Thông Tin Cửa Hàng</h6>
                    <div class="small text-secondary d-flex flex-column gap-2">
                        <div><i class="fa fa-store me-2 text-info"></i> <b>shopbanhangcuakha</b></div>
                    </div>
                </div>
            </div>
            <hr class="border-secondary my-4">
            <div class="row align-items-center small">
                <div class="col-md-6 text-center text-md-start mb-2 mb-md-0">
                    &copy; 2026 <b>shopbanhangcuakha</b>. All rights reserved.
                </div>
                <div class="col-md-6 text-center text-md-end text-secondary">
                    Designed with <i class="fa fa-heart text-danger"></i> using Bootstrap 5 & SiteMesh 3
                </div>
            </div>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/assets/js/form-validation.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
