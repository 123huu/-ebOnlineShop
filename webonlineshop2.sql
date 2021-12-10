-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 10, 2021 lúc 02:32 AM
-- Phiên bản máy phục vụ: 10.4.21-MariaDB
-- Phiên bản PHP: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `webonlineshop2`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `admin`
--

CREATE TABLE `admin` (
  `ID` int(11) NOT NULL,
  `TenAdmin` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `DiaChi` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Gmail` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `MatKhau` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `SDT` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `Avatar` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Status` tinyint(4) NOT NULL DEFAULT 0,
  `Level` tinyint(4) NOT NULL DEFAULT 1,
  `Create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `Update_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `admin`
--

INSERT INTO `admin` (`ID`, `TenAdmin`, `DiaChi`, `Gmail`, `MatKhau`, `SDT`, `Avatar`, `Status`, `Level`, `Create_at`, `Update_at`) VALUES
(1, 'Lê Tự Hữu', 'Thanh hóa', 'huu@gmail.com', '1234556', '0369140787', 'testimonials-5.jpg', 0, 1, '2021-12-03 06:23:42', '2021-12-03 06:23:42');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chitiethdban`
--

CREATE TABLE `chitiethdban` (
  `MaHDB` int(11) NOT NULL,
  `ID` int(11) NOT NULL,
  `SLBan` int(11) NOT NULL DEFAULT 0,
  `GiaBan` decimal(60,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `chitiethdban`
--

INSERT INTO `chitiethdban` (`MaHDB`, `ID`, `SLBan`, `GiaBan`) VALUES
(88, 15, 1, '12341234.00'),
(89, 14, 2, '12341234.00'),
(89, 16, 2, '12341234.00'),
(90, 17, 1, '12341234.00'),
(91, 22, 1, '12341234.00'),
(92, 16, 1, '12341234.00'),
(93, 15, 1, '12341234.00'),
(93, 17, 1, '12341234.00'),
(94, 15, 1, '12341234.00');

--
-- Bẫy `chitiethdban`
--
DELIMITER $$
CREATE TRIGGER `capnhaptonggiatriban` AFTER UPDATE ON `chitiethdban` FOR EACH ROW BEGIN
    UPDATE hoadonban
		SET TongGiaTri = (SELECT SUM(SLBan * GiaBan) FROM chitiethdban WHERE chitiethdban.MaHDB=hoadonban.MaHDB);
		UPDATE sanpham
		INNER JOIN chitiethdban ON sanpham.ID = chitiethdban.ID
		SET sanpham.SLTon = sanpham.SLTon - (SELECT SLBan FROM chitiethdban WHERE sanpham.ID=chitiethdban.ID ORDER BY chitiethdban.MaHDB DESC LIMIT 1 ) Where sanpham.ID=chitiethdban.ID;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `capnhaptonggiatriban1` AFTER INSERT ON `chitiethdban` FOR EACH ROW BEGIN
    UPDATE hoadonban
		SET TongGiaTri = (SELECT SUM(SLBan * GiaBan) FROM chitiethdban WHERE chitiethdban.MaHDB=hoadonban.MaHDB);
		UPDATE sanpham
		INNER JOIN chitiethdban ON sanpham.ID = chitiethdban.ID
		SET sanpham.SLTon = sanpham.SLTon - (SELECT SLBan FROM chitiethdban WHERE sanpham.ID=chitiethdban.ID ORDER BY chitiethdban.MaHDB DESC LIMIT 1 ) Where sanpham.ID=chitiethdban.ID;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `capnhaptonggiatriban2` AFTER DELETE ON `chitiethdban` FOR EACH ROW BEGIN
    UPDATE hoadonban
		SET TongGiaTri = (SELECT SUM(SLBan * GiaBan) FROM chitiethdban WHERE chitiethdban.MaHDB=hoadonban.MaHDB);
		UPDATE sanpham
		INNER JOIN chitiethdban ON sanpham.ID = chitiethdban.ID
		SET sanpham.SLTon = sanpham.SLTon - (SELECT SLBan FROM chitiethdban WHERE sanpham.ID=chitiethdban.ID ORDER BY chitiethdban.MaHDB DESC LIMIT 1 ) Where sanpham.ID=chitiethdban.ID;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhmuc`
--

CREATE TABLE `danhmuc` (
  `ID` int(11) NOT NULL,
  `TenDM` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Slug` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Images` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Home` tinyint(4) NOT NULL DEFAULT 0,
  `Create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `Update_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `danhmuc`
--

INSERT INTO `danhmuc` (`ID`, `TenDM`, `Slug`, `Images`, `Home`, `Create_at`, `Update_at`) VALUES
(6, 'ferrary', '3680', 'logo_ferrari.jpg', 1, '2021-12-06 00:19:29', '2021-12-06 00:19:29'),
(7, 'Toyota', '3688', 'logo_toyota.jpg', 1, '2021-12-06 00:26:42', '2021-12-06 00:26:42'),
(8, 'Rollroyce', '3692', 'logo_rollroyce.jpg', 1, '2021-12-06 00:30:20', '2021-12-06 00:30:20');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `giohang`
--

CREATE TABLE `giohang` (
  `MaKH` int(11) NOT NULL,
  `TenKH` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `DiaChi` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `SDT` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `ID` int(11) NOT NULL,
  `TenSP` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Photo1` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Soluong` int(11) DEFAULT 1,
  `Gia` decimal(60,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `hoadonban`
--

CREATE TABLE `hoadonban` (
  `MaHDB` int(11) NOT NULL,
  `MaKH` int(11) NOT NULL,
  `TongGiaTri` decimal(60,2) NOT NULL DEFAULT 0.00,
  `NgayLap` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `hoadonban`
--

INSERT INTO `hoadonban` (`MaHDB`, `MaKH`, `TongGiaTri`, `NgayLap`, `status`) VALUES
(87, 1, '0.00', '0000-00-00 00:00:00', 1),
(88, 41, '12341234.00', '2021-12-08 13:36:45', 1),
(89, 41, '49364936.00', '2021-12-08 13:38:53', 1),
(90, 41, '12341234.00', '2021-12-08 13:42:37', 1),
(91, 41, '12341234.00', '2021-12-08 13:45:30', 1),
(92, 41, '12341234.00', '2021-12-08 13:46:22', 1),
(93, 41, '24682468.00', '2021-12-08 14:00:40', 1),
(94, 41, '12341234.00', '2021-12-10 00:23:43', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `khachhang`
--

CREATE TABLE `khachhang` (
  `MaKH` int(11) NOT NULL,
  `TenKH` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `DiaChi` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `SDT` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `Cmt` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `Email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Home` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `khachhang`
--

INSERT INTO `khachhang` (`MaKH`, `TenKH`, `DiaChi`, `SDT`, `Cmt`, `Email`, `Home`) VALUES
(1, 'Lưu Văn Tiến', 'Bắc Ninh', '0345678912', 'Hàng chính hãng, đập thùng. Mua được flash sale giá tốt hơn nhiều so với mua shop ngoài.\r\nCấu hình ngon, máy mạnh, mát mẻ.\r\nHàng chính hãng, đập thùng. Mua được flash sale giá tốt hơn nhiều so với mua shop ngoài.\r\nCấu hình ngon, máy mạnh, mát mẻ.\r\nHàng chính hãng, đập thùng. Mua được flash sale giá tốt hơn nhiều so với mua shop ngoài.\r\nCấu hình ngon, máy mạnh, mát mẻ.', 'luuvantien@gmail.com', 1),
(2, 'Lê Tự Hữu', 'Thanh Hóa', '034126785', 'Sản phẩm rất tốt, vỏ nhôm mỏng nhẹ sang trọng, rất đáng tiền mua. Máy chạy rất nhanh và mượt, dù có lỗi nhỏ về hiển thị wifi nhưng vẫn chấp nhận được. Tuy nhiên giao hàng hơi lâu, nhưng bù lại đóng gói rất cẩn thận nên cũng không sao. Highly recommend mọi người mua thử sản phẩm.', 'letuhuu@gmail.com', 1),
(40, 'Sơn Tùng MT-P', 'Thái Bình', '039489654', '', 'sontung@gmail.com', 1),
(41, 'Phạm Thành Quang', 'hà nội', '0987654', 'sản phẩm ổn', 'quang123@gmail.com', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nguoidung`
--

CREATE TABLE `nguoidung` (
  `id` int(11) NOT NULL,
  `TenNguoiDung` varchar(255) NOT NULL,
  `MatKhau` int(11) NOT NULL,
  `diachi` varchar(255) NOT NULL,
  `SDT` int(11) NOT NULL,
  `CMND` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nhacungcap`
--

CREATE TABLE `nhacungcap` (
  `MaNCC` int(11) NOT NULL,
  `TenNCC` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `DiaChi` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `SDT` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `Email` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `nhacungcap`
--

INSERT INTO `nhacungcap` (`MaNCC`, `TenNCC`, `DiaChi`, `SDT`, `Email`) VALUES
(2, 'Lê Hữu', '235, Hoàng Quốc Việt, Bắc Từ Liêm, Hà Nội', '123456244', 'huu01669140787@gmail.com'),
(3, 'Phạm thành quang', 'Hà nội', '09876', 'quang123@gmail.com'),
(4, 'Vương Tuấn Anh', 'Hải Dương', '098765', 'anh@gmail.com');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sanpham`
--

CREATE TABLE `sanpham` (
  `ID` int(11) NOT NULL,
  `TenSP` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Photo1` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Photo2` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Photo3` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Photo4` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Photo5` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Photo6` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Dungtich` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Dongco` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `CongSuatCD` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `KhoangSangGam` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `MucTieuThuNL` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `XuatXu` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `HopSo` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `DungTichKhoangCD` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `ChoNgoi` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `KichThuocLop` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `TrongLuong` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `MaNCC` int(11) NOT NULL,
  `MaTTBH` int(11) NOT NULL,
  `SLTon` int(11) NOT NULL DEFAULT 0,
  `Gia` decimal(60,2) NOT NULL DEFAULT 0.00,
  `GiaBan` decimal(60,2) NOT NULL DEFAULT 0.00,
  `Sale` tinyint(4) NOT NULL DEFAULT 0,
  `Home` tinyint(4) NOT NULL DEFAULT 0,
  `category_id` int(11) NOT NULL,
  `Content` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `Create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `Update_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `sanpham`
--

INSERT INTO `sanpham` (`ID`, `TenSP`, `Photo1`, `Photo2`, `Photo3`, `Photo4`, `Photo5`, `Photo6`, `Dungtich`, `Dongco`, `CongSuatCD`, `KhoangSangGam`, `MucTieuThuNL`, `XuatXu`, `HopSo`, `DungTichKhoangCD`, `ChoNgoi`, `KichThuocLop`, `TrongLuong`, `MaNCC`, `MaTTBH`, `SLTon`, `Gia`, `GiaBan`, `Sale`, `Home`, `category_id`, `Content`, `Create_at`, `Update_at`) VALUES
(14, 'ferrary', 'Ferrari_photo1.jpg', 'Ferrari_photo2.jpg', 'Ferrari_photo3.jpg', 'Ferrari_photo4.jpg', 'Ferrari_photo5.jpg', 'Ferrari_photo7.jpg', '12200', '1234', '1234', '1234', '1234', 'nhập khẩu', '1234', '1234', '2', '1234', '1234', 2, 5, 1218, '12341234.00', '12345612345.00', 20, 1, 6, '', '2021-12-06 00:25:12', '2021-12-06 00:25:12'),
(15, 'Tyota', 'Toyota_photo1.jpg', '', '', '', '', '', '12200', '1234', '1234', '1234', '1234', 'nhập khẩu', '1234', '1234', '4', '1234', '1234', 2, 6, 1225, '12341234.00', '12345612345.00', 20, 1, 7, '', '2021-12-06 00:29:09', '2021-12-06 00:29:09'),
(16, 'Rollroyce', 'Rollroy_photo1.jpg', 'Rollroy_photo2.jpg', 'Rollroy_photo3.jpg', 'Rollroy_photo4.jpg', 'Rollroy_photo5.jpg', 'Rollroy_photo6.jpg', '12200', '1234', '1234', '1234', '1234', 'nhập khẩu', '1234', '1234', '6', '1234', '1234', 2, 4, 1224, '12341234.00', '12345612345.00', 20, 1, 8, '', '2021-12-06 00:32:09', '2021-12-06 00:32:09'),
(17, 'ferrary1', 'Ferrari_photo2.jpg', 'Ferrari_photo5.jpg', 'Ferrari_photo1.jpg', 'Ferrari_photo7.jpg', 'Ferrari_photo9.jpg', 'Ferrari_photo4.jpg', '12200', '1234', '1234', '1234', '1234', 'nhập khẩu', '1234', '1234', '2', '12', '1234', 2, 5, 1228, '12341234.00', '12345612345.00', 20, 1, 6, '', '2021-12-07 01:20:44', '2021-12-07 01:20:44'),
(20, 'ferrary2', 'Ferrari_photo10.jpg', 'Ferrari_photo13.jpg', 'Ferrari_photo3.jpg', 'Ferrari_photo5.jpg', 'Ferrari_photo8.jpg', 'Ferrari_photo9.jpg', '12200', '1234', '1234', '1234', '1234', 'nhập khẩu', '1234', '1234', '2', '12', '1234', 2, 6, 1234, '12341234.00', '12345612345.00', 20, 1, 6, '', '2021-12-07 01:22:54', '2021-12-07 01:22:54'),
(22, 'Tyota1', 'Toyota_photo11.jpg', 'Toyota_photo13.jpg', 'Toyota_photo18.jpg', 'Toyota_photo3.jpg', 'Toyota_photo4.jpg', 'Toyota_photo6.jpg', '12200', '1234', '1234', '1234', '1234', 'nhập khẩu', '1234', '1234', '4', '12', '1234', 2, 6, 1229, '12341234.00', '12345612345.00', 20, 1, 7, '', '2021-12-07 01:25:37', '2021-12-07 01:25:37'),
(23, 'Tyota2', 'Toyota_photo2.jpg', 'Toyota_photo12.jpg', 'Toyota_photo14.jpg', 'Toyota_photo12.jpg', 'Toyota_photo16.jpg', 'Toyota_photo17.jpg', '12200', '1234', '1234', '1234', '1234', 'nhập khẩu', '1234', '1234', '4', '12', '1234', 2, 6, 1234, '12341234.00', '12345612345.00', 20, 0, 7, '', '2021-12-07 01:28:08', '2021-12-07 01:28:08'),
(24, 'Rollroyce1', 'Rollroy_photo4.jpg', 'Rollroy_photo1.jpg', 'Rollroy_photo2.jpg', 'Rollroy_photo3.jpg', 'Rollroy_photo4.jpg', 'Rollroy_photo5.jpg', '12200', '1234', '1234', '1234', '1234', 'nhập khẩu', '1234', '1234', '6', '12', '1234', 2, 4, 1234, '12341234.00', '12345612345.00', 20, 1, 8, '', '2021-12-07 01:31:15', '2021-12-07 01:31:15'),
(25, 'Rollroyce2', 'Rollroy_photo7.jpg', 'Rollroy_photo8.jpg', 'Rollroy_photo9.jpg', 'Rollroy_photo10.jpg', 'Rollroy_photo11.jpg', 'Rollroy_photo12.jpg', '12200', '1234', '1234', '1234', '1234', 'nhập khẩu', '1234', '1234', '6', '12', '1234', 2, 4, 1234, '12341234.00', '12345612345.00', 20, 1, 8, '', '2021-12-07 01:32:55', '2021-12-07 01:32:55');

--
-- Bẫy `sanpham`
--
DELIMITER $$
CREATE TRIGGER `capnhapsanphamtheoban` AFTER UPDATE ON `sanpham` FOR EACH ROW BEGIN
    
		UPDATE danhmuc
		SET Slug = (SELECT SUM(SLTon) FROM sanpham WHERE sanpham.category_id=danhmuc.ID);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `capnhapsanphamtheoban1` AFTER INSERT ON `sanpham` FOR EACH ROW BEGIN
    
		UPDATE danhmuc
		SET Slug = (SELECT SUM(SLTon) FROM sanpham WHERE sanpham.category_id=danhmuc.ID);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `capnhapsanphamtheoban2` AFTER DELETE ON `sanpham` FOR EACH ROW BEGIN
    
		UPDATE danhmuc
		SET Slug = (SELECT SUM(SLTon) FROM sanpham WHERE sanpham.category_id=danhmuc.ID);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ttbaohanh`
--

CREATE TABLE `ttbaohanh` (
  `MaTTBH` int(11) NOT NULL,
  `TenTTBH` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `DiaChi` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `SDT` varchar(10) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `ttbaohanh`
--

INSERT INTO `ttbaohanh` (`MaTTBH`, `TenTTBH`, `DiaChi`, `SDT`) VALUES
(4, 'Rolls-Royce - S&S Automotive', ' Số 5 Nguyễn Văn Linh, Gia Thụy, Long Biên, Hà Nội', '0868 190 4'),
(5, 'thanhphongauto', ' 68B Nguyễn Hữu Thọ, Phường Tân Hưng, Quận 7, TP.Hồ Chí Minh', '0312491829'),
(6, 'CÔNG TY Ô TÔ TOYOTA VIỆT NAM', ' Phường Phúc Thắng, Thành phố Phúc Yên, Tỉnh Vĩnh Phúc, Việt Nam', '0916 001 5');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`ID`) USING BTREE,
  ADD UNIQUE KEY `Gmail` (`Gmail`) USING BTREE,
  ADD UNIQUE KEY `SDT` (`SDT`) USING BTREE;

--
-- Chỉ mục cho bảng `chitiethdban`
--
ALTER TABLE `chitiethdban`
  ADD KEY `MaHDB` (`MaHDB`) USING BTREE,
  ADD KEY `ID` (`ID`) USING BTREE;

--
-- Chỉ mục cho bảng `danhmuc`
--
ALTER TABLE `danhmuc`
  ADD PRIMARY KEY (`ID`) USING BTREE;

--
-- Chỉ mục cho bảng `giohang`
--
ALTER TABLE `giohang`
  ADD PRIMARY KEY (`ID`) USING BTREE;

--
-- Chỉ mục cho bảng `hoadonban`
--
ALTER TABLE `hoadonban`
  ADD PRIMARY KEY (`MaHDB`) USING BTREE,
  ADD KEY `MaKH` (`MaKH`) USING BTREE;

--
-- Chỉ mục cho bảng `khachhang`
--
ALTER TABLE `khachhang`
  ADD PRIMARY KEY (`MaKH`) USING BTREE;

--
-- Chỉ mục cho bảng `nguoidung`
--
ALTER TABLE `nguoidung`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `nhacungcap`
--
ALTER TABLE `nhacungcap`
  ADD PRIMARY KEY (`MaNCC`) USING BTREE;

--
-- Chỉ mục cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD PRIMARY KEY (`ID`) USING BTREE,
  ADD KEY `category_id` (`category_id`) USING BTREE,
  ADD KEY `MaNCC` (`MaNCC`) USING BTREE,
  ADD KEY `MaTTBH` (`MaTTBH`) USING BTREE;

--
-- Chỉ mục cho bảng `ttbaohanh`
--
ALTER TABLE `ttbaohanh`
  ADD PRIMARY KEY (`MaTTBH`) USING BTREE;

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `admin`
--
ALTER TABLE `admin`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `danhmuc`
--
ALTER TABLE `danhmuc`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `hoadonban`
--
ALTER TABLE `hoadonban`
  MODIFY `MaHDB` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT cho bảng `khachhang`
--
ALTER TABLE `khachhang`
  MODIFY `MaKH` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT cho bảng `nguoidung`
--
ALTER TABLE `nguoidung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `nhacungcap`
--
ALTER TABLE `nhacungcap`
  MODIFY `MaNCC` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT cho bảng `ttbaohanh`
--
ALTER TABLE `ttbaohanh`
  MODIFY `MaTTBH` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD CONSTRAINT `sanpham_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `danhmuc` (`ID`),
  ADD CONSTRAINT `sanpham_ibfk_2` FOREIGN KEY (`MaNCC`) REFERENCES `nhacungcap` (`MaNCC`),
  ADD CONSTRAINT `sanpham_ibfk_3` FOREIGN KEY (`MaTTBH`) REFERENCES `ttbaohanh` (`MaTTBH`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
