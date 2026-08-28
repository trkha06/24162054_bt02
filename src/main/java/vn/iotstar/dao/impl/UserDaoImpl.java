package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.UserDao;
import vn.iotstar.model.User;

public class UserDaoImpl implements UserDao {

    private static final List<User> MEMORY_USERS = new CopyOnWriteArrayList<>();

    static {
        Date createdDate = Date.valueOf("2026-06-24");
        MEMORY_USERS.add(new User(1, "admin@ute.edu.vn", "admin", "Quản Trị Viên", "123456", null, 1,
                "0901234567", createdDate));
        MEMORY_USERS.add(new User(2, "manager@ute.edu.vn", "manager", "Quản Lý Cửa Hàng", "123456", null, 2,
                "0907654321", createdDate));
        MEMORY_USERS.add(new User(3, "24162054@student.hcmute.edu.vn", "24162054", "Võ Văn Trường Kha", "123",
                null, 1, "0908617108", createdDate));
        MEMORY_USERS.add(new User(4, "trungnh@hcmute.edu.vn", "trungnh", "ThS. Nguyễn Hữu Trung", "123", null, 5,
                "0900000000", createdDate));
    }

    private final DBConnection dbConnection = new DBConnection();

    @Override
    public User get(String username) {
        String sql = "SELECT id, username, password, fullname, email, phone, roleid FROM users WHERE username = ?";
        try (Connection connection = dbConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, username);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapUser(resultSet);
                }
            }
        } catch (SQLException exception) {
            System.err.println("Cannot read users from database; using the in-memory fallback: "
                    + exception.getMessage());
        }
        return MEMORY_USERS.stream()
                .filter(user -> user.getUserName().equalsIgnoreCase(username))
                .findFirst()
                .orElse(null);
    }

    @Override
    public void insert(User user) {
        String sql = "INSERT INTO users(email, username, fullname, password, avatar, roleid, phone, createddate) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = dbConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, user.getEmail());
            statement.setString(2, user.getUserName());
            statement.setString(3, user.getFullName());
            statement.setString(4, user.getPassWord());
            statement.setString(5, user.getAvatar());
            statement.setInt(6, user.getRoleid());
            statement.setString(7, user.getPhone());
            statement.setDate(8, user.getCreatedDate());
            statement.executeUpdate();
        } catch (SQLException exception) {
            System.err.println("Cannot insert user into database; using the in-memory fallback: "
                    + exception.getMessage());
        }

        if (MEMORY_USERS.stream().noneMatch(item -> item.getUserName().equalsIgnoreCase(user.getUserName()))) {
            MEMORY_USERS.add(user);
        }
    }

    @Override
    public boolean checkExistEmail(String email) {
        return existsBy("email", email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return existsBy("username", username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return existsBy("phone", phone);
    }

    private boolean existsBy(String column, String value) {
        if (!List.of("email", "username", "phone").contains(column)) {
            throw new IllegalArgumentException("Unsupported users column: " + column);
        }

        String sql = "SELECT 1 FROM users WHERE " + column + " = ? LIMIT 1";
        try (Connection connection = dbConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, value);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }
        } catch (SQLException exception) {
            return MEMORY_USERS.stream().anyMatch(user -> switch (column) {
                case "email" -> user.getEmail().equalsIgnoreCase(value);
                case "phone" -> user.getPhone().equalsIgnoreCase(value);
                default -> user.getUserName().equalsIgnoreCase(value);
            });
        }
    }

    private User mapUser(ResultSet resultSet) throws SQLException {
        return new User(
                resultSet.getInt("id"),
                resultSet.getString("email"),
                resultSet.getString("username"),
                resultSet.getString("fullname"),
                resultSet.getString("password"),
                null,
                resultSet.getInt("roleid"),
                resultSet.getString("phone"),
                null);
    }
}
