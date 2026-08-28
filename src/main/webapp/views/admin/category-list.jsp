<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Quản lý danh mục bằng JPA" />
</jsp:include>
<body>
<jsp:include page="../common/topbar.jsp" />

<main class="container py-4">
    <div class="card card-custom p-4">
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
            <div>
                <h2 class="h3 fw-bold text-primary mb-1"><i class="fa fa-folder-tree"></i> Quản lý Category</h2>
                <div class="text-muted">CRUD theo mô hình MVC 3 tầng, lưu dữ liệu bằng JPA/Hibernate.</div>
            </div>
            <a class="btn btn-success" href="<c:url value='/admin/category/add'/>">
                <i class="fa fa-plus"></i> Thêm danh mục
            </a>
        </div>

        <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
        <c:if test="${not empty alert}"><div class="alert alert-danger">${alert}</div></c:if>

        <form action="<c:url value='/admin/categories'/>" method="get" class="row g-2 mb-3">
            <div class="col-md-7 col-lg-5">
                <label for="q" class="visually-hidden">Tên danh mục</label>
                <div class="input-group">
                    <input id="q" name="q" class="form-control" value="${keyword}"
                           placeholder="Tìm theo tên danh mục..." maxlength="100">
                    <button class="btn btn-primary" type="submit"><i class="fa fa-search"></i> Tìm</button>
                    <c:if test="${not empty keyword}">
                        <a class="btn btn-outline-secondary" href="<c:url value='/admin/categories'/>">Xóa lọc</a>
                    </c:if>
                </div>
            </div>
        </form>

        <div class="table-responsive">
            <table class="table table-hover table-bordered align-middle">
                <thead class="table-dark text-center">
                <tr>
                    <th style="width: 70px">STT</th>
                    <th style="width: 190px">Hình ảnh</th>
                    <th>Tên danh mục</th>
                    <th style="width: 120px">Trạng thái</th>
                    <th style="width: 170px">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${listcate}" var="cate" varStatus="stt">
                    <c:choose>
                        <c:when test="${not empty cate.images && (cate.images.startsWith('http://') || cate.images.startsWith('https://'))}">
                            <c:set var="imgUrl" value="${cate.images}" />
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image" var="imgUrl"><c:param name="fname" value="${cate.images}" /></c:url>
                        </c:otherwise>
                    </c:choose>
                    <tr>
                        <td class="text-center">${(currentPage - 1) * pageSize + stt.index + 1}</td>
                        <td class="text-center">
                            <img src="${imgUrl}" alt="Ảnh ${cate.categoryname}" width="150" height="100"
                                 class="rounded border object-fit-cover"
                                 onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/category-placeholder.svg';">
                        </td>
                        <td class="fw-semibold">${cate.categoryname}</td>
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${cate.status == 1}"><span class="badge bg-success">Hoạt động</span></c:when>
                                <c:otherwise><span class="badge bg-secondary">Đã khóa</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-center text-nowrap">
                            <c:url value="/admin/category/edit" var="editUrl"><c:param name="id" value="${cate.categoryid}" /></c:url>
                            <c:url value="/admin/category/delete" var="deleteUrl"><c:param name="id" value="${cate.categoryid}" /></c:url>
                            <a class="btn btn-warning btn-sm" href="${editUrl}"><i class="fa fa-pen"></i> Sửa</a>
                            <a class="btn btn-danger btn-sm" href="${deleteUrl}"
                               onclick="return confirm('Bạn chắc chắn muốn xóa danh mục này?');"><i class="fa fa-trash"></i> Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listcate}">
                    <tr><td colspan="5" class="text-center text-muted py-5">Không tìm thấy danh mục phù hợp.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <div class="d-flex flex-wrap justify-content-between align-items-center gap-2">
            <span class="text-muted">Tổng số: ${totalItems} danh mục</span>
            <c:if test="${totalPages > 1}">
                <nav aria-label="Phân trang danh mục">
                    <ul class="pagination mb-0">
                        <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                            <c:url value="/admin/categories" var="pageUrl"><c:param name="page" value="${pageNumber}" /></c:url>
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
</body>
</html>
