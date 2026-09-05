<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${product.productName} - Chi Tiết Sản Phẩm | shopbanhangcuakha</title>
</head>
<body>
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb bg-white p-3 rounded-3 shadow-sm">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none"><i class="fa fa-home me-1"></i> Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/product" class="text-decoration-none">Sản phẩm</a></li>
            <c:if test="${product.category != null}">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/product?cid=${product.category.categoryid}" class="text-decoration-none">${product.category.categoryname}</a></li>
            </c:if>
            <li class="breadcrumb-item active text-truncate" aria-current="page" style="max-width: 300px;">${product.productName}</li>
        </ol>
    </nav>

    <c:choose>
        <c:when test="${not empty product.images && (product.images.startsWith('http://') || product.images.startsWith('https://'))}">
            <c:set var="detailImg" value="${product.images}" />
        </c:when>
        <c:otherwise>
            <c:url value="/image" var="detailImg"><c:param name="fname" value="${product.images}" /></c:url>
        </c:otherwise>
    </c:choose>

    <div class="card card-custom p-4 mb-5 shadow-sm">
        <div class="row g-4">
            <div class="col-md-5 text-center">
                <img src="${detailImg}" alt="${product.productName}" class="img-fluid rounded border object-fit-cover w-100 shadow-sm" style="max-height: 420px;"
                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/category-placeholder.svg';">
            </div>
            <div class="col-md-7">
                <span class="badge bg-primary mb-2 px-3 py-2 fs-6">${product.category != null ? product.category.categoryname : 'Chưa phân loại'}</span>
                <h2 class="fw-bold mb-3 text-dark">${product.productName}</h2>
                <div class="mb-3">
                    <span class="text-danger fw-bold fs-2">
                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
                    </span>
                </div>

                <div class="row mb-3 g-2">
                    <div class="col-sm-6">
                        <div class="p-3 border rounded-3 bg-light">
                            <small class="text-muted d-block"><i class="fa fa-warehouse me-1"></i> Tình trạng kho:</small>
                            <span class="fw-bold ${product.quantity > 0 ? 'text-success' : 'text-danger'}">
                                ${product.quantity > 0 ? 'Còn hàng (' : 'Hết hàng'}
                                <c:if test="${product.quantity > 0}">${product.quantity} sản phẩm)</c:if>
                            </span>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="p-3 border rounded-3 bg-light">
                            <small class="text-muted d-block"><i class="fa fa-tag me-1"></i> Trạng thái mở bán:</small>
                            <span class="fw-bold ${product.status == 1 ? 'text-success' : 'text-secondary'}">
                                ${product.status == 1 ? 'Đang mở bán' : 'Tạm ngưng'}
                            </span>
                        </div>
                    </div>
                </div>

                <div class="mb-4">
                    <h5 class="fw-bold text-secondary mb-2"><i class="fa fa-align-left me-1"></i> Mô tả sản phẩm:</h5>
                    <div class="p-3 bg-light rounded-3 border text-muted" style="line-height: 1.7;">
                        ${product.description != null && !product.description.isBlank() ? product.description : 'Chưa có mô tả chi tiết cho sản phẩm này.'}
                    </div>
                </div>

                <div class="d-flex flex-wrap gap-2">
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-secondary btn-lg px-4"><i class="fa fa-arrow-left me-1"></i> Quay lại</a>
                </div>
            </div>
        </div>
    </div>

    <c:if test="${not empty relatedProducts}">
        <div class="mb-4">
            <h4 class="fw-bold text-primary mb-3"><i class="fa fa-tags me-2"></i> Sản phẩm cùng danh mục</h4>
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">
                <c:forEach items="${relatedProducts}" var="rel">
                    <c:choose>
                        <c:when test="${not empty rel.images && (rel.images.startsWith('http://') || rel.images.startsWith('https://'))}">
                            <c:set var="relImg" value="${rel.images}" />
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image" var="relImg"><c:param name="fname" value="${rel.images}" /></c:url>
                        </c:otherwise>
                    </c:choose>
                    <div class="col">
                        <div class="card card-custom h-100 shadow-sm border-0">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${rel.productId}">
                                <img src="${relImg}" class="card-img-top object-fit-cover" height="150" alt="${rel.productName}"
                                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/category-placeholder.svg';">
                            </a>
                            <div class="card-body d-flex flex-column p-3">
                                <h6 class="card-title text-truncate mb-1">
                                    <a href="${pageContext.request.contextPath}/product/detail?id=${rel.productId}" class="text-dark text-decoration-none fw-semibold">
                                        ${rel.productName}
                                    </a>
                                </h6>
                                <div class="mt-auto text-danger fw-bold">
                                    <fmt:formatNumber value="${rel.price}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>
</body>
</html>
