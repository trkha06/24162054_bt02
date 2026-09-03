# Bài tập Web MVC - Quản trị Category & Hồ sơ User Profile (JPA, Multipart, SiteMesh)

**Sinh viên thực hiện**: Võ Văn Trường Kha  
**MSSV**: 24162054  
**Học phần**: Lập trình Web - HCMUTE  

---

## 1. Tính năng của Hệ Thống

### 1.1. Chức năng User Profile (Hồ Sơ Cá Nhân)
- **Cập nhật thông tin**: Họ và tên (`fullname`), Số điện thoại (`phone`), Ảnh đại diện (`avatar`/`images`).
- **Tải ảnh đại diện (Multipart File Upload)**: Hỗ trợ upload ảnh JPG, PNG, GIF, WEBP từ máy tính lưu vào `Constant.DIR` (`24162054_uploads`) hoặc dán trực tiếp đường dẫn ảnh trực tuyến.
- **Xem trước ảnh trực tiếp (Live Image Preview)**: Sử dụng JavaScript FileReader giúp xem trước ảnh ngay khi chọn tệp từ máy.
- **Xử lý JPA / Hibernate**: Quản lý `User` entity qua `EntityManager` và `EntityTransaction`.
- **Cập nhật Session tức thì**: Sau khi lưu thông tin, Session `account` được cập nhật giúp thanh Topbar và Header phản ánh ngay ảnh và tên mới.

### 1.2. Quản lý Giao diện bằng SiteMesh Decorator
- Bố cục giao diện đồng bộ với SiteMesh:
  - `decorators/web.jsp` / `views/decorators/web.jsp`: Decorator layout cho trang người dùng, trang chủ, hồ sơ cá nhân.
  - `decorators/admin.jsp` / `views/decorators/admin.jsp`: Decorator layout cho khu vực quản trị Admin.
  - Tích hợp `topbar.jsp`, `header.jsp`, `footer.jsp` đồng nhất.

### 1.3. CRUD Category bằng JPA
- Quản lý danh mục theo mô hình MVC 3 tầng (DAO, Service, Controller, Entity JPA).
- Thêm, xem, tìm kiếm theo tên, phân trang, sửa và xóa danh mục với Multipart Upload ảnh.

---

## 2. Kiến trúc & Cấu trúc Mã Nguồn

- **Entity JPA**: `vn.iotstar.entity.User`, `vn.iotstar.entity.Category`, `vn.iotstar.entity.Video`
- **DAO JPA**: `vn.iotstar.dao.UserDao`, `vn.iotstar.dao.impl.UserDaoImpl`, `vn.iotstar.dao.ICategoryDao`, `vn.iotstar.dao.impl.CategoryDao`
- **Service**: `vn.iotstar.service.UserService`, `vn.iotstar.service.impl.UserServiceImpl`, `vn.iotstar.services.ICategoryService`, `vn.iotstar.services.impl.CategoryServiceImpl`
- **Controller**:
  - `vn.iotstar.controller.auth.ProfileController` (`/profile`, `/user/profile`, `/my-profile`)
  - `vn.iotstar.controller.admin.CategoryController` (`/admin/categories`, ...)
  - `vn.iotstar.controller.admin.DownloadImageController` (`/image`)
  - `vn.iotstar.controller.auth.LoginController`, `RegisterController`, `LogoutController`, `WaitingController`
- **View & Decorators**:
  - `views/profile.jsp`: Giao diện hồ sơ cá nhân và form cập nhật
  - `views/decorators/web.jsp`, `views/decorators/admin.jsp`
  - `WEB-INF/decorators.xml`, `WEB-INF/sitemesh3.xml`

---

## 3. Môi trường & Hướng dẫn Chạy

- **JDK**: 21
- **Servlet Container**: Tomcat 10.1 trở lên (hỗ trợ Jakarta EE 10 / Servlet 6.0)
- **Database**: MySQL 8.x (Database `servletjpa`)
- **Build tool**: Maven 3.9 trở lên

### Build project:
```bash
mvn clean package
```

File WAR được sinh tại: `target/24162054_bt02.war`.

### Tài khoản mẫu:
- **Admin**: `admin` / `123456` (truy cập `/profile`, `/admin/categories`)
- **Manager**: `manager` / `123456`
- **User Sinh viên**: `24162054` / `123`