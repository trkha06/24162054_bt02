<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Trang Chủ Người Dùng - Shopping Servlet MVC" />
</jsp:include>
<body>
<jsp:include page="common/topbar.jsp" />

<div class="container my-4">
    <!-- User Welcome Banner -->
    <div class="card card-custom p-4 shadow-sm mb-4">
        <div class="d-flex flex-wrap align-items-center justify-content-between gap-3">
            <div class="d-flex align-items-center gap-3">
                <c:choose>
                    <c:when test="${not empty sessionScope.account.avatar}">
                        <c:choose>
                            <c:when test="${sessionScope.account.avatar.startsWith('http')}">
                                <img src="${sessionScope.account.avatar}" alt="Avatar" class="rounded-circle shadow" style="width: 70px; height: 70px; object-fit: cover;">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.avatar}" alt="Avatar" class="rounded-circle shadow" style="width: 70px; height: 70px; object-fit: cover;" onerror="this.src='https://ui-avatars.com/api/?name=${sessionScope.account.fullName}&background=0d6efd&color=fff&size=70'">
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <img src="https://ui-avatars.com/api/?name=${sessionScope.account.fullName}&background=0d6efd&color=fff&size=70" alt="Avatar" class="rounded-circle shadow" style="width: 70px; height: 70px; object-fit: cover;">
                    </c:otherwise>
                </c:choose>
                <div>
                    <h4 class="text-primary fw-bold mb-1">Xin chào, ${sessionScope.account.fullName}!</h4>
                    <p class="text-muted mb-0 small">Tài khoản: <b>@${sessionScope.account.userName}</b> | Email: <b>${sessionScope.account.email}</b></p>
                </div>
            </div>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-primary btn-sm">
                    <i class="fa fa-user-edit me-1"></i> Hồ sơ cá nhân
                </a>
                <c:if test="${sessionScope.account.roleid == 1}">
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-danger btn-sm">
                        <i class="fa fa-cogs me-1"></i> Quản lý Category (Admin)
                    </a>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Danh sách Danh mục / Category Sản Phẩm -->
    <div class="d-flex align-items-center justify-content-between mb-3">
        <h3 class="fw-bold text-dark mb-0"><i class="fa fa-th-large text-primary me-2"></i> Danh Mục Sản Phẩm</h3>
        <span class="badge bg-primary fs-6">${listCategory != null ? listCategory.size() : 0} danh mục</span>
    </div>

    <div class="row g-4">
        <c:forEach items="${listCategory}" var="cate">
            <c:choose>
                <c:when test="${not empty cate.images && (cate.images.startsWith('http://') || cate.images.startsWith('https://'))}">
                    <c:set var="cateImg" value="${cate.images}" />
                </c:when>
                <c:otherwise>
                    <c:url value="/image" var="cateImg"><c:param name="fname" value="${cate.images}" /></c:url>
                </c:otherwise>
            </c:choose>

            <div class="col-sm-6 col-md-4 col-lg-3">
                <div class="card card-custom h-100 shadow-sm border-0 overflow-hidden">
                    <div class="position-relative" style="height: 180px; background: #e9ecef;">
                        <img src="${cateImg}" class="w-100 h-100 object-fit-cover" alt="${cate.categoryname}"
                             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/category-placeholder.svg';">
                        <c:choose>
                            <c:when test="${cate.status == 1}">
                                <span class="position-absolute top-0 end-0 badge bg-success m-2">Đang mở</span>
                            </c:when>
                            <c:otherwise>
                                <span class="position-absolute top-0 end-0 badge bg-secondary m-2">Đã đóng</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="card-body text-center d-flex flex-column justify-content-between">
                        <h5 class="card-title fw-bold text-dark mb-2">${cate.categoryname}</h5>
                        <p class="card-text text-muted small mb-3">Mã danh mục: #${cate.categoryid}</p>
                        <a href="#" class="btn btn-outline-primary btn-sm w-100 mt-auto">
                            <i class="fa fa-eye me-1"></i> Xem sản phẩm
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty listCategory}">
            <div class="col-12">
                <div class="card p-5 text-center text-muted">
                    <i class="fa fa-folder-open fa-3x mb-3 text-secondary"></i>
                    <h5>Chưa có danh mục nào trong hệ thống.</h5>
                    <p class="small">Admin có thể thêm danh mục tại trang Quản trị Category.</p>
                </div>
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>