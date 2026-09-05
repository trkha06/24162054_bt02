<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập Nhật Sản Phẩm - Admin Portal</title>
</head>
<body>
<c:set var="isRemoteImage" value="${not empty product.images && (product.images.startsWith('http://') || product.images.startsWith('https://'))}" />
<c:choose>
    <c:when test="${isRemoteImage}"><c:set var="imgUrl" value="${product.images}" /></c:when>
    <c:otherwise>
        <c:url value="/image" var="imgUrl"><c:param name="fname" value="${product.images}" /></c:url>
    </c:otherwise>
</c:choose>

<div class="row justify-content-center">
    <div class="col-lg-9">
        <div class="card card-custom p-4 p-md-5 shadow-sm">
            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                <div>
                    <h3 class="fw-bold text-primary mb-1"><i class="fa fa-pen-to-square me-2"></i> Cập Nhật Sản Phẩm #${product.productId}</h3>
                    <p class="text-muted small mb-0">Chỉnh sửa thông tin sản phẩm trong cơ sở dữ liệu JPA</p>
                </div>
                <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary btn-sm">
                    <i class="fa fa-arrow-left me-1"></i> Quay lại
                </a>
            </div>

            <form action="<c:url value='/admin/product/update'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <input type="hidden" name="productid" value="${product.productId}">

                <div class="row g-3 mb-3">
                    <div class="col-md-3">
                        <label class="form-label fw-bold">Mã sản phẩm</label>
                        <input class="form-control bg-light" value="${product.productId}" readonly disabled>
                    </div>
                    <div class="col-md-9">
                        <label class="form-label fw-bold" for="productname">Tên sản phẩm <span class="text-danger">*</span></label>
                        <input id="productname" type="text" name="productname" class="form-control form-control-lg"
                               value="${product.productName}" minlength="2" maxlength="200" required autofocus>
                        <div class="invalid-feedback">Vui lòng nhập tên sản phẩm (từ 2 đến 200 ký tự).</div>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-bold" for="categoryid">Danh mục sản phẩm <span class="text-danger">*</span></label>
                        <select id="categoryid" name="categoryid" class="form-select" required>
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach items="${categories}" var="category">
                                <option value="${category.categoryid}" ${product.category != null && product.category.categoryid == category.categoryid ? 'selected' : ''}>
                                    ${category.categoryname}
                                </option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn danh mục cho sản phẩm.</div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-bold" for="price">Đơn giá (VNĐ) <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <input id="price" type="number" name="price" class="form-control" value="${product.price}" min="0" step="1000" required>
                            <span class="input-group-text">đ</span>
                            <div class="invalid-feedback">Đơn giá không được âm.</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-bold" for="quantity">Số lượng kho <span class="text-danger">*</span></label>
                        <input id="quantity" type="number" name="quantity" class="form-control" value="${product.quantity}" min="0" required>
                        <div class="invalid-feedback">Số lượng không được âm.</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold" for="description">Mô tả sản phẩm:</label>
                    <textarea id="description" name="description" class="form-control" rows="4">${product.description}</textarea>
                </div>

                <div class="card bg-light border-0 p-3 mb-3 rounded-3">
                    <h6 class="fw-bold text-dark mb-3"><i class="fa fa-image me-2 text-primary"></i> Quản Lý Hình Ảnh</h6>

                    <div class="mb-3 text-center">
                        <label class="form-label fw-semibold d-block text-start">Ảnh hiện tại:</label>
                        <img src="${imgUrl}" alt="Ảnh ${product.productName}" width="160" height="110"
                             class="rounded border object-fit-cover shadow-sm"
                             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/category-placeholder.svg';">
                    </div>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold" for="images1">Thay ảnh từ máy tính (Multipart Upload):</label>
                            <input id="images1" type="file" name="images1" class="form-control" accept="image/jpeg,image/png,image/gif,image/webp">
                            <small class="text-muted">Chấp nhận JPG, PNG, GIF, WEBP (tối đa 10 MB).</small>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold" for="images">Hoặc đường dẫn ảnh mới (URL):</label>
                            <input id="images" type="url" name="images" class="form-control"
                                   value="${isRemoteImage ? product.images : ''}" placeholder="https://domain.com/image.jpg">
                        </div>
                    </div>
                </div>

                <div class="mb-4">
                    <span class="form-label fw-bold d-block mb-2">Trạng thái bán hàng:</span>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="status" id="status1" value="1" required ${product.status == 1 ? 'checked' : ''}>
                        <label class="form-check-label text-success fw-bold" for="status1">
                            <i class="fa fa-check-circle me-1"></i> Hoạt động / Mở bán
                        </label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="status" id="status0" value="0" ${product.status != 1 ? 'checked' : ''}>
                        <label class="form-check-label text-secondary fw-bold" for="status0">
                            <i class="fa fa-lock me-1"></i> Khóa / Tạm dừng
                        </label>
                    </div>
                </div>

                <div class="d-flex gap-2 pt-3 border-top">
                    <button type="submit" class="btn btn-primary btn-lg px-4 fw-bold shadow-sm">
                        <i class="fa fa-save me-1"></i> Lưu Thay Đổi
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
