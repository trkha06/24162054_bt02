package vn.iotstar.util;

import java.nio.file.Paths;

public class Constant {
    public static final String DIR = System.getProperty(
            "app.upload.dir",
            Paths.get(System.getProperty("user.home"), "24162054_uploads").toString());
    public static final String DEFAULT_IMAGE = "avatar.png";
    public static final String COOKIE_REMEMBER = "username";
    public static final String SESSION_USERNAME = "username";
    public static final String SESSION_ACCOUNT = "account";
    
    public static class Path {
        public static final String REGISTER = "/views/register.jsp";
        public static final String LOGIN = "/views/login.jsp";
        public static final String HOME = "/views/home.jsp";
        public static final String ADMIN_HOME = "/views/admin/admin-home.jsp";
        public static final String MANAGER_HOME = "/views/manager/manager-home.jsp";
        public static final String CATEGORY_LIST = "/views/admin/category-list.jsp";
        public static final String CATEGORY_ADD = "/views/admin/category-add.jsp";
        public static final String CATEGORY_EDIT = "/views/admin/category-edit.jsp";
        public static final String PROFILE = "/views/profile.jsp";
    }
}
