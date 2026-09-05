<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Quên Mật Khẩu - Khôi Phục Qua Email" />
</jsp:include>
<body>
<jsp:include page="common/topbar.jsp" />

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card card-custom p-4">
                <div class="text-center mb-4">
                    <div class="display-6 text-warning mb-2"><i class="fa fa-key"></i></div>
                    <h3 class="fw-bold text-dark">QUÊN MẬT KHẨU</h3>
                    <p class="text-muted">Nhập tên tài khoản (Username) hoặc Email đã đăng ký để nhận mã OTP khôi phục.</p>
                </div>

                <c:if test="${alert != null}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fa fa-exclamation-triangle"></i> ${alert}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tài khoản hoặc Email:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa fa-user-circle"></i></span>
                            <input type="text" class="form-control" name="account" placeholder="Nhập username hoặc email..." required autofocus />
                        </div>
                    </div>

                    <button type="submit" class="btn btn-warning w-100 py-2 fw-bold mb-3 text-dark">
                        <i class="fa fa-paper-plane"></i> Gửi Mã OTP Qua Email
                    </button>

                    <div class="text-center pt-2 border-top">
                        <a href="${pageContext.request.contextPath}/login" class="text-secondary small text-decoration-none">
                            <i class="fa fa-arrow-left"></i> Quay lại Đăng nhập
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp" />
</body>
</html>
