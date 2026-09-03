<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Thêm danh mục" />
</jsp:include>
<body>
<jsp:include page="../common/topbar.jsp" />

<main class="container py-4">
    <div class="card card-custom p-4 mx-auto" style="max-width: 720px">
        <h2 class="h3 fw-bold text-success mb-3"><i class="fa fa-folder-plus"></i> Thêm Category</h2>
        <c:if test="${not empty alert}"><div class="alert alert-danger">${alert}</div></c:if>

        <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="categoryname" class="form-label fw-semibold">Tên danh mục <span class="text-danger">*</span></label>
                <input type="text" id="categoryname" name="categoryname" class="form-control"
                       value="${formCategory.categoryname}" maxlength="100" required autofocus>
            </div>
            <div class="mb-3">
                <label for="images" class="form-label fw-semibold">Link ảnh</label>
                <input type="url" id="images" name="images" class="form-control" value="${formCategory.images}"
                       placeholder="https://example.com/category.jpg">
                <div class="form-text">Có thể nhập link hoặc tải một file bên dưới. File tải lên được ưu tiên.</div>
            </div>
            <div class="mb-3">
                <label for="images1" class="form-label fw-semibold">Tải ảnh từ máy</label>
                <input type="file" id="images1" name="images1" class="form-control"
                       accept="image/jpeg,image/png,image/gif,image/webp">
                <div class="form-text">JPG, PNG, GIF hoặc WEBP; tối đa 10 MB.</div>
            </div>
            <fieldset class="mb-4">
                <legend class="fs-6 fw-semibold">Trạng thái</legend>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="ston" name="status" value="1"
                           ${empty formCategory || formCategory.status == 1 ? 'checked' : ''}>
                    <label class="form-check-label" for="ston">Hoạt động</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="stoff" name="status" value="0"
                           ${not empty formCategory && formCategory.status != 1 ? 'checked' : ''}>
                    <label class="form-check-label" for="stoff">Khóa</label>
                </div>
            </fieldset>
            <button class="btn btn-success" type="submit"><i class="fa fa-floppy-disk"></i> Thêm danh mục</button>
            <a class="btn btn-outline-secondary" href="<c:url value='/admin/categories'/>">Hủy</a>
        </form>
    </div>
</main>
<jsp:include page="../common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
