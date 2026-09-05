<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tải Tệp Multipart - Demo Upload | shopbanhangcuakha</title>
</head>
<body>
<div class="row justify-content-center my-4">
    <div class="col-md-7 col-lg-6">
        <div class="card card-custom p-4 p-md-5 shadow-sm">
            <div class="text-center mb-4">
                <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                    <i class="fa fa-cloud-arrow-up fa-lg"></i>
                </div>
                <h3 class="fw-bold text-dark">TẢI TỆP MULTIPART</h3>
                <p class="text-muted small">Demo tính năng Upload File bằng Servlet 6.0 MultipartConfig</p>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/multiPartServlet" enctype="multipart/form-data" class="needs-validation" novalidate>
                <div class="mb-4">
                    <label for="multiPartServlet" class="form-label fw-bold">Chọn tệp tải lên <span class="text-danger">*</span></label>
                    <input id="multiPartServlet" type="file" name="multiPartServlet" class="form-control" required>
                    <div class="invalid-feedback">Vui lòng chọn tệp để tải lên (tối đa 10 MB).</div>
                </div>
                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold shadow-sm">
                    <i class="fa fa-upload me-1"></i> Tải Lên Máy Chủ
                </button>
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
