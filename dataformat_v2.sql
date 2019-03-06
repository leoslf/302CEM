-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- 主機: localhost
-- 產生時間： 2019 年 03 月 06 日 18:20
-- 伺服器版本: 10.1.36-MariaDB
-- PHP 版本： 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： 302CEM
--

-- --------------------------------------------------------

--
-- 資料表結構 Customer
--

CREATE TABLE IF NOT EXISTS Customer (
  id varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  name varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  address1 varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  address2 varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  address3 varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  email varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'name@email.com',
  contact varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT '98765432',
  PRIMARY KEY (id),
  UNIQUE KEY name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 Customer
--

INSERT INTO Customer (id, `name`, address1, address2, address3, email, contact) VALUES
('', 'DUMMY', 'DUMMY Building, -1 DUMMY Street', 'DUMMY District ', 'DUMMY', 'name@email.com', '98765432'),
('000000000001', 'Web Store 1', 'NO.45, WO HING TSUEN,NO. 45, WO HING TSUEN', 'NORTH', 'NT', 'name@email.com', '98765432'),
('000000000002', 'Web Store 2', 'BLOCK A23,EUROPA GARDEN,NO. 48,KWU TUNG ROAD', 'NORTH', 'NT', 'name@email.com', '98765432'),
('000000000003', 'Web Store 3', '338, FAN KAM ROAD, The Green , Maple Drive F2', 'NORTH', 'NT', 'name@email.com', '98765432');

-- --------------------------------------------------------

--
-- 資料表結構 Logistics
--

CREATE TABLE IF NOT EXISTS Logistics (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  address1 varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  address2 varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  address3 varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY name (name)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 Logistics
--

INSERT INTO Logistics (id, `name`, address1, address2, address3) VALUES
(-1, 'DUMMY Logistics Company', 'DUMMY Address', NULL, NULL),
(1, 'Logistics Company 1', 'Logistics Company 1 Address', NULL, NULL),
(2, 'Logistics Company 2', 'Logistics Company 2 Company', NULL, NULL),
(3, 'Logistics Company 3', 'Logistics Company 3 Address', NULL, NULL);

-- --------------------------------------------------------

--
-- 資料表結構 Logistics_Request
--

CREATE TABLE IF NOT EXISTS Logistics_Request (
  id int(11) NOT NULL AUTO_INCREMENT,
  quantity int(11) NOT NULL,
  weight float NOT NULL,
  Customer_id varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (id),
  KEY Customer_id (Customer_id)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 Logistics_Request
--

INSERT INTO Logistics_Request (id, quantity, weight, Customer_id) VALUES
(1, 1, 1, '000000000001'),
(2, 1, 1, '000000000001'),
(3, 1, 1, '000000000001'),
(4, 1, 1, '000000000001'),
(5, 1, 1, '000000000001'),
(6, 1, 1, '000000000001'),
(7, 1, 1, '000000000001'),
(8, 1, 1, '000000000001'),
(9, 1, 1, '000000000001');

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 Logistics_Request_View
-- (請參考以下實際畫面)
--
CREATE TABLE IF NOT EXISTS `Logistics_Request_View` (
`shipper_name` varchar(32)
,`shipper_email` varchar(255)
,`id` int(11)
,`quantity` int(11)
,`weight` float
,`Customer_id` varchar(12)
,`receiver_name` varchar(32)
,`receiver_address` text
,`receiver_contact` varchar(8)
);

-- --------------------------------------------------------

--
-- 資料表結構 Product
--

CREATE TABLE IF NOT EXISTS Product (
  id varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  name varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  description varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  weight float NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 Product
--

INSERT INTO Product (id, `name`, description, weight) VALUES
('', 'DUMMY', 'Dummy to occupy the empty string ID', 0),
('000000000001', 'Custom Product 1', 'Test Product', 1),
('000000000002', 'Custom Product 2', 'Test Product 2', 2),
('000000000003', 'Custom Product 3', 'Test Product 3', 3);

-- --------------------------------------------------------

--
-- 資料表結構 Request
--

CREATE TABLE IF NOT EXISTS Request (
  id int(11) NOT NULL AUTO_INCREMENT,
  Customer_id varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  Manufacturer_id varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  Product_id varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  qty int(11) NOT NULL,
  order_date date NOT NULL,
  due_date date NOT NULL,
  Invoice_id int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY Customer_id (Customer_id),
  KEY Product_id (Product_id)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 Request
--

INSERT INTO Request (id, Customer_id, Manufacturer_id, Product_id, qty, order_date, due_date, Invoice_id) VALUES
(-1, '', NULL, '', 0, '0000-00-00', '0000-00-00', -1),
(1, '000000000001', NULL, '000000000001', 1, '2019-02-15', '2019-02-22', 1),
(2, '000000000002', NULL, '000000000002', 2, '2019-02-15', '2019-02-21', 2),
(3, '000000000003', NULL, '000000000003', 3, '2019-02-15', '2019-02-20', 3),
(5, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 5),
(6, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 6),
(7, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 7),
(8, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 8),
(9, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 9),
(10, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 10),
(11, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 11),
(12, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 12),
(13, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 13),
(14, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 14),
(15, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 15),
(16, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 16),
(17, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 17),
(18, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 18),
(19, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 19),
(20, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 20),
(21, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 21),
(22, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 22),
(23, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 23),
(24, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 24),
(25, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 25),
(26, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 26),
(27, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 27),
(28, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 28),
(29, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 29),
(30, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 30),
(31, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 31),
(32, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 32),
(33, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 33),
(34, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 34),
(35, '000000000001', NULL, '000000000001', 1, '2019-03-06', '2019-03-13', 0);

-- --------------------------------------------------------

--
-- 檢視表結構 Logistics_Request_View
--
DROP TABLE IF EXISTS `Logistics_Request_View`;

CREATE ALGORITHM=UNDEFINED DEFINER=root@localhost SQL SECURITY DEFINER VIEW   AS CEM.Logistics_Request_View AS select d.`name` AS shipper_name,d.email AS shipper_email,l.`id` AS `id`,l.quantity AS quantity,l.weight AS weight,l.Customer_id AS Customer_id,c.`name` AS receiver_name,concat(c.address1,', ',c.address2,', ',c.address3) AS receiver_address,c.contact AS receiver_contact from ((302CEM.Logistics_Request l join 302CEM.Customer d on((d.`id` = ''))) join 302CEM.Customer c on((c.`id` = l.Customer_id))) ;

--
-- 已匯出資料表的限制(Constraint)
--

--
-- 資料表的 Constraints Logistics_Request
--
ALTER TABLE Logistics_Request
  ADD CONSTRAINT Logistics_Request_ibfk_1 FOREIGN KEY (Customer_id) REFERENCES Customer (id);

--
-- 資料表的 Constraints Request
--
ALTER TABLE Request
  ADD CONSTRAINT Request_ibfk_1 FOREIGN KEY (Customer_id) REFERENCES Customer (id),
  ADD CONSTRAINT Request_ibfk_2 FOREIGN KEY (Product_id) REFERENCES Product (id);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
