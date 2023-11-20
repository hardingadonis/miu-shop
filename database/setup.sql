SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `miu` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `miu`;

CREATE TABLE `admin` (
  `id` int(11) NOT NULL COMMENT 'ID dùng để quản lý, tự động tăng',
  `username` varchar(30) NOT NULL COMMENT 'Admin dùng username để đăng nhập',
  `hashed_password` varchar(64) NOT NULL COMMENT 'Mật khẩu sau khi hash bằng SHA256',
  `role` enum('super_admin','admin') NOT NULL COMMENT 'Phân quyền, super_admin có thể tạo ra admin',
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `delete_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `admin` (`id`, `username`, `hashed_password`, `role`, `create_at`, `update_at`, `delete_at`) VALUES
(1, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'super_admin', '2023-11-17 09:46:24', NULL, NULL),
(2, 'thuy', '5adf805ab91494fb0803dc1f111a31877545576686847d8790a46a30c7e6e285', 'admin', '2023-11-17 09:50:33', NULL, NULL),
(3, 'hoang', '270723e7f50a26d4ae90da0e13079f293dd37e9953f7f9801ce7de19a35fc58e', 'admin', '2023-11-17 09:51:12', NULL, NULL),
(4, 'vuong', '9ef78ba5f2594c24944ce9a90f2a6358d260a7cc3bb7db8e37f06c5d41249eef', 'admin', '2023-11-17 09:51:41', NULL, NULL);

CREATE TABLE `cart` (
  `user_id` int(11) NOT NULL COMMENT 'Liên kết với id bảng user',
  `product_id` int(11) NOT NULL COMMENT 'Liên kết với id bảng product',
  `amount` int(11) NOT NULL DEFAULT 1 COMMENT 'Số lượng sẩn phẩm được chọn'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `category` (
  `id` int(11) NOT NULL COMMENT 'ID dùng để quản lý, tự động tăng',
  `name` varchar(30) NOT NULL COMMENT 'Tên loại sản phẩm',
  `slug` varchar(30) NOT NULL COMMENT 'Đường dẫn trên web',
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `delete_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `category` (`id`, `name`, `slug`, `create_at`, `update_at`, `delete_at`) VALUES
(1, 'Mặt nạ', 'fb.com', '2023-11-16 15:34:35', NULL, NULL),
(2, 'Son môi', 'fb.com', '2023-11-16 15:34:35', NULL, NULL),
(3, 'Phấn nước', 'fb.com', '2023-11-16 15:34:35', NULL, NULL),
(4, 'Phấn phủ', 'fb.com', '2023-11-16 15:34:35', NULL, NULL),
(5, 'Chăm sóc da & Trang điểm', 'fb.com', '2023-11-16 15:34:35', NULL, NULL),
(6, 'Nước hoa', 'fb.com', '2023-11-16 15:34:35', NULL, NULL);

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

CREATE TABLE `order_data` (
  `order_id` int(11) NOT NULL COMMENT 'Liên kết với id bảng order',
  `product_id` int(11) NOT NULL COMMENT 'Liên kết với id bảng product',
  `amount` int(11) NOT NULL DEFAULT 1 COMMENT 'Số lượng sẩn phẩm được chọn'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(12, 'M.O.I', 'Son môi sáp cao cấp love M.O.I Matte Lipstick', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '2.2g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 379000, 599, 'assets/images/thumbnails/ca2aca95720d8cfd3ac72a47b5a021ba45a830b8a7514b84d346100d84be6e6e.jpg', '[\"assets/images/products/63de3e3c2b939d97d5d28c161851cf01807f33503088c1928f8b4bc29541184d.jpg\",\"assets/images/products/f1e02f0b9160c51cd6e53ed10ea1101754a202f25e5b9154d2e92aefc47050c0.jpg\",\"assets/images/products/9aefc858d0e8bb620f6acd6d4b7422b3314ed8c042118a8412722c51c613688a.jpg\",\"assets/images/products/0bf02fabcc97b684d728f975d4535e87dec65a1109fc0d77c11da1ae6a3bb705.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(13, 'M.O.I', 'Bông tẩy trang 3 lớp cao cấp M.O.I 50 miếng', 5, 'Trung Quốc', '5 năm kể từ ngày sản xuất', 'Gói 50 miếng', 'Đóng kín túi zip sau mỗi lần sử dụng. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 99000, 9458, 'assets/images/thumbnails/6cd379f6ca9d0e5daeaa0dfadbe090b6080b99f9926dc20ce6591fcb3a697ae4.jpg', '[\"assets/images/products/d7ad87be32601887de5ab51d32a3a8156c9700c854ab4b646fa88c0c9d9b9eb0.jpg\",\"assets/images/products/11bc1d209ebd5365a5f2633f0f9abfc7f72709f72c826dab26e39ca13d6ebac6.jpg\",\"assets/images/products/5da05c6eaad9373347158ca31759fbf256bddcd3c232cda39370357c4bb0d56c.jpg\",\"assets/images/products/2f83e9597e3cc68fa309c12bfc076b192188d48b70221e1f4accd69027118a6b.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(14, 'M.O.I', 'Nước tẩy trang M.O.I 40ml', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '40ml', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời.', 99000, 500, 'assets/images/thumbnails/12e514b60d28b19c4e7c56681d202398348e1c42dfa9ffb94a282e90fbbdef84.jpg', '[\"assets/images/products/cac91186673d0e4380d2d84dac09b775d279dfd5dde3da99850c7dc657ef5f98.jpg\",\"assets/images/products/a6c2f2bd074722292990c9bf305836b28b918f569f9c1abc816d33a51cd6e678.jpg\",\"assets/images/products/edc76cbe259ca80c0fa941b880cd2d19c1bce5052598e8760aaaea1d71360004.jpg\",\"assets/images/products/4139508159bf73dd0ffa627f4cfb619df012a35c71e5820e5fb616d320e2ca39.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(15, 'M.O.I', 'Sữa rửa mặt by M.O.I', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '200ml', 'Bảo quản nơi khô ráo/Tránh ánh nắng trực tiếp mặt trời.', 239000, 1000, 'assets/images/thumbnails/55cdf6ce90ee2349cd423e36bd420b72efe5ae36328d2e07479b312c6b984fa4.jpg', '[\"assets/images/products/55cdf6ce90ee2349cd423e36bd420b72efe5ae36328d2e07479b312c6b984fa4.jpg\",\"assets/images/products/a42e9a5ebedef12867aed85693011f71fdea037b8bc0b2fcca2778537684a3e0.jpg\",\"assets/images/products/fd0762e76335dc8d234a4c864a380219140666909429f7c038ce4181bea5de6c.jpg\",\"assets/images/products/976a2cce9485570957b6c1b1c690953638d685a0f3e5d8ba4e5bbc2965814fcc.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(16, 'M.O.I', 'Kem chống nắng nâng tông tự nhiên M.O.I 10ml', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '10ml', 'Bảo quản nơi khô ráo/Tránh ánh nắng trực tiếp mặt trời. ', 129000, 560, 'assets/images/thumbnails/ed819d15e37588c97776e3168a60a244426bcb83f6ceaf25d79d49be7ca484c6.jpg', '[\"assets/images/products/8c4fc61d90bbb4c9f2048ce654a488cef3b53646b98bb0ae5365c1ba2721e626.jpg\",\"assets/images/products/719cce4b066f9f306a52cc4f7796fc5deb75d8ed3f8a6d4f042c8c8ef8c4a2e5.jpg\",\"assets/images/products/e32d7b734bb05058b2d017d0796e31598793948ac5f2c5cc030dfce1cad10113.jpg\",\"assets/images/products/f013f38082d3bc4f28a1d5fe9e9fbd72dfbe3c7c2a477b19f9e0429fd2f434fb.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(17, 'M.O.I', 'Nước hoa hồng 5 trong 1 by M.O.I', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '200ml', 'Đậy nắp kín sau khi sử dụng. Bảo quản nơi khô ráo, thoáng mát.', 249000, 450, 'assets/images/thumbnails/e0b725ec8041beccf2b8e8a08a4926a2cee282ac2e3225cf9a59365c01985223.jpg', '[\"assets/images/products/3f61e2ea90baf4949b88c8319ec9133679b14c7d52850ec72c0d267f49faf0d5.jpeg\",\"assets/images/products/06f1d387201f0d3b0fbc624322dc7c1cf19a3cd4ec496b702af1e81a841255b6.jpg\",\"assets/images/products/6f19b0f85e01e1ff120de885d0990e5b29731d958fbd376554bd3621a51de7a4.jpg\",\"assets/images/products/04715745fb7352e534dfa638253db1cee4aa153efd52c65ed775a91f73647faa.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(18, 'M.O.I', 'Bộ sản phẩm chăm sóc da toàn diện M.O.I', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '750ml+50 miếng ', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời.', 1297000, 876, 'assets/images/thumbnails/437e1a4a5c914f14a04d992ecfe2f37bf0f649b1107a294c46bb3ea479113a84.jpg', '[\"assets/images/products/3fc2b6460f1dba82752b1c4941004bd304cdf3016c88997951422416d9334825.jpg\",\"assets/images/products/9e43b964b11a450690f6dd0c7d5552b468b3965ca2a913d37d00fba9e637cd98.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(19, 'M.O.I', 'Nước hoa cao cấp DESTINY 10ml', 6, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '10ml', 'Đậy nắp kín sau khi sử dụng. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 329000, 1000, 'assets/images/thumbnails/780afdde72f416a28708e1fb020c1a4088cca13e49fb29012ad661dd20bb6e02.jpg', '[\"assets/images/products/26aabbccc86ab2bfaabed9fda3cf19d09a37083094a6f7e5d32356b72f5cd6f2.jpg\",\"assets/images/products/52bfd42538409b27efb30c9174b2255796ec439e14649514028c5009215c4219.jpg\",\"assets/images/products/a703538cf66e47e74d3ceb39ca4582e7698c34973f387c0118402ed8d012a296.jpg\",\"assets/images/products/de9d61d146a527070b9f4fa8def50551aa9b5ed1bc350a98181aefa77a4c4154.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(20, 'M.O.I', 'Nước hoa cao cấp DESTINY 50ML', 6, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '50ml', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời.', 899000, 670, 'assets/images/thumbnails/da40d1728baa048fbe37782b29e91a4062466fc2454e62fa0f1ac9e231e2cd34.jpg', '[\"assets/images/products/9f2b33345524f40092330e102009f6a81f844880c45b036145c8dc02b038251b.jpg\",\"assets/images/products/96c5bce4eb196fb193fec567e5ab7721a4f2e4a095b4fb3a3b7de2308e1faac4.jpg\",\"assets/images/products/bfd58b4aab73a91a4c77f5fe340b99523989ae5b08f1c9274f0013e62057f32a.jpg\",\"assets/images/products/e3ada8561dbe8fb6e08f9f0324d5f643a5434fdff813e4604dd94dd168688236.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(21, 'M.O.I', 'Phấn má hồng M.O.I', 4, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '9g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời.', 399000, 250, 'assets/images/thumbnails/dc566c38d60e65417d78b71bef57d533cabdf710846d4b16f73b892503cf82a7.jpg', '[\"assets/images/products/0ca738780a122b741ce71970bff642581db80d52e192f37eb74e7004a3f09996.jpg\",\"assets/images/products/48cadae310caa7d58dc2e23789965e9dea0b0495b559c4ae0a0d5b54dfcf6b35.jpg\",\"assets/images/products/86507456e2441881b91cc2018848983c46d0146e217ecd60420e79973c01801a.jpg\",\"assets/images/products/f878bca962e5ba1de84fde5e51ec3ba70fc8d4dd4fb819aa254d613c04099b33.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(22, 'M.O.I', 'Dưỡng môi có màu MICKEY\'S MAGIC LIPS', 2, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '15g', 'Bảo quản nơi khô ráo. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 329000, 700, 'assets/images/thumbnails/5f7c01dacfe5f59bf2eeecca6deb5311d9cfde870aee93bc1c749aa45f0eb860.jpg', '[\"assets/images/products/42212b262e08518ecc79ea486aaca104d791fd5431bb0735141866ab4aacb11a.jpg\",\"assets/images/products/0aa1a2dd9f83ef12b28b6a29e1dd8b0479ed672184a0f0f62d6117fc10e7ec04.jpg\",\"assets/images/products/2fdc55419a78c33853c9e2592275c77dbece654b69f6d83ad9e7cad86034a91e.jpg\",\"assets/images/products/a2cb1542ecd069be88f5cfce91368b3e213a5ad4eee7fb8a2ca16f3b7bb101a3.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(23, 'M.O.I', 'Bút kẻ mắt nước', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '35g', 'Đậy nắp kín sau khi sử dụng. Tránh ánh nắng trực tiếp mặt trời, nhiệt độ cao.', 249000, 870, 'assets/images/thumbnails/7f6284fb9422a18e2ec3a84a7a5778c549ae25834e8c314dc6d710a02ebee7be.jpg', '[\"assets/images/products/02be164221ff2c2ed22664d4a9529bb0775865829af1796cd637e14c01df6dd2.jpg\",\"assets/images/products/70357c8de3bfd08f6d1008bacebb397e07228169d77e76459c303309f8a3bb6b.jpg\",\"assets/images/products/e48965103320e4e26997d5892960960b9d159c24c46e242c63c3fdd8a3590d56.jpg\",\"assets/images/products/e7399b38b4543c5439cceabb698523ad5a0e896fd3e1e39c2116bd833e5ec26b.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(24, 'M.O.I', 'Chì kẻ mày', 5, 'Hàn Quốc', '3 năm kể từ ngày sản xuất', '35g', 'Đậy nắp kín sau khi sử dụng. Tránh ánh nắng trực trời.', 189000, 780, 'assets/images/thumbnails/03284e4c096a0540ff8644daaa11a0d609fba7adcfaeb9ad89856430627b67f9.jpg', '[\"assets/images/products/c066761400580218e390e8daecaa501f5960ab75801d1a9074cd0ef0806e3cdf.jpg\",\"assets/images/products/bd58713cedaf485227425c579de67eac8ca64b2de3fa4ed74672600e4a40b6ea.jpg\",\"assets/images/products/82410543792ec9414a85d36c21a1df4c62da78ae96a7b2733f4dfe702b3f1f43.jpg\",\"assets/images/products/4c7fca0b9f3a6a0f2d7913687c612b0415c705857a8b6b6eeaf37231ea929ade.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(25, 'M.O.I', 'Bộ cọ trang điểm mắt', 5, 'Trung Quốc', '3 năm kể từ ngày sản xuất', 'Bộ 8 cây', 'Bảo quản nơi khô ráo thoáng mát.', 335000, 500, 'assets/images/thumbnails/37ce0358192beaeaa98018c7e4675124179aa5ccad53ce36fdad78675c13c1b7.jpg', '[\"assets/images/products/5d9c564336455dbd759d988ef70d7538ef1d94def6bfc2fc8f360eed62aac00d.jpg\",\"assets/images/products/1e83281c537c352aec6ff35e54d7d0019b2154da220c864fda573dc7e7e98857.jpg\",\"assets/images/products/38e637414fd9be579de10f5ddb70c914dda99c2ec3df72b0e66797bc1bd0bf59.jpg\",\"assets/images/products/2768c9ebbcf90737aca8172c0511be8ced3920c59c999b9e4aeaa5afbbbb262a.jpg\"]', '2023-11-16 15:34:35', NULL, NULL);

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

INSERT INTO `user` (`id`, `full_name`, `birth_year`, `gender`, `email`, `hashed_password`, `avatar_path`, `address`, `status`, `create_at`, `update_at`, `delete_at`) VALUES
(1, 'Lê Minh Vương', 2003, 'male', 'vuonglmqe170148@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/bf8a9d7de5fb8310df146a4f061a85ef4757f6930f7633b98f9c8f1b290154bd.jpg', '[{\"province\":\"52\",\"district\":\"540\",\"ward\":\"21550\",\"specific\":\"Đại học FPT Quy Nhơn\"},{\"province\":\"52\",\"district\":\"547\",\"ward\":\"21808\",\"specific\":\"123 Trần Quang Diệu\"}]', 'activate', '2023-11-17 09:54:01', NULL, NULL),
(2, 'Nguyễn Thị Thúy', 2003, 'female', 'thuyntqe170033@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/0913a5b201de74b1cc693a3ce5254c31e963a4b334ebf34d0699f03b28972d55.jpg', '[{\"province\":\"52\",\"district\":\"540\",\"ward\":\"21550\",\"specific\":\"Đại học FPT Quy Nhơn\"},{\"province\":\"52\",\"district\":\"547\",\"ward\":\"21808\",\"specific\":\"123 Trần Quang Diệu\"}]', 'activate', '2023-11-17 10:01:32', NULL, NULL),
(3, 'Trần Huy Hoàng', 2003, 'male', 'hoangthqe170116@fpt.edu.vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'assets/images/avatars/99f35734734c349cce956db639c055ee376e6ae62364c5f22ffc738da2565415.jpg', '[{\"province\":\"52\",\"district\":\"540\",\"ward\":\"21550\",\"specific\":\"Đại học FPT Quy Nhơn\"},{\"province\":\"52\",\"district\":\"547\",\"ward\":\"21808\",\"specific\":\"123 Trần Quang Diệu\"}]', 'activate', '2023-11-17 10:03:47', NULL, NULL);

ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

ALTER TABLE `cart`
  ADD PRIMARY KEY (`user_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

ALTER TABLE `order_data`
  ADD PRIMARY KEY (`order_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID dùng để quản lý, tự động tăng', AUTO_INCREMENT=5;

ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID dùng để quản lý, tự động tăng', AUTO_INCREMENT=7;

ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID dùng để quản lý, tự động tăng';

ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID dùng để quản lý, tự động tăng', AUTO_INCREMENT=26;

ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID dùng để quản lý, tự động tăng', AUTO_INCREMENT=4;

ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

ALTER TABLE `order_data`
  ADD CONSTRAINT `order_data_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `order_data_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);
COMMIT;