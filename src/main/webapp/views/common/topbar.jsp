<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="topbar-box">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <i class="fa fa-user"></i> Liên hệ: Võ Văn Trường Kha | <i class="fa fa-envelope"></i> 24162054@student.hcmute.edu.vn
        </div>
        <div>
            <c:choose>
                <c:when test="${sessionScope.account == null}">
                    <a href="${pageContext.request.contextPath}/login"><i class="fa fa-sign-in-alt"></i> Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/register"><i class="fa fa-user-plus"></i> Đăng ký</a>
                </c:when>
                <c:otherwise>
                    <span>Xin chào: <b>${sessionScope.account.fullName}</b></span>
                    <c:if test="${sessionScope.account.roleid == 1}">
                        <a href="${pageContext.request.contextPath}/admin/categories" class="badge bg-primary text-white"><i class="fa fa-cogs"></i> Quản trị Category</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/logout" class="text-danger"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
