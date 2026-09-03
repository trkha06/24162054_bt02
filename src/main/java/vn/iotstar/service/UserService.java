package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.User;

public interface UserService {
    User login(String username, String password);
    User get(String username);
    User findById(int id);
    void insert(User user);
    void update(User user);
    boolean updateProfile(int id, String fullname, String phone, String avatar);
    boolean register(String username, String password, String email, String fullname, String phone);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    boolean checkExistPhoneExceptUser(String phone, int userId);
    List<User> findAll();
}
