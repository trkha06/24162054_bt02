<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Sản Phẩm - Cửa Hàng Trực Tuyến shopbanhangcuakha</title>
</head>
<body>
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
        <div>
            <h2 class="h3 fw-bold text-primary mb-1"><i class="fa fa-boxes-stacked me-2"></i> Danh Sách Sản Phẩm</h2>
            <div class="text-muted">Phân trang 6 sản phẩm/trang, lọc theo danh mục và tìm kiếm từ khóa</div>
        </div>

        <form action="${pageContext.request.contextPath}/product" method="get" class="d-flex gap-2">
            <c:if test="${selectedCid > 0}">
                <input type="hidden" name="cid" value="${selectedCid}">
            </c:if>
            <div class="input-group">
                <input type="text" name="q" class="form-control" maxlength="100" placeholder="Tìm kiếm sản phẩm..." value="${keyword}">
                <button class="btn btn-primary" type="submit"><i class="fa fa-search"></i> Tìm</button>
                <c:if test="${not empty keyword || selectedCid > 0}">
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-secondary">Xóa lọc</a>
                </c:if>
            </div>
        </form>
    </div>

    <div class="d-flex flex-wrap gap-2 mb-4 pb-2 border-bottom">
        <a href="${pageContext.request.contextPath}/product" class="btn ${selectedCid == 0 ? 'btn-primary' : 'btn-outline-secondary'} btn-sm fw-semibold">
            <i class="fa fa-th-large me-1"></i> Tất cả danh mục
        </a>
        <c:forEach items="${categories}" var="c">
            <a href="${pageContext.request.contextPath}/product?cid=${c.categoryid}" class="btn ${selectedCid == c.categoryid ? 'btn-primary' : 'btn-outline-secondary'} btn-sm fw-semibold">
                <i class="fa fa-folder me-1"></i> ${c.categoryname}
            </a>
        </c:forEach>
    </div>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 mb-4">
        <c:forEach items="${products}" var="prod">
            <c:choose>
                <c:when test="${not empty prod.images && (prod.images.startsWith('http://') || prod.images.startsWith('https://'))}">
                    <c:set var="prodImg" value="${prod.images}" />
                </c:when>
                <c:otherwise>
                    <c:url value="/image" var="prodImg"><c:param name="fname" value="${prod.images}" /></c:url>
                </c:otherwise>
            </c:choose>
            <div class="col">
                <div class="card card-custom h-100 position-relative overflow-hidden">
                    <a href="${pageContext.request.contextPath}/product/detail?id=${prod.productId}" class="text-decoration-none">
                        <img src="${prodImg}" class="card-img-top object-fit-cover" height="220" alt="${prod.productName}"
                             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/category-placeholder.svg';">
                    </a>
                    <div class="card-body d-flex flex-column p-3">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge bg-light text-primary border">${prod.category != null ? prod.category.categoryname : 'Chưa phân loại'}</span>
                            <span class="badge ${prod.quantity > 0 ? 'bg-success' : 'bg-danger'}">
                                ${prod.quantity > 0 ? 'Còn hàng' : 'Hết hàng'}
                            </span>
                        </div>
                        <h5 class="card-title mb-2">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${prod.productId}" class="text-dark text-decoration-none fw-bold">
                                ${prod.productName}
                            </a>
                        </h5>
                        <p class="card-text text-muted small mb-3" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                            ${not empty prod.description ? prod.description : 'Chưa có mô tả chi tiết cho sản phẩm này.'}
                        </p>
                        <div class="mt-auto d-flex justify-content-between align-items-center pt-2">
                            <span class="text-danger fw-bold fs-5">
                                <fmt:formatNumber value="${prod.price}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
                            </span>
                            <a href="${pageContext.request.contextPath}/product/detail?id=${prod.productId}" class="btn btn-primary btn-sm fw-semibold">
                                <i class="fa fa-eye me-1"></i> Xem chi tiết
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty products}">
        <div class="card card-custom p-5 text-center my-4">
            <i class="fa fa-exclamation-circle display-4 text-warning mb-3"></i>
            <h5>Không tìm thấy sản phẩm phù hợp</h5>
            <p class="text-muted">Vui lòng thử lại với từ khóa hoặc danh mục khác.</p>
            <div>
                <a href="${pageContext.request.contextPath}/product" class="btn btn-primary btn-sm mt-2">Xem tất cả sản phẩm</a>
            </div>
        </div>
    </c:if>

    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 pt-3 border-top">
        <span class="text-muted">Tổng số: <b>${totalItems}</b> sản phẩm (Trang ${currentPage} / ${totalPages})</span>
        <c:if test="${totalPages > 1}">
            <nav aria-label="Phân trang sản phẩm">
                <ul class="pagination mb-0">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/product?page=${currentPage - 1}&cid=${selectedCid}&q=${keyword}">&laquo; Trước</a>
                        </li>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                        <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/product?page=${pageNumber}&cid=${selectedCid}&q=${keyword}">${pageNumber}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/product?page=${currentPage + 1}&cid=${selectedCid}&q=${keyword}">Sau &raquo;</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </c:if>
    </div>
</body>
</html>
