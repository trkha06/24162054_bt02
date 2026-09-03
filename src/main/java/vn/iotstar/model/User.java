package vn.iotstar.model;

import java.sql.Date;

@SuppressWarnings("serial")
public class User extends vn.iotstar.entity.User {

    public User() {
        super();
    }

    public User(int id, String email, String userName, String fullName, String passWord, String avatar, int roleid,
            String phone, Date createdDate) {
        super(id, email, userName, fullName, passWord, avatar, roleid, phone, createdDate);
    }

    public User(String email, String userName, String fullName, String passWord, String avatar, int roleid,
            String phone, Date createdDate) {
        super(email, userName, fullName, passWord, avatar, roleid, phone, createdDate);
    }
}
