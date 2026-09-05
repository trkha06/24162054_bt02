<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ Sơ Cá Nhân - shopbanhangcuakha</title>
</head>
<body>
<div class="container my-3">
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb bg-white p-3 rounded-3 shadow-sm">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home"><i class="fa fa-home me-1"></i> Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Hồ sơ cá nhân</li>
        </ol>
    </nav>

    <div class="row g-4">
        <div class="col-lg-4">
            <div class="card card-custom p-4 text-center shadow-sm">
                <div class="position-relative d-inline-block mx-auto mb-3">
                    <c:choose>
                        <c:when test="${not empty user.avatar}">
                            <c:choose>
                                <c:when test="${user.avatar.startsWith('http')}">
                                    <img id="avatarPreview" src="${user.avatar}" alt="Avatar"
                                         class="rounded-circle img-thumbnail shadow avatar-img"
                                         style="width: 140px; height: 140px; object-fit: cover;">
                                </c:when>
                                <c:otherwise>
                                    <img id="avatarPreview" src="${pageContext.request.contextPath}/image?fname=${user.avatar}" alt="Avatar"
                                         class="rounded-circle img-thumbnail shadow avatar-img"
                                         style="width: 140px; height: 140px; object-fit: cover;"
                                         onerror="this.src='https://ui-avatars.com/api/?name=${user.fullName}&background=0d6efd&color=fff&size=140'">
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <img id="avatarPreview" src="https://ui-avatars.com/api/?name=${user.fullName}&background=0d6efd&color=fff&size=140" alt="Avatar"
                                 class="rounded-circle img-thumbnail shadow avatar-img"
                                 style="width: 140px; height: 140px; object-fit: cover;">
                        </c:otherwise>
                    </c:choose>
                    <span class="position-absolute bottom-0 end-0 bg-success border border-white rounded-circle p-2" title="Online"></span>
                </div>

                <h4 class="fw-bold text-dark mb-1">${user.fullName}</h4>
                <p class="text-muted mb-2">@${user.userName}</p>

                <div class="mb-3">
                    <c:choose>
                        <c:when test="${user.roleid == 1}">
                            <span class="badge bg-danger fs-6 px-3 py-2"><i class="fa fa-user-shield me-1"></i> Quản Trị Viên (Admin)</span>
                        </c:when>
                        <c:when test="${user.roleid == 2}">
                            <span class="badge bg-warning text-dark fs-6 px-3 py-2"><i class="fa fa-user-tie me-1"></i> Quản Lý (Manager)</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-info text-dark fs-6 px-3 py-2"><i class="fa fa-user me-1"></i> Thành Viên (User)</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <hr class="my-3 text-muted">

                <div class="text-start small">
                    <div class="d-flex justify-content-between py-2 border-bottom">
                        <span class="text-muted"><i class="fa fa-phone me-2 text-primary"></i> Điện thoại:</span>
                        <span class="fw-semibold">${not empty user.phone ? user.phone : '<em class=\"text-muted\">Chưa cập nhật</em>'}</span>
                    </div>
                    <div class="d-flex justify-content-between py-2 border-bottom">
                        <span class="text-muted"><i class="fa fa-envelope me-2 text-primary"></i> Email:</span>
                        <span class="fw-semibold text-truncate" style="max-width: 170px;" title="${user.email}">${user.email}</span>
                    </div>
                    <div class="d-flex justify-content-between py-2">
                        <span class="text-muted"><i class="fa fa-calendar-alt me-2 text-primary"></i> Ngày tạo:</span>
                        <span class="fw-semibold">${not empty user.createdDate ? user.createdDate : 'N/A'}</span>
                    </div>
                </div>

                <div class="mt-4 d-grid gap-2">
                    <c:if test="${user.roleid == 1}">
                        <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-outline-danger btn-sm fw-semibold">
                            <i class="fa fa-cogs me-1"></i> Trang Quản Trị Admin
                        </a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-primary btn-sm fw-semibold">
                        <i class="fa fa-home me-1"></i> Về Trang Chủ
                    </a>
                </div>
            </div>
        </div>

        <div class="col-lg-8">
            <div class="card card-custom p-4 shadow-sm">
                <div class="d-flex align-items-center justify-content-between border-bottom pb-3 mb-4">
                    <div>
                        <h3 class="fw-bold text-primary mb-1"><i class="fa fa-user-edit me-2"></i> Cập Nhật Hồ Sơ Cá Nhân</h3>
                        <p class="text-muted small mb-0">Cập nhật họ và tên, số điện thoại và ảnh đại diện (Multipart File Upload & JPA)</p>
                    </div>
                    <span class="badge bg-light text-secondary border p-2">JPA + Servlet 6.0</span>
                </div>

                <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold text-secondary"><i class="fa fa-user me-1"></i> Tên đăng nhập (Username)</label>
                            <input type="text" class="form-control bg-light" value="${user.userName}" readonly disabled>
                            <small class="text-muted">Tên đăng nhập không thể thay đổi.</small>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold text-secondary"><i class="fa fa-envelope me-1"></i> Địa chỉ Email</label>
                            <input type="text" class="form-control bg-light" value="${user.email}" readonly disabled>
                            <small class="text-muted">Email dùng để xác thực bảo mật.</small>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="fullname" class="form-label fw-bold"><i class="fa fa-id-card me-1 text-primary"></i> Họ và Tên <span class="text-danger">*</span></label>
                        <input type="text" id="fullname" name="fullname" class="form-control form-control-lg"
                               value="${user.fullName}" placeholder="Nhập họ và tên đầy đủ" maxlength="150" required>
                        <div class="invalid-feedback">Họ và tên không được để trống.</div>
                    </div>

                    <div class="mb-3">
                        <label for="phone" class="form-label fw-bold"><i class="fa fa-phone me-1 text-primary"></i> Số Điện Thoại</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa fa-phone"></i></span>
                            <input type="tel" id="phone" name="phone" class="form-control"
                                   value="${user.phone}" placeholder="Ví dụ: 0901234567" pattern="^(0[0-9]{9}|\+84[0-9]{9})$">
                            <div class="invalid-feedback">Số điện thoại phải có 10 chữ số hợp lệ (bắt đầu bằng 0 hoặc +84).</div>
                        </div>
                    </div>

                    <div class="card bg-light border-0 p-3 mb-4 rounded-3">
                        <h6 class="fw-bold text-dark mb-3"><i class="fa fa-image me-2 text-primary"></i> Cập Nhật Ảnh Đại Diện (Images)</h6>

                        <div class="mb-3">
                            <label for="images1" class="form-label fw-semibold">1. Tải ảnh từ máy tính (Multipart Upload):</label>
                            <input type="file" id="images1" name="images1" class="form-control"
                                   accept="image/jpeg,image/png,image/gif,image/webp" onchange="previewFile(this)">
                            <small class="text-muted">Hỗ trợ các định dạng: JPG, PNG, GIF, WEBP (tối đa 10MB).</small>
                        </div>

                        <div class="mb-2">
                            <label for="images" class="form-label fw-semibold">2. Hoặc nhập liên kết ảnh trực tuyến (URL):</label>
                            <input type="url" id="images" name="images" class="form-control"
                                   placeholder="https://images.unsplash.com/..."
                                   value="${user.avatar != null && user.avatar.startsWith('http') ? user.avatar : ''}"
                                   oninput="previewUrl(this.value)">
                            <small class="text-muted">Nhập link bắt đầu bằng http:// hoặc https:// nếu không tải tệp lên.</small>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary px-4">
                            <i class="fa fa-arrow-left me-1"></i> Quay lại
                        </a>
                        <button type="submit" class="btn btn-primary btn-lg px-5 shadow">
                            <i class="fa fa-save me-2"></i> Lưu Cập Nhật
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function previewFile(input) {
        if (input.files && input.files[0]) {
            const file = input.files[0];
            const reader = new FileReader();
            reader.onload = function(e) {
                const preview = document.getElementById('avatarPreview');
                if (preview) {
                    preview.src = e.target.result;
                }
            };
            reader.readAsDataURL(file);
            const urlInput = document.getElementById('images');
            if (urlInput) {
                urlInput.value = '';
            }
        }
    }

    function previewUrl(url) {
        if (url && (url.startsWith('http://') || url.startsWith('https://'))) {
            const preview = document.getElementById('avatarPreview');
            if (preview) {
                preview.src = url;
            }
        }
    }

    (() => {
        'use strict'
        const forms = document.querySelectorAll('.needs-validation')
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>
</body>
</html>
