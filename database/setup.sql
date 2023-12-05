-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 27, 2023 lúc 07:21 PM
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

--
-- Đang đổ dữ liệu cho bảng `admin`
--

INSERT INTO `admin` (`id`, `username`, `hashed_password`, `role`, `create_at`, `update_at`, `delete_at`) VALUES
(1, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'super_admin', '2023-11-17 09:46:24', NULL, NULL),
(2, 'thuy', '5adf805ab91494fb0803dc1f111a31877545576686847d8790a46a30c7e6e285', 'admin', '2023-11-17 09:50:33', NULL, NULL),
(3, 'hoang', '270723e7f50a26d4ae90da0e13079f293dd37e9953f7f9801ce7de19a35fc58e', 'admin', '2023-11-17 09:51:12', NULL, NULL),
(4, 'vuong', '9ef78ba5f2594c24944ce9a90f2a6358d260a7cc3bb7db8e37f06c5d41249eef', 'admin', '2023-11-17 09:51:41', NULL, NULL);


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL COMMENT 'ID dùng để quản lý, tự động tăng',
  `name` varchar(30) NOT NULL COMMENT 'Tên loại sản phẩm',
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `delete_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `category`
--

INSERT INTO `category` (`id`, `name`, `create_at`, `update_at`, `delete_at`) VALUES
(1, 'Mặt nạ', '2023-11-16 15:34:35', NULL, NULL),
(2, 'Son môi', '2023-11-16 15:34:35', NULL, NULL),
(3, 'Phấn nước', '2023-11-16 15:34:35', NULL, NULL),
(4, 'Phấn phủ', '2023-11-16 15:34:35', NULL, NULL),
(5, 'Chăm sóc da & Trang điểm', '2023-11-16 15:34:35', NULL, NULL),
(6, 'Nước hoa', '2023-11-16 15:34:35', NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL COMMENT 'ID dùng để quản lý, tự động tăng',
  `user_id` int(11) NOT NULL COMMENT 'Liên kết với id bảng user',
  `address` longtext NOT NULL COMMENT 'Địa chỉ nhận hàng',
  `total_price` bigint(20) NOT NULL COMMENT 'Được tính dựa trên bảng order_data',
  `payment` enum('cod','vnpay') NOT NULL COMMENT 'Lựa chọn phương thức thanh toán',
  `status` enum('processing','shipping','done','canceled') NOT NULL COMMENT 'Tình trạng đơn hàng',
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
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
(1, 'M.O.I', 'Mặt nạ Gạo Hydrogel vàng phiên bản cao cấp\r\n', 1, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '28 gram x 3 miếng', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 299000, 1000, 'assets/images/thumbnails/e651913ed4cb56acc40465a78bd1d83cab272deef7518d9f76b07b6a3e8ef606.webp', '[\"assets/images/products/b09a6e0d6c98a1e716eb09f93df17264af64a5a04b01f27be1324346d2de7eb7.webp\",\"assets/images/products/c75dab334bd6cd06840c95edaaac0e1337ef38ee9cc0c5c537d0ad3a52bb5b4d.webp\",\"assets/images/products/e0d3480dd3171f4ea9a1e77deeeec0fa36ea963c1f9403e35d074377d7138cef.webp\",\"assets/images/products/4424a6f82ff1f3c5d6068478891b2da9ce6b16ebfd489d2c15530ec8566025d5.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(2, 'M.O.I', 'Mặt nạ bơ tinh khiết hydrgel da by M.O.I', 1, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '28 gram x 3 miếng', 'Bảo quản nơi khô ráo, thoáng mát. Tránh nhiệt độ cao.', 199000, 900, 'assets/images/thumbnails/c6cf3bd922ed22fc2c1c53e0a321108b9851f546ef0d3f763b2d59e1b6612101.webp', '[\"assets/images/products/62a85936c0d3616b53d7a80ea853e7529e9729bcb00428da36f0b8310e57ca63.webp\",\"assets/images/products/a87f3e2d0dd58d8464972819c60c2ecb979916cd6483406753e81b9db5587348.webp\",\"assets/images/products/799a89b46b68bdfd62fb8ffd70ccb2391a351f6fc5ed1c9a0b7d4a86e13fd2ff.webp\",\"assets/images/products/f4e19c64f4684e84e3f66cd4211e3c9682b6aa26513310d3c7ed512089baee91.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(3, 'M.O.I', 'Son dưỡng có màu Jelly Lipgloss M.O.I', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '4.5 gram', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 359000, 1650, 'assets/images/thumbnails/abe1c1fa1b047c49bc18a5a52fafb1b8b7497b5378945966dd1399d31bd2de88.webp', '[\"assets/images/products/8a3a23ccb982151cb818000b30c0d247bc2a9cd5453d5e41db3cab5eaf184ee1.webp\",\"assets/images/products/4fae91f2cb7b97d3b6fc3ef86aa02ad53cebfe08f8d1e1f34fb09e59fd2653bd.webp\",\"assets/images/products/82c2f42e64e17eda29e42b52af4ec7bb39bbf2056eec415b989cd9ad68efebdb.webp\",\"assets/images/products/47367d999f994a6da9cb64f436d65cf08af8eb5984317d036dd7e0a90008bb57.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(4, 'M.O.I', 'Son thỏi M.O.I the Stars phiên bản giới hạn mùa Lễ hội', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '3.5g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 319000, 350, 'assets/images/thumbnails/cbb92615a2fca5ea23f81d6b5f1a2fe038f20785d650c758e9340981a9f51ff0.webp', '[\"assets/images/products/775f245bc796827e0d2ef1704e528219154c60d92e936a9e3c1f526b82d2c2ff.webp\",\"assets/images/products/59d3669fcfa396e5e007ab6ce773f620664afbe4564425ce32562102811100f4.webp\",\"assets/images/products/cb52d020661aa873de55d268fe4fe89039ee7e5d44c9edfc61dba3d75bcb1240.webp\",\"assets/images/products/0f389bd209ace48144a98ba008ec93151a5f1efc596351dc56fa8421d30322fc.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(5, 'M.O.I', '6 màu son kem nhung lì Sgirls by M.O.I', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '3.5g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 299000, 300, 'assets/images/thumbnails/ea7d5ce196ed5ba570b7335d5c0f7fdd0858e1e0ee20ea7f6207896e8c409df1.webp', '[\"assets/images/products/93d712acb2c9dca7690cd92c7d3ec08cc2390565cecf26d65b16d711cf4482c7.webp\",\"assets/images/products/94bdef9d6e761bf6fe3e6b9bafbe73d29e399610d3189cde59d323ea4979407f.webp\",\"assets/images/products/d2b439b0e33e8a7a4bcc1f5fdbef7340423a0e681bbb9ae8687dbc3b840fbab9.webp\",\"assets/images/products/9366b6517bd272d12ca9f6bbb7a230d311070ecb4cfeeafc71d4420d45056f62.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(6, 'M.O.I', 'Phấn nước M.O.I Premium baby skin cushion', 3, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '12g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 599000, 1000, 'assets/images/thumbnails/731915630888b554c7a925c94f42999e7525cbca09bc0a683a9166930a832853.webp', '[\"assets/images/products/da0e5b435096231f1debbf8e21552803ee421132a8b90e477bb76e79f6e968e8.webp\",\"assets/images/products/f0e21d00aaf41cfbeb996fb7a16bc85440be25d07fb2324febe7560eb98a9de5.webp\",\"assets/images/products/dfefc2076b0d51e25a9f4d0ff146b76689d99d3888e775db8ed98f88f07585b2.webp\",\"assets/images/products/daa930e0687768d7b922f18b24ead9ab67732ccc4284489c411b074670bbbe2a.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(7, 'M.O.I', 'Phấn nước M.O.I Iconic perfection cushion', 3, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '12g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 399000, 300, 'assets/images/thumbnails/fa1dfdb9d5d00d7ae0f231ee358b40fc32e8099c12e780f58edd40633ebb7646.webp', '[\"assets/images/products/7371dfd22d9a6fa865a47a8b981d64abc58f1561842e18a3835e32b14d29ad7a.webp\",\"assets/images/products/31f8fe3064403bf194ba42b2cf50ef072a7fe0abcc87aee6f9b039956150870f.webp\",\"assets/images/products/f2816b437e84b64b7960e143270078f6714bd374c187fe258f24673e59595c23.webp\",\"assets/images/products/9627b63f9b3b7d91dc2566aaee1050d6eba30b552259a34846980c76f8d38ed5.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(8, 'M.O.I', 'Phấn nước M.O.I Baby skin cushion', 3, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '12g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 399000, 340, 'assets/images/thumbnails/36a9c7f85265a1f6efa2202233a7452bc15c2e2a6633d433085e19dbfaa95c83.webp', '[\"assets/images/products/66c24be77fb036fe863d150e89b6a806ff8fb2ca0819476d06eaf29851f9c4eb.webp\",\"assets/images/products/a75839eaaacb1bfe9579118ec7711ce281bc522c240a7c92ae79fed6eacb7f13.webp\",\"assets/images/products/791781de1a0a0fec9a6e72ba5584f98dafb2be1b4785dd880cfb8cb3e0780c88.webp\",\"assets/images/products/11db7f03c45389989bab980b4bdba2893d173cc91aab2509d05507e2c1e3e5e6.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(9, 'M.O.I', 'Phấn phủ M.O.I Baby skin powder [màu mới]', 4, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '10g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 499000, 560, 'assets/images/thumbnails/09ee5436461944df599111c4c594854287c964c281a682a00ccf8d5a4fe27290.webp', '[\"assets/images/products/fc15ccc2513196c4cedd3d8c4334ca35c57ce441b6b8f3a356c5291a9c8d0e91.webp\",\"assets/images/products/162397801a42f5414227e3032e443deccca3bb904aca7e6f6683a8f925a6cc0b.webp\",\"assets/images/products/a0b0c65763f244d624c48bcda9e6dcd380819843a738700e29147fe0fc75989e.webp\",\"assets/images/products/755523d8515bd81d13e58ee41d7321962e198c656cc6f3ffb8ecef8e3764e8f4.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(10, 'M.O.I', '6 màu son thỏi love M.O.I by Thuỳ Tiên', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '3.5g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 359000, 650, 'assets/images/thumbnails/b80217fe6f792a190e4f6e1bdef007cd0df23bdaf020ff1145170ae6dc26b4fc.webp', '[\"assets/images/products/2592f2f578ccb40664bef7c5aee6a0e8c455d43e77b51d73317bcd33c374f574.webp\",\"assets/images/products/b9041c6ea645c40346ef1962cac8b73f234d3dc479df55787eca5ff3ed170293.webp\",\"assets/images/products/a22b21eb5e2b71b50cfbf221e91d04c62a82f15ed0d2e2b17aeb202b8f4a4203.webp\",\"assets/images/products/ab98609915bb066751456d54edf57e8dc89f24bd41bbc33a9cace8dc04599bed.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(11, 'M.O.I', 'Set 6 son thỏi cao cấp love M.O.I phiên bản giới hạn', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '2.2g/thỏi', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 2274000, 900, 'assets/images/thumbnails/d0a196a9adbc8ae2484b1af3d753b6677972fc0f8af259b18228ad3d360b77c6.webp', '[\"assets/images/products/23f145f1b771f0b08cca35f64ad6787e5bb61404926146fb63e10559eb1e70ed.webp\",\"assets/images/products/cfe90a9dfbc47bbbc550c082945c8fd49482535784e2e32ba2298851129614c6.webp\",\"assets/images/products/18df951db0593c292eab8dbf1d442a1e2514b6974b12b3d0a312620eeb9a46d3.webp\",\"assets/images/products/d3ab396d2b83bb1494516c4f6971aea14f678b141372d9bdcde569e3142e89b8.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(12, 'M.O.I', 'Son môi sáp cao cấp love M.O.I Matte Lipstick', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '2.2g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 379000, 599, 'assets/images/thumbnails/ca2aca95720d8cfd3ac72a47b5a021ba45a830b8a7514b84d346100d84be6e6e.webp', '[\"assets/images/products/63de3e3c2b939d97d5d28c161851cf01807f33503088c1928f8b4bc29541184d.webp\",\"assets/images/products/f1e02f0b9160c51cd6e53ed10ea1101754a202f25e5b9154d2e92aefc47050c0.webp\",\"assets/images/products/9aefc858d0e8bb620f6acd6d4b7422b3314ed8c042118a8412722c51c613688a.webp\",\"assets/images/products/0bf02fabcc97b684d728f975d4535e87dec65a1109fc0d77c11da1ae6a3bb705.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(13, 'M.O.I', 'Bông tẩy trang 3 lớp cao cấp M.O.I 50 miếng', 5, 'Việt Nam', '5 năm kể từ ngày sản xuất', 'Gói 50 miếng', 'Đóng kín túi zip sau mỗi lần sử dụng. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 99000, 9458, 'assets/images/thumbnails/6cd379f6ca9d0e5daeaa0dfadbe090b6080b99f9926dc20ce6591fcb3a697ae4.webp', '[\"assets/images/products/d7ad87be32601887de5ab51d32a3a8156c9700c854ab4b646fa88c0c9d9b9eb0.webp\",\"assets/images/products/11bc1d209ebd5365a5f2633f0f9abfc7f72709f72c826dab26e39ca13d6ebac6.webp\",\"assets/images/products/5da05c6eaad9373347158ca31759fbf256bddcd3c232cda39370357c4bb0d56c.webp\",\"assets/images/products/2f83e9597e3cc68fa309c12bfc076b192188d48b70221e1f4accd69027118a6b.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(14, 'M.O.I', 'Nước tẩy trang M.O.I 40ml', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '40ml', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời.', 99000, 500, 'assets/images/thumbnails/12e514b60d28b19c4e7c56681d202398348e1c42dfa9ffb94a282e90fbbdef84.webp', '[\"assets/images/products/cac91186673d0e4380d2d84dac09b775d279dfd5dde3da99850c7dc657ef5f98.webp\",\"assets/images/products/a6c2f2bd074722292990c9bf305836b28b918f569f9c1abc816d33a51cd6e678.webp\",\"assets/images/products/edc76cbe259ca80c0fa941b880cd2d19c1bce5052598e8760aaaea1d71360004.webp\",\"assets/images/products/4139508159bf73dd0ffa627f4cfb619df012a35c71e5820e5fb616d320e2ca39.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(15, 'M.O.I', 'Sữa rửa mặt by M.O.I', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '200ml', 'Bảo quản nơi khô ráo/Tránh ánh nắng trực tiếp mặt trời.', 239000, 1000, 'assets/images/thumbnails/55cdf6ce90ee2349cd423e36bd420b72efe5ae36328d2e07479b312c6b984fa4.webp', '[\"assets/images/products/55cdf6ce90ee2349cd423e36bd420b72efe5ae36328d2e07479b312c6b984fa4.webp\",\"assets/images/products/a42e9a5ebedef12867aed85693011f71fdea037b8bc0b2fcca2778537684a3e.webp\",\"assets/images/products/fd0762e76335dc8d234a4c864a380219140666909429f7c038ce4181bea5de6c.webp\",\"assets/images/products/976a2cce9485570957b6c1b1c690953638d685a0f3e5d8ba4e5bbc2965814fcc.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(16, 'M.O.I', 'Kem chống nắng nâng tông tự nhiên M.O.I 10ml', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '10ml', 'Bảo quản nơi khô ráo/Tránh ánh nắng trực tiếp mặt trời. ', 129000, 560, 'assets/images/thumbnails/ed819d15e37588c97776e3168a60a244426bcb83f6ceaf25d79d49be7ca484c6.webp', '[\"assets/images/products/8c4fc61d90bbb4c9f2048ce654a488cef3b53646b98bb0ae5365c1ba2721e626.webp\",\"assets/images/products/719cce4b066f9f306a52cc4f7796fc5deb75d8ed3f8a6d4f042c8c8ef8c4a2e5.webp\",\"assets/images/products/e32d7b734bb05058b2d017d0796e31598793948ac5f2c5cc030dfce1cad10113.webp\",\"assets/images/products/f013f38082d3bc4f28a1d5fe9e9fbd72dfbe3c7c2a477b19f9e0429fd2f434fb.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(17, 'M.O.I', 'Nước hoa hồng 5 trong 1 by M.O.I', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '200ml', 'Đậy nắp kín sau khi sử dụng. Bảo quản nơi khô ráo, thoáng mát.', 249000, 450, 'assets/images/thumbnails/e0b725ec8041beccf2b8e8a08a4926a2cee282ac2e3225cf9a59365c01985223.webp', '[\"assets/images/products/3f61e2ea90baf4949b88c8319ec9133679b14c7d52850ec72c0d267f49faf0d5.webp\",\"assets/images/products/06f1d387201f0d3b0fbc624322dc7c1cf19a3cd4ec496b702af1e81a841255b6.webp\",\"assets/images/products/6f19b0f85e01e1ff120de885d0990e5b29731d958fbd376554bd3621a51de7a4.webp\",\"assets/images/products/04715745fb7352e534dfa638253db1cee4aa153efd52c65ed775a91f73647faa.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(18, 'M.O.I', 'Bộ sản phẩm chăm sóc da toàn diện M.O.I', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '750ml+50 miếng ', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời.', 1297000, 876, 'assets/images/thumbnails/437e1a4a5c914f14a04d992ecfe2f37bf0f649b1107a294c46bb3ea479113a84.webp', '[\"assets/images/products/3fc2b6460f1dba82752b1c4941004bd304cdf3016c88997951422416d9334825.webp\",\"assets/images/products/9e43b964b11a450690f6dd0c7d5552b468b3965ca2a913d37d00fba9e637cd98.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(19, 'M.O.I', 'Nước hoa cao cấp DESTINY by M.O.I 10ml', 6, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '10ml', 'Đậy nắp kín sau khi sử dụng. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 329000, 1000, 'assets/images/thumbnails/780afdde72f416a28708e1fb020c1a4088cca13e49fb29012ad661dd20bb6e02.webp', '[\"assets/images/products/26aabbccc86ab2bfaabed9fda3cf19d09a37083094a6f7e5d32356b72f5cd6f2.webp\",\"assets/images/products/52bfd42538409b27efb30c9174b2255796ec439e14649514028c5009215c4219.webp\",\"assets/images/products/a703538cf66e47e74d3ceb39ca4582e7698c34973f387c0118402ed8d012a296.webp\",\"assets/images/products/de9d61d146a527070b9f4fa8def50551aa9b5ed1bc350a98181aefa77a4c4154.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(20, 'M.O.I', 'Nước hoa cao cấp DESTINY by M.O.I 50ML', 6, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '50ml', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời.', 899000, 670, 'assets/images/thumbnails/da40d1728baa048fbe37782b29e91a4062466fc2454e62fa0f1ac9e231e2cd34.webp', '[\"assets/images/products/9f2b33345524f40092330e102009f6a81f844880c45b036145c8dc02b038251b.webp\",\"assets/images/products/96c5bce4eb196fb193fec567e5ab7721a4f2e4a095b4fb3a3b7de2308e1faac4.webp\",\"assets/images/products/bfd58b4aab73a91a4c77f5fe340b99523989ae5b08f1c9274f0013e62057f32a.webp\",\"assets/images/products/e3ada8561dbe8fb6e08f9f0324d5f643a5434fdff813e4604dd94dd168688236.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(21, 'M.O.I', 'Phấn má hồng M.O.I', 4, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '9g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời.', 399000, 250, 'assets/images/thumbnails/dc566c38d60e65417d78b71bef57d533cabdf710846d4b16f73b892503cf82a7.webp', '[\"assets/images/products/0ca738780a122b741ce71970bff642581db80d52e192f37eb74e7004a3f09996.webp\",\"assets/images/products/48cadae310caa7d58dc2e23789965e9dea0b0495b559c4ae0a0d5b54dfcf6b35.webp\",\"assets/images/products/86507456e2441881b91cc2018848983c46d0146e217ecd60420e79973c01801a.webp\",\"assets/images/products/f878bca962e5ba1de84fde5e51ec3ba70fc8d4dd4fb819aa254d613c04099b33.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(22, 'M.O.I', 'Dưỡng môi có màu MICKEY\'S MAGIC LIPS by M.O.I', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '15g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 329000, 700, 'assets/images/thumbnails/5f7c01dacfe5f59bf2eeecca6deb5311d9cfde870aee93bc1c749aa45f0eb860.webp', '[\"assets/images/products/42212b262e08518ecc79ea486aaca104d791fd5431bb0735141866ab4aacb11a.webp\",\"assets/images/products/0aa1a2dd9f83ef12b28b6a29e1dd8b0479ed672184a0f0f62d6117fc10e7ec04.webp\",\"assets/images/products/2fdc55419a78c33853c9e2592275c77dbece654b69f6d83ad9e7cad86034a91e.webp\",\"assets/images/products/a2cb1542ecd069be88f5cfce91368b3e213a5ad4eee7fb8a2ca16f3b7bb101a3.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(23, 'M.O.I', 'Bút kẻ mắt nước by M.O.I', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '35g', 'Đậy nắp kín sau khi sử dụng. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 249000, 870, 'assets/images/thumbnails/7f6284fb9422a18e2ec3a84a7a5778c549ae25834e8c314dc6d710a02ebee7be.webp', '[\"assets/images/products/02be164221ff2c2ed22664d4a9529bb0775865829af1796cd637e14c01df6dd2.webp\",\"assets/images/products/70357c8de3bfd08f6d1008bacebb397e07228169d77e76459c303309f8a3bb6b.webp\",\"assets/images/products/e48965103320e4e26997d5892960960b9d159c24c46e242c63c3fdd8a3590d56.webp\",\"assets/images/products/e7399b38b4543c5439cceabb698523ad5a0e896fd3e1e39c2116bd833e5ec26b.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(24, 'M.O.I', 'Chì kẻ mày by M.O.I', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '35g', 'Đậy nắp kín sau khi sử dụng. Tránh ánh nắng trực trời.', 189000, 780, 'assets/images/thumbnails/03284e4c096a0540ff8644daaa11a0d609fba7adcfaeb9ad89856430627b67f9.webp', '[\"assets/images/products/c066761400580218e390e8daecaa501f5960ab75801d1a9074cd0ef0806e3cdf.webp\",\"assets/images/products/bd58713cedaf485227425c579de67eac8ca64b2de3fa4ed74672600e4a40b6ea.webp\",\"assets/images/products/82410543792ec9414a85d36c21a1df4c62da78ae96a7b2733f4dfe702b3f1f43.webp\",\"assets/images/products/4c7fca0b9f3a6a0f2d7913687c612b0415c705857a8b6b6eeaf37231ea929ade.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(25, 'M.O.I', 'Bộ cọ trang điểm by M.O.I', 5, 'Việt Nam', '3 năm kể từ ngày sản xuất', 'Bộ 8 cây', 'Bảo quản nơi khô ráo thoáng mát.', 335000, 500, 'assets/images/thumbnails/37ce0358192beaeaa98018c7e4675124179aa5ccad53ce36fdad78675c13c1b7.webp', '[\"assets/images/products/5d9c564336455dbd759d988ef70d7538ef1d94def6bfc2fc8f360eed62aac00d.webp\",\"assets/images/products/1e83281c537c352aec6ff35e54d7d0019b2154da220c864fda573dc7e7e98857.webp\",\"assets/images/products/38e637414fd9be579de10f5ddb70c914dda99c2ec3df72b0e66797bc1bd0bf59.webp\",\"assets/images/products/2768c9ebbcf90737aca8172c0511be8ced3920c59c999b9e4aeaa5afbbbb262a.webp\"]', '2023-11-16 15:34:35', NULL, NULL),
(26, 'M.O.I', 'Nước Hoa Hồng Dưỡng Ẩm Dears,Klairs Supple Preparation Toner', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '180ml', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 210000, 560, 'assets/images/thumbnails/a511d55e4eec72cfdd9fd8d5959453e7462978b016dc5eb497e6bb614375db68.webp', '[\"assets/images/products/4a5ebb6c0552913f65c6f4b61351ba1688433461ea339e098413b0dca28c4ba9.webp\",\"assets/images/products/4aca056b4eb6215e7010977edc7cae6a4d6c96a51c5aea889775610bb5ffce67.webp\",\"assets/images/products/e91ce031172dda8213e15ea0e8a7e0c31c69a667af307193465db34a05f23ef0.webp\",\"assets/images/products/ea3653219f2f072f301007bc233ce4c735e6574c416b8216da8e4cebeb6ea4b2.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(27, 'M.O.I', 'Mặt Nạ Ngủ Dưỡng Ẩm & Làm Sáng Da Dear Klairs Freshly Juiced Vitamin E Mask 90ml', 1, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '90ml', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 354000, 450, 'assets/images/thumbnails/a182010e61a05832f09ce9d26a0be84970626351b4daec0e28fec86592199ab1.webp', '[\"assets/images/products/daaca09c036a92d01223632e8af23cd93dcf9a840e20b1193ab6962ac36c602d.webp\",\"assets/images/products/130ca81d1b95743b1b49e40bb000006a5db60465e99b83adec4cf190779e09f7.webp\",\"assets/images/products/86a17f5e7ac629fd1e143902481ef3834a06060777be5a84d230934ed53e0603.webp\",\"assets/images/products/11b627d23239f014784442568423caf68a677c854a7d46ba9ef1b3ee22c155f1.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(28, 'M.O.I', 'Tinh Chất Trắng Da Klairs Freshly Juiced Vitamin Drop Serum 35ml', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '35ml', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 296000, 876, 'assets/images/thumbnails/274b575cef64c1df7cb13f2232335251681096bbb2e27d1e358184aea9a6df46.webp', '[\"assets/images/products/fd0f16c22ecb87718f674f0964728a791af1f3a5d58bd9730943d4b0b4b8696d.webp\",\"assets/images/products/d3fae9c102155b9835af2d2f3ed0fe025c1919d99e6f00e4c699c890c5da29cd.webp\",\"assets/images/products/c7214f5bbf31ab6f60f771795290cbf8c25025b0ca6237810a1e95ff19de6b3f.webp\",\"assets/images/products/253748f0efeb7724bfb397d7681b8c4239c925d065342bf6eee1f0ef5bc66bac.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(29, 'M.O.I', 'Mặt Nạ Phục Hồi Da Martiderm The Originals Moisturing Mask 25ml', 1, 'Trung Quốc', '3 năm kể từ ngày sản xuất', '25ml', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 700000, 500, 'assets/images/thumbnails/5c0319c70532b79f481302fce14c8f41c37be5bb572774eeb825fd9e2e7b3f73.webp', '[\"assets/images/products/fd6559e6155c119c59c1a6edf2584a64657947c4f87a78ce3257ec168d441d3a.webp\",\"assets/images/products/cab4c145c81fe465e3442f2ec6c0acb3bf28665c83258eb4d936e2a39dc62a27.webp\",\"assets/images/products/ab6ebe3c6231032a724a30dfbfea85d79379685e025a3253ceb0fe7051e07187.webp\",\"assets/images/products/53f15a1fa0c262a31c89b618a5333408a475b3f8dc71c84a547e1c98f02a59c5.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(30, 'M.O.I', 'Mặt Nạ Nâng Cơ và săn chắc da BEBALANCE STICKY COLLAGEN MASK', 1, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '200g', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 499000, 876, 'assets/images/thumbnails/646f3ebc7afe04e0e2e9f6ae2f07fabea14746f4bc91a2c9c20a2582fa19e66c.webp', '[\"assets/images/products/f70c26005222cfc692f021a4c436e438cbc602026a505d3a99987cf783647ec1.webp\",\"assets/images/products/f93bf6319f57482e659d20dc61eda305f7452d833a17898860d69f3085242138.webp\",\"assets/images/products/8b851abfd10ad0a5c71da8c4e296b71ae3aec2be55ce44b6618b22f62e368dd2.webp\",\"assets/images/products/f089ac1faef949f1a0a84bf87076d03c15d5151c80a58803e3fc071933e4bc80.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(31, 'M.O.I', 'Mặt nạ ETUDE dưỡng trắng chăm sóc da mặt', 1, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '20ml', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 400000, 450, 'assets/images/thumbnails/074f064f39d45cb9480a684e10a34fee5c808a45a4f8e25bf3ea661e395f23de.webp', '[\"assets/images/products/75737960cf785817ed2f3785517b5faa6eedee20b467b8ab28ac75e2ec84941d.webp\",\"assets/images/products/e4f72269cb79b28fa2fb8cd9f57d33a405c9be0e310cab9bb5cd9bd070e9b138.webp\",\"assets/images/products/2f40030858247d3470dfb240ce49b615bd969522a691b4dcb3949db6538e332e.webp\",\"assets/images/products/f51f77e563bd77c430f4d32b1191e176e26b94218205024e50de4cc2d52bc10d.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(32, 'M.O.I', '8 MIẾNG Mặt Nạ Kiểm Soát Dầu và Mụn Trà Tràm Naruko Tea Tree', 1, 'Đài Loan', '3 năm kể từ ngày sản xuất', '10ml', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 252000, 700, 'assets/images/thumbnails/6feb215159fab18565f54c55c822ee123c472698022a99d4df1d8aa1316e091c.webp', '[\"assets/images/products/514c30f881570afa2401fff5ad131d005b8be67b43bba9c10470eeae6c73baa2.webp\",\"assets/images/products/7e437551f182e34ed6dc9468f0e2097a9fdc369af116e4f6d2fe4a10f8b0780c.webp\",\"assets/images/products/b6ef4fd93e08be6983c847e11e4ce5d57b52ea1c28b94042818f3c78b5af253c.webp\",\"assets/images/products/e636d88d4f39f3051f15ab07f280974520cf41a2f0d2c4960f82e77ff2e34c2b.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(33, 'M.O.I', 'Nước hoa Jillian Unisex DARK FICTION - thanh lịch, cá tính, quyến rũ', 6, 'Thuỵ Sĩ', '3 năm kể từ ngày sản xuất', '400g', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 1700000, 200, 'assets/images/thumbnails/5b522ddd207407f0635515e28306a703e548bc8bd19524aac0aa1f62e83fdfe6.webp', '[\"assets/images/products/0e994a3db91669ced55fc2323acab2be716c7d80ba1edb9321f616cfa6dcf33d.webp\",\"assets/images/products/0a7e53a0200be28165d94589da500a67cadfa0ae7ad94714657161ae3e506b88.webp\",\"assets/images/products/68642fa1fbeee8c6ca2207591cd67dd6d78fdc952e209df28480fcce04901cf6.webp\",\"assets/images/products/7a74dd56c4126232766aef46a722defde0a5f37a8b66ebb13963b393182665e4.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(34, 'M.O.I', 'Nước hoa nữ Versace Yellow Diamond', 6, 'Thuỵ Sĩ', '3 năm kể từ ngày sản xuất', '50ml', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 1894000, 150, 'assets/images/thumbnails/8398b858b62a96e1c26a7ae4341499009aa79c819e372d419229efe1333549f2.webp', '[\"assets/images/products/906e2a9f4d5c963b46eeecd866d95eea7bc14d772b76b4c73f71da9f4754a37b.webp\",\"assets/images/products/3f253626233def916527eea1fee3a3ba1e27b0612aac6b30389950c75b10d2cb.webp\",\"assets/images/products/02f7b4d151c9422dac70f151047b9719b0204c0403771eb0e78cb1ab4cea0242.webp\",\"assets/images/products/dff0adc46de471bac2fd9cee247d0225931e612a59f74ec8dc49123209a3deb0.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(35, 'M.O.I', 'Nước hoa nữ Charme Party', 6, 'Thuỵ Sĩ', '3 năm kể từ ngày sản xuất', '100ml', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 699000, 430, 'assets/images/thumbnails/ee9debee15c6f24558ab06921fa962e806567e986a8be0db22071672583b8b11.webp', '[\"assets/images/products/b03d278c1f314fd041c756be5feecde467be83730dd010b722806eafffe58e06.webp\",\"assets/images/products/d46d5de2dd8296b5f2c4e126b4359379ec7f5544093ca5f19d6251bfe700b21a.webp\",\"assets/images/products/94f4d94f3d9c6f7d5c088589e65b3d019679e0d17a0798ab4a81a16fb81b3d58.webp\",\"assets/images/products/26e222beaa99506ad08f7baf68818f9105ba2e5465bec13b8be0464833ce11ab.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(36, 'M.O.I', 'Nước Noa Nam Nữ Thơm Lâu Wildest Rose Loli & The Wolf Hương Thơm Lôi Cuốn', 6, 'Thuỵ Sĩ', '3 năm kể từ ngày sản xuất', '50ml', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 480000, 250, 'assets/images/thumbnails/8c2359b33b5a5340640a2f269b3f10d7a47ece5337800e4673e0790c21f39a6c.webp', '[\"assets/images/products/cf633c2b78d9075a3887ea8922db199c6e5a74223875dd833c55138895fa3a33.webp\",\"assets/images/products/0eb1c367ed047d9808364dc15774a5ca9c386516d8c16dce4895f9317e9483ac.webp\",\"assets/images/products/258c599f5cdcd2e5522272034a0795d31a0f35f2cfa0cb64fa0d0743bd9f9b12.webp\",\"assets/images/products/bd4f3292243d3706299ac74c18107bb34f2bf96c79781ed32651a95de6e0d643.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(37, 'M.O.I', 'Nước hoa Chloe Nomade_Eau de parfum', 6, 'Thuỵ Sĩ', '3 năm kể từ ngày sản xuất', '5ml', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 400000, 590, 'assets/images/thumbnails/4534b3a3e1f271f3714af56c0dcc144a89f5754be602c6efe00f5649db27daa7.webp', '[\"assets/images/products/f625e264c4521ecbfaa9cf19c6f902179cf1ff51efe2be07ad00913370914fcf.webp\",\"assets/images/products/4e24b967da4e6089d083e0dd6d2cdafc9fa2ece17b6fa279f040064b5bab0cfc.webp\",\"assets/images/products/8df42dc155f2f4972b4235f6810c4f128e54c887327c373ad71e38e471f5febc.webp\",\"assets/images/products/8cd94b81887e6f83831eaabba066ab8358119b13571893a84b3318e7005a821c.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(38, 'M.O.I', 'Nước Hoa Unisex Dreamer Cao Cấp Thơm Lâu Nhẹ Nhàng Quyến Rũ Cỏ Mềm', 6, 'Thuỵ Sĩ', '3 năm kể từ ngày sản xuất', '10ml', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 350000, 650, 'assets/images/thumbnails/67325323a9f591d3b3251833b49cc3c23a768351487d1dda3c613938ccf31dcd.webp', '[\"assets/images/products/8cbc368411a85f08031ad33770773f182384b88bd675c41d8fa62adff8275c8e.webp\",\"assets/images/products/f64141a515ddab1efaad686f4009ac47bef6450646f3463377576e46bfec1246.webp\",\"assets/images/products/c70437b42bb2e85a4a31fa7fca9098d58b6620104da22cdecace3f69f3a9c696.webp\",\"assets/images/products/38eafb0e5e98eebf5c2f729cb57ef032fc27b1762a896eeb5d8855e40701c60e.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(39, 'M.O.I', 'Mặt Nạ Dear Klairs Dưỡng Ẩm Và Phục Hồi Da Midnight Blue Calming Sheet Mask', 1, 'Đài Loan', '3 năm kể từ ngày sản xuất', '25ml', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 41000, 876, 'assets/images/thumbnails/cab8867d24f167237c6191ba5d06a8034babba311374f8cde9d046ccaebb6a25.webp', '[\"assets/images/products/d7dd7c6589d3839dcbcfb55a2a02bd583d05ad4916751ca4c5ce2a40e88b8e34.webp\",\"assets/images/products/db950ece3671fc9abe0ffa8a626abc25b565b5815f34211ac912e930da3db652.webp\",\"assets/images/products/d08bb3a46fc63a0f5f0fd57caa69070a5e3f01e80d039c7178796f99aca0bcec.webp\",\"assets/images/products/9eb9f66890f6782cbe1b0f4487a6dcea1aa69b0184ab245804f84846980e26a2.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(40, 'M.O.I', 'Mặt Nạ Ngọc Trai Matrix ', 1, 'Đài Loan', '3 năm kể từ ngày sản xuất', '35g', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 15000, 600, 'assets/images/thumbnails/b6d697208ca5b629a8c7c4e3fd31efc7748c77266b2f2d1d6be07fcc82caaa11.webp', '[\"assets/images/products/f20fa889de4dda60b1669ddc8a88ac2f6a04b0c0ecf6049855eaded022084b31.webp\",\"assets/images/products/7b14d31b254a52e3e09ee196ac7637608a65574261228436bbfa51545bada84c.webp\",\"assets/images/products/cd89bb6251dece3d875d5de57d9e5533ca41ed5e5611783c41b50d0cff6bbc33.webp\",\"assets/images/products/3d4397cb4286bb4bc549ca487c3ff8fcc2904514998331b083e9454b582002a4.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(41, 'M.O.I', 'Phấn Phủ Dạng Nén Kiềm Dầu Siêu Tốt Gucci Poudre De Beaute Mat Naturel', 4, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '10g', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 1650000, 700, 'assets/images/thumbnails/3ec04e5df50ecf27bfd7de0722622d86ef6c3dda3b138e366a68644d2b0b3914.webp', '[\"assets/images/products/b05301a25ee70dea5ad17c23dc57276d66d5680a4ca03b7f7ac4c889d4bbedb0.webp\",\"assets/images/products/b34e85a46d39468301ba12d7c5ff14d619bd21d48ff3848934aa517b9beb82d1.webp\",\"assets/images/products/63e1dc713a73b727aabca6cda123b72ecc366030894809a7b56072a6bddb5b3d.webp\",\"assets/images/products/3f8f83254413c956c6635ac1be8587aab3e98ad30003ff9469b03046391c540d.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(42, 'M.O.I', 'Phấn Phủ Đa Năng Célefit Perfect Selpic Finish Powder', 4, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '10g', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 480000, 654, 'assets/images/thumbnails/fe2860655f5c1dd2c2eb29f5c504fa4e1dd9f9dfee3c203130f58cfdffe4590d.webp', '[\"assets/images/products/c4f0603778d0496f7c329ddd7b6dc49f86688ab0e8a8fc42fa28c8ad07deacb0.webp\",\"assets/images/products/ad0e2b0f83af553e63d01652d13d46356d2eb8673faa9ff65bad367a2242b3d1.webp\",\"assets/images/products/543f3f4862acbb1936ce3dc93ca5031784948862f0d0f496b68876bece98c303.webp\",\"assets/images/products/de65a8ec60c6be9113f76984db8ddb159c8ee26fa76e87c1a33adceabc6c288c.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(43, 'M.O.I', 'Phấn Phủ Dạng Bột Colorkey Kết Cấu Lì Trang Điểm Làm Sáng Da Mặt Kiềm Dầu Chống Mồ Hôi', 4, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '10g', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 428000, 680, 'assets/images/thumbnails/5cb7937d6e3b888ee39dc00ee4b437453d151e78a59bc9e9dc348b498492808a.webp', '[\"assets/images/products/73be91e82d53221d9d45d8ecc455878df8beb7227dc836cb082fbd4f8a745d7f.webp\",\"assets/images/products/de754f7558f2265a701c82f23e31dc029b90a648a0e35faa83c3bc9875982e7c.webp\",\"assets/images/products/93dd3023895c87d5b2a4cee0f24e5d39c844d7f28f80578a7965ecb924c289d5.webp\",\"assets/images/products/3023bcb32826c194ee8ebe9cb6e791d962070bae4e0624a2e3bfce25fd1e90f8.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(44, 'M.O.I', 'Phấn Phủ Bột Focallure giúp kiềm dầu tối đa', 4, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '10g', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 95000, 700, 'assets/images/thumbnails/2fcfc35ce7a1bbf3899ae82b4d00d0c1935340c87c11c451ef490492ea27ac50.webp', '[\"assets/images/products/cee589df1c3a19edc3486072fb051414e59c200838511f78ff974e3971b4f598.webp\",\"assets/images/products/eb140f66edf5351ef2df82691ccf932df0bf6767e1558e42b38d33562bfe454e.webp\",\"assets/images/products/ecede6b4b201b2136752e65a7d7254321423ea0ff1cc55cbbf7ce205e19a61a7.webp\",\"assets/images/products/1629f2907c61a20ddbd5e69217601e6e64fc2fcf47b1aa2a466763cda6e47755.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(45, 'M.O.I', 'Nước hoa Charme No.1 Street', 6, 'Thuỵ Sĩ', '3 năm kể từ ngày sản xuất', '100ml', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 1350000, 650, 'assets/images/thumbnails/24789ebf182a0d54b6d99a2bbf74434bb96cb7f97d9b2315cc05234eef0632d4.webp', '[\"assets/images/products/18ff01640621703e7379f3624dea8a0d282a852f5bfed7839cc64d58b9775694.webp\",\"assets/images/products/daf8719f61d692924308fb7773255ffd3eddd77c96b43118a4e6289170543521.webp\",\"assets/images/products/79c9bbf6b4a793be95a51693eca65e14e2597adb714ad9588321d0a4c979cbcb.webp\",\"assets/images/products/d7aa1ce79372836ad32041f1bcfa551f5592186bed0f27e0df894fdb97143fc9.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(46, 'M.O.I', 'Tinh Chất Rau Má Giảm Mụn Và Làm Dịu Dành Cho Da Nhạy Cảm', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '100ml', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 399000, 504, 'assets/images/thumbnails/9d009b70b134f4dfba513ee52f70aa52a1e7c5ff303bd50539a4aef191032ac7.webp', '[\"assets/images/products/4744d70d28872d17ba8c463cc22cf540b264226f3461cf15c91cb26e543979b9.webp\",\"assets/images/products/ed9d90a2ee8be34b725296b57d87ffbc6424052e7bb42c448f110a0fc7d331f7.webp\",\"assets/images/products/a3f73022821a753cc434300eddc52b64145c4856d3bc5a7e3ec31fa4a245859d.webp\",\"assets/images/products/52020cbcdb63b9a70d47da1eb4b94245cd305164b01431d6579fb5b3c7deec53.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(47, 'M.O.I', 'Phấn nước Incellderm Radiansome™ 100 Ampoule Cushion SPF 50+ PA ++++ ', 3, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '35g', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 1320000, 780, 'assets/images/thumbnails/6873a54650982cad577cbc41b288c7f301197e4f5eab0eccf697fc41c709a4b9.webp', '[\"assets/images/products/33274ce820aad6e057d2470a6c11baf1ff3ccdf1b366e513abbdebefd4d1d45d.webp\",\"assets/images/products/d68441ca90f93d15996da42374cbc6faf01db304e8d467a69b7d009c44ddf614.webp\",\"assets/images/products/c0a0c3f674a53767b35a85a3d7ade2cb513d38598c8b22c199e9438f52fe645c.webp\",\"assets/images/products/57ce661d166d4ae2b8fba61d081c59847c630e0c874eba3e39244644a5dd041d.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(48, 'M.O.I', 'Combo Best Seller Phấn Nước Đa Năng 3 Trong 1', 3, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '45g', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 1399000, 450, 'assets/images/thumbnails/0906252b9338f0eea705caf2052d22a417a31092a2051310b6c3eeb5e1688a2b.webp', '[\"assets/images/products/e5881512be6bb038d6027e8c118be63ee59ef1861615bd2c533a7299116af464.webp\",\"assets/images/products/82466fbcfd5b244a65b7b478906419f6b0e9e25a8d1ba15330988d0e8f980ecf.webp\",\"assets/images/products/c0a0c3f674a53767b35a85a3d7ade2cb513d38598c8b22c199e9438f52fe645c.webp\",\"assets/images/products/4b2156cbb801dc49af99755181a1de087be87538ba11073733f832f664cd7a2d.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(49, 'M.O.I', 'Phấn Nước Mịn Mướt Da Dear Dahlia Skin Paradise Sheer Silk Cushion SPF50+ PA++++', 3, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '8g', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 1019000, 860, 'assets/images/thumbnails/cbe5b26b115f0a5e239057ed4f9e3199bd93f588d22415c75fcb8bb5c6af0f5a.webp', '[\"assets/images/products/9390a61ac6bc215ca1e70dd8f39d85c55c81197de5c70bfb810016b384bda1b5.webp\",\"assets/images/products/504544480ed35fecbb9ae2006e04883051650059bf2ad5341e7d4943f2ace890.webp\",\"assets/images/products/570cd9a1c6003f86f1575a6dfe0840926852a652788e7409ff726f22f29bfde4.webp\",\"assets/images/products/acf85b93547c36c19e2768d1461420aa90876fe082738d51aa767f57458c0341.webp\"]', '2023-11-27 19:06:53', NULL, NULL),
(50, 'M.O.I', 'Son MAC powder kiss liquid lipcolour , son kem lì lâu trôi Lipstick', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '1.5g', 'Bảo quản nơi khô ráo, thoáng mát. Tránh ánh nắng trực tiếp mặt trời.', 650000, 680, 'assets/images/thumbnails/5e4bff08a776d5b68c30c2087d23abfc375f9baa921d8f9a2bc049828b0d813c.webp', '[\"assets/images/products/1cc69559e6ca2d2a35b46f0d84f5ffa079d660c062a166ae3edcac072cfbe1bd.webp\",\"assets/images/products/be129298fd771558ac043d9cdf1c8b46f991fd9b2fc6ca6e0580bfd99c12b51b.webp\",\"assets/images/products/235a5eeb7701eabf9e8a6f9d499ab435697409deefc2a502e6944c17e392a997.webp\",\"assets/images/products/41927d5587e559fce63e2cab955daf8e73df17cd36db68825dbaf74940d758a4.webp\"]', '2023-11-27 19:06:53', NULL, NULL);

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
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`id`, `full_name`, `birth_year`, `gender`, `email`, `hashed_password`, `avatar_path`, `address`, `status`, `create_at`, `update_at`, `delete_at`) VALUES
(1, 'Lê Minh Vương', 2003, 'male', 'vuonglmqe170148@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/bf8a9d7de5fb8310df146a4f061a85ef4757f6930f7633b98f9c8f1b290154bd.webp', '["Đại học FPT Quy Nhơn, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định","Đại học Quy Nhơn, Phường Nguyễn Văn Cừ, Thành phố Quy Nhơn, Tỉnh Bình Định"]', 'activate', '2023-11-17 09:54:01', NULL, NULL),
(2, 'Nguyễn Thị Thúy', 2003, 'female', 'thuyntqe170033@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/0913a5b201de74b1cc693a3ce5254c31e963a4b334ebf34d0699f03b28972d55.webp', '["Đại học FPT Quy Nhơn, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định","Đại học Quy Nhơn, Phường Nguyễn Văn Cừ, Thành phố Quy Nhơn, Tỉnh Bình Định"]', 'activate', '2023-11-17 10:01:32', NULL, NULL),
(3, 'Trần Huy Hoàng', 2003, 'male', 'hoangthqe170116@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/99f35734734c349cce956db639c055ee376e6ae62364c5f22ffc738da2565415.webp', '["Đại học FPT Quy Nhơn, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định","Đại học Quy Nhơn, Phường Nguyễn Văn Cừ, Thành phố Quy Nhơn, Tỉnh Bình Định"]', 'activate', '2023-11-17 10:03:47', NULL, NULL),
(4, 'Tạ Ngọc An', 2003, 'male', 'antnqe170035@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/c65613dffc95623406dce4fa1645d77939dc320b8771b756befab2c31be1001f.webp', '["Đại học FPT Quy Nhơn, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định","Đại học Quy Nhơn, Phường Nguyễn Văn Cừ, Thành phố Quy Nhơn, Tỉnh Bình Định"]', 'activate', '2023-11-20 15:34:35', NULL, NULL),
(5, 'Lê Nguyễn Phúc Anh', 2003, 'male', 'anhlnpqe170043@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/fe834a66ef198450c03a8706b16770883c4334bf487db52a0408b58e880d587c.webp', '["Đại học FPT Quy Nhơn, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định","Đại học Quy Nhơn, Phường Nguyễn Văn Cừ, Thành phố Quy Nhơn, Tỉnh Bình Định"]', 'activate', '2023-11-20 22:57:37', NULL, NULL),
(6, 'Trịnh Minh Dương', 2003, 'male', 'duongtmqe170056@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/6e7eae42904517363a738483f2629e8760a278d2b090dfda7d50916ca092fe4c.webp', '["Đại học FPT Quy Nhơn, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định","Đại học Quy Nhơn, Phường Nguyễn Văn Cừ, Thành phố Quy Nhơn, Tỉnh Bình Định"]', 'activate', '2023-11-20 15:34:35', NULL, NULL),
(7, 'Đinh Quốc Chương', 2003, 'male', 'chuongdqqe170097@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/48927de2fc45fac1f673b6e2e0f19a0bd7a753ab935f988b62f74b6445b6a2e4.webp', '["Đại học FPT Quy Nhơn, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định","Đại học Quy Nhơn, Phường Nguyễn Văn Cừ, Thành phố Quy Nhơn, Tỉnh Bình Định"]', 'activate', '2023-11-20 22:57:37', NULL, NULL),
(8, 'Lê Đồng Tâm', 2003, 'male', 'tamldqe170103@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/ec5c8a1765e20e9a83f33c68d5c1f64eda595542c787c2f93293ff44587cc91f.webp', '["Đại học FPT Quy Nhơn, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định","Đại học Quy Nhơn, Phường Nguyễn Văn Cừ, Thành phố Quy Nhơn, Tỉnh Bình Định"]', 'activate', '2023-11-20 15:34:35', NULL, NULL),
(9, 'Lê Phước Thắng', 2003, 'male', 'thanglpqe170122@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/b4181bc38fe63d2cd5270ab78b616a84dfe1bd1b11b8e0281eea677903994328.webp', '["Đại học FPT Quy Nhơn, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định","Đại học Quy Nhơn, Phường Nguyễn Văn Cừ, Thành phố Quy Nhơn, Tỉnh Bình Định"]', 'activate', '2023-11-20 22:57:37', NULL, NULL),
(10, 'Đinh Trọng Huy ', 2003, 'male', 'huydtqe170135@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/d78338e0264bc91f5ba801d979fa7a33a8882d6bce9a952cce9a004649a9523e.webp', '["Đại học FPT Quy Nhơn, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định","Đại học Quy Nhơn, Phường Nguyễn Văn Cừ, Thành phố Quy Nhơn, Tỉnh Bình Định"]', 'activate', '2023-11-20 15:34:35', NULL, NULL),
(11, 'Âu Công Danh', 2003, 'male', 'danhacqe170170@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/98e515ae3850362bbcd2979dadc724d778a17c9dd9f4348183b04ffd450e8079.webp', '["Đại học FPT Quy Nhơn, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định","Đại học Quy Nhơn, Phường Nguyễn Văn Cừ, Thành phố Quy Nhơn, Tỉnh Bình Định"]', 'activate', '2023-11-20 22:57:37', NULL, NULL),
(12, 'Nguyễn Thị Kiều Duyên', 2003, 'female', 'duyenntkqe170192@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/afc8687a027c360f7dfaff870c6f3b95e168e6c21487d31442dee5bd835bbd45.webp', '["Đại học FPT Quy Nhơn, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định","Đại học Quy Nhơn, Phường Nguyễn Văn Cừ, Thành phố Quy Nhơn, Tỉnh Bình Định"]', 'deactivate', '2023-11-20 15:34:35', NULL, NULL),
(13, 'Phan Thu Thảo', 2003, 'female', 'thaoptqe170211@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/eaddff5f5f12493f65962f9ad23c4b47eb82f30d825a8e475b80dd772dc3e01a.webp', '["Đại học FPT Quy Nhơn, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định","Đại học Quy Nhơn, Phường Nguyễn Văn Cừ, Thành phố Quy Nhơn, Tỉnh Bình Định"]', 'deactivate', '2023-11-20 22:57:37', NULL, NULL),
(14, 'Tô Thế Vĩ', 2003, 'male', 'vittqe170234@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/8bbd2ff5b8581dda54e15421dbd0e8280a8c9d99880f08e93b71957a13f0ef06.webp', '["Đại học FPT Quy Nhơn, Phường Nhơn Bình, Thành phố Quy Nhơn, Tỉnh Bình Định","Đại học Quy Nhơn, Phường Nguyễn Văn Cừ, Thành phố Quy Nhơn, Tỉnh Bình Định"]', 'activate', '2023-11-16 15:34:35', NULL, NULL);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID dùng để quản lý, tự động tăng', AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID dùng để quản lý, tự động tăng', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID dùng để quản lý, tự động tăng';

--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID dùng để quản lý, tự động tăng', AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID dùng để quản lý, tự động tăng', AUTO_INCREMENT=15;

--
-- Các ràng buộc cho các bảng đã đổ
--


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
