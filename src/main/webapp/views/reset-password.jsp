<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Đặt Lại Mật Khẩu Mới" />
</jsp:include>
<body>
<jsp:include page="common/topbar.jsp" />

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card card-custom p-4">
                <div class="text-center mb-4">
                    <div class="display-6 text-primary mb-2"><i class="fa fa-shield-halved"></i></div>
                    <h3 class="fw-bold text-primary">ĐẶT LẠI MẬT KHẨU</h3>
                    <p class="text-muted">Mã OTP đã được gửi đến địa chỉ đã đăng ký.</p>
                </div>

                <c:if test="${alert != null}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fa fa-exclamation-triangle"></i> ${alert}
                    </div>
                </c:if>

                <c:if test="${sessionScope.otpResentMessage != null}">
                    <div class="alert alert-info" role="alert">
                        <i class="fa fa-info-circle"></i> ${sessionScope.otpResentMessage}
                    </div>
                    <c:remove var="otpResentMessage" scope="session"/>
                </c:if>

                <form action="${pageContext.request.contextPath}/reset-password" method="post">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Nhập mã OTP (6 chữ số):</label>
                        <input type="text" class="form-control form-control-lg text-center fw-bold" name="otp"
                               placeholder="------" maxlength="6" pattern="[0-9]{6}" required autofocus
                               style="letter-spacing: 8px; font-size: 22px;" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mật khẩu mới:</label>
                        <input type="password" class="form-control" name="newPassword" placeholder="Nhập mật khẩu mới..." required />
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Xác nhận mật khẩu mới:</label>
                        <input type="password" class="form-control" name="confirmPassword" placeholder="Nhập lại mật khẩu mới..." required />
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-2 fw-bold mb-3">
                        <i class="fa fa-check-circle"></i> Đổi Mật Khẩu
                    </button>

                    <div class="text-center">
                        <span class="text-muted">Không nhận được mã? </span>
                        <a href="${pageContext.request.contextPath}/resend-forgot-otp" class="fw-bold text-primary text-decoration-none">
                            <i class="fa fa-rotate-right"></i> Gửi lại mã OTP
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp" />
</body>
</html>
