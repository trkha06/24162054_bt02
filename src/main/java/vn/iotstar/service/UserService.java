package vn.iotstar.service;

import vn.iotstar.model.User;

public interface UserService {
    User login(String username, String password);
    User get(String username);
    User findByEmail(String email);
    User findById(int id);
    void insert(User user);
    void update(User user);
    boolean register(String username, String password, String email, String fullname, String phone);
    void updatePassword(String usernameOrEmail, String newPassword);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    boolean checkExistPhoneExceptUser(String phone, int userId);
}
