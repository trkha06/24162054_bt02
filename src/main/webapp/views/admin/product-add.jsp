<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Sản Phẩm Mới - Admin Portal</title>
</head>
<body>
<div class="row justify-content-center">
    <div class="col-lg-9">
        <div class="card card-custom p-4 p-md-5 shadow-sm">
            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                <div>
                    <h3 class="fw-bold text-success mb-1"><i class="fa fa-plus-circle me-2"></i> Thêm Sản Phẩm Mới</h3>
                    <p class="text-muted small mb-0">Điền thông tin sản phẩm để lưu trữ vào hệ thống JPA</p>
                </div>
                <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary btn-sm">
                    <i class="fa fa-arrow-left me-1"></i> Quay lại
                </a>
            </div>

            <form action="<c:url value='/admin/product/insert'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label class="form-label fw-bold">Tên sản phẩm <span class="text-danger">*</span></label>
                    <input type="text" name="productname" class="form-control form-control-lg"
                           value="${product.productName}" placeholder="Nhập tên sản phẩm..."
                           minlength="2" maxlength="200" required autofocus>
                    <div class="invalid-feedback">Vui lòng nhập tên sản phẩm (từ 2 đến 200 ký tự).</div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Danh mục sản phẩm <span class="text-danger">*</span></label>
                        <select name="categoryid" class="form-select" required>
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.categoryid}" ${product.category != null && product.category.categoryid == c.categoryid ? 'selected' : ''}>
                                    ${c.categoryname}
                                </option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn danh mục cho sản phẩm.</div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-bold">Đơn giá (VNĐ) <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <input type="number" name="price" class="form-control"
                                   value="${product.price > 0 ? product.price : 0}" min="0" step="1000" required>
                            <span class="input-group-text">đ</span>
                            <div class="invalid-feedback">Đơn giá không được âm.</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-bold">Số lượng kho <span class="text-danger">*</span></label>
                        <input type="number" name="quantity" class="form-control"
                               value="${product.quantity > 0 ? product.quantity : 10}" min="0" required>
                        <div class="invalid-feedback">Số lượng không được âm.</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Mô tả sản phẩm:</label>
                    <textarea name="description" class="form-control" rows="4" placeholder="Nhập mô tả chi tiết tính năng, thông số sản phẩm...">${product.description}</textarea>
                </div>

                <div class="card bg-light border-0 p-3 mb-3 rounded-3">
                    <h6 class="fw-bold text-dark mb-3"><i class="fa fa-image me-2 text-primary"></i> Hình Ảnh Sản Phẩm</h6>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">1. Tải ảnh từ máy tính (Multipart File):</label>
                            <input type="file" name="images1" class="form-control" accept="image/jpeg,image/png,image/gif,image/webp">
                            <small class="text-muted">Chấp nhận JPG, PNG, GIF, WEBP (tối đa 10 MB).</small>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">2. Hoặc đường dẫn ảnh Online (URL):</label>
                            <input type="url" name="images" class="form-control" value="${product.images}" placeholder="https://domain.com/image.jpg">
                        </div>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold d-block">Trạng thái bán hàng:</label>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="status" id="status1" value="1" required
                               ${empty product || product.status == 1 ? 'checked' : ''}>
                        <label class="form-check-label text-success fw-bold" for="status1">
                            <i class="fa fa-check-circle me-1"></i> Hoạt động / Mở bán
                        </label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="status" id="status0" value="0"
                               ${not empty product && product.status != 1 ? 'checked' : ''}>
                        <label class="form-check-label text-secondary fw-bold" for="status0">
                            <i class="fa fa-lock me-1"></i> Khóa / Tạm dừng
                        </label>
                    </div>
                </div>

                <div class="d-flex gap-2 pt-3 border-top">
                    <button type="submit" class="btn btn-success btn-lg px-4 fw-bold shadow-sm">
                        <i class="fa fa-save me-1"></i> Lưu Sản Phẩm
                    </button>
                    <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary btn-lg px-4">Hủy bỏ</a>
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
