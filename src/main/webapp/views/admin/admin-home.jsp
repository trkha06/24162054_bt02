<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Bảng Điều Khiển Admin" />
</jsp:include>
<body>
<jsp:include page="../common/topbar.jsp" />

<div class="container mt-5">
    <div class="card card-custom p-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-danger"><i class="fa fa-user-shield"></i> DASHBOARD DÀNH CHO ADMIN (Role ID = 1)</h2>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
        <p class="lead">Xin chào Admin <b>${sessionScope.account.fullName}</b> (${sessionScope.account.userName})</p>
        <div class="row mt-4">
            <div class="col-md-6 mb-3">
                <div class="card bg-primary text-white p-3">
                    <h4><i class="fa fa-folder-open"></i> Quản Lý Danh Mục</h4>
                    <p>CRUD Category bằng JPA/Hibernate, hỗ trợ tải ảnh</p>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-light btn-sm fw-bold">Vào quản lý</a>
                </div>
            </div>
            <div class="col-md-6 mb-3">
                <div class="card bg-success text-white p-3">
                    <h4><i class="fa fa-plus-circle"></i> Thêm Danh Mục Mới</h4>
                    <p>Tạo category với Upload ảnh icon</p>
                    <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-light btn-sm fw-bold">Thêm ngay</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
