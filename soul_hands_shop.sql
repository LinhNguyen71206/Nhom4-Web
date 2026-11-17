-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 17, 2026 lúc 06:21 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `soul_hands_shop`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`) VALUES
(1, 'Gốm sứ', 'gom-su'),
(2, 'Gỗ điêu khắc', 'go-dieu-khac'),
(3, 'Mây tre', 'may-tre'),
(4, 'Sơn mài', 'son-mai');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `coupons`
--

CREATE TABLE `coupons` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `type` enum('percent','fixed') NOT NULL DEFAULT 'percent',
  `value` decimal(12,0) NOT NULL DEFAULT 0,
  `min_order` decimal(12,0) NOT NULL DEFAULT 0,
  `max_discount` decimal(12,0) DEFAULT NULL,
  `usage_limit` int(10) UNSIGNED DEFAULT NULL,
  `used_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `coupons`
--

INSERT INTO `coupons` (`id`, `code`, `description`, `type`, `value`, `min_order`, `max_discount`, `usage_limit`, `used_count`, `start_date`, `end_date`, `is_active`, `created_at`) VALUES
(1, 'HANDMADE10', 'Giảm 10% toàn đơn', 'percent', 10, 0, NULL, NULL, 0, NULL, NULL, 1, '2026-11-10 16:43:29'),
(2, 'SOUL20', 'Giảm 20% toàn đơn', 'percent', 20, 0, NULL, NULL, 0, NULL, NULL, 1, '2026-11-10 16:43:29'),
(3, 'FREESHIP', 'Giảm 30.000đ', 'fixed', 30000, 300000, NULL, NULL, 1, NULL, NULL, 1, '2026-11-10 16:43:29');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_code` varchar(30) NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `receiver_name` varchar(100) NOT NULL,
  `receiver_phone` varchar(20) NOT NULL,
  `receiver_email` varchar(150) DEFAULT NULL,
  `province` varchar(100) NOT NULL,
  `district` varchar(100) NOT NULL,
  `ward` varchar(100) NOT NULL,
  `address` varchar(255) NOT NULL,
  `full_address` varchar(600) NOT NULL,
  `subtotal` decimal(12,0) NOT NULL DEFAULT 0,
  `shipping_fee` decimal(12,0) NOT NULL DEFAULT 0,
  `discount` decimal(12,0) NOT NULL DEFAULT 0,
  `total` decimal(12,0) NOT NULL DEFAULT 0,
  `coupon_code` varchar(50) DEFAULT NULL,
  `payment_method` enum('cod','bank','momo') NOT NULL DEFAULT 'cod',
  `payment_status` enum('unpaid','paid') NOT NULL DEFAULT 'unpaid',
  `status` enum('pending','confirmed','shipping','delivered','cancelled') NOT NULL DEFAULT 'pending',
  `note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `order_code`, `user_id`, `receiver_name`, `receiver_phone`, `receiver_email`, `province`, `district`, `ward`, `address`, `full_address`, `subtotal`, `shipping_fee`, `discount`, `total`, `coupon_code`, `payment_method`, `payment_status`, `status`, `note`, `created_at`, `updated_at`) VALUES
(1, 'SH2610276885', 1, 'Nguyễn Hoàng Linh', '0358716436', 'linhnguyents26@gmail.com', 'Thành phố Hà Nội', 'Quận Long Biên', 'Phường Thượng Thanh', '1', '1, Phường Thượng Thanh, Quận Long Biên, Thành phố Hà Nội', 200000, 35000, 0, 235000, '', 'cod', 'unpaid', 'delivered', '', '2026-10-27 17:16:12', '2026-10-28 09:41:39'),
(2, 'SH2611118169', 3, 'Nguyễn Hoàng Linh', '0123456789', 'linhnguyents26@gmail.com', 'Tỉnh Đắk Lắk', 'Huyện Lắk', 'Xã Krông Nô', 'ádsdasd', 'ádsdasd, Xã Krông Nô, Huyện Lắk, Tỉnh Đắk Lắk', 1100000, 0, 0, 1100000, '', 'cod', 'unpaid', 'cancelled', '', '2026-11-11 03:44:05', '2026-11-12 12:15:02'),
(3, 'SH2611124077', 1, 'Nguyễn Hoàng Linh', '0123456789', 'linhnguyents26@gmail.com', 'Tỉnh Bình Định', 'Thành phố Quy Nhơn', 'Xã Nhơn Châu', '123', '123, Xã Nhơn Châu, Thành phố Quy Nhơn, Tỉnh Bình Định', 50000, 35000, 30000, 55000, 'FREESHIP', 'cod', 'unpaid', 'delivered', '', '2026-11-12 12:15:50', '2026-11-12 12:16:04'),
(4, 'SH2611177478', 1, 'Nguyễn Hoàng', '0123456789', 'linhnguyents@gmail.com', 'Tỉnh Cà Mau', 'Huyện U Minh', 'Xã Khánh Hòa', '123', '123, Xã Khánh Hòa, Huyện U Minh, Tỉnh Cà Mau', 690000, 0, 0, 690000, '', 'cod', 'unpaid', 'delivered', '', '2026-11-17 05:54:15', '2026-11-17 05:55:01'),
(5, 'SH2611178516', 1, 'Nguyễn', '01234567898', 'linhnguyents26@gmail.com', 'Tỉnh Bình Thuận', 'Huyện Phú Quí', 'Xã Ngũ Phụng', '1', '1, Xã Ngũ Phụng, Huyện Phú Quí, Tỉnh Bình Thuận', 819999, 0, 0, 819999, '', 'cod', 'unpaid', 'cancelled', '', '2026-11-17 05:55:55', '2026-11-17 05:56:13'),
(6, 'SH2611175705', 1, 'Nguyễn duy', '0358716436', 'linhnguyents26@gmail.com', 'Tỉnh Đắk Nông', 'Huyện Đăk Glong', 'Xã Quảng Hoà', '11', '11, Xã Quảng Hoà, Huyện Đăk Glong, Tỉnh Đắk Nông', 7770000, 0, 0, 7770000, '', 'cod', 'unpaid', 'confirmed', '', '2026-11-17 05:57:51', '2026-11-17 05:58:02');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_items`
--

CREATE TABLE `order_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `product_name` varchar(200) NOT NULL,
  `product_image` varchar(500) DEFAULT NULL,
  `unit_price` decimal(12,0) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `subtotal` decimal(12,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `product_name`, `product_image`, `unit_price`, `quantity`, `subtotal`) VALUES
(1, 1, 2, 'Bát sứ', 'assets/images/bat_su.jpg', 100000, 2, 200000),
(2, 2, 5, 'Bát sứ', '', 100000, 11, 1100000),
(3, 3, 13, 'Đĩa gỗ Dừa', 'assets/images/dia_godua.jpg', 50000, 1, 50000),
(4, 4, 14, 'Đĩa gốm Xanh', 'assets/images/dia_gom.jpg', 690000, 1, 690000),
(5, 5, 15, 'Đồng hồ Gỗ', 'assets/images/dong_ho_go.jpg', 819999, 1, 819999),
(6, 6, 28, 'Tượng phật di lặc', 'assets/images/tuong_phat_dilac.jpg', 2590000, 3, 7770000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(200) NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `price` decimal(12,0) NOT NULL DEFAULT 0,
  `old_price` decimal(12,0) DEFAULT NULL,
  `badge` varchar(30) DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `style` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `sub_type` varchar(50) DEFAULT NULL,
  `image_class` varchar(30) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `name`, `category_id`, `price`, `old_price`, `badge`, `image_url`, `description`, `style`, `color`, `sub_type`, `image_class`, `created_at`) VALUES
