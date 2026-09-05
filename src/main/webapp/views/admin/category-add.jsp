<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Category Mới - Admin Portal</title>
</head>
<body>
<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="card card-custom p-4 p-md-5 shadow-sm">
            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                <div>
                    <h3 class="fw-bold text-success mb-1"><i class="fa fa-folder-plus me-2"></i> Thêm Danh Mục Mới</h3>
                    <p class="text-muted small mb-0">Nhập thông tin danh mục sản phẩm vào cơ sở dữ liệu JPA</p>
                </div>
                <a class="btn btn-outline-secondary btn-sm" href="<c:url value='/admin/categories'/>">
                    <i class="fa fa-arrow-left me-1"></i> Quay lại
                </a>
            </div>

            <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label for="categoryname" class="form-label fw-bold">Tên danh mục <span class="text-danger">*</span></label>
                    <input type="text" id="categoryname" name="categoryname" class="form-control form-control-lg"
                           value="${formCategory.categoryname}" maxlength="100" placeholder="Ví dụ: Điện thoại, Laptop, Quần áo..." required autofocus>
                    <div class="invalid-feedback">Tên danh mục không được để trống (tối đa 100 ký tự).</div>
                </div>

                <div class="card bg-light border-0 p-3 mb-3 rounded-3">
                    <h6 class="fw-bold text-dark mb-3"><i class="fa fa-image me-2 text-primary"></i> Hình Ảnh Danh Mục</h6>

                    <div class="mb-3">
                        <label for="images1" class="form-label fw-semibold">1. Tải ảnh từ máy tính (Multipart Upload):</label>
                        <input type="file" id="images1" name="images1" class="form-control"
                               accept="image/jpeg,image/png,image/gif,image/webp">
                        <small class="text-muted">Chấp nhận JPG, PNG, GIF, WEBP (tối đa 10 MB).</small>
                    </div>

                    <div class="mb-2">
                        <label for="images" class="form-label fw-semibold">2. Hoặc nhập đường dẫn ảnh trực tuyến (URL):</label>
                        <input type="url" id="images" name="images" class="form-control" value="${formCategory.images}"
                               placeholder="https://example.com/category.jpg">
                    </div>
                </div>

                <fieldset class="mb-4">
                    <legend class="fs-6 fw-bold mb-2">Trạng thái danh mục:</legend>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="ston" name="status" value="1" required
                               ${empty formCategory || formCategory.status == 1 ? 'checked' : ''}>
                        <label class="form-check-label text-success fw-bold" for="ston">
                            <i class="fa fa-check-circle me-1"></i> Hoạt động
                        </label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="stoff" name="status" value="0"
                               ${not empty formCategory && formCategory.status != 1 ? 'checked' : ''}>
                        <label class="form-check-label text-secondary fw-bold" for="stoff">
                            <i class="fa fa-lock me-1"></i> Tạm khóa
                        </label>
                    </div>
                </fieldset>

                <div class="d-flex gap-2 pt-3 border-top">
                    <button class="btn btn-success btn-lg px-4 fw-bold shadow-sm" type="submit">
                        <i class="fa fa-save me-1"></i> Thêm Danh Mục
                    </button>
                    <a class="btn btn-outline-secondary btn-lg px-4" href="<c:url value='/admin/categories'/>">Hủy bỏ</a>
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
