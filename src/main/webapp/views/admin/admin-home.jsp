<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Bảng Điều Khiển Admin - Admin Dashboard | shopbanhangcuakha</title>
</head>
<body>
    <div class="card card-custom p-4 p-md-5 shadow-sm">
        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
            <div>
                <h2 class="text-dark fw-bold mb-1"><i class="fa fa-tachometer-alt text-danger me-2"></i> BẢNG ĐIỀU KHIỂN QUẢN TRỊ VIÊN</h2>
                <div class="text-muted small">Hệ thống quản trị MVC 3-Tier kết hợp JPA/Hibernate, SiteMesh 3 và Bootstrap 5</div>
            </div>
            <div>
                <span class="badge bg-danger fs-6 px-3 py-2"><i class="fa fa-user-shield me-1"></i> ADMIN</span>
            </div>
        </div>

        <div class="alert alert-light border shadow-sm p-3 mb-4 rounded-3 d-flex align-items-center justify-content-between">
            <div>
                <i class="fa fa-user-circle text-primary me-2 fs-5"></i>
                Xin chào <b>${sessionScope.account.fullName}</b> (Tài khoản: <code>@${sessionScope.account.userName}</code> - shopbanhangcuakha)
            </div>
            <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-primary btn-sm fw-semibold">
                <i class="fa fa-id-card me-1"></i> Xem hồ sơ
            </a>
        </div>

        <div class="row g-4">
            <div class="col-md-6 col-lg-3">
                <div class="card bg-primary text-white p-4 h-100 shadow-sm rounded-4 border-0 d-flex flex-column">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <i class="fa fa-folder-tree fa-2x"></i>
                        <span class="badge bg-white text-primary fw-bold">JPA CRUD</span>
                    </div>
                    <h5 class="fw-bold">Quản Lý Category</h5>
                    <p class="small text-white-50 flex-grow-1">CRUD Category bằng JPA/Hibernate, tìm kiếm, phân trang và tải ảnh lên.</p>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-light btn-sm fw-bold text-primary mt-3">
                        Vào danh mục <i class="fa fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card bg-success text-white p-4 h-100 shadow-sm rounded-4 border-0 d-flex flex-column">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <i class="fa fa-boxes-stacked fa-2x"></i>
                        <span class="badge bg-white text-success fw-bold">JPA CRUD</span>
                    </div>
                    <h5 class="fw-bold">Quản Lý Product</h5>
                    <p class="small text-white-50 flex-grow-1">Quản lý sản phẩm, đơn giá, tồn kho, liên kết quan hệ N - 1 với Category.</p>
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-light btn-sm fw-bold text-success mt-3">
                        Vào sản phẩm <i class="fa fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card bg-dark text-white p-4 h-100 shadow-sm rounded-4 border-0 d-flex flex-column">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <i class="fa fa-plus-circle fa-2x text-warning"></i>
                        <span class="badge bg-warning text-dark fw-bold">Mới</span>
                    </div>
                    <h5 class="fw-bold">Thêm Sản Phẩm</h5>
                    <p class="small text-white-50 flex-grow-1">Thêm sản phẩm mới với tính năng tải ảnh Multipart hoặc link URL.</p>
                    <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-warning btn-sm fw-bold text-dark mt-3">
                        Thêm sản phẩm <i class="fa fa-plus ms-1"></i>
                    </a>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card bg-info text-white p-4 h-100 shadow-sm rounded-4 border-0 d-flex flex-column">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <i class="fa fa-user-edit fa-2x"></i>
                        <span class="badge bg-white text-info fw-bold">Tài Khoản</span>
                    </div>
                    <h5 class="fw-bold">Hồ Sơ Admin</h5>
                    <p class="small text-white-50 flex-grow-1">Cập nhật họ tên, số điện thoại và tải avatar của tài khoản Admin.</p>
                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-light btn-sm fw-bold text-info mt-3">
                        Hồ sơ cá nhân <i class="fa fa-user ms-1"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
