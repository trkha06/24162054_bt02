<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Đăng Nhập - Cửa Hàng Trực Tuyến" />
</jsp:include>
<body>
<jsp:include page="common/topbar.jsp" />

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card card-custom p-4">
                <div class="text-center mb-4">
                    <h3 class="fw-bold text-primary"><i class="fa fa-lock"></i> ĐĂNG NHẬP</h3>
                    <p class="text-muted">Hệ thống bài tập Servlet MVC 3-Tier</p>
                </div>

                <c:if test="${alert != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fa fa-exclamation-triangle"></i> ${alert}
                    </div>
                </c:if>
                <c:if test="${success != null}">
                    <div class="alert alert-success" role="alert">
                        <i class="fa fa-check-circle"></i> ${success}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên tài khoản hoặc Email:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa fa-user"></i></span>
                            <input type="text" class="form-control" name="username" value="${param.username}" placeholder="Nhập username hoặc email..." required autofocus />
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mật khẩu:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa fa-key"></i></span>
                            <input type="password" class="form-control" name="password" placeholder="Nhập mật khẩu..." required />
                        </div>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="remember" id="rememberMe">
                            <label class="form-check-label" for="rememberMe">Ghi nhớ đăng nhập</label>
                        </div>
                        <a href="${pageContext.request.contextPath}/forgot-password" class="text-decoration-none small text-primary fw-semibold">Quên mật khẩu?</a>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-2 fw-bold"><i class="fa fa-sign-in-alt"></i> Đăng nhập</button>

                    <div class="text-center mt-4">
                        <p class="mb-0 text-muted">Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="fw-bold text-decoration-none">Đăng ký ngay</a></p>
                        <p class="mt-2"><a href="${pageContext.request.contextPath}/home" class="text-secondary small"><i class="fa fa-home"></i> Quay lại trang chủ</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp" />
</body>
</html>
