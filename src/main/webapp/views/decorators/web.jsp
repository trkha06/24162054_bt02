<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title">Hệ Thống Quản Trị - Web MVC</sitemesh:write></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar-brand { font-weight: 700; color: #0d6efd !important; letter-spacing: 0.5px; }
        .card-custom { border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); border: none; }
        .topbar-box { background: #212529; color: #fff; }
        .topbar-box a { color: #adb5bd; text-decoration: none; }
        .topbar-box a:hover { color: #fff; }
        main { flex: 1 0 auto; }
        footer { flex-shrink: 0; }
        .avatar-img { object-fit: cover; }
    </style>
    <sitemesh:write property="head" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
        <div class="container">
            <a class="navbar-brand text-white" href="${pageContext.request.contextPath}/home">
                <i class="fa fa-layer-group"></i> MVC JPA SYSTEM
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMain">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navMain">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/home"><i class="fa fa-home"></i> Trang chủ</a>
                    </li>
                    <c:if test="${not empty sessionScope.account}">
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/profile"><i class="fa fa-user-circle"></i> Hồ sơ cá nhân</a>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.account.roleid == 1}">
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/categories"><i class="fa fa-folder-open"></i> Quản lý Category</a>
                        </li>
                    </c:if>
                </ul>
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