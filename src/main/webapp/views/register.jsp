<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Đăng Ký Tài Khoản - Kích Hoạt OTP" />
</jsp:include>
<body>
<jsp:include page="common/topbar.jsp" />

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card card-custom p-4">
                <div class="text-center mb-4">
                    <h3 class="fw-bold text-success"><i class="fa fa-user-plus"></i> ĐĂNG KÝ TÀI KHOẢN</h3>
                    <p class="text-muted">Hệ thống sẽ gửi mã xác thực OTP qua Email để kích hoạt tài khoản</p>
                </div>

                <c:if test="${alert != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fa fa-exclamation-triangle"></i> ${alert}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tài khoản (Username):</label>
                        <input type="text" class="form-control" name="username" value="${param.username}" placeholder="Nhập tên tài khoản..." required />
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Họ và tên:</label>
                        <input type="text" class="form-control" name="fullname" value="${param.fullname}" placeholder="Nhập họ và tên đầy đủ..." required />
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Địa chỉ Email (Nhận mã OTP):</label>
                        <input type="email" class="form-control" name="email" value="${param.email}" placeholder="example@gmail.com" required />
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Số điện thoại:</label>
                        <input type="text" class="form-control" name="phone" value="${param.phone}" placeholder="Nhập số điện thoại..." required />
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mật khẩu:</label>
                        <input type="password" class="form-control" name="password" placeholder="Nhập mật khẩu..." required />
                    </div>

                    <button type="submit" class="btn btn-success w-100 py-2 fw-bold"><i class="fa fa-paper-plane"></i> Tiếp Tục & Nhận Mã OTP</button>

                    <div class="text-center mt-3">
                        <p class="mb-0">Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="fw-bold text-decoration-none">Đăng nhập</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp" />
</body>
</html>
