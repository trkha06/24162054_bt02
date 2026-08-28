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
        initializeUsers();
    }

    private void initializeJpa() {
        EntityManager entityManager = null;
        try {
            entityManager = JpaConfig.getEntityManager();
        } catch (RuntimeException e) {
            sceLog("Không thể khởi tạo JPA: " + e.getMessage());
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }

    private void initializeUsers() {
        String createTable = "CREATE TABLE IF NOT EXISTS users ("
                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                + "email VARCHAR(150) NOT NULL UNIQUE, "
                + "username VARCHAR(100) NOT NULL UNIQUE, "
                + "fullname VARCHAR(150) NOT NULL, "
                + "password VARCHAR(150) NOT NULL, "
                + "avatar VARCHAR(255), roleid INT NOT NULL DEFAULT 5, "
                + "phone VARCHAR(20) UNIQUE, createddate DATE)";

        try (Connection connection = new DBConnection().getConnection();
                Statement statement = connection.createStatement()) {
            statement.executeUpdate(createTable);
            seedUser(connection, "admin@ute.edu.vn", "admin", "Quản Trị Viên", "123456", 1, "0901234567");
            seedUser(connection, "manager@ute.edu.vn", "manager", "Quản Lý Cửa Hàng", "123456", 2, "0907654321");
            seedUser(connection, "24162054@student.hcmute.edu.vn", "24162054", "Võ Văn Trường Kha", "123", 1, "0908617108");
            seedUser(connection, "trungnh@hcmute.edu.vn", "trungnh", "ThS. Nguyễn Hữu Trung", "123", 5, "0900000000");
        } catch (Exception e) {
            sceLog("Không thể khởi tạo bảng users; ứng dụng sẽ dùng tài khoản mẫu trong bộ nhớ: " + e.getMessage());
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

    private void sceLog(String message) {
        System.err.println("[24162054_bt02] " + message);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        JpaConfig.close();
    }
}
