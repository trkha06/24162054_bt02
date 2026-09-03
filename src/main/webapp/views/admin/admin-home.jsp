<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Bảng Điều Khiển Admin" />
</jsp:include>
<body>
<jsp:include page="../common/topbar.jsp" />

<div class="container my-5">
    <div class="card card-custom p-4 shadow-sm">
        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
            <h2 class="text-danger fw-bold mb-0"><i class="fa fa-user-shield me-2"></i> DASHBOARD QUẢN TRỊ VIÊN (Admin)</h2>
            <div>
                <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-primary btn-sm me-2"><i class="fa fa-user-circle"></i> Hồ sơ</a>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
            </div>
        </div>
        <p class="lead">Xin chào Admin <b>${sessionScope.account.fullName}</b> (@${sessionScope.account.userName})</p>
        <div class="row g-4 mt-2">
            <div class="col-md-4">
                <div class="card bg-primary text-white p-4 h-100 shadow-sm rounded-3">
                    <h4><i class="fa fa-folder-open me-2"></i> Quản Lý Danh Mục</h4>
                    <p class="small">CRUD Category bằng JPA/Hibernate, hỗ trợ tìm kiếm, phân trang và tải ảnh.</p>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-light btn-sm fw-bold mt-auto">Vào quản lý danh mục</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card bg-success text-white p-4 h-100 shadow-sm rounded-3">
                    <h4><i class="fa fa-plus-circle me-2"></i> Thêm Danh Mục Mới</h4>
                    <p class="small">Tạo danh mục mới với tính năng Upload ảnh icon qua Multipart.</p>
                    <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-light btn-sm fw-bold mt-auto">Thêm Category mới</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card bg-info text-white p-4 h-100 shadow-sm rounded-3">
                    <h4><i class="fa fa-user-edit me-2"></i> Hồ Sơ Cá Nhân</h4>
                    <p class="small">Cập nhật họ tên, số điện thoại và ảnh đại diện Avatar của tài khoản.</p>
                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-light btn-sm fw-bold mt-auto">Cập nhật Profile</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>