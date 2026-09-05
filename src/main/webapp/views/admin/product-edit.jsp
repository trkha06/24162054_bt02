<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Cập nhật sản phẩm" />
</jsp:include>
<body>
<jsp:include page="../common/topbar.jsp" />
<main class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card card-custom p-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h1 class="h3 fw-bold text-success mb-0"><i class="fa fa-pen-to-square"></i> Cập nhật sản phẩm</h1>
                    <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary btn-sm"><i class="fa fa-arrow-left"></i> Quay lại</a>
                </div>
                <c:if test="${not empty alert}"><div class="alert alert-danger">${alert}</div></c:if>
                <form action="<c:url value='/admin/product/update'/>" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="productid" value="${product.productId}">
                    <div class="mb-3">
                        <label class="form-label fw-semibold" for="productname">Tên sản phẩm</label>
                        <input id="productname" type="text" name="productname" class="form-control" value="${product.productName}" required>
                    </div>
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold" for="categoryid">Danh mục của sản phẩm</label>
                            <select id="categoryid" name="categoryid" class="form-select">
                                <option value="0">-- Chưa phân loại --</option>
                                <c:forEach items="${categories}" var="category">
                                    <option value="${category.categoryid}" ${product.category != null && product.category.categoryid == category.categoryid ? 'selected' : ''}>${category.categoryname}</option>
                                </c:forEach>
                            </select>
                            <small class="text-muted">Mỗi sản phẩm thuộc một danh mục; một danh mục có thể có nhiều sản phẩm.</small>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-semibold" for="price">Đơn giá</label>
                            <input id="price" type="number" name="price" class="form-control" value="${product.price}" min="0" step="1000" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-semibold" for="quantity">Số lượng</label>
                            <input id="quantity" type="number" name="quantity" class="form-control" value="${product.quantity}" min="0" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold" for="description">Mô tả</label>
                        <textarea id="description" name="description" class="form-control" rows="4">${product.description}</textarea>
                    </div>
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold" for="images1">Thay ảnh từ máy tính</label>
                            <input id="images1" type="file" name="images1" class="form-control" accept="image/jpeg,image/png,image/gif,image/webp">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold" for="images">Hoặc dùng URL ảnh</label>
                            <input id="images" type="url" name="images" class="form-control" value="${product.images.startsWith('http') ? product.images : ''}" placeholder="https://domain.com/image.jpg">
                        </div>
                    </div>
                    <div class="mb-4">
                        <span class="form-label fw-semibold d-block">Trạng thái</span>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status" id="status1" value="1" ${product.status == 1 ? 'checked' : ''}>
                            <label class="form-check-label" for="status1">Hoạt động</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status" id="status0" value="0" ${product.status != 1 ? 'checked' : ''}>
                            <label class="form-check-label" for="status0">Tạm dừng</label>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-success px-4"><i class="fa fa-save"></i> Lưu thay đổi</button>
                    <a href="<c:url value='/admin/products'/>" class="btn btn-secondary">Hủy</a>
                </form>
            </div>
        </div>
    </div>
</main>
<jsp:include page="../common/footer.jsp" />
</body>
</html>
