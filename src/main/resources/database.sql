CREATE DATABASE IF NOT EXISTS `servletjpa` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `servletjpa`;

CREATE TABLE IF NOT EXISTS `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `email` VARCHAR(150) NOT NULL UNIQUE,
    `username` VARCHAR(100) NOT NULL UNIQUE,
    `fullname` VARCHAR(150) NOT NULL,
    `password` VARCHAR(150) NOT NULL,
    `avatar` VARCHAR(255) NULL,
    `roleid` INT NOT NULL DEFAULT 5,
    `phone` VARCHAR(20) UNIQUE,
    `createddate` DATE NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `categories` (
    `CategoryId` INT AUTO_INCREMENT PRIMARY KEY,
    `CategoryName` VARCHAR(100) NOT NULL,
    `Images` VARCHAR(500) NULL,
    `Status` INT NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `products` (
    `ProductId` INT AUTO_INCREMENT PRIMARY KEY,
    `ProductName` VARCHAR(255) NOT NULL,
    `Price` DOUBLE NOT NULL DEFAULT 0,
    `Description` TEXT NULL,
    `Images` VARCHAR(500) NULL,
    `Status` INT NOT NULL DEFAULT 1,
    `Quantity` INT NOT NULL DEFAULT 0,
    `CreateDate` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `CategoryId` INT NULL,
    CONSTRAINT `fk_products_category` FOREIGN KEY (`CategoryId`) REFERENCES `categories` (`CategoryId`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `videos` (
    `VideoId` VARCHAR(50) PRIMARY KEY,
    `Title` VARCHAR(255) NOT NULL,
    `Poster` VARCHAR(255) NULL,
    `Views` INT NOT NULL DEFAULT 0,
    `Description` TEXT NULL,
    `Active` TINYINT(1) NOT NULL DEFAULT 1,
    `CategoryId` INT NULL,
    CONSTRAINT `fk_videos_category` FOREIGN KEY (`CategoryId`) REFERENCES `categories` (`CategoryId`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id`, `email`, `username`, `fullname`, `password`, `avatar`, `roleid`, `phone`, `createddate`)
VALUES
(1, 'admin@gmail.com', 'admin', 'Administrator', '123456', NULL, 1, '0901234567', CURRENT_DATE),
(2, 'manager@gmail.com', 'manager', 'Store Manager', '123456', NULL, 2, '0907654321', CURRENT_DATE),
(3, 'user@gmail.com', 'user', 'Member User', '123456', NULL, 5, '0908889999', CURRENT_DATE),
(4, 'teacher@gmail.com', 'teacher', 'Nguyen Van A', '123456', NULL, 5, '0900000000', CURRENT_DATE)
ON DUPLICATE KEY UPDATE `username`=`username`;

INSERT INTO `categories` (`CategoryId`, `CategoryName`, `Images`, `Status`)
VALUES
(1, 'Điện thoại', 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&q=80', 1),
(2, 'Laptop', 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500&q=80', 1),
(3, 'Phụ kiện', 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80', 1),
(4, 'Đồng hồ thông minh', 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&q=80', 1)
ON DUPLICATE KEY UPDATE `CategoryName`=VALUES(`CategoryName`);

INSERT INTO `products` (`ProductId`, `ProductName`, `Price`, `Description`, `Images`, `Status`, `Quantity`, `CreateDate`, `CategoryId`)
VALUES
(1, 'iPhone 15 Pro Max 256GB', 29990000, 'Mẫu flagship cao cấp mới nhất từ Apple với khung titan.', 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=500&q=80', 1, 50, CURRENT_TIMESTAMP, 1),
(2, 'Samsung Galaxy S24 Ultra', 27490000, 'Công nghệ AI đỉnh cao và camera 200MP siêu nét.', 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=500&q=80', 1, 40, CURRENT_TIMESTAMP, 1),
(3, 'MacBook Pro 14 M3 Pro', 45990000, 'Hiệu năng bứt phá cho lập trình viên và đồ họa chuyên nghiệp.', 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500&q=80', 1, 30, CURRENT_TIMESTAMP, 2),
(4, 'Dell XPS 15 OLED', 38500000, 'Màn hình OLED 3.5K sắc nét, thiết kế nhôm nguyên khối sang trọng.', 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=500&q=80', 1, 25, CURRENT_TIMESTAMP, 2),
(5, 'Tai nghe Sony WH-1000XM5', 7990000, 'Khả năng chống ồn chủ động hàng đầu thế giới.', 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=500&q=80', 1, 60, CURRENT_TIMESTAMP, 3),
(6, 'Apple Watch Ultra 2', 19990000, 'Đồng hồ thể thao chuyên nghiệp với vỏ titan siêu bền.', 'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=500&q=80', 1, 35, CURRENT_TIMESTAMP, 4),
(7, 'Xiaomi 14 Ultra Leica', 24990000, 'Hệ thống 4 camera cảm biến 1 inch hợp tác cùng Leica.', 'https://images.unsplash.com/photo-1580910051074-3eb694886505?w=500&q=80', 1, 45, CURRENT_TIMESTAMP, 1),
(8, 'Asus ROG Zephyrus G14', 39990000, 'Laptop gaming mỏng nhẹ màn hình OLED 120Hz mạnh mẽ.', 'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=500&q=80', 1, 20, CURRENT_TIMESTAMP, 2),
(9, 'Bàn phím cơ Keychron Q1 Pro', 4500000, 'Bàn phím custom nhôm CNC Bluetooth không dây cao cấp.', 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500&q=80', 1, 80, CURRENT_TIMESTAMP, 3),
(10, 'Chuột Logitech MX Master 3S', 2290000, 'Chuột công thái học tĩnh âm cho dân văn phòng và coder.', 'https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?w=500&q=80', 1, 100, CURRENT_TIMESTAMP, 3),
(11, 'Garmin Fenix 7 Pro Solar', 21500000, 'Đồng hồ đa môn thể thao pin sạc năng lượng mặt trời.', 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=500&q=80', 1, 15, CURRENT_TIMESTAMP, 4),
(12, 'iPad Pro M4 11 inch', 26990000, 'Màn hình OLED Ultra Retina XDR siêu mỏng chỉ 5.3mm.', 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500&q=80', 1, 55, CURRENT_TIMESTAMP, 1),
(13, 'Củ sạc Anker GaNPrime 65W', 990000, 'Công nghệ sạc nhanh GaN 3 cổng nhỏ gọn tiện lợi.', 'https://images.unsplash.com/photo-1583863788434-e58a36330cf0?w=500&q=80', 1, 120, CURRENT_TIMESTAMP, 3),
(14, 'Tai nghe AirPods Pro 2 USB-C', 5490000, 'Chống ồn thông minh thích ứng và âm thanh không gian.', 'https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=500&q=80', 1, 70, CURRENT_TIMESTAMP, 3)
ON DUPLICATE KEY UPDATE `ProductName`=VALUES(`ProductName`);
