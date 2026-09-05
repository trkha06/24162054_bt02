<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Quản lý sản phẩm bằng JPA" />
</jsp:include>
<body>
<jsp:include page="../common/topbar.jsp" />

<main class="container py-4">
    <div class="card card-custom p-4">
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
            <div>
                <h2 class="h3 fw-bold text-success mb-1"><i class="fa fa-boxes-stacked"></i> Quản lý Product (CRUD)</h2>
                <div class="text-muted">CRUD theo mô hình MVC 3 tầng, lưu trữ và quan hệ 1 - N với Category bằng JPA.</div>
            </div>
            <a class="btn btn-success" href="<c:url value='/admin/product/add'/>">
                <i class="fa fa-plus"></i> Thêm sản phẩm
            </a>
        </div>

        <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
        <c:if test="${not empty alert}"><div class="alert alert-danger">${alert}</div></c:if>

        <form action="<c:url value='/admin/products'/>" method="get" class="row g-2 mb-3">
            <div class="col-md-7 col-lg-5">
                <div class="input-group">
                    <input name="q" class="form-control" value="${keyword}" placeholder="Tìm theo tên sản phẩm...">
                    <button class="btn btn-success" type="submit"><i class="fa fa-search"></i> Tìm</button>
                    <c:if test="${not empty keyword}">
                        <a class="btn btn-outline-secondary" href="<c:url value='/admin/products'/>">Xóa lọc</a>
                    </c:if>
                </div>
            </div>
        </form>

        <div class="table-responsive">
            <table class="table table-hover table-bordered align-middle">
                <thead class="table-dark text-center">
                <tr>
                    <th style="width: 60px">STT</th>
                    <th style="width: 120px">Hình ảnh</th>
                    <th>Tên sản phẩm</th>
                    <th style="width: 150px">Danh mục</th>
                    <th style="width: 130px">Đơn giá</th>
                    <th style="width: 90px">Số lượng</th>
                    <th style="width: 120px">Trạng thái</th>
                    <th style="width: 160px">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${listProducts}" var="prod" varStatus="stt">
                    <c:choose>
                        <c:when test="${not empty prod.images && (prod.images.startsWith('http://') || prod.images.startsWith('https://'))}">
                            <c:set var="imgUrl" value="${prod.images}" />
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image" var="imgUrl"><c:param name="fname" value="${prod.images}" /></c:url>
                        </c:otherwise>
                    </c:choose>
                    <tr>
                        <td class="text-center">${(currentPage - 1) * pageSize + stt.index + 1}</td>
                        <td class="text-center">
                            <img src="${imgUrl}" alt="Ảnh ${prod.productName}" width="90" height="70"
                                 class="rounded border object-fit-cover"
                                 onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/category-placeholder.svg';">
                        </td>
                        <td class="fw-semibold">${prod.productName}</td>
                        <td class="text-center">
                            <span class="badge bg-secondary">${prod.category != null ? prod.category.categoryname : 'N/A'}</span>
                        </td>
                        <td class="text-end text-danger fw-bold">
                            <fmt:formatNumber value="${prod.price}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
                        </td>
                        <td class="text-center">${prod.quantity}</td>
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${prod.status == 1}"><span class="badge bg-success">Hoạt động</span></c:when>
                                <c:otherwise><span class="badge bg-secondary">Khóa</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-center text-nowrap">
                            <c:url value="/admin/product/edit" var="editUrl"><c:param name="id" value="${prod.productId}" /></c:url>
                            <c:url value="/admin/product/delete" var="deleteUrl"><c:param name="id" value="${prod.productId}" /></c:url>
                            <a class="btn btn-warning btn-sm" href="${editUrl}"><i class="fa fa-pen"></i> Sửa</a>
                            <a class="btn btn-danger btn-sm" href="${deleteUrl}"
                               onclick="return confirm('Bạn chắc chắn muốn xóa sản phẩm này?');"><i class="fa fa-trash"></i> Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listProducts}">
                    <tr><td colspan="8" class="text-center text-muted py-5">Không tìm thấy sản phẩm nào.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <div class="d-flex flex-wrap justify-content-between align-items-center gap-2">
            <span class="text-muted">Tổng số: ${totalItems} sản phẩm</span>
            <c:if test="${totalPages > 1}">
                <nav aria-label="Phân trang sản phẩm">
                    <ul class="pagination mb-0">
                        <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                            <c:url value="/admin/products" var="pageUrl"><c:param name="page" value="${pageNumber}" /></c:url>
                            <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                                <a class="page-link" href="${pageUrl}">${pageNumber}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </nav>
            </c:if>
        </div>
    </div>
</main>
<jsp:include page="../common/footer.jsp" />
</body>
</html>
