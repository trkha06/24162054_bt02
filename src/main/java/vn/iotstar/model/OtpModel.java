package vn.iotstar.model;

import java.io.Serializable;

public class OtpModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private String email;
    private String otp;
    private long expireTime;
    private String type;
    private User pendingUser;

    public OtpModel() {
    }

    public OtpModel(String email, String otp, long expireTime, String type, User pendingUser) {
        this.email = email;
        this.otp = otp;
        this.expireTime = expireTime;
        this.type = type;
        this.pendingUser = pendingUser;
    }

    public boolean isExpired() {
        return System.currentTimeMillis() > this.expireTime;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }

    public long getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(long expireTime) {
        this.expireTime = expireTime;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public User getPendingUser() {
        return pendingUser;
    }

    public void setPendingUser(User pendingUser) {
        this.pendingUser = pendingUser;
    }
}
