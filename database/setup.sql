-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 16, 2023 lúc 02:41 PM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `miu`
--
CREATE DATABASE IF NOT EXISTS `miu` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `miu`;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL COMMENT 'ID dùng để quản lý, tự động tăng',
  `username` varchar(30) NOT NULL COMMENT 'Admin dùng username để đăng nhập',
  `hashed_password` varchar(64) NOT NULL COMMENT 'Mật khẩu sau khi hash bằng SHA256',
  `role` enum('super_admin','admin') NOT NULL COMMENT 'Phân quyền, super_admin có thể tạo ra admin',
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `delete_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart`
--

CREATE TABLE `cart` (
  `user_id` int(11) NOT NULL COMMENT 'Liên kết với id bảng user',
  `product_id` int(11) NOT NULL COMMENT 'Liên kết với id bảng product',
  `amount` int(11) NOT NULL DEFAULT 1 COMMENT 'Số lượng sẩn phẩm được chọn'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL COMMENT 'ID dùng để quản lý, tự động tăng',
  `name` varchar(30) NOT NULL COMMENT 'Tên loại sản phẩm',
  `slug` varchar(30) NOT NULL COMMENT 'Đường dẫn trên web',
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `delete_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `category`
--

INSERT INTO `category` (`id`, `name`, `slug`, `create_at`, `update_at`, `delete_at`) VALUES
(1, 'Mặt nạ', 'fb.com', '2023-11-16 15:34:35', NULL, NULL),
(2, 'Son môi', 'fb.com', '2023-11-16 15:34:35', NULL, NULL),
(3, 'Phấn nước', 'fb.com', '2023-11-16 15:34:35', NULL, NULL),
(4, 'Phấn phủ', 'fb.com', '2023-11-16 15:34:35', NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL COMMENT 'ID dùng để quản lý, tự động tăng',
  `user_id` int(11) NOT NULL COMMENT 'Liên kết với id bảng user',
  `total_price` bigint(20) NOT NULL COMMENT 'Được tính dựa trên bảng order_data',
  `payment` enum('cod','vnpay') NOT NULL COMMENT 'Lựa chọn phương thức thanh toán',
  `status` enum('processing','shipping','done','canceled') NOT NULL COMMENT 'Tình trạng đơn hàng',
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `delete_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_data`
--

CREATE TABLE `order_data` (
  `order_id` int(11) NOT NULL COMMENT 'Liên kết với id bảng order',
  `product_id` int(11) NOT NULL COMMENT 'Liên kết với id bảng product',
  `amount` int(11) NOT NULL DEFAULT 1 COMMENT 'Số lượng sẩn phẩm được chọn'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL COMMENT 'ID dùng để quản lý, tự động tăng',
  `brand` varchar(30) NOT NULL DEFAULT 'M.O.I' COMMENT 'Tên hãng, mặc định là M.O.I',
  `name` varchar(100) NOT NULL COMMENT 'Tên sản phẩm',
  `category_id` int(11) NOT NULL COMMENT 'ID loại sản phẩm',
  `origin` varchar(50) NOT NULL COMMENT 'Xuất xứ',
  `expiry_date` varchar(50) NOT NULL COMMENT 'Hạn sử dụng',
  `weight` varchar(50) NOT NULL COMMENT 'Trọng lượng',
  `preservation` varchar(150) NOT NULL COMMENT 'Cách bảo quản',
  `price` bigint(20) NOT NULL COMMENT 'Giá sản phẩm',
  `amount` int(11) NOT NULL COMMENT 'Số lượng sẩn phẩm hiện có',
  `thumbnail` longtext DEFAULT NULL,
  `images` longtext DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `delete_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`id`, `brand`, `name`, `category_id`, `origin`, `expiry_date`, `weight`, `preservation`, `price`, `amount`, `thumbnail`, `images`, `create_at`, `update_at`, `delete_at`) VALUES
