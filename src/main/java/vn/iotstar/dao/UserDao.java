package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.User;

public interface UserDao {
    User findById(int id);
    User get(String username);
    User findByUsername(String username);
    User findByEmail(String email);
    void insert(User user);
    void update(User user);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    boolean checkExistPhoneExceptUser(String phone, int userId);
    List<User> findAll();
}
