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
(1, 'M.O.I', 'Mặt nạ Gạo Hydrogel vàng phiên bản cao cấp\r\n', 1, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '28 gram x 3 miếng', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 299000, 1000, 'assets/images/thumbnails/e651913ed4cb56acc40465a78bd1d83cab272deef7518d9f76b07b6a3e8ef606.jpg', '[\"assets/images/products/b09a6e0d6c98a1e716eb09f93df17264af64a5a04b01f27be1324346d2de7eb7.jpg\",\"assets/images/products/c75dab334bd6cd06840c95edaaac0e1337ef38ee9cc0c5c537d0ad3a52bb5b4d.jpg\",\"assets/images/products/e0d3480dd3171f4ea9a1e77deeeec0fa36ea963c1f9403e35d074377d7138cef.jpg\",\"assets/images/products/4424a6f82ff1f3c5d6068478891b2da9ce6b16ebfd489d2c15530ec8566025d5.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(2, 'M.O.I', 'Mặt nạ bơ tinh khiết hydrgel da by M.O.I', 1, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '28 gram x 3 miếng', 'Bảo quản nơi khô ráo, thoáng mát. Tránh nhiệt độ cao.', 199000, 900, 'assets/images/thumbnails/c6cf3bd922ed22fc2c1c53e0a321108b9851f546ef0d3f763b2d59e1b6612101.jpg', '[\"assets/images/products/62a85936c0d3616b53d7a80ea853e7529e9729bcb00428da36f0b8310e57ca63.jpg\",\"assets/images/products/a87f3e2d0dd58d8464972819c60c2ecb979916cd6483406753e81b9db5587348.jpg\",\"assets/images/products/799a89b46b68bdfd62fb8ffd70ccb2391a351f6fc5ed1c9a0b7d4a86e13fd2ff.jpg\",\"assets/images/products/f4e19c64f4684e84e3f66cd4211e3c9682b6aa26513310d3c7ed512089baee91.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(3, 'M.O.I', 'Son dưỡng có màu Jelly Lipgloss M.O.I', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '4.5 gram', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 359000, 1650, 'assets/images/thumbnails/abe1c1fa1b047c49bc18a5a52fafb1b8b7497b5378945966dd1399d31bd2de88.jpg', '[\"assets/images/products/8a3a23ccb982151cb818000b30c0d247bc2a9cd5453d5e41db3cab5eaf184ee1.jpg\",\"assets/images/products/4fae91f2cb7b97d3b6fc3ef86aa02ad53cebfe08f8d1e1f34fb09e59fd2653bd.jpg\",\"assets/images/products/82c2f42e64e17eda29e42b52af4ec7bb39bbf2056eec415b989cd9ad68efebdb.jpg\",\"assets/images/products/47367d999f994a6da9cb64f436d65cf08af8eb5984317d036dd7e0a90008bb57.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(4, 'M.O.I', 'Son thỏi M.O.I the Stars phiên bản giới hạn mùa Lễ hội', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '3.5g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 319000, 350, 'assets/images/thumbnails/cbb92615a2fca5ea23f81d6b5f1a2fe038f20785d650c758e9340981a9f51ff0.jpg', '[\"assets/images/products/775f245bc796827e0d2ef1704e528219154c60d92e936a9e3c1f526b82d2c2ff.jpg\",\"assets/images/products/59d3669fcfa396e5e007ab6ce773f620664afbe4564425ce32562102811100f4.jpg\",\"assets/images/products/cb52d020661aa873de55d268fe4fe89039ee7e5d44c9edfc61dba3d75bcb1240.jpg\",\"assets/images/products/0f389bd209ace48144a98ba008ec93151a5f1efc596351dc56fa8421d30322fc.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(5, 'M.O.I', '6 màu son kem nhung lì Sgirls by M.O.I', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '3.5g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 299000, 300, 'assets/images/thumbnails/ea7d5ce196ed5ba570b7335d5c0f7fdd0858e1e0ee20ea7f6207896e8c409df1.jpg', '[\"assets/images/products/93d712acb2c9dca7690cd92c7d3ec08cc2390565cecf26d65b16d711cf4482c7.jpg\",\"assets/images/products/94bdef9d6e761bf6fe3e6b9bafbe73d29e399610d3189cde59d323ea4979407f\",\"assets/images/products/d2b439b0e33e8a7a4bcc1f5fdbef7340423a0e681bbb9ae8687dbc3b840fbab9.jpg\",\"assets/images/products/9366b6517bd272d12ca9f6bbb7a230d311070ecb4cfeeafc71d4420d45056f62.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(6, 'M.O.I', 'Phấn nước M.O.I Premium baby skin cushion', 3, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '12g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 599000, 1000, 'assets/images/thumbnails/731915630888b554c7a925c94f42999e7525cbca09bc0a683a9166930a832853.jpg', '[\"assets/images/products/da0e5b435096231f1debbf8e21552803ee421132a8b90e477bb76e79f6e968e8.jpg\",\"assets/images/products/f0e21d00aaf41cfbeb996fb7a16bc85440be25d07fb2324febe7560eb98a9de5.jpg\",\"assets/images/products/dfefc2076b0d51e25a9f4d0ff146b76689d99d3888e775db8ed98f88f07585b2.jpg\",\"assets/images/products/daa930e0687768d7b922f18b24ead9ab67732ccc4284489c411b074670bbbe2a.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(7, 'M.O.I', 'Phấn nước M.O.I Iconic perfection cushion', 3, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '12g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 399000, 300, 'assets/images/thumbnails/fa1dfdb9d5d00d7ae0f231ee358b40fc32e8099c12e780f58edd40633ebb7646.jpg', '[\"assets/images/products/7371dfd22d9a6fa865a47a8b981d64abc58f1561842e18a3835e32b14d29ad7a.jpg\",\"assets/images/products/31f8fe3064403bf194ba42b2cf50ef072a7fe0abcc87aee6f9b039956150870f.jpg\",\"assets/images/products/f2816b437e84b64b7960e143270078f6714bd374c187fe258f24673e59595c23.jpg\",\"assets/images/products/9627b63f9b3b7d91dc2566aaee1050d6eba30b552259a34846980c76f8d38ed5.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(8, 'M.O.I', 'Phấn nước M.O.I Baby skin cushion', 3, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '12g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 399000, 340, 'assets/images/thumbnails/36a9c7f85265a1f6efa2202233a7452bc15c2e2a6633d433085e19dbfaa95c83.jpg', '[\"assets/images/products/66c24be77fb036fe863d150e89b6a806ff8fb2ca0819476d06eaf29851f9c4eb.jpg\",\"assets/images/products/a75839eaaacb1bfe9579118ec7711ce281bc522c240a7c92ae79fed6eacb7f13.jpg\",\"assets/images/products/791781de1a0a0fec9a6e72ba5584f98dafb2be1b4785dd880cfb8cb3e0780c88.jpg\",\"assets/images/products/11db7f03c45389989bab980b4bdba2893d173cc91aab2509d05507e2c1e3e5e6.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(9, 'M.O.I', 'Phấn phủ M.O.I Baby skin powder [màu mới]', 4, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '10g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 499000, 560, 'assets/images/thumbnails/09ee5436461944df599111c4c594854287c964c281a682a00ccf8d5a4fe27290.jpg', '[\"assets/images/products/fc15ccc2513196c4cedd3d8c4334ca35c57ce441b6b8f3a356c5291a9c8d0e91.jpg\",\"assets/images/products/162397801a42f5414227e3032e443deccca3bb904aca7e6f6683a8f925a6cc0b.jpg\",\"assets/images/products/a0b0c65763f244d624c48bcda9e6dcd380819843a738700e29147fe0fc75989e.jpg\",\"assets/images/products/755523d8515bd81d13e58ee41d7321962e198c656cc6f3ffb8ecef8e3764e8f4.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(10, 'M.O.I', '6 màu son thỏi love M.O.I by Thuỳ Tiên', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '3.5g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 359000, 650, 'assets/images/thumbnails/b80217fe6f792a190e4f6e1bdef007cd0df23bdaf020ff1145170ae6dc26b4fc.jpg', '[\"assets/images/products/2592f2f578ccb40664bef7c5aee6a0e8c455d43e77b51d73317bcd33c374f574.jpg\",\"assets/images/products/b9041c6ea645c40346ef1962cac8b73f234d3dc479df55787eca5ff3ed170293.jpg\",\"assets/images/products/a22b21eb5e2b71b50cfbf221e91d04c62a82f15ed0d2e2b17aeb202b8f4a4203.jpg\",\"assets/images/products/ab98609915bb066751456d54edf57e8dc89f24bd41bbc33a9cace8dc04599bed.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(11, 'M.O.I', 'Set 6 son thỏi cao cấp love M.O.I phiên bản giới hạn', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '2.2g/thỏi', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 2274000, 900, 'assets/images/thumbnails/d0a196a9adbc8ae2484b1af3d753b6677972fc0f8af259b18228ad3d360b77c6.jpg', '[\"assets/images/products/23f145f1b771f0b08cca35f64ad6787e5bb61404926146fb63e10559eb1e70ed.jpg\",\"assets/images/products/cfe90a9dfbc47bbbc550c082945c8fd49482535784e2e32ba2298851129614c6.jpg\",\"assets/images/products/18df951db0593c292eab8dbf1d442a1e2514b6974b12b3d0a312620eeb9a46d3.jpg\",\"assets/images/products/d3ab396d2b83bb1494516c4f6971aea14f678b141372d9bdcde569e3142e89b8.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(12, 'M.O.I', 'Son môi sáp cao cấp love M.O.I Matte Lipstick', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '2.2g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 379000, 599, 'assets/images/thumbnails/ca2aca95720d8cfd3ac72a47b5a021ba45a830b8a7514b84d346100d84be6e6e.jpg', '[\"assets/images/products/63de3e3c2b939d97d5d28c161851cf01807f33503088c1928f8b4bc29541184d.jpg\",\"assets/images/products/f1e02f0b9160c51cd6e53ed10ea1101754a202f25e5b9154d2e92aefc47050c0.jpg\",\"assets/images/products/9aefc858d0e8bb620f6acd6d4b7422b3314ed8c042118a8412722c51c613688a.jpg\",\"assets/images/products/0bf02fabcc97b684d728f975d4535e87dec65a1109fc0d77c11da1ae6a3bb705.jpg\"]', '2023-11-16 15:34:35', NULL, NULL);

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
