<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Cập nhật danh mục" />
</jsp:include>
<body>
<jsp:include page="../common/topbar.jsp" />

<c:set var="isRemoteImage" value="${not empty cate.images && (cate.images.startsWith('http://') || cate.images.startsWith('https://'))}" />
<c:choose>
    <c:when test="${isRemoteImage}"><c:set var="imgUrl" value="${cate.images}" /></c:when>
    <c:otherwise>
        <c:url value="/image" var="imgUrl"><c:param name="fname" value="${cate.images}" /></c:url>
    </c:otherwise>
</c:choose>

<main class="container py-4">
    <div class="card card-custom p-4 mx-auto" style="max-width: 720px">
        <h2 class="h3 fw-bold text-primary mb-3"><i class="fa fa-pen-to-square"></i> Cập nhật Category</h2>
        <c:if test="${not empty alert}"><div class="alert alert-danger">${alert}</div></c:if>

        <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
            <input type="hidden" name="categoryid" value="${cate.categoryid}">
            <div class="mb-3">
                <label class="form-label fw-semibold">Mã danh mục</label>
                <input class="form-control" value="${cate.categoryid}" readonly>
            </div>
            <div class="mb-3">
                <label for="categoryname" class="form-label fw-semibold">Tên danh mục <span class="text-danger">*</span></label>
                <input type="text" id="categoryname" name="categoryname" class="form-control"
                       value="${cate.categoryname}" maxlength="100" required autofocus>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold d-block">Ảnh hiện tại</label>
                <img src="${imgUrl}" alt="Ảnh ${cate.categoryname}" width="200" height="135"
                     class="rounded border object-fit-cover"
                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/category-placeholder.svg';">
            </div>
            <div class="mb-3">
                <label for="images" class="form-label fw-semibold">Link ảnh mới</label>
                <input type="url" id="images" name="images" class="form-control"
                       value="${isRemoteImage ? cate.images : ''}" placeholder="https://example.com/category.jpg">
                <div class="form-text">Để trống nếu muốn giữ ảnh hiện tại.</div>
            </div>
            <div class="mb-3">
                <label for="images1" class="form-label fw-semibold">Hoặc tải ảnh mới từ máy</label>
                <input type="file" id="images1" name="images1" class="form-control"
                       accept="image/jpeg,image/png,image/gif,image/webp">
                <div class="form-text">File tải lên được ưu tiên; tối đa 10 MB.</div>
            </div>
            <fieldset class="mb-4">
                <legend class="fs-6 fw-semibold">Trạng thái</legend>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="ston" name="status" value="1" ${cate.status == 1 ? 'checked' : ''}>
                    <label class="form-check-label" for="ston">Hoạt động</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="stoff" name="status" value="0" ${cate.status != 1 ? 'checked' : ''}>
                    <label class="form-check-label" for="stoff">Khóa</label>
                </div>
            </fieldset>
            <button class="btn btn-primary" type="submit"><i class="fa fa-floppy-disk"></i> Lưu thay đổi</button>
            <a class="btn btn-outline-secondary" href="<c:url value='/admin/categories'/>">Hủy</a>
        </form>
    </div>
</main>
</body>
</html>
