<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Category - Admin Portal | shopbanhangcuakha</title>
</head>
<body>
    <div class="card card-custom p-4">
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
            <div>
                <h2 class="h3 fw-bold text-dark mb-1"><i class="fa fa-folder-tree text-warning me-2"></i> Quản Lý Danh Mục Category</h2>
                <div class="text-muted small">CRUD theo mô hình MVC 3 tầng, ánh xạ dữ liệu bằng JPA/Hibernate</div>
            </div>
            <a class="btn btn-success fw-bold shadow-sm" href="<c:url value='/admin/category/add'/>">
                <i class="fa fa-plus me-1"></i> Thêm Danh Mục Mới
            </a>
        </div>

        <form action="<c:url value='/admin/categories'/>" method="get" class="row g-2 mb-4">
            <div class="col-md-7 col-lg-5">
                <div class="input-group">
                    <input name="q" class="form-control" value="${keyword}" placeholder="Tìm kiếm theo tên danh mục..." maxlength="100">
                    <button class="btn btn-primary" type="submit"><i class="fa fa-search me-1"></i> Tìm</button>
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
                    <th style="width: 160px">Hình ảnh</th>
                    <th>Tên danh mục</th>
                    <th style="width: 140px">Trạng thái</th>
                    <th style="width: 180px">Thao tác</th>
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
                        <td class="text-center fw-semibold">${(currentPage - 1) * pageSize + stt.index + 1}</td>
                        <td class="text-center">
                            <img src="${imgUrl}" alt="Ảnh ${cate.categoryname}" width="120" height="80"
                                 class="rounded border object-fit-cover shadow-sm"
                                 onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/category-placeholder.svg';">
                        </td>
                        <td class="fw-bold text-dark">${cate.categoryname}</td>
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${cate.status == 1}"><span class="badge bg-success px-3 py-2">Hoạt động</span></c:when>
                                <c:otherwise><span class="badge bg-secondary px-3 py-2">Đã khóa</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-center text-nowrap">
                            <c:url value="/admin/category/edit" var="editUrl"><c:param name="id" value="${cate.categoryid}" /></c:url>
                            <c:url value="/admin/category/delete" var="deleteUrl"><c:param name="id" value="${cate.categoryid}" /></c:url>
                            <a class="btn btn-warning btn-sm fw-semibold me-1" href="${editUrl}"><i class="fa fa-pen me-1"></i> Sửa</a>
                            <a class="btn btn-danger btn-sm fw-semibold" href="${deleteUrl}"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục &quot;${cate.categoryname}&quot;?');"><i class="fa fa-trash me-1"></i> Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listcate}">
                    <tr><td colspan="5" class="text-center text-muted py-5">Không tìm thấy danh mục nào phù hợp.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 pt-3 border-top">
            <span class="text-muted">Tổng số: <b>${totalItems}</b> danh mục</span>
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
</body>
</html>
