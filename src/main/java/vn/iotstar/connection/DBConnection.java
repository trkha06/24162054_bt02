package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String DEFAULT_URL =
            "jdbc:mysql://localhost:3306/servletjpa?createDatabaseIfNotExist=true"
            + "&useSSL=false&allowPublicKeyRetrieval=true&useUnicode=true"
            + "&characterEncoding=UTF-8&serverTimezone=UTC";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASSWORD = "Kha@01216114778";

    public Connection getConnection() throws SQLException {
        String url = System.getProperty("app.jdbc.url", DEFAULT_URL);
        String user = System.getProperty("app.jdbc.user", DEFAULT_USER);
        String password = System.getProperty("app.jdbc.password", DEFAULT_PASSWORD);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Không tìm thấy MySQL JDBC Driver", e);
        }
        return DriverManager.getConnection(url, user, password);
    }
}
