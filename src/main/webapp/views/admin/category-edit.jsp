<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập Nhật Category - Admin Portal</title>
</head>
<body>
<c:set var="isRemoteImage" value="${not empty cate.images && (cate.images.startsWith('http://') || cate.images.startsWith('https://'))}" />
<c:choose>
    <c:when test="${isRemoteImage}"><c:set var="imgUrl" value="${cate.images}" /></c:when>
    <c:otherwise>
        <c:url value="/image" var="imgUrl"><c:param name="fname" value="${cate.images}" /></c:url>
    </c:otherwise>
</c:choose>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="card card-custom p-4 p-md-5 shadow-sm">
            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                <div>
                    <h3 class="fw-bold text-primary mb-1"><i class="fa fa-pen-to-square me-2"></i> Cập Nhật Category #${cate.categoryid}</h3>
                    <p class="text-muted small mb-0">Chỉnh sửa thông tin danh mục trong hệ thống</p>
                </div>
                <a class="btn btn-outline-secondary btn-sm" href="<c:url value='/admin/categories'/>">
                    <i class="fa fa-arrow-left me-1"></i> Quay lại
                </a>
            </div>

            <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <input type="hidden" name="categoryid" value="${cate.categoryid}">

                <div class="row g-3 mb-3">
                    <div class="col-md-3">
                        <label class="form-label fw-bold">Mã danh mục</label>
                        <input class="form-control bg-light" value="${cate.categoryid}" readonly disabled>
                    </div>
                    <div class="col-md-9">
                        <label for="categoryname" class="form-label fw-bold">Tên danh mục <span class="text-danger">*</span></label>
                        <input type="text" id="categoryname" name="categoryname" class="form-control"
                               value="${cate.categoryname}" maxlength="100" required autofocus>
                        <div class="invalid-feedback">Tên danh mục không được để trống (tối đa 100 ký tự).</div>
                    </div>
                </div>

                <div class="card bg-light border-0 p-3 mb-3 rounded-3">
                    <h6 class="fw-bold text-dark mb-3"><i class="fa fa-image me-2 text-primary"></i> Quản Lý Hình Ảnh</h6>

                    <div class="mb-3 text-center">
                        <label class="form-label fw-semibold d-block text-start">Ảnh hiện tại:</label>
                        <img src="${imgUrl}" alt="Ảnh ${cate.categoryname}" width="200" height="130"
                             class="rounded border object-fit-cover shadow-sm"
                             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/category-placeholder.svg';">
                    </div>

                    <div class="mb-3">
                        <label for="images1" class="form-label fw-semibold">Tải ảnh mới từ máy tính (Multipart Upload):</label>
                        <input type="file" id="images1" name="images1" class="form-control"
                               accept="image/jpeg,image/png,image/gif,image/webp">
                        <small class="text-muted">Chấp nhận JPG, PNG, GIF, WEBP (tối đa 10 MB). File tải lên được ưu tiên.</small>
                    </div>

                    <div class="mb-2">
                        <label for="images" class="form-label fw-semibold">Hoặc đường dẫn ảnh mới (URL):</label>
                        <input type="url" id="images" name="images" class="form-control"
                               value="${isRemoteImage ? cate.images : ''}" placeholder="https://example.com/category.jpg">
                        <small class="text-muted">Để trống các trường ảnh nếu muốn giữ lại ảnh hiện tại.</small>
                    </div>
                </div>

                <fieldset class="mb-4">
                    <legend class="fs-6 fw-bold mb-2">Trạng thái danh mục:</legend>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="ston" name="status" value="1" required ${cate.status == 1 ? 'checked' : ''}>
                        <label class="form-check-label text-success fw-bold" for="ston">
                            <i class="fa fa-check-circle me-1"></i> Hoạt động
                        </label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="stoff" name="status" value="0" ${cate.status != 1 ? 'checked' : ''}>
                        <label class="form-check-label text-secondary fw-bold" for="stoff">
                            <i class="fa fa-lock me-1"></i> Tạm khóa
                        </label>
                    </div>
                </fieldset>

                <div class="d-flex gap-2 pt-3 border-top">
                    <button class="btn btn-primary btn-lg px-4 fw-bold shadow-sm" type="submit">
                        <i class="fa fa-save me-1"></i> Lưu Thay Đổi
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
