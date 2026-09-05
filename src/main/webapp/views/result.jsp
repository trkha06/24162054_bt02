<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Kết Quả Tải Tệp - shopbanhangcuakha</title>
</head>
<body>
<div class="row justify-content-center my-4">
    <div class="col-md-7 col-lg-6">
        <div class="card card-custom p-4 p-md-5 text-center shadow-sm">
            <div class="bg-success text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3" style="width: 70px; height: 70px;">
                <i class="fa fa-circle-check fa-2x"></i>
            </div>
            <h3 class="fw-bold text-dark mb-2">Tải Tệp Thành Công</h3>
            <p class="text-muted mb-4">${message}</p>
            <div class="d-flex justify-content-center gap-2">
                <a class="btn btn-outline-secondary px-4" href="${pageContext.request.contextPath}/home">Về Trang Chủ</a>
                <a class="btn btn-primary px-4" href="${pageContext.request.contextPath}/multiPartServlet">Tải Tệp Khác</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
