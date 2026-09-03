<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Bảng Điều Khiển Quản Lý" />
</jsp:include>
<body>
<jsp:include page="../common/topbar.jsp" />

<div class="container my-5">
    <div class="card card-custom p-4 shadow-sm text-center">
        <h2 class="text-warning fw-bold"><i class="fa fa-tasks"></i> Chào mừng bạn đến với Trang Quản Lý (Manager)!</h2>
        <p class="lead text-muted">Xin chào Manager <b>${sessionScope.account.fullName}</b> (@${sessionScope.account.userName})</p>
        <div class="mt-4 d-flex justify-content-center gap-2">
            <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary px-4"><i class="fa fa-user-edit"></i> Hồ Sơ Cá Nhân</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger px-4"><i class="fa fa-sign-out-alt"></i> Đăng Xuất</a>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>