(1, 'M.O.I', 'Mặt nạ Gạo Hydrogel vàng phiên bản cao cấp\r\n', 1, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '28 gram x 3 miếng', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 299000, 1000, 'assets/images/thumbnails/mask_tang_cot_toc_c2befaf454a84db09ddbae76c2b25587_master.jpg', '[\"assets/images/products/pro_hop_3_mieng_1_d5f41021bb824c16b160bb490e8ced96.jpg\",\"assets/images/products/pro_hop_3_mieng_3_61d493a720d2440687ced94b71af8807.jpg\",\"assets/images/products/pro_hop_3_mieng_4_2149a7556f884e93b5dc006724030a14.jpg\",\"assets/images/products/pro_hop_3_mieng_5_673ea2b644594df098be1dcb2972c383.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(2, 'M.O.I', 'Mặt nạ bơ tinh khiết hydrgel da by M.O.I', 1, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '28 gram x 3 miếng', 'Bảo quản nơi khô ráo, thoáng mát. Tránh nhiệt độ cao.', 199000, 900, 'assets/images/thumbnails/mask_e4dd437e1e6145b391e593406b590356_master.jpg', '[\"assets/images/products/297998604_180562687779221_5246664134353942080_n_193ae0caa28245d997ade87f582f7e2d_master.jpg\",\"assets/images/products/mask_e4dd437e1e6145b391e593406b590356_master.jpg\",\"assets/images/products/matna_3a4b00bfafa94a05aed9c6dd0e78562f_master.jpg\",\"assets/images/products/matna3_9264767e07104d77b9c766a9d3165d8d_master.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(3, 'M.O.I', 'Son dưỡng có màu Jelly Lipgloss M.O.I', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '4.5 gram', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 359000, 1650, 'assets/images/thumbnails/thump_e14cb415dfac43a6a3a6e0c4fe123774_master.jpg', '[\"assets/images/products/pro_no1_peaches_hong_cam_dao_4_ed7b5ffab30a4bfa9b87a4eb72193427.jpg\",\"assets/images/products/pro_no1_peaches_hong_cam_dao_3_516d8c3d2c434b7fb44132689068383f.jpg\",\"assets/images/products/pro_no1_peaches_hong_cam_dao_1_d886dea63e9a40bbb0ac7cef56c5123d.jpg\",\"assets/images/products/pro_no1_peaches_hong_cam_dao_2_19fdde224e6740c996450ff081f3ad37.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(4, 'M.O.I', 'Son thỏi M.O.I the Stars phiên bản giới hạn mùa Lễ hội', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '3.5g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 319000, 350, 'assets/images/thumbnails/stars_tang_guong_a077cf1e9e2d4a8482488f97b5c488cd_master.jpg', '[\"assets/images/products/pro_no1_cam_tay_4_8c89659c2cd6447ca0eaa2e14f6b5e07.jpg\",\"assets/images/products/pro_no1_cam_tay_3_b76c0827642f40d4aecb4895701a5c00.jpg\",\"assets/images/products/pro_no1_cam_tay_2_a400adc473554512bb06d00450e530ed.jpg\",\"assets/images/products/pro_no1_cam_tay_5_d82b215f9c504a229e72e1febf5ef4e8.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(5, 'M.O.I', '6 màu son kem nhung lì Sgirls by M.O.I', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '3.5g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 299000, 300, 'assets/images/thumbnails/sgirl_le___sgirl_mua2_giam_50_f4db37816c084a7d999de7468e2bd017_master.jpg', '[\"assets/images/products/pro_no1_halong_4_cc4c331c72ff47d0944906093cc87d14.jpg\",\"assets/images/products/pro_no1_halong_3_aaaf08b212814303b13ec84e5b8baac3\",\"assets/images/products/pro_no1_halong_2_798a48e8bd444482bcf1350a5c3610fa.jpg\",\"assets/images/products/pro_no1_halong_1_729a6d3700c34a69a1ce808f5bc4aa8f.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(6, 'M.O.I', 'Phấn nước M.O.I Premium baby skin cushion', 3, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '12g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 599000, 1000, 'assets/images/thumbnails/assets\\images\\thumbnails', '[\"assets/images/products/pro_tone10_2_a29bb6f1caea470dbd3328cd15588d2c.jpg\",\"assets/images/products/pro_tone10_3_46c28b4807fc42adbac1acf879dc9b09.jpg\",\"assets/images/products/pro_tone10_4_9e962a4c6c374279bea3e861eb01e09b.jpg\",\"assets/images/products/pro_tone10_5_c236e6613ed04e158d275e771fe491b3.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(7, 'M.O.I', 'Phấn nước M.O.I Iconic perfection cushion', 3, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '12g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 399000, 300, 'assets/images/thumbnails/iconic_tang_tui_coi_xuyen_suot_cd56f7be8fc5492db4c872faf04de042_master.jpg', '[\"assets/images/products/pro_tone10_2_a3cd65cd3e6d4c67a84c5437fc0f488e.jpg\",\"assets/images/products/pro_tone10_3_c42c76d7a1884f0f918c563eb4b8919c.jpg\",\"assets/images/products/pro_tone10_4_f398c171acb945149f423248cae57931.jpg\",\"assets/images/products/pro_tone10_5_3ae1f5ee3fc04b3f9bf009e48f280e0e.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(8, 'M.O.I', 'Phấn nước M.O.I Baby skin cushion', 3, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '12g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 399000, 340, 'assets/images/thumbnails/baby_tang_nuoc_tt_c5e9b170cf094a37964bd9cf59a30fa0_master.jpg', '[\"assets/images/products/pro_tone10_1_66bcd1b31fee4e5481363375b759d2e9.jpg\",\"assets/images/products/pro_tone10_5_02579120320740d1bf603fbbf45dcd1e.jpg\",\"assets/images/products/pro_tone10_3_65b9d74e70cc41da9f7f9b1b008e5aa8.jpg\",\"assets/images/products/pro_tone10_4_6d8e70a577564becaa1c160e821859a2.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(9, 'M.O.I', 'Phấn phủ M.O.I Baby skin powder [màu mới]', 4, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '10g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 499000, 560, 'assets/images/thumbnails/phanphu_gift_4d50a95982054aa5bc997a0bc0455be2_master.jpg', '[\"assets/images/products/pro_tonetranghong_2_a795d14150b2418da6a830e80e96e910.jpg\",\"assets/images/products/pro_tonetranghong_3_ad8a59b55878438bb45cbcdcdb4b4e81.jpg\",\"assets/images/products/pro_tonetranghong_4_1e425b1c690441fa873eca87c6d11a54.jpg\",\"assets/images/products/pro_tonetranghong_5_92fb09428eef428f923dd8e9e71d4bfd.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(10, 'M.O.I', '6 màu son thỏi love M.O.I by Thuỳ Tiên', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '3.5g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 359000, 650, 'assets/images/thumbnails/AnyConv.com__4_thuy_tien__67fa14c40c8040e28599052d5c723983_master.jpg', '[\"assets/images/products/AnyConv.com__pro_no1_cam_nau_dat_1_3624a871b9e94edebb9250288e43497d.jpg\",\"assets/images/products/AnyConv.com__pro_no1_cam_nau_dat_4_c8d7533cc7e54dfa873351013d8717ff.jpg\",\"assets/images/products/AnyConv.com__pro_no1_cam_nau_dat_2_5899b5da438d42d29afa162e41aa072e.jpg\",\"assets/images/products/AnyConv.com__pro_no1_cam_nau_dat_3_268270114cb3497aa3f4cafcf2e0499e.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(11, 'M.O.I', 'Set 6 son thỏi cao cấp love M.O.I phiên bản giới hạn', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '2.2g/thỏi', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 2274000, 900, 'assets/images/thumbnails/AnyConv.com__set6_tang_croissant_b_17d0ba2019d74c65951f33beae417c93_master.jpg', '[\"assets/images/products/pro_white_macaron_cam_dao_5_2492-510x510.jpg\",\"assets/images/products/pro_set_6_2_e70043aa539b444184fb-510x510.jpg\",\"assets/images/products/pro_set_6_4_180d1d2660744172aff9-510x510.jpg\",\"assets/images/products/pro_set_6_3_e05e686519af4a43bdc3-510x510.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(12, 'M.O.I', 'Son môi sáp cao cấp love M.O.I Matte Lipstick', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '2.2g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 379000, 599, 'assets/images/thumbnails/AnyConv.com__set3_tang_croissant__0820019c6b454087b5577fad321b5139_master.jpg', '[\"assets/images/products/AnyConv.com__pro_white_macaron_cam_dao_1_115ec84461d54bc6a1a2a2c320354e2c.jpg\",\"assets/images/products/AnyConv.com__pro_white_macaron_cam_dao_2_4b35e9e340004d63b2711c6d400acae7.jpg\",\"assets/images/products/AnyConv.com__pro_white_macaron_cam_dao_3_cbec5061f01e407db7dec88d197c3974.jpg\",\"assets/images/products/AnyConv.com__pro_white_macaron_cam_dao_6_fe7b7b1b60b84393809e0b4e3209e192.jpg\"]', '2023-11-16 15:34:35', NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL COMMENT 'ID dùng để quản lý, tự động tăng',
  `full_name` varchar(255) NOT NULL COMMENT 'Họ tên người dùng',
  `birth_year` int(11) NOT NULL COMMENT 'Năm sinh',
  `gender` enum('male','female') NOT NULL COMMENT 'Giới tính',
  `email` varchar(255) NOT NULL COMMENT 'Địa chỉ email',
  `hashed_password` varchar(64) NOT NULL COMMENT 'Mật khẩu sau khi hash bằng SHA256',
  `avatar_path` varchar(255) DEFAULT NULL COMMENT 'Đường dẫn lưu ảnh đại diện',
  `address` longtext DEFAULT NULL COMMENT 'Địa chỉ nhận hàng, lưu dạng json',
  `status` enum('activate','deactivate') NOT NULL COMMENT 'Nếu set deactivate là bị ban',
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `delete_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Chỉ mục cho bảng `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`user_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `order_data`
--
ALTER TABLE `order_data`
  ADD PRIMARY KEY (`order_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID dùng để quản lý, tự động tăng';

--
-- AUTO_INCREMENT cho bảng `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID dùng để quản lý, tự động tăng', AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID dùng để quản lý, tự động tăng';

--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID dùng để quản lý, tự động tăng', AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID dùng để quản lý, tự động tăng';

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Các ràng buộc cho bảng `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Các ràng buộc cho bảng `order_data`
--
ALTER TABLE `order_data`
  ADD CONSTRAINT `order_data_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `order_data_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Các ràng buộc cho bảng `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
