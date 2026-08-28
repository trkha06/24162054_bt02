<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lỗi 404 - Trang Không Tồn Tại</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="height: 100vh;">
    <div class="text-center p-5 bg-white rounded shadow">
        <h1 class="display-1 text-danger fw-bold">404</h1>
        <h2>Xảy ra lỗi, trang không tồn tại!</h2>
        <p class="text-muted">Đường dẫn bạn yêu cầu không hợp lệ hoặc đã bị xoá.</p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary mt-3">Về Trang Chủ Portal</a>
    </div>
</body>
</html>
