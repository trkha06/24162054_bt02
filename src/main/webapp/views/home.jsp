<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Trang Chủ - Cửa Hàng Trực Tuyến" />
</jsp:include>
<body>
<jsp:include page="common/topbar.jsp" />

<div class="container py-4">
    <div class="p-5 mb-4 bg-primary text-white rounded-3 shadow-sm">
        <div class="container-fluid py-2">
            <h1 class="display-6 fw-bold"><i class="fa fa-shopping-bag"></i> Hệ Thống Quản Lý & Bán Hàng Trực Tuyến</h1>
            <p class="col-md-9 fs-5">Mô hình MVC 3 Tầng kết hợp Jakarta Servlet 6.0, JPA Hibernate và MySQL Database.</p>
            <div class="d-flex gap-2">
                <a class="btn btn-warning btn-lg fw-bold" href="${pageContext.request.contextPath}/product">
                    <i class="fa fa-th-large"></i> Xem Tất Cả Sản Phẩm
                </a>
                <c:if test="${sessionScope.account != null && sessionScope.account.roleid == 1}">
                    <a class="btn btn-light btn-lg fw-bold text-primary" href="${pageContext.request.contextPath}/admin/products">
                        <i class="fa fa-cogs"></i> Quản Trị Sản Phẩm
                    </a>
                </c:if>
            </div>
        </div>
    </div>

    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
        <div>
            <h2 class="h4 fw-bold text-primary mb-0">
                <i class="fa fa-fire text-danger"></i> 10 Sản Phẩm Mới Nhất
            </h2>
            <small class="text-muted">Các mặt hàng vừa được cập nhật vào hệ thống</small>
        </div>
        <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-primary btn-sm">
            Xem thêm <i class="fa fa-arrow-right"></i>
        </a>
    </div>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-3">
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
                <div class="card h-100 shadow-sm border-0 position-relative">
                    <a href="${pageContext.request.contextPath}/product/detail?id=${prod.productId}" class="text-decoration-none">
                        <img src="${prodImg}" class="card-img-top object-fit-cover" height="180" alt="${prod.productName}"
                             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/category-placeholder.svg';">
                    </a>
                    <div class="card-body d-flex flex-column p-3">
                        <span class="badge bg-secondary mb-2 align-self-start">${prod.category != null ? prod.category.categoryname : 'Chưa phân loại'}</span>
                        <h6 class="card-title text-truncate mb-2" title="${prod.productName}">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${prod.productId}" class="text-dark text-decoration-none fw-bold">
                                ${prod.productName}
                            </a>
                        </h6>
                        <div class="mt-auto">
                            <div class="text-danger fw-bold fs-6 mb-2">
                                <fmt:formatNumber value="${prod.price}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
                            </div>
                            <a href="${pageContext.request.contextPath}/product/detail?id=${prod.productId}" class="btn btn-outline-primary btn-sm w-100">
                                <i class="fa fa-eye"></i> Chi tiết
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty top10Products}">
        <div class="alert alert-info text-center py-4">
            <i class="fa fa-info-circle"></i> Chưa có sản phẩm nào trong hệ thống.
        </div>
    </c:if>
</div>
<jsp:include page="common/footer.jsp" />
</body>
</html>