<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên Mật Khẩu - shopbanhangcuakha</title>
</head>
<body>
<div class="row justify-content-center my-4">
    <div class="col-md-6 col-lg-5">
        <div class="card card-custom p-4 p-md-5">
            <div class="text-center mb-4">
                <div class="bg-warning text-dark rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                    <i class="fa fa-key fa-lg"></i>
                </div>
                <h3 class="fw-bold text-dark">QUÊN MẬT KHẨU</h3>
                <p class="text-muted small">Nhập tên tài khoản (Username) hoặc Email đã đăng ký để nhận mã OTP khôi phục mật khẩu</p>
            </div>

            <form action="${pageContext.request.contextPath}/forgot-password" method="post" class="needs-validation" novalidate>
                <div class="mb-4">
                    <label class="form-label fw-semibold">Tài khoản hoặc Email <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fa fa-user-circle text-secondary"></i></span>
                        <input type="text" class="form-control" name="account"
                               value="${not empty account ? account : param.account}"
                               placeholder="Nhập username hoặc email..." required autofocus />
                        <div class="invalid-feedback">Vui lòng nhập tên tài khoản hoặc email của bạn.</div>
                    </div>
                </div>

                <button type="submit" class="btn btn-warning w-100 py-2 fw-bold text-dark shadow-sm">
                    <i class="fa fa-paper-plane me-1"></i> Gửi Mã OTP Qua Email
                </button>

                <div class="text-center mt-4 pt-3 border-top">
                    <a href="${pageContext.request.contextPath}/login" class="text-secondary small text-decoration-none fw-semibold">
                        <i class="fa fa-arrow-left me-1"></i> Quay lại Đăng nhập
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
