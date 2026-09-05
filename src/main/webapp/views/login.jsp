<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập - shopbanhangcuakha</title>
</head>
<body>
<div class="row justify-content-center my-4">
    <div class="col-md-6 col-lg-5">
        <div class="card card-custom p-4 p-md-5">
            <div class="text-center mb-4">
                <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                    <i class="fa fa-lock fa-lg"></i>
                </div>
                <h3 class="fw-bold text-dark">ĐĂNG NHẬP</h3>
                <p class="text-muted small">Hệ thống bài tập Servlet MVC 3-Tier & JPA</p>
            </div>

            <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Tên tài khoản hoặc Email <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fa fa-user text-secondary"></i></span>
                        <input type="text" class="form-control" name="username" value="${not empty username ? username : param.username}" placeholder="Nhập username hoặc email..." maxlength="100" required autofocus />
                        <div class="invalid-feedback">Vui lòng nhập tên tài khoản hoặc email.</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fa fa-key text-secondary"></i></span>
                        <input type="password" class="form-control" name="password" placeholder="Nhập mật khẩu..." maxlength="150" required />
                        <div class="invalid-feedback">Vui lòng nhập mật khẩu.</div>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="remember" id="rememberMe">
                        <label class="form-check-label small" for="rememberMe">Ghi nhớ đăng nhập</label>
                    </div>
                    <a href="${pageContext.request.contextPath}/forgot-password" class="text-decoration-none small text-primary fw-semibold">Quên mật khẩu?</a>
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold shadow-sm">
                    <i class="fa fa-sign-in-alt me-1"></i> Đăng nhập
                </button>

                <div class="text-center mt-4 pt-3 border-top">
                    <p class="mb-0 text-muted small">Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="fw-bold text-primary text-decoration-none">Đăng ký ngay</a></p>
                    <p class="mt-2 mb-0"><a href="${pageContext.request.contextPath}/home" class="text-secondary small text-decoration-none"><i class="fa fa-arrow-left me-1"></i> Quay lại trang chủ</a></p>
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
