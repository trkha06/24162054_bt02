<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="topbar-box py-2 bg-dark text-white border-bottom border-secondary">
    <div class="container d-flex flex-wrap justify-content-between align-items-center">
        <div class="d-flex align-items-center small">
            <span class="me-3"><i class="fa fa-user text-info"></i> Võ Văn Trường Kha</span>
            <span class="me-3"><i class="fa fa-id-card text-warning"></i> MSSV: 24162054</span>
            <span><i class="fa fa-envelope text-success"></i> 24162054@student.hcmute.edu.vn</span>
        </div>
        <div class="d-flex align-items-center mt-2 mt-md-0">
            <c:choose>
                <c:when test="${sessionScope.account == null}">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm me-2"><i class="fa fa-sign-in-alt"></i> Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-sm"><i class="fa fa-user-plus"></i> Đăng ký</a>
                </c:when>
                <c:otherwise>
                    <div class="d-flex align-items-center me-3">
                        <c:choose>
                            <c:when test="${not empty sessionScope.account.avatar}">
                                <c:choose>
                                    <c:when test="${sessionScope.account.avatar.startsWith('http')}">
                                        <img src="${sessionScope.account.avatar}" alt="Avatar" class="rounded-circle me-2 border border-light" style="width: 28px; height: 28px; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.avatar}" alt="Avatar" class="rounded-circle me-2 border border-light" style="width: 28px; height: 28px; object-fit: cover;" onerror="this.src='https://ui-avatars.com/api/?name=${sessionScope.account.fullName}&background=random'">
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <img src="https://ui-avatars.com/api/?name=${sessionScope.account.fullName}&background=0d6efd&color=fff" alt="Avatar" class="rounded-circle me-2 border border-light" style="width: 28px; height: 28px; object-fit: cover;">
                            </c:otherwise>
                        </c:choose>
                        <span>Xin chào: <b>${sessionScope.account.fullName}</b></span>
                    </div>

                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-sm btn-outline-info me-2" title="Hồ sơ cá nhân">
                        <i class="fa fa-user-edit"></i> Hồ sơ
                    </a>

                    <c:if test="${sessionScope.account.roleid == 1}">
                        <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-sm btn-primary me-2"><i class="fa fa-cogs"></i> Quản trị Category</a>
                    </c:if>
                    <c:if test="${sessionScope.account.roleid == 2}">
                        <a href="${pageContext.request.contextPath}/manager/home" class="btn btn-sm btn-warning me-2"><i class="fa fa-tasks"></i> Quản lý</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-outline-danger"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>