(6, 'Bát sứ', 1, 100000, 125000, '-20%', 'assets/images/bat_su.jpg', 'Bát sứ Tràng An mang phong cách truyền thống. Phù hợp cho trang trí bàn thờ.', 'truyen-thong', 'xanh', 'chen-bat', 'rust', '2026-11-12 11:47:02'),
(7, 'Bình gốm Chu Đậu', 1, 725000, 849000, '-15%', 'assets/images/binh_gom_ChuDau.jpg', '', 'truyen-thong', 'nau', 'binh-hoa', '', '2026-11-12 11:50:18'),
(8, 'Bình hoa Sơn mài', 1, 749999, 800000, '-6%', 'assets/images/binh_hoa_sonmai.jpg', '', 'dan-gian', 'hong', 'binh-hoa', '', '2026-11-12 11:51:25'),
(9, 'Bình gốm Hoa', 1, 699999, 750000, '-7%', 'assets/images/binhgom_hoa.jpg', '', 'dan-gian', 'xanh', 'binh-hoa', '', '2026-11-12 11:52:57'),
(10, 'Bộ ấm trà Truyền thống', 1, 599999, 700000, '-14%', 'assets/images/bo_am_tra.jpg', '', 'truyen-thong', 'trang', 'am-tra', '', '2026-11-12 11:53:52'),
(11, 'Bộ dụng cụ bếp bằng gỗ Dừa', 2, 259999, 300000, '-13%', 'assets/images/bodungcu_dua.jpg', '', 'thien-nhien', 'nau-dam', 'do-dung', '', '2026-11-12 11:55:14'),
(12, 'Đèn lồng bằng Mây', 3, 159000, 180000, '-12%', 'assets/images/den_long_may.jpg', '', 'thien-nhien', 'nau-tre', 'den-long', '', '2026-11-12 11:56:07'),
(13, 'Đĩa gỗ Dừa', 2, 50000, 69000, '-28%', 'assets/images/dia_godua.jpg', '', 'thien-nhien', 'nau-sang', 'khay-dia', '', '2026-11-12 11:57:05'),
(14, 'Đĩa gốm Xanh', 1, 690000, 790000, '-13%', 'assets/images/dia_gom.jpg', '', 'truyen-thong', 'trang', 'chen-bat', '', '2026-11-12 11:58:26'),
(15, 'Đồng hồ Gỗ', 2, 819999, 999999, '-18%', 'assets/images/dong_ho_go.jpg', '', 'thien-nhien', 'nau-dam', 'do-trang-tri', '', '2026-11-12 11:59:16'),
(16, 'Ghế Mây', 3, 600000, 629000, '-5%', 'assets/images/ghe_may_tron.jpg', '', 'thien-nhien', 'kem-vang', 'do-noi-that', '', '2026-11-12 12:00:25'),
(17, 'Giỏ Mây oval', 3, 79000, 99999, '-21%', 'assets/images/gio_may_oval.jpg', '', 'thien-nhien', 'kem-vang', 'gio-ro', '', '2026-11-12 12:01:08'),
(18, 'Giỏ sách Mây', 3, 100000, 129000, '-22%', 'assets/images/gio_xach_may.jpg', '', 'bohemian', 'nau-tre', 'gio-ro', '', '2026-11-12 12:01:51'),
(19, 'Tranh sơn mài Hà Nội xưa', 4, 1799999, 2000000, '-10%', 'assets/images/hanoixua_sonmai.jpg', '', 'co-dien', 'do-son', 'tranh-tuong', '', '2026-11-12 12:02:59'),
(20, 'Hộp sơn mài', 4, 425000, 500000, '-15%', 'assets/images/hop_sonmai.jpg', '', 'phong-dong', 'xanh-co-vit', 'hop-khay', '', '2026-11-12 12:03:50'),
(21, 'Khay Mây', 3, 135000, 150000, '-10%', 'assets/images/khay_may_xacu.jpg', '', 'bohemian', 'nau-tre', 'gio-ro', '', '2026-11-12 12:04:53'),
(22, 'Khay gỗ', 2, 189000, 200000, '-6%', 'assets/images/khay_go.jpg', '', 'dan-gian', 'tu-nhien', 'do-trang-tri', '', '2026-11-12 12:05:56'),
(23, 'Khay sơn mài', 4, 169000, 219000, '-23%', 'assets/images/khay_sonmai.jpg', '', 'co-dien', 'den-son', 'do-trang-tri', '', '2026-11-12 12:07:11'),
(24, 'Khay tre', 3, 150000, NULL, '', 'assets/images/khay_tre2.jpg', '', 'bohemian', 'nau-tre', 'khay-may', '', '2026-11-12 12:08:16'),
(25, 'Khay tròn Mây', 3, 89000, NULL, '', 'assets/images/khay_tron_may.jpg', '', 'truyen-thong', 'nau-tre', 'gio-ro', '', '2026-11-12 12:09:03'),
(26, 'Tranh sơn mài thiếu nữ sen', 4, 1999999, NULL, '', 'assets/images/tranh_thieunu_sen.jpg', '', 'hien-dai', 'do-son', 'tranh-tuong', '', '2026-11-12 12:10:10'),
(27, 'Tượng gốm quan âm', 1, 3199999, NULL, '', 'assets/images/tuong_gom_quanam.jpg', '', 'truyen-thong', 'kem', 'tuong', '', '2026-11-12 12:11:03'),
(28, 'Tượng phật di lặc', 2, 2590000, 2700000, '-4%', 'assets/images/tuong_phat_dilac.jpg', '', 'truyen-thong', 'tu-nhien', 'tuong-nghe-thuat', '', '2026-11-12 12:11:59'),
(29, 'Tượng Rồng', 2, 3890000, 4000000, '-3%', 'assets/images/tuong_rong.jpg', '', 'hien-dai', 'vang-gold', 'tuong-nghe-thuat', '', '2026-11-12 12:13:04'),
(30, 'Tượng Thần tài', 2, 4790000, 5000000, '-4%', 'assets/images/tuonggo_thantai.jpg', '', 'dan-gian', 'nau-dam', 'tuong-nghe-thuat', '', '2026-11-12 12:13:58'),
(31, 'Vòng tay', 4, 299000, 310000, '-4%', 'assets/images/vong_tay_sonmai.jpg', '', 'hien-dai', 'vang-nhung', 'trang-suc', '', '2026-11-12 12:14:48');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `reviews`
--

