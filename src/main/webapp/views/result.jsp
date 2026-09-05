<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Kết quả tải tệp" />
</jsp:include>
<body>
<jsp:include page="common/topbar.jsp" />
<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-6">
            <div class="card card-custom p-4 text-center">
                <i class="fa fa-circle-check text-success display-5 mb-3"></i>
                <h1 class="h4 fw-bold">Kết quả tải tệp</h1>
                <p class="mb-4">${message}</p>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/multiPartServlet">Tải tệp khác</a>
            </div>
        </div>
    </div>
</main>
<jsp:include page="common/footer.jsp" />
</body>
</html>
