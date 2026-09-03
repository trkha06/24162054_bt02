package vn.iotstar.service.impl;

import java.sql.Date;
import java.util.List;

import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;

public class UserServiceImpl implements UserService {
    private final UserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {
        User user = this.get(username);
        if (user != null && password != null && password.equals(user.getPassWord())) {
            return user;
        }
        return null;
    }

    @Override
    public User get(String username) {
        return userDao.get(username);
    }

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public boolean updateProfile(int id, String fullname, String phone, String avatar) {
        User user = userDao.findById(id);
        if (user == null) {
            return false;
        }
        if (fullname != null && !fullname.isBlank()) {
            user.setFullName(fullname.trim());
        }
        user.setPhone(phone == null || phone.isBlank() ? null : phone.trim());
        if (avatar != null && !avatar.isBlank()) {
            user.setAvatar(avatar.trim());
        }
        userDao.update(user);
        return true;
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (userDao.checkExistUsername(username)) {
            return false;
        }
        long millis = System.currentTimeMillis();
        Date date = new Date(millis);
        userDao.insert(new User(email, username, fullname, password, null, 5, phone, date));
        return true;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);
    }

    @Override
    public boolean checkExistPhoneExceptUser(String phone, int userId) {
        return userDao.checkExistPhoneExceptUser(phone, userId);
    }

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }
}
