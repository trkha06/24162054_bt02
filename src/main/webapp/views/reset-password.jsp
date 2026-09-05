<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt Lại Mật Khẩu Mới - shopbanhangcuakha</title>
</head>
<body>
<div class="row justify-content-center my-4">
    <div class="col-md-6 col-lg-5">
        <div class="card card-custom p-4 p-md-5">
            <div class="text-center mb-4">
                <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                    <i class="fa fa-shield-halved fa-lg"></i>
                </div>
                <h3 class="fw-bold text-primary">ĐẶT LẠI MẬT KHẨU</h3>
                <p class="text-muted small">Nhập mã OTP đã nhận qua email và thiết lập mật khẩu mới</p>
            </div>

            <c:if test="${sessionScope.otpResentMessage != null}">
                <div class="alert alert-info alert-dismissible fade show shadow-sm border-0 small" role="alert">
                    <i class="fa fa-info-circle me-1"></i> ${sessionScope.otpResentMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="otpResentMessage" scope="session"/>
            </c:if>

            <form action="${pageContext.request.contextPath}/reset-password" method="post" class="needs-validation" novalidate>
                <div class="mb-3 text-center">
                    <label class="form-label fw-semibold">Mã OTP (6 chữ số) <span class="text-danger">*</span></label>
                    <input type="text" class="form-control form-control-lg text-center fw-bold text-primary" name="otp"
                           placeholder="------" maxlength="6" pattern="[0-9]{6}" required autofocus
                           style="letter-spacing: 8px; font-size: 24px;" />
                    <div class="invalid-feedback text-center">Vui lòng nhập 6 chữ số mã OTP.</div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Mật khẩu mới <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fa fa-lock text-secondary"></i></span>
                        <input type="password" class="form-control" name="newPassword" id="newPassword"
                               placeholder="Tối thiểu 6 ký tự..." minlength="6" maxlength="150" required />
                        <div class="invalid-feedback">Mật khẩu mới phải từ 6 ký tự trở lên.</div>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fa fa-lock-open text-secondary"></i></span>
                        <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" data-match-password="#newPassword"
                               placeholder="Nhập lại mật khẩu mới..." minlength="6" maxlength="150" required />
                        <div class="invalid-feedback">Vui lòng xác nhận lại mật khẩu mới.</div>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold shadow-sm mb-3">
                    <i class="fa fa-check-circle me-1"></i> Lưu Đổi Mật Khẩu
                </button>

                <div class="text-center">
                    <span class="text-muted small">Chưa nhận được mã? </span>
                    <a href="${pageContext.request.contextPath}/resend-forgot-otp" class="fw-bold text-primary text-decoration-none small">
                        <i class="fa fa-rotate-right me-1"></i> Gửi lại mã OTP
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
                const newPass = document.getElementById('newPassword').value;
                const confirmPass = document.getElementById('confirmPassword').value;
                if (newPass !== confirmPass) {
                    document.getElementById('confirmPassword').setCustomValidity('Mật khẩu xác nhận không khớp');
                } else {
                    document.getElementById('confirmPassword').setCustomValidity('');
                }

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
