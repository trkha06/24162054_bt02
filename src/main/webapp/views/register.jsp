<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký Tài Khoản - shopbanhangcuakha</title>
</head>
<body>
<div class="row justify-content-center my-4">
    <div class="col-md-8 col-lg-6">
        <div class="card card-custom p-4 p-md-5">
            <div class="text-center mb-4">
                <div class="bg-success text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                    <i class="fa fa-user-plus fa-lg"></i>
                </div>
                <h3 class="fw-bold text-dark">ĐĂNG KÝ TÀI KHOẢN</h3>
                <p class="text-muted small">Hệ thống sẽ gửi mã OTP qua Email để kích hoạt tài khoản</p>
            </div>

            <form action="${pageContext.request.contextPath}/register" method="post" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Tên tài khoản (Username) <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fa fa-user text-secondary"></i></span>
                        <input type="text" class="form-control" name="username" value="${not empty username ? username : param.username}"
                               placeholder="Từ 3-30 ký tự, không dấu (vd: nguyenvana)"
                               pattern="^[a-zA-Z0-9_]{3,30}$" required autofocus />
                        <div class="invalid-feedback">Vui lòng nhập tên tài khoản hợp lệ (3-30 ký tự, chữ/số/_).</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Họ và tên đầy đủ <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fa fa-id-card text-secondary"></i></span>
                        <input type="text" class="form-control" name="fullname" value="${not empty fullname ? fullname : param.fullname}"
                               placeholder="Nhập họ và tên đầy đủ..." maxlength="150" required />
                        <div class="invalid-feedback">Vui lòng nhập họ và tên của bạn.</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Địa chỉ Email (Nhận OTP) <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fa fa-envelope text-secondary"></i></span>
                        <input type="email" class="form-control" name="email" value="${not empty email ? email : param.email}"
                               placeholder="example@gmail.com" required />
                        <div class="invalid-feedback">Vui lòng nhập đúng định dạng email.</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Số điện thoại <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fa fa-phone text-secondary"></i></span>
                        <input type="tel" class="form-control" name="phone" value="${not empty phone ? phone : param.phone}"
                               placeholder="10 chữ số (vd: 0901234567)" pattern="^(0[0-9]{9}|\+84[0-9]{9})$" required />
                        <div class="invalid-feedback">Vui lòng nhập số điện thoại hợp lệ (10 chữ số).</div>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fa fa-lock text-secondary"></i></span>
                        <input type="password" class="form-control" name="password" placeholder="Tối thiểu 6 ký tự..." minlength="6" maxlength="150" required />
                        <div class="invalid-feedback">Mật khẩu phải từ 6 ký tự trở lên.</div>
                    </div>
                </div>

                <button type="submit" class="btn btn-success w-100 py-2 fw-bold shadow-sm">
                    <i class="fa fa-paper-plane me-1"></i> Tiếp Tục & Nhận Mã OTP
                </button>

                <div class="text-center mt-4 pt-3 border-top">
                    <p class="mb-0 text-muted small">Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="fw-bold text-success text-decoration-none">Đăng nhập</a></p>
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
