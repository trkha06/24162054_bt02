<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác Thực Mã OTP - shopbanhangcuakha</title>
</head>
<body>
<div class="row justify-content-center my-4">
    <div class="col-md-6 col-lg-5">
        <div class="card card-custom p-4 p-md-5">
            <div class="text-center mb-4">
                <div class="bg-success text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                    <i class="fa fa-envelope-circle-check fa-lg"></i>
                </div>
                <h3 class="fw-bold text-success">XÁC THỰC MÃ OTP</h3>
                <p class="text-muted small">Mã xác thực 6 chữ số đã được gửi đến email của bạn (hiệu lực trong 5 phút)</p>
            </div>

            <c:if test="${sessionScope.otpResentMessage != null}">
                <div class="alert alert-info alert-dismissible fade show shadow-sm border-0 small" role="alert">
                    <i class="fa fa-info-circle me-1"></i> ${sessionScope.otpResentMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="otpResentMessage" scope="session"/>
            </c:if>

            <form action="${pageContext.request.contextPath}/verify-otp" method="post" class="needs-validation" novalidate>
                <div class="mb-4 text-center">
                    <label class="form-label fw-semibold">Nhập mã OTP (6 chữ số) <span class="text-danger">*</span></label>
                    <input type="text" class="form-control form-control-lg text-center fw-bold text-success" name="otp"
                           placeholder="------" maxlength="6" pattern="[0-9]{6}" required autofocus
                           style="letter-spacing: 10px; font-size: 26px; border-width: 2px;" />
                    <div class="invalid-feedback text-center">Vui lòng nhập chính xác 6 chữ số mã OTP.</div>
                </div>

                <button type="submit" class="btn btn-success w-100 py-2 fw-bold shadow-sm mb-3">
                    <i class="fa fa-check-circle me-1"></i> Xác Nhận Kích Hoạt
                </button>

                <div class="text-center">
                    <span class="text-muted small">Chưa nhận được mã? </span>
                    <a href="${pageContext.request.contextPath}/resend-otp" class="fw-bold text-primary text-decoration-none small">
                        <i class="fa fa-rotate-right me-1"></i> Gửi lại mã OTP mới
                    </a>
                </div>

                <div class="text-center mt-4 pt-3 border-top">
                    <a href="${pageContext.request.contextPath}/register" class="text-secondary small text-decoration-none">
                        <i class="fa fa-arrow-left me-1"></i> Đăng ký lại tài khoản khác
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    (() => {
        'use strict'
        const forms = document.querySelectorAll('.needs-validation')
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>
</body>
</html>
