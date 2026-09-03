<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Trang Chủ Người Dùng - Shopping Servlet MVC" />
</jsp:include>
<body>
<jsp:include page="common/topbar.jsp" />

<div class="container my-5">
    <div class="card card-custom p-4 shadow-sm text-center">
        <div class="mb-3">
            <c:choose>
                <c:when test="${not empty sessionScope.account.avatar}">
                    <c:choose>
                        <c:when test="${sessionScope.account.avatar.startsWith('http')}">
                            <img src="${sessionScope.account.avatar}" alt="Avatar" class="rounded-circle shadow" style="width: 100px; height: 100px; object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.avatar}" alt="Avatar" class="rounded-circle shadow" style="width: 100px; height: 100px; object-fit: cover;" onerror="this.src='https://ui-avatars.com/api/?name=${sessionScope.account.fullName}&background=0d6efd&color=fff&size=100'">
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <img src="https://ui-avatars.com/api/?name=${sessionScope.account.fullName}&background=0d6efd&color=fff&size=100" alt="Avatar" class="rounded-circle shadow" style="width: 100px; height: 100px; object-fit: cover;">
                </c:otherwise>
            </c:choose>
        </div>

        <h2 class="text-primary fw-bold"><i class="fa fa-home"></i> Chào mừng bạn đến với Hệ Thống Web MVC!</h2>
        <p class="lead text-muted">Mô hình kiến trúc 3 Tầng MVC với JPA / Hibernate & Quản lý giao diện SiteMesh</p>
        
        <div class="alert alert-light border p-3 mx-auto" style="max-width: 600px;">
            <p class="mb-1">Tài khoản hiện tại: <b>${sessionScope.account.userName}</b> | Họ và tên: <b>${sessionScope.account.fullName}</b></p>
            <p class="mb-0">Email: <b>${sessionScope.account.email}</b> | Số điện thoại: <b>${not empty sessionScope.account.phone ? sessionScope.account.phone : 'Chưa cập nhật'}</b></p>
        </div>

        <div class="mt-4 d-flex justify-content-center gap-2 flex-wrap">
            <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary px-4">
                <i class="fa fa-user-edit me-1"></i> Chỉnh sửa Hồ sơ cá nhân (Profile)
            </a>
            <c:if test="${sessionScope.account.roleid == 1}">
                <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-success px-4">
                    <i class="fa fa-folder-open me-1"></i> Quản lý Category (JPA)
                </a>
            </c:if>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger px-4">
                <i class="fa fa-sign-out-alt me-1"></i> Đăng Xuất
            </a>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>