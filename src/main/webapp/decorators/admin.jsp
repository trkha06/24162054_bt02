<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title">Khu Vực Quản Trị - Admin Dashboard</sitemesh:write></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; min-height: 100vh; display: flex; flex-direction: column; }
        .sidebar-brand { font-weight: 700; color: #dc3545 !important; letter-spacing: 0.5px; }
        .card-custom { border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); border: none; }
        main { flex: 1 0 auto; }
        footer { flex-shrink: 0; }
    </style>
    <sitemesh:write property="head" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container">
            <a class="navbar-brand text-danger fw-bold" href="${pageContext.request.contextPath}/admin/home">
                <i class="fa fa-user-shield"></i> ADMIN PORTAL
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navAdmin">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navAdmin">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/home"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/categories"><i class="fa fa-folder-open"></i> Danh mục Category</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/category/add"><i class="fa fa-plus-circle"></i> Thêm Category</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/products"><i class="fa fa-boxes-stacked"></i> Quản lý sản phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/profile"><i class="fa fa-user-circle"></i> Hồ sơ cá nhân</a>
                    </li>
                </ul>
                <div class="d-flex">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light btn-sm me-2"><i class="fa fa-globe"></i> Trang User</a>
                </div>
            </div>
        </div>
    </nav>

    <main class="py-4">
        <div class="container">
            <c:if test="${not empty sessionScope.flashSuccess or not empty requestScope.success}">
                <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                    <i class="fa fa-check-circle me-2"></i> ${not empty sessionScope.flashSuccess ? sessionScope.flashSuccess : requestScope.success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty sessionScope.flashError or not empty requestScope.alert}">
                <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                    <i class="fa fa-exclamation-triangle me-2"></i> ${not empty sessionScope.flashError ? sessionScope.flashError : requestScope.alert}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <sitemesh:write property="body">
                ${body}
            </sitemesh:write>
        </div>
    </main>

    <jsp:include page="/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
