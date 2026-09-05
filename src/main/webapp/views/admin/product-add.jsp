<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Thêm Sản Phẩm Mới" />
</jsp:include>
<body>
<jsp:include page="../common/topbar.jsp" />

<main class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card card-custom p-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h3 class="fw-bold text-success mb-0"><i class="fa fa-plus-circle"></i> Thêm Sản Phẩm Mới</h3>
                    <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary btn-sm"><i class="fa fa-arrow-left"></i> Quay lại</a>
                </div>

                <c:if test="${not empty alert}"><div class="alert alert-danger">${alert}</div></c:if>

                <form action="<c:url value='/admin/product/insert'/>" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên sản phẩm (*):</label>
                        <input type="text" name="productname" class="form-control" value="${product.productName}" placeholder="Nhập tên sản phẩm..." required>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Danh mục của sản phẩm:</label>
                            <select name="categoryid" class="form-select">
                                <option value="0">-- Chọn danh mục --</option>
                                <c:forEach items="${categories}" var="c">
                                    <option value="${c.categoryid}" ${product.category != null && product.category.categoryid == c.categoryid ? 'selected' : ''}>
                                        ${c.categoryname}
                                    </option>
                                </c:forEach>
                            </select>
                            <small class="text-muted">Mỗi sản phẩm thuộc một danh mục; một danh mục có thể có nhiều sản phẩm.</small>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-semibold">Đơn giá (VNĐ):</label>
                            <input type="number" name="price" class="form-control" value="${product.price > 0 ? product.price : 0}" min="0" step="1000" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-semibold">Số lượng:</label>
                            <input type="number" name="quantity" class="form-control" value="${product.quantity > 0 ? product.quantity : 10}" min="0" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mô tả sản phẩm:</label>
                        <textarea name="description" class="form-control" rows="4" placeholder="Nhập thông tin chi tiết về sản phẩm...">${product.description}</textarea>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Tải lên tệp ảnh (Multipart File):</label>
                            <input type="file" name="images1" class="form-control" accept="image/*">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Hoặc đường dẫn ảnh Online (URL):</label>
                            <input type="url" name="images" class="form-control" value="${product.images}" placeholder="https://domain.com/image.jpg">
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold d-block">Trạng thái:</label>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status" id="status1" value="1" checked>
                            <label class="form-check-label text-success fw-bold" for="status1">Hoạt động / Mở bán</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status" id="status0" value="0">
                            <label class="form-check-label text-secondary fw-bold" for="status0">Khóa / Tạm dừng</label>
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-success px-4 py-2 fw-bold"><i class="fa fa-save"></i> Lưu Sản Phẩm</button>
                        <a href="<c:url value='/admin/products'/>" class="btn btn-secondary px-4 py-2">Hủy bỏ</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>
<jsp:include page="../common/footer.jsp" />
</body>
</html>
