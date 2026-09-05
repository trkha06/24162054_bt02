package vn.iotstar.config;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import vn.iotstar.connection.DBConnection;

@WebListener
public class ApplicationLifecycleListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        initializeJpa();
        initializeDatabase();
    }

    private void initializeJpa() {
        EntityManager entityManager = null;
        try {
            entityManager = JpaConfig.getEntityManager();
        } catch (RuntimeException e) {
            System.err.println("JPA Initialization: " + e.getMessage());
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }

    private void initializeDatabase() {
        String createUsers = "CREATE TABLE IF NOT EXISTS users ("
                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                + "email VARCHAR(150) NOT NULL UNIQUE, "
                + "username VARCHAR(100) NOT NULL UNIQUE, "
                + "fullname VARCHAR(150) NOT NULL, "
                + "password VARCHAR(150) NOT NULL, "
                + "avatar VARCHAR(255), "
                + "roleid INT NOT NULL DEFAULT 5, "
                + "phone VARCHAR(20) UNIQUE, "
                + "createddate DATE)";

        String createCategories = "CREATE TABLE IF NOT EXISTS categories ("
                + "CategoryId INT AUTO_INCREMENT PRIMARY KEY, "
                + "CategoryName VARCHAR(100) NOT NULL, "
                + "Images VARCHAR(500), "
                + "Status INT NOT NULL DEFAULT 1)";

        String createProducts = "CREATE TABLE IF NOT EXISTS products ("
                + "ProductId INT AUTO_INCREMENT PRIMARY KEY, "
                + "ProductName VARCHAR(255) NOT NULL, "
                + "Price DOUBLE NOT NULL DEFAULT 0, "
                + "Description TEXT, "
                + "Images VARCHAR(500), "
                + "Status INT NOT NULL DEFAULT 1, "
                + "Quantity INT NOT NULL DEFAULT 0, "
                + "CreateDate DATETIME DEFAULT CURRENT_TIMESTAMP, "
                + "CategoryId INT, "
                + "CONSTRAINT fk_products_category FOREIGN KEY (CategoryId) REFERENCES categories(CategoryId) ON DELETE SET NULL)";

        try (Connection connection = new DBConnection().getConnection();
                Statement statement = connection.createStatement()) {
            statement.executeUpdate(createUsers);
            statement.executeUpdate(createCategories);
            statement.executeUpdate(createProducts);

            seedUser(connection, "admin@gmail.com", "admin", "Administrator", "123456", 1, "0901234567");
            seedUser(connection, "manager@gmail.com", "manager", "Store Manager", "123456", 2, "0907654321");
            seedUser(connection, "user@gmail.com", "user", "Standard User", "123456", 5, "0908889999");
            seedUser(connection, "teacher@gmail.com", "teacher", "Nguyen Van A", "123456", 5, "0900000000");

            seedCategory(connection, 1, "Điện thoại", "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&q=80", 1);
            seedCategory(connection, 2, "Laptop", "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500&q=80", 1);
            seedCategory(connection, 3, "Phụ kiện", "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80", 1);
            seedCategory(connection, 4, "Đồng hồ thông minh", "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&q=80", 1);

            seedProduct(connection, "iPhone 15 Pro Max 256GB", 29990000, "Mẫu flagship cao cấp mới nhất từ Apple với khung titan.", "https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=500&q=80", 1, 50, 1);
            seedProduct(connection, "Samsung Galaxy S24 Ultra", 27490000, "Công nghệ AI đỉnh cao và camera 200MP siêu nét.", "https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=500&q=80", 1, 40, 1);
            seedProduct(connection, "MacBook Pro 14 M3 Pro", 45990000, "Hiệu năng bứt phá cho lập trình viên và đồ họa chuyên nghiệp.", "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500&q=80", 1, 30, 2);
            seedProduct(connection, "Dell XPS 15 OLED", 38500000, "Màn hình OLED 3.5K sắc nét, thiết kế nhôm nguyên khối sang trọng.", "https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=500&q=80", 1, 25, 2);
            seedProduct(connection, "Tai nghe Sony WH-1000XM5", 7990000, "Khả năng chống ồn chủ động hàng đầu thế giới.", "https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=500&q=80", 1, 60, 3);
            seedProduct(connection, "Apple Watch Ultra 2", 19990000, "Đồng hồ thể thao chuyên nghiệp với vỏ titan siêu bền.", "https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=500&q=80", 1, 35, 4);
            seedProduct(connection, "Xiaomi 14 Ultra Leica", 24990000, "Hệ thống 4 camera cảm biến 1 inch hợp tác cùng Leica.", "https://images.unsplash.com/photo-1580910051074-3eb694886505?w=500&q=80", 1, 45, 1);
            seedProduct(connection, "Asus ROG Zephyrus G14", 39990000, "Laptop gaming mỏng nhẹ màn hình OLED 120Hz mạnh mẽ.", "https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=500&q=80", 1, 20, 2);
            seedProduct(connection, "Bàn phím cơ Keychron Q1 Pro", 4500000, "Bàn phím custom nhôm CNC Bluetooth không dây cao cấp.", "https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500&q=80", 1, 80, 3);
            seedProduct(connection, "Chuột Logitech MX Master 3S", 2290000, "Chuột công thái học tĩnh âm cho dân văn phòng và coder.", "https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?w=500&q=80", 1, 100, 3);
            seedProduct(connection, "Garmin Fenix 7 Pro Solar", 21500000, "Đồng hồ đa môn thể thao pin sạc năng lượng mặt trời.", "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=500&q=80", 1, 15, 4);
            seedProduct(connection, "iPad Pro M4 11 inch", 26990000, "Màn hình OLED Ultra Retina XDR siêu mỏng chỉ 5.3mm.", "https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500&q=80", 1, 55, 1);
            seedProduct(connection, "Củ sạc Anker GaNPrime 65W", 990000, "Công nghệ sạc nhanh GaN 3 cổng nhỏ gọn tiện lợi.", "https://images.unsplash.com/photo-1583863788434-e58a36330cf0?w=500&q=80", 1, 120, 3);
            seedProduct(connection, "Tai nghe AirPods Pro 2 USB-C", 5490000, "Chống ồn thông minh thích ứng và âm thanh không gian.", "https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=500&q=80", 1, 70, 3);
        } catch (Exception e) {
            System.err.println("Database initialization error: " + e.getMessage());
        }
    }

    private void seedUser(Connection connection, String email, String username, String fullname,
            String password, int roleId, String phone) throws Exception {
        String sql = "INSERT INTO users(email, username, fullname, password, avatar, roleid, phone, createddate) "
                + "SELECT ?, ?, ?, ?, NULL, ?, ?, CURRENT_DATE "
                + "WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            statement.setString(2, username);
            statement.setString(3, fullname);
            statement.setString(4, password);
            statement.setInt(5, roleId);
            statement.setString(6, phone);
            statement.setString(7, username);
            statement.executeUpdate();
        }
    }

    private void seedCategory(Connection connection, int id, String name, String image, int status) throws Exception {
        String sql = "INSERT INTO categories(CategoryId, CategoryName, Images, Status) "
                + "SELECT ?, ?, ?, ? WHERE NOT EXISTS (SELECT 1 FROM categories WHERE CategoryId = ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            statement.setString(2, name);
            statement.setString(3, image);
            statement.setInt(4, status);
            statement.setInt(5, id);
            statement.executeUpdate();
        }
    }

    private void seedProduct(Connection connection, String name, double price, String desc, String img, int status,
            int quantity, int categoryId) throws Exception {
        String sql = "INSERT INTO products(ProductName, Price, Description, Images, Status, Quantity, CreateDate, CategoryId) "
                + "SELECT ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ? "
                + "WHERE NOT EXISTS (SELECT 1 FROM products WHERE ProductName = ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, name);
            statement.setDouble(2, price);
            statement.setString(3, desc);
            statement.setString(4, img);
            statement.setInt(5, status);
            statement.setInt(6, quantity);
            statement.setInt(7, categoryId);
            statement.setString(8, name);
            statement.executeUpdate();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        JpaConfig.close();
    }
}
