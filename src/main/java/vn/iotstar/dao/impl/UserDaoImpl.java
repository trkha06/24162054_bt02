package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.UserDao;
import vn.iotstar.model.User;

public class UserDaoImpl implements UserDao {

    private static final List<User> MEMORY_USERS = new CopyOnWriteArrayList<>();

    static {
        Date createdDate = Date.valueOf("2026-01-01");
        MEMORY_USERS.add(new User(1, "admin@gmail.com", "admin", "Administrator", "123456", null, 1,
                "0901234567", createdDate));
        MEMORY_USERS.add(new User(2, "manager@gmail.com", "manager", "Store Manager", "123456", null, 2,
                "0907654321", createdDate));
        MEMORY_USERS.add(new User(3, "user@gmail.com", "user", "Standard User", "123456", null, 5,
                "0908889999", createdDate));
        MEMORY_USERS.add(new User(4, "teacher@gmail.com", "teacher", "Nguyen Van A", "123456", null, 5,
                "0900000000", createdDate));
    }

    private final DBConnection dbConnection = new DBConnection();

    @Override
    public User get(String username) {
        String sql = "SELECT id, username, password, fullname, email, phone, roleid, avatar, createddate FROM users WHERE username = ?";
        try (Connection connection = dbConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, username);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapUser(resultSet);
                }
            }
        } catch (SQLException exception) {
            System.err.println("Database query error: " + exception.getMessage());
        }
        return MEMORY_USERS.stream()
                .filter(user -> user.getUserName().equalsIgnoreCase(username))
                .findFirst()
                .orElse(null);
    }

    @Override
    public User findByEmail(String email) {
        String sql = "SELECT id, username, password, fullname, email, phone, roleid, avatar, createddate FROM users WHERE email = ?";
        try (Connection connection = dbConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapUser(resultSet);
                }
            }
        } catch (SQLException exception) {
            System.err.println("Database query error: " + exception.getMessage());
        }
        return MEMORY_USERS.stream()
                .filter(user -> user.getEmail().equalsIgnoreCase(email))
                .findFirst()
                .orElse(null);
    }

    @Override
    public User findById(int id) {
        String sql = "SELECT id, username, password, fullname, email, phone, roleid, avatar, createddate FROM users WHERE id = ?";
        try (Connection connection = dbConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapUser(resultSet);
                }
            }
        } catch (SQLException exception) {
            System.err.println("Database query error: " + exception.getMessage());
        }
        return MEMORY_USERS.stream().filter(user -> user.getId() == id).findFirst().orElse(null);
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
            statement.setDate(8, user.getCreatedDate() != null ? user.getCreatedDate() : new Date(System.currentTimeMillis()));
            statement.executeUpdate();
        } catch (SQLException exception) {
            System.err.println("Database insert error: " + exception.getMessage());
        }

        if (MEMORY_USERS.stream().noneMatch(item -> item.getUserName().equalsIgnoreCase(user.getUserName()))) {
            if (user.getId() == 0) {
                user.setId(MEMORY_USERS.size() + 1);
            }
            MEMORY_USERS.add(user);
        }
    }

    @Override
    public void update(User user) {
        String sql = "UPDATE users SET fullname = ?, phone = ?, avatar = ? WHERE id = ?";
        try (Connection connection = dbConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, user.getFullName());
            statement.setString(2, user.getPhone());
            statement.setString(3, user.getAvatar());
            statement.setInt(4, user.getId());
            statement.executeUpdate();
        } catch (SQLException exception) {
            System.err.println("Database update error: " + exception.getMessage());
        }
        MEMORY_USERS.stream().filter(item -> item.getId() == user.getId()).findFirst().ifPresent(item -> {
            item.setFullName(user.getFullName());
            item.setPhone(user.getPhone());
            item.setAvatar(user.getAvatar());
        });
    }

    @Override
    public void updatePassword(String usernameOrEmail, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE username = ? OR email = ?";
        try (Connection connection = dbConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, newPassword);
            statement.setString(2, usernameOrEmail);
            statement.setString(3, usernameOrEmail);
            statement.executeUpdate();
        } catch (SQLException exception) {
            System.err.println("Database update password error: " + exception.getMessage());
        }

        for (User user : MEMORY_USERS) {
            if (user.getUserName().equalsIgnoreCase(usernameOrEmail) || user.getEmail().equalsIgnoreCase(usernameOrEmail)) {
                user.setPassWord(newPassword);
            }
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

    @Override
    public boolean checkExistPhoneExceptUser(String phone, int userId) {
        String sql = "SELECT 1 FROM users WHERE phone = ? AND id <> ? LIMIT 1";
        try (Connection connection = dbConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, phone);
            statement.setInt(2, userId);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }
        } catch (SQLException exception) {
            return MEMORY_USERS.stream()
                    .anyMatch(user -> user.getId() != userId && phone.equalsIgnoreCase(user.getPhone()));
        }
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
                resultSet.getString("avatar"),
                resultSet.getInt("roleid"),
                resultSet.getString("phone"),
                resultSet.getDate("createddate"));
    }
}
