<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Bảng Điều Khiển Quản Lý - Manager Portal | shopbanhangcuakha</title>
</head>
<body>
    <div class="card card-custom p-5 shadow-sm text-center my-4">
        <div class="bg-warning text-dark rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3" style="width: 70px; height: 70px;">
            <i class="fa fa-tasks fa-2x"></i>
        </div>
        <h2 class="text-dark fw-bold mb-2">Trang Quản Lý (Manager Dashboard)</h2>
        <p class="lead text-muted">Xin chào Quản lý <b>${sessionScope.account.fullName}</b> (@${sessionScope.account.userName})</p>
        <p class="text-secondary small">Khu vực dành cho nhân sự quản lý sản phẩm và danh mục cửa hàng.</p>
        <div class="mt-4 d-flex justify-content-center gap-3">
            <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-primary px-4 fw-semibold">
                <i class="fa fa-boxes-stacked me-1"></i> Xem Sản Phẩm
            </a>
            <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary px-4 fw-semibold">
                <i class="fa fa-user-edit me-1"></i> Hồ Sơ Cá Nhân
            </a>
        </div>
    </div>
</body>
</html>
