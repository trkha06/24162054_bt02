<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="topbar-box">
    <div class="container d-flex flex-wrap justify-content-between align-items-center gap-2">
        <div class="d-flex align-items-center gap-3">
            <a href="${pageContext.request.contextPath}/home" class="fw-bold text-white text-decoration-none">
                <i class="fa fa-store text-warning"></i> Cửa Hàng Trực Tuyến
            </a>
            <a href="${pageContext.request.contextPath}/home"><i class="fa fa-home"></i> Trang Chủ</a>
            <a href="${pageContext.request.contextPath}/product"><i class="fa fa-boxes-stacked"></i> Sản Phẩm</a>
            <c:if test="${sessionScope.account != null}">
                <a href="${pageContext.request.contextPath}/multiPartServlet"><i class="fa fa-cloud-arrow-up"></i> Upload File</a>
            </c:if>
        </div>
        <div class="d-flex align-items-center gap-2">
            <c:choose>
                <c:when test="${sessionScope.account == null}">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm"><i class="fa fa-sign-in-alt"></i> Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-sm text-white"><i class="fa fa-user-plus"></i> Đăng ký</a>
                </c:when>
                <c:otherwise>
                    <span class="text-light me-2">Xin chào: <b>${sessionScope.account.fullName}</b></span>
                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-light btn-sm">
                        <i class="fa fa-user-circle"></i> Hồ sơ
                    </a>
                    <c:if test="${sessionScope.account.roleid == 1}">
                        <a href="${pageContext.request.contextPath}/admin/categories" class="badge bg-primary text-white text-decoration-none py-2 px-3"><i class="fa fa-folder"></i> Quản lý Category</a>
                        <a href="${pageContext.request.contextPath}/admin/products" class="badge bg-success text-white text-decoration-none py-2 px-3"><i class="fa fa-box-open"></i> Quản lý Product</a>
                    </c:if>
                    <c:if test="${sessionScope.account.roleid == 2}">
                        <a href="${pageContext.request.contextPath}/manager/home" class="badge bg-info text-dark text-decoration-none py-2 px-3"><i class="fa fa-tasks"></i> Kênh Quản Lý</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm text-white"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
