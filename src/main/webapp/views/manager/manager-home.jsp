<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Bảng Điều Khiển Quản Lý" />
</jsp:include>
<body>
<jsp:include page="../common/topbar.jsp" />

<div class="container mt-5">
    <div class="card card-custom p-4">
        <h2 class="text-warning"><i class="fa fa-briefcase"></i> DASHBOARD DÀNH CHO MANAGER (Role ID = 2)</h2>
        <p class="lead">Xin chào Quản lý <b>${sessionScope.account.fullName}</b></p>
        <p>Bạn có quyền theo dõi và giám sát các sản phẩm danh mục bán hàng.</p>
        <div class="mt-4">
            <span class="badge bg-warning text-dark fs-6 me-2"><i class="fa fa-user-clock"></i> Phiên đăng nhập Manager</span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
    </div>
</div>
</body>
</html>
