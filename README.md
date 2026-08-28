# Bài tập 02 - CRUD Category bằng JPA

Project kế thừa chức năng đăng nhập, đăng ký, Cookie, Session và phân quyền của bài tập 01. Phần bài tập 02 bổ sung CRUD Category theo MVC/3-tier:

- Controller: `vn.iotstar.controller.admin.CategoryController`
- Service: `vn.iotstar.services.ICategoryService` và `CategoryServiceImpl`
- DAO JPA: `vn.iotstar.dao.ICategoryDao` và `CategoryDao`
- Entity: `Category`, `Video`
- View: `category-list.jsp`, `category-add.jsp`, `category-edit.jsp`

## Môi trường

- JDK 21
- Tomcat 10.1 trở lên
- MySQL 8
- Maven 3.9 trở lên

## Chuẩn bị dữ liệu

Mặc định ứng dụng kết nối database `servletjpa` trên `localhost:3306`. Có thể chạy file `src/main/resources/database.sql` để tạo schema và dữ liệu mẫu. Hibernate cũng được cấu hình `hbm2ddl.auto=update` để tự tạo/cập nhật bảng entity.

Nếu máy dùng tài khoản MySQL khác, sửa `src/main/resources/META-INF/persistence.xml`, hoặc truyền ba Java system properties khi chạy Tomcat:

```text
-Dapp.jdbc.url=jdbc:mysql://localhost:3306/servletjpa
-Dapp.jdbc.user=root
-Dapp.jdbc.password=mat_khau_mysql
```

Thư mục lưu ảnh upload mặc định là `24162054_uploads` trong thư mục người dùng. Có thể đổi bằng `-Dapp.upload.dir=duong_dan_mong_muon`.

## Build và chạy

```text
mvn clean package
```

Deploy `target/24162054_bt02.war` lên Tomcat, sau đó mở:

```text
http://localhost:8080/24162054_bt02/
```

Tài khoản demo quản trị:

```text
Username: admin
Password: 123456
```

Sau khi đăng nhập, vào `/admin/categories` để thêm, xem, tìm kiếm, phân trang, sửa và xóa Category.
