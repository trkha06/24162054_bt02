CREATE DATABASE IF NOT EXISTS servletjpa
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE servletjpa;

CREATE TABLE IF NOT EXISTS categories (
    CategoryId INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL,
    Images VARCHAR(500) NULL,
    Status INT NOT NULL DEFAULT 1,
    CONSTRAINT uq_categories_name UNIQUE (CategoryName)
);

CREATE TABLE IF NOT EXISTS videos (
    VideoId VARCHAR(255) PRIMARY KEY,
    Active INT NOT NULL DEFAULT 1,
    Description VARCHAR(500) NULL,
    Poster VARCHAR(500) NULL,
    Title VARCHAR(500) NULL,
    Views INT NOT NULL DEFAULT 0,
    CategoryId INT NULL,
    CONSTRAINT fk_videos_categories
        FOREIGN KEY (CategoryId) REFERENCES categories(CategoryId)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(150) NOT NULL UNIQUE,
    username VARCHAR(100) NOT NULL UNIQUE,
    fullname VARCHAR(150) NOT NULL,
    password VARCHAR(150) NOT NULL,
    avatar VARCHAR(255) NULL,
    roleid INT NOT NULL DEFAULT 5,
    phone VARCHAR(20) NULL UNIQUE,
    createddate DATE NULL
);

INSERT IGNORE INTO users
    (email, username, fullname, password, avatar, roleid, phone, createddate)
VALUES
    ('admin@ute.edu.vn', 'admin', 'Quản Trị Viên', '123456', NULL, 1, '0901234567', CURDATE()),
    ('manager@ute.edu.vn', 'manager', 'Quản Lý Cửa Hàng', '123456', NULL, 2, '0907654321', CURDATE()),
    ('24162054@student.hcmute.edu.vn', '24162054', 'Võ Văn Trường Kha', '123', NULL, 1, '0908617108', CURDATE());

INSERT IGNORE INTO categories (CategoryName, Images, Status)
VALUES
    ('Điện thoại', 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500', 1),
    ('Máy tính', 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500', 1),
    ('Phụ kiện', 'https://images.unsplash.com/photo-1526738549149-8e07eca6c147?w=500', 1);
