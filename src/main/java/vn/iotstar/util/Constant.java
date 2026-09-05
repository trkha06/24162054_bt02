package vn.iotstar.util;

import java.nio.file.Paths;

public class Constant {
    public static final String DIR = System.getProperty(
            "app.upload.dir",
            Paths.get(System.getProperty("user.home"), "app_uploads").toString());
    public static final String DEFAULT_IMAGE = "avatar.png";
    public static final String COOKIE_REMEMBER = "username";
    public static final String SESSION_USERNAME = "username";
    public static final String SESSION_ACCOUNT = "account";
    public static final String SESSION_OTP = "session_otp";

    public static final String UPLOAD_DIRECTORY = "E:\\upload";
    public static final String DEFAULT_FILENAME = "default.file";

    public static class Path {
        public static final String REGISTER = "/views/register.jsp";
        public static final String VERIFY_OTP = "/views/verify-otp.jsp";
        public static final String FORGOT_PASSWORD = "/views/forgot-password.jsp";
        public static final String RESET_PASSWORD = "/views/reset-password.jsp";
        public static final String LOGIN = "/views/login.jsp";
        public static final String PROFILE = "/views/profile.jsp";
        public static final String HOME = "/views/home.jsp";
        public static final String PRODUCT_LIST = "/views/product-list.jsp";
        public static final String PRODUCT_DETAIL = "/views/product-detail.jsp";
        public static final String ADMIN_HOME = "/views/admin/admin-home.jsp";
        public static final String MANAGER_HOME = "/views/manager/manager-home.jsp";
        public static final String CATEGORY_LIST = "/views/admin/category-list.jsp";
        public static final String CATEGORY_ADD = "/views/admin/category-add.jsp";
        public static final String CATEGORY_EDIT = "/views/admin/category-edit.jsp";
        public static final String ADMIN_PRODUCT_LIST = "/views/admin/product-list.jsp";
        public static final String ADMIN_PRODUCT_ADD = "/views/admin/product-add.jsp";
        public static final String ADMIN_PRODUCT_EDIT = "/views/admin/product-edit.jsp";
        public static final String UPLOAD_DEMO = "/views/upload-demo.jsp";
        public static final String RESULT = "/views/result.jsp";
    }
}
