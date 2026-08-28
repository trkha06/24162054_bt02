<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Trang Chủ Người Dùng" />
</jsp:include>
<body>
<jsp:include page="common/topbar.jsp" />

<div class="container mt-5">
    <div class="card card-custom p-4 text-center">
        <h2 class="text-primary"><i class="fa fa-home"></i> Chào mừng bạn đến với Trang Chủ Khách Hàng (User)!</h2>
        <p class="lead">Bạn đã đăng nhập thành công theo mô hình MVC 3 Tầng.</p>
        <p>Tài khoản hiện tại: <b>${sessionScope.account.userName}</b> | Họ tên: <b>${sessionScope.account.fullName}</b> | Email: <b>${sessionScope.account.email}</b></p>
        <div class="mt-4">
            <span class="badge bg-success fs-6 me-2"><i class="fa fa-check"></i> Session đang hoạt động</span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger"><i class="fa fa-sign-out-alt"></i> Đăng Xuất</a>
        </div>
    </div>
</div>
</body>
</html>