CREATE TABLE `reviews` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `rating` tinyint(3) UNSIGNED NOT NULL,
  `comment` text DEFAULT NULL,
  `status` enum('visible','hidden') NOT NULL DEFAULT 'visible',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `reviews`
--

INSERT INTO `reviews` (`id`, `product_id`, `user_id`, `rating`, `comment`, `status`, `created_at`, `updated_at`) VALUES
(2, 13, 1, 5, 'Đồ dùng tốt', 'visible', '2026-11-12 12:17:04', NULL),
(3, 14, 1, 5, '', 'visible', '2026-11-17 05:58:57', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('customer','admin') NOT NULL DEFAULT 'customer',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `phone`, `password`, `role`, `created_at`) VALUES
(1, 'Nguyễn Hoàng Linh', 'admin@soulandhands.vn', '0358716436', '$2y$10$Z56fFkJCrSTX7lonBWA1jut7EHrCTxMb4yE5craoC..BkiRpMFUMm', 'admin', '2026-10-25 16:15:32'),
(2, 'Nguyễn Hoàng Linh', 'linhnguyents26@gmail.com', '0358716436', '$2y$10$fusqJoqErOlj4U.yPTjWfOSRAxY2BbKUSuQ0HRcJACZ8mHdHAytC6', 'customer', '2026-10-27 17:01:33'),
(3, 'Nguyễn Hoàng Linh', 'linhnguyents@gmail.com', '0123456789', '$2y$10$zWkFchbMxu0awjXU1pctIOj6Utx1j8p5S7BzzjLv.DWdsrm5ljy3K', 'customer', '2026-11-10 17:00:34');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_categories_slug` (`slug`);

--
-- Chỉ mục cho bảng `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_coupons_code` (`code`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_orders_code` (`order_code`),
  ADD KEY `idx_orders_user` (`user_id`),
  ADD KEY `idx_orders_status` (`status`);

--
-- Chỉ mục cho bảng `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_items_order` (`order_id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_products_category` (`category_id`);

--
-- Chỉ mục cho bảng `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_review_user_product` (`user_id`,`product_id`),
  ADD KEY `idx_reviews_product` (`product_id`,`status`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_users_email` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT cho bảng `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_reviews_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_reviews_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
