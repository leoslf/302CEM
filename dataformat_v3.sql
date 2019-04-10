-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- 主機: localhost
-- 產生時間： 2019 年 04 月 07 日 18:43
-- 伺服器版本: 10.1.36-MariaDB
-- PHP 版本： 7.3.4

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
CREATE DATABASE IF NOT EXISTS 302CEM DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE 302CEM;

-- --------------------------------------------------------

--
-- 資料表結構 Consumption
--

CREATE TABLE Consumption (
  Production_id int(11) NOT NULL,
  Material_id int(11) NOT NULL,
  qty int(11) NOT NULL,
  create_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 Consumption_View
-- (請參考以下實際畫面)
--
CREATE TABLE `Consumption_View` (
`Material_id` int(11)
,`qty` decimal(32,0)
);

-- --------------------------------------------------------

--
-- 資料表結構 Customer
--

CREATE TABLE Customer (
  id varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  name varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  address1 varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  address2 varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  address3 varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  email varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'name@email.com',
  contact varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT '98765432'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 Logistics
--

CREATE TABLE Logistics (
  id int(11) NOT NULL,
  name varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  address1 varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  address2 varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  address3 varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 Logistics_Request
--

CREATE TABLE Logistics_Request (
  id int(11) NOT NULL,
  quantity int(11) NOT NULL,
  weight float NOT NULL,
  Customer_id varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 Logistics_Request_Request
--

CREATE TABLE Logistics_Request_Request (
  Logistics_Request_id int(11) NOT NULL,
  Request_id int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 Logistics_Request_View
-- (請參考以下實際畫面)
--
CREATE TABLE `Logistics_Request_View` (
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
-- 資料表結構 Material
--

CREATE TABLE Material (
  id int(11) NOT NULL,
  name varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 Product
--

CREATE TABLE Product (
  id varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  name varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  description varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  weight float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 Production
--

CREATE TABLE Production (
  id int(11) NOT NULL,
  Product_id varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  qty int(11) NOT NULL,
  create_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  Request_id int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 Recipe
--

CREATE TABLE Recipe (
  Product_id varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  Material_id int(11) NOT NULL,
  qty int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 Request
--

CREATE TABLE Request (
  id int(11) NOT NULL,
  Customer_id varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  Manufacturer_id varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  Product_id varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  qty int(11) NOT NULL,
  order_date date NOT NULL,
  due_date date NOT NULL,
  Invoice_id int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 Request_View
-- (請參考以下實際畫面)
--
CREATE TABLE `Request_View` (
`Request_id` int(11)
,`Invoice_id` int(11)
,`Logistics_Request_id` int(11)
,`shipper_name` varchar(32)
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
-- 資料表結構 Restock
--

CREATE TABLE Restock (
  id int(11) NOT NULL,
  Material_id int(11) NOT NULL,
  qty int(11) NOT NULL,
  create_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 Restock_View
-- (請參考以下實際畫面)
--
CREATE TABLE `Restock_View` (
`Material_id` int(11)
,`qty` decimal(32,0)
);

-- --------------------------------------------------------

--
-- 檢視表結構 Consumption_View
--
DROP TABLE IF EXISTS `Consumption_View`;

CREATE ALGORITHM=UNDEFINED DEFINER=root@localhost SQL SECURITY DEFINER VIEW   AS CEM.Consumption_View AS select m.`id` AS Material_id,coalesce(sum(c.qty),0) AS qty from (302CEM.Material m left join 302CEM.Consumption c on((m.`id` = c.Material_id))) group by m.`id` ;

-- --------------------------------------------------------

--
-- 檢視表結構 Logistics_Request_View
--
DROP TABLE IF EXISTS `Logistics_Request_View`;

CREATE ALGORITHM=UNDEFINED DEFINER=302@localhost AS `CEM` SQL SECURITY DEFINER VIEW   AS CEM.Logistics_Request_View AS select d.`name` AS shipper_name,d.email AS shipper_email,l.`id` AS `id`,l.quantity AS quantity,l.weight AS weight,l.Customer_id AS Customer_id,c.`name` AS receiver_name,concat(c.address1,', ',c.address2,', ',c.address3) AS receiver_address,c.contact AS receiver_contact from ((302CEM.Logistics_Request l join 302CEM.Customer d on((d.`id` = ''))) join 302CEM.Customer c on((c.`id` = l.Customer_id))) ;

-- --------------------------------------------------------

--
-- 檢視表結構 Request_View
--
DROP TABLE IF EXISTS `Request_View`;

CREATE ALGORITHM=UNDEFINED DEFINER=root@localhost SQL SECURITY DEFINER VIEW   AS CEM.Request_View AS select r.`id` AS Request_id,r.Invoice_id AS Invoice_id,lrr.Logistics_Request_id AS Logistics_Request_id,lrv.shipper_name AS shipper_name,lrv.shipper_email AS shipper_email,lrv.`id` AS `id`,lrv.quantity AS quantity,lrv.weight AS weight,lrv.Customer_id AS Customer_id,lrv.receiver_name AS receiver_name,lrv.receiver_address AS receiver_address,lrv.receiver_contact AS receiver_contact from ((302CEM.Request r left join 302CEM.Logistics_Request_Request lrr on((lrr.Request_id = r.`id`))) left join 302CEM.Logistics_Request_View lrv on((lrv.`id` = lrr.Logistics_Request_id))) ;

-- --------------------------------------------------------

--
-- 檢視表結構 Restock_View
--
DROP TABLE IF EXISTS `Restock_View`;

CREATE ALGORITHM=UNDEFINED DEFINER=root@localhost SQL SECURITY DEFINER VIEW   AS CEM.Restock_View AS select m.`id` AS Material_id,coalesce(sum(r.qty),0) AS qty from (302CEM.Material m left join 302CEM.Restock r on((m.`id` = r.Material_id))) group by m.`id` ;

--
-- 已匯出資料表的索引
--

--
-- 資料表索引 Consumption
--
ALTER TABLE Consumption
  ADD PRIMARY KEY (Production_id,Material_id),
  ADD KEY Material_id (Material_id);

--
-- 資料表索引 Customer
--
ALTER TABLE Customer
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY name (name);

--
-- 資料表索引 Logistics
--
ALTER TABLE Logistics
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY name (name);

--
-- 資料表索引 Logistics_Request
--
ALTER TABLE Logistics_Request
  ADD PRIMARY KEY (id),
  ADD KEY Customer_id (Customer_id);

--
-- 資料表索引 Logistics_Request_Request
--
ALTER TABLE Logistics_Request_Request
  ADD PRIMARY KEY (Logistics_Request_id,Request_id),
  ADD KEY Request_id (Request_id);

--
-- 資料表索引 Material
--
ALTER TABLE Material
  ADD PRIMARY KEY (id);

--
-- 資料表索引 Product
--
ALTER TABLE Product
  ADD PRIMARY KEY (id);

--
-- 資料表索引 Production
--
ALTER TABLE Production
  ADD PRIMARY KEY (id),
  ADD KEY Product_id (Product_id),
  ADD KEY Request_id (Request_id);

--
-- 資料表索引 Recipe
--
ALTER TABLE Recipe
  ADD PRIMARY KEY (Product_id,Material_id),
  ADD KEY Material_id (Material_id);

--
-- 資料表索引 Request
--
ALTER TABLE Request
  ADD PRIMARY KEY (id),
  ADD KEY Customer_id (Customer_id),
  ADD KEY Product_id (Product_id);

--
-- 資料表索引 Restock
--
ALTER TABLE Restock
  ADD PRIMARY KEY (id),
  ADD KEY Material_id (Material_id);

--
-- 在匯出的資料表使用 AUTO_INCREMENT
--

--
-- 使用資料表 AUTO_INCREMENT Logistics
--
ALTER TABLE Logistics
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表 AUTO_INCREMENT Logistics_Request
--
ALTER TABLE Logistics_Request
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表 AUTO_INCREMENT Material
--
ALTER TABLE Material
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表 AUTO_INCREMENT Production
--
ALTER TABLE Production
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表 AUTO_INCREMENT Request
--
ALTER TABLE Request
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表 AUTO_INCREMENT Restock
--
ALTER TABLE Restock
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

--
-- 已匯出資料表的限制(Constraint)
--

--
-- 資料表的 Constraints Consumption
--
ALTER TABLE Consumption
  ADD CONSTRAINT Consumption_ibfk_1 FOREIGN KEY (Production_id) REFERENCES Production (id),
  ADD CONSTRAINT Consumption_ibfk_2 FOREIGN KEY (Material_id) REFERENCES Material (id);

--
-- 資料表的 Constraints Logistics_Request
--
ALTER TABLE Logistics_Request
  ADD CONSTRAINT Logistics_Request_ibfk_1 FOREIGN KEY (Customer_id) REFERENCES Customer (id);

--
-- 資料表的 Constraints Logistics_Request_Request
--
ALTER TABLE Logistics_Request_Request
  ADD CONSTRAINT Logistics_Request_Request_ibfk_1 FOREIGN KEY (Logistics_Request_id) REFERENCES Logistics_Request (id),
  ADD CONSTRAINT Logistics_Request_Request_ibfk_2 FOREIGN KEY (Request_id) REFERENCES Request (id);

--
-- 資料表的 Constraints Production
--
ALTER TABLE Production
  ADD CONSTRAINT Production_ibfk_1 FOREIGN KEY (Product_id) REFERENCES Product (id),
  ADD CONSTRAINT Production_ibfk_2 FOREIGN KEY (Request_id) REFERENCES Request (id);

--
-- 資料表的 Constraints Recipe
--
ALTER TABLE Recipe
  ADD CONSTRAINT Recipe_ibfk_1 FOREIGN KEY (Product_id) REFERENCES Product (id),
  ADD CONSTRAINT Recipe_ibfk_2 FOREIGN KEY (Material_id) REFERENCES Material (id);

--
-- 資料表的 Constraints Request
--
ALTER TABLE Request
  ADD CONSTRAINT Request_ibfk_1 FOREIGN KEY (Customer_id) REFERENCES Customer (id),
  ADD CONSTRAINT Request_ibfk_2 FOREIGN KEY (Product_id) REFERENCES Product (id);

--
-- 資料表的 Constraints Restock
--
ALTER TABLE Restock
  ADD CONSTRAINT Restock_ibfk_1 FOREIGN KEY (Material_id) REFERENCES Material (id);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
