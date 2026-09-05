<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Cửa Hàng Trực Tuyến shopbanhangcuakha</title>
</head>
<body>
    <div class="p-5 mb-5 bg-primary text-white rounded-4 shadow-sm position-relative overflow-hidden" style="background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%) !important;">
        <div class="row align-items-center position-relative" style="z-index: 2;">
            <div class="col-lg-8">
                <span class="badge bg-warning text-dark fw-bold mb-3 px-3 py-2 fs-6"><i class="fa fa-fire"></i> Hệ Thống Thương Mại & Quản Trị</span>
                <h1 class="display-5 fw-bold mb-3">Chào Mừng Đến Với Cửa Hàng Trực Tuyến</h1>
                <p class="fs-5 mb-4 text-light opacity-90">
                    Dự án Lập Trình Web MVC 3-Tier xây dựng với Jakarta Servlet 6.0, JPA Hibernate, SiteMesh 3 Decorator và Bootstrap 5.
                </p>
                <div class="d-flex flex-wrap gap-3">
                    <a class="btn btn-warning btn-lg fw-bold text-dark px-4 shadow" href="${pageContext.request.contextPath}/product">
                        <i class="fa fa-th-large me-2"></i> Khám Phá Sản Phẩm
                    </a>
                    <c:if test="${sessionScope.account != null && sessionScope.account.roleid == 1}">
                        <a class="btn btn-outline-light btn-lg fw-bold px-4" href="${pageContext.request.contextPath}/admin/home">
                            <i class="fa fa-cogs me-2"></i> Trang Quản Trị Admin
                        </a>
                    </c:if>
                </div>
            </div>
            <div class="col-lg-4 text-center d-none d-lg-block">
                <i class="fa fa-store display-1 text-white opacity-25"></i>
            </div>
        </div>
    </div>

    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
        <div>
            <h2 class="h3 fw-bold text-dark mb-1">
                <i class="fa fa-star text-warning me-2"></i> 10 Sản Phẩm Mới Nhất
            </h2>
            <small class="text-muted">Các mặt hàng được cập nhật mới nhất trên hệ thống</small>
        </div>
        <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-primary btn-sm fw-semibold">
            Xem tất cả <i class="fa fa-arrow-right ms-1"></i>
        </a>
    </div>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-4">
        <c:forEach items="${top10Products}" var="prod">
            <c:choose>
                <c:when test="${not empty prod.images && (prod.images.startsWith('http://') || prod.images.startsWith('https://'))}">
                    <c:set var="prodImg" value="${prod.images}" />
                </c:when>
                <c:otherwise>
                    <c:url value="/image" var="prodImg"><c:param name="fname" value="${prod.images}" /></c:url>
                </c:otherwise>
            </c:choose>
            <div class="col">
                <div class="card card-custom h-100 position-relative transition-hover overflow-hidden">
                    <a href="${pageContext.request.contextPath}/product/detail?id=${prod.productId}" class="text-decoration-none">
                        <img src="${prodImg}" class="card-img-top object-fit-cover" height="200" alt="${prod.productName}"
                             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/category-placeholder.svg';">
                    </a>
                    <div class="card-body d-flex flex-column p-3">
                        <span class="badge bg-light text-primary border align-self-start mb-2">${prod.category != null ? prod.category.categoryname : 'Chưa phân loại'}</span>
                        <h6 class="card-title text-truncate mb-2" title="${prod.productName}">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${prod.productId}" class="text-dark text-decoration-none fw-bold">
                                ${prod.productName}
                            </a>
                        </h6>
                        <div class="mt-auto pt-2">
                            <div class="text-danger fw-bold fs-5 mb-2">
                                <fmt:formatNumber value="${prod.price}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
                            </div>
                            <a href="${pageContext.request.contextPath}/product/detail?id=${prod.productId}" class="btn btn-primary btn-sm w-100 fw-semibold">
                                <i class="fa fa-eye me-1"></i> Chi tiết
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty top10Products}">
        <div class="card card-custom p-5 text-center my-4">
            <i class="fa fa-box-open display-4 text-muted mb-3"></i>
            <h5 class="text-muted">Chưa có sản phẩm nào trong hệ thống.</h5>
            <p class="text-secondary small">Vui lòng quay lại sau hoặc đăng nhập với quyền Admin để thêm sản phẩm mới.</p>
        </div>
    </c:if>
</body>
</html>
