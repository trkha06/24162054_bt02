<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Tải tệp Multipart" />
</jsp:include>
<body>
<jsp:include page="common/topbar.jsp" />
<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-6">
            <div class="card card-custom p-4">
                <h1 class="h4 text-primary fw-bold mb-3"><i class="fa fa-cloud-arrow-up"></i> Tải tệp bằng Servlet Multipart</h1>
                <p class="text-muted">Chọn một tệp có dung lượng tối đa 10 MB.</p>
                <form method="post" action="${pageContext.request.contextPath}/multiPartServlet" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="multiPartServlet" class="form-label fw-semibold">Chọn tệp</label>
                        <input id="multiPartServlet" type="file" name="multiPartServlet" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="fa fa-upload"></i> Tải lên</button>
                </form>
            </div>
        </div>
    </div>
</main>
<jsp:include page="common/footer.jsp" />
</body>
</html>
