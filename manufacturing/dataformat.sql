-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- 主機: localhost
-- 產生時間： 2019 年 04 月 10 日 07:59
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
-- 資料庫： `302CEM`
--

-- --------------------------------------------------------

--
-- 資料表結構 `Consumption`
--

CREATE TABLE IF NOT EXISTS `Consumption` (
  `Production_id` int(11) NOT NULL,
  `Material_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `create_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 `Consumption`
--

INSERT IGNORE INTO `Consumption` (`Production_id`, `Material_id`, `qty`, `create_timestamp`) VALUES
(8, 1, 10000, '2019-04-10 04:14:24'),
(9, 1, 10000, '2019-04-10 04:14:44');

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `Consumption_View`
-- (請參考以下實際畫面)
--
CREATE TABLE IF NOT EXISTS `Consumption_View` (
`Material_id` int(11)
,`qty` decimal(32,0)
);

-- --------------------------------------------------------

--
-- 資料表結構 `Customer`
--

CREATE TABLE IF NOT EXISTS `Customer` (
  `id` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address1` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'name@email.com',
  `contact` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT '98765432'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 `Customer`
--

INSERT IGNORE INTO `Customer` (`id`, `name`, `address1`, `address2`, `address3`, `email`, `contact`) VALUES
('', 'DUMMY', 'DUMMY Building, -1 DUMMY Street', 'DUMMY District ', 'DUMMY', 'name@email.com', '98765432'),
('000000000001', 'Web Store 1', 'NO.45, WO HING TSUEN,NO. 45, WO HING TSUEN', 'NORTH', 'NT', 'name@email.com', '98765432'),
('000000000002', 'Web Store 2', 'BLOCK A23,EUROPA GARDEN,NO. 48,KWU TUNG ROAD', 'NORTH', 'NT', 'name@email.com', '98765432'),
('000000000003', 'Web Store 3', '338, FAN KAM ROAD, The Green , Maple Drive F2', 'NORTH', 'NT', 'name@email.com', '98765432');

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `Inventory`
-- (請參考以下實際畫面)
--
CREATE TABLE IF NOT EXISTS `Inventory` (
`Material_id` int(11)
,`qty` decimal(55,0)
);

-- --------------------------------------------------------

--
-- 資料表結構 `Logistics`
--

CREATE TABLE IF NOT EXISTS `Logistics` (
  `id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address1` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO Logistics (id, `name`, address1, address2, address3) VALUES
(-1, 'DUMMY Logistics Company', 'DUMMY Address', NULL, NULL),
(1, 'Logistics Company 1', 'Logistics Company 1 Address', NULL, NULL),
(2, 'Logistics Company 2', 'Logistics Company 2 Company', NULL, NULL),
(3, 'Logistics Company 3', 'Logistics Company 3 Address', NULL, NULL);
-- --------------------------------------------------------

--
-- 資料表結構 `Logistics_Request`
--

CREATE TABLE IF NOT EXISTS `Logistics_Request` (
  `id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `weight` float NOT NULL,
  `Customer_id` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 `Logistics_Request`
--

INSERT IGNORE INTO `Logistics_Request` (`id`, `quantity`, `weight`, `Customer_id`) VALUES
(1, 10, 100, '000000000002');

-- --------------------------------------------------------

--
-- 資料表結構 `Logistics_Request_Request`
--

CREATE TABLE IF NOT EXISTS `Logistics_Request_Request` (
  `Logistics_Request_id` int(11) NOT NULL,
  `Request_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `Logistics_Request_View`
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
-- 資料表結構 `Material`
--

CREATE TABLE IF NOT EXISTS `Material` (
  `id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 `Material`
--

INSERT IGNORE INTO `Material` (`id`, `name`) VALUES
(1, 'Test Material');

-- --------------------------------------------------------

--
-- 資料表結構 `Product`
--

CREATE TABLE IF NOT EXISTS `Product` (
  `id` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `weight` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 `Product`
--

INSERT IGNORE INTO `Product` (`id`, `name`, `description`, `weight`) VALUES
('', 'DUMMY', 'Dummy to occupy the empty string ID', 0),
('000000000001', 'Custom Product 1', 'Test Product', 1),
('000000000002', 'Custom Product 2', 'Test Product 2', 2),
('000000000003', 'Custom Product 3', 'Test Product 3', 3);

-- --------------------------------------------------------

--
-- 資料表結構 `Production`
--

CREATE TABLE IF NOT EXISTS `Production` (
  `id` int(11) NOT NULL,
  `Product_id` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qty` int(11) NOT NULL,
  `create_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Request_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 `Production`
--

INSERT IGNORE INTO `Production` (`id`, `Product_id`, `qty`, `create_timestamp`, `Request_id`) VALUES
(4, '10', 10, '2019-04-10 04:11:02', 5),
(8, '10', 10, '2019-04-10 04:14:24', 9),
(9, '10', 10, '2019-04-10 04:14:44', 10);

-- --------------------------------------------------------

--
-- 資料表結構 `Recipe`
--

CREATE TABLE IF NOT EXISTS `Recipe` (
  `Product_id` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Material_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 `Recipe`
--

INSERT IGNORE INTO `Recipe` (`Product_id`, `Material_id`, `qty`) VALUES
('10', 1, 1000);

-- --------------------------------------------------------

--
-- 資料表結構 `Request`
--

CREATE TABLE IF NOT EXISTS `Request` (
  `id` int(11) NOT NULL,
  `Customer_id` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Manufacturer_id` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Product_id` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qty` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `due_date` date NOT NULL,
  `Invoice_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 `Request`
--

INSERT IGNORE INTO `Request` (`id`, `Customer_id`, `Manufacturer_id`, `Product_id`, `qty`, `order_date`, `due_date`, `Invoice_id`) VALUES
(3, '000000000002', '012', '10', 10, '0000-00-00', '0000-00-00', 413),
(4, '000000000002', '012', '10', 10, '0000-00-00', '0000-00-00', 413),
(5, '000000000002', '012', '10', 10, '0000-00-00', '0000-00-00', 413),
(6, '000000000002', '012', '10', 10, '0000-00-00', '0000-00-00', 413),
(7, '000000000002', '012', '10', 10, '0000-00-00', '0000-00-00', 413),
(8, '000000000002', '012', '10', 10, '0000-00-00', '0000-00-00', 413),
(9, '000000000002', '012', '10', 10, '0000-00-00', '0000-00-00', 413),
(10, '000000000002', '012', '10', 10, '0000-00-00', '0000-00-00', 413);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `Request_View`
-- (請參考以下實際畫面)
--
CREATE TABLE IF NOT EXISTS `Request_View` (
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
-- 資料表結構 `Restock`
--

CREATE TABLE IF NOT EXISTS `Restock` (
  `id` int(11) NOT NULL,
  `Material_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `create_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `Restock_View`
-- (請參考以下實際畫面)
--
CREATE TABLE IF NOT EXISTS `Restock_View` (
`Material_id` int(11)
,`qty` decimal(32,0)
);

-- --------------------------------------------------------

--
-- 檢視表結構 `Consumption_View`
--
DROP TABLE IF EXISTS `Consumption_View`;

CREATE ALGORITHM=UNDEFINED DEFINER=`302CEM`@`localhost` SQL SECURITY DEFINER VIEW `Consumption_View`  AS  select `Consumption`.`Material_id` AS `Material_id`,sum(`Consumption`.`qty`) AS `qty` from `Consumption` ;

-- --------------------------------------------------------

--
-- 檢視表結構 `Inventory`
--
DROP TABLE IF EXISTS `Inventory`;

CREATE ALGORITHM=UNDEFINED DEFINER=`302CEM`@`localhost` SQL SECURITY DEFINER VIEW `Inventory`  AS  select `m`.`id` AS `Material_id`,(coalesce(sum(`r`.`qty`),0) - coalesce(sum(`c`.`qty`),0)) AS `qty` from ((`Material` `m` left join `Restock_View` `r` on((`r`.`Material_id` = `m`.`id`))) left join `Consumption_View` `c` on((`c`.`Material_id` = `m`.`id`))) where (`r`.`Material_id` = `c`.`Material_id`) ;

-- --------------------------------------------------------

--
-- 檢視表結構 `Logistics_Request_View`
--
DROP TABLE IF EXISTS `Logistics_Request_View`;

CREATE ALGORITHM=UNDEFINED DEFINER=`302CEM`@`localhost` SQL SECURITY DEFINER VIEW `Logistics_Request_View`  AS  select `d`.`name` AS `shipper_name`,`d`.`email` AS `shipper_email`,`l`.`id` AS `id`,`l`.`quantity` AS `quantity`,`l`.`weight` AS `weight`,`l`.`Customer_id` AS `Customer_id`,`c`.`name` AS `receiver_name`,concat(`c`.`address1`,', ',`c`.`address2`,', ',`c`.`address3`) AS `receiver_address`,`c`.`contact` AS `receiver_contact` from ((`Logistics_Request` `l` join `Customer` `d` on((`d`.`id` = ''))) join `Customer` `c` on((`c`.`id` = `l`.`Customer_id`))) ;

-- --------------------------------------------------------

--
-- 檢視表結構 `Request_View`
--
DROP TABLE IF EXISTS `Request_View`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `Request_View`  AS  select `r`.`id` AS `Request_id`,`r`.`Invoice_id` AS `Invoice_id`,`lrr`.`Logistics_Request_id` AS `Logistics_Request_id`,`lrv`.`shipper_name` AS `shipper_name`,`lrv`.`shipper_email` AS `shipper_email`,`lrv`.`id` AS `id`,`lrv`.`quantity` AS `quantity`,`lrv`.`weight` AS `weight`,`lrv`.`Customer_id` AS `Customer_id`,`lrv`.`receiver_name` AS `receiver_name`,`lrv`.`receiver_address` AS `receiver_address`,`lrv`.`receiver_contact` AS `receiver_contact` from ((`Request` `r` left join `Logistics_Request_Request` `lrr` on((`lrr`.`Request_id` = `r`.`id`))) left join `Logistics_Request_View` `lrv` on((`lrv`.`id` = `lrr`.`Logistics_Request_id`))) ;

-- --------------------------------------------------------

--
-- 檢視表結構 `Restock_View`
--
DROP TABLE IF EXISTS `Restock_View`;

CREATE ALGORITHM=UNDEFINED DEFINER=`302CEM`@`localhost` SQL SECURITY DEFINER VIEW `Restock_View`  AS  select `Restock`.`Material_id` AS `Material_id`,sum(`Restock`.`qty`) AS `qty` from `Restock` ;

--
-- 已匯出資料表的索引
--

--
-- 資料表索引 `Consumption`
--
ALTER TABLE `Consumption`
  ADD PRIMARY KEY (`Production_id`,`Material_id`),
  ADD KEY `Material_id` (`Material_id`);

--
-- 資料表索引 `Customer`
--
ALTER TABLE `Customer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- 資料表索引 `Logistics`
--
ALTER TABLE `Logistics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- 資料表索引 `Logistics_Request`
--
ALTER TABLE `Logistics_Request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Customer_id` (`Customer_id`);

--
-- 資料表索引 `Logistics_Request_Request`
--
ALTER TABLE `Logistics_Request_Request`
  ADD PRIMARY KEY (`Logistics_Request_id`,`Request_id`),
  ADD KEY `Request_id` (`Request_id`);

--
-- 資料表索引 `Material`
--
ALTER TABLE `Material`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `Product`
--
ALTER TABLE `Product`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `Production`
--
ALTER TABLE `Production`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Product_id` (`Product_id`),
  ADD KEY `Request_id` (`Request_id`);

--
-- 資料表索引 `Recipe`
--
ALTER TABLE `Recipe`
  ADD PRIMARY KEY (`Product_id`,`Material_id`),
  ADD KEY `Material_id` (`Material_id`);

--
-- 資料表索引 `Request`
--
ALTER TABLE `Request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Customer_id` (`Customer_id`),
  ADD KEY `Product_id` (`Product_id`);

--
-- 資料表索引 `Restock`
--
ALTER TABLE `Restock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Material_id` (`Material_id`);

--
-- 在匯出的資料表使用 AUTO_INCREMENT
--

--
-- 使用資料表 AUTO_INCREMENT `Logistics`
--
ALTER TABLE `Logistics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表 AUTO_INCREMENT `Logistics_Request`
--
ALTER TABLE `Logistics_Request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用資料表 AUTO_INCREMENT `Material`
--
ALTER TABLE `Material`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用資料表 AUTO_INCREMENT `Production`
--
ALTER TABLE `Production`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- 使用資料表 AUTO_INCREMENT `Request`
--
ALTER TABLE `Request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- 使用資料表 AUTO_INCREMENT `Restock`
--
ALTER TABLE `Restock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 已匯出資料表的限制(Constraint)
--

--
-- 資料表的 Constraints `Consumption`
--
ALTER TABLE `Consumption`
  ADD CONSTRAINT `Consumption_ibfk_1` FOREIGN KEY (`Production_id`) REFERENCES `Production` (`id`),
  ADD CONSTRAINT `Consumption_ibfk_2` FOREIGN KEY (`Material_id`) REFERENCES `Material` (`id`);

--
-- 資料表的 Constraints `Logistics_Request`
--
ALTER TABLE `Logistics_Request`
  ADD CONSTRAINT `Logistics_Request_ibfk_1` FOREIGN KEY (`Customer_id`) REFERENCES `Customer` (`id`);

--
-- 資料表的 Constraints `Logistics_Request_Request`
--
ALTER TABLE `Logistics_Request_Request`
  ADD CONSTRAINT `Logistics_Request_Request_ibfk_1` FOREIGN KEY (`Logistics_Request_id`) REFERENCES `Logistics_Request` (`id`),
  ADD CONSTRAINT `Logistics_Request_Request_ibfk_2` FOREIGN KEY (`Request_id`) REFERENCES `Request` (`id`);

--
-- 資料表的 Constraints `Production`
--
ALTER TABLE `Production`
  ADD CONSTRAINT `Production_ibfk_1` FOREIGN KEY (`Product_id`) REFERENCES `Product` (`id`),
  ADD CONSTRAINT `Production_ibfk_2` FOREIGN KEY (`Request_id`) REFERENCES `Request` (`id`);

--
-- 資料表的 Constraints `Recipe`
--
ALTER TABLE `Recipe`
  ADD CONSTRAINT `Recipe_ibfk_1` FOREIGN KEY (`Product_id`) REFERENCES `Product` (`id`),
  ADD CONSTRAINT `Recipe_ibfk_2` FOREIGN KEY (`Material_id`) REFERENCES `Material` (`id`);

--
-- 資料表的 Constraints `Request`
--
ALTER TABLE `Request`
  ADD CONSTRAINT `Request_ibfk_1` FOREIGN KEY (`Customer_id`) REFERENCES `Customer` (`id`),
  ADD CONSTRAINT `Request_ibfk_2` FOREIGN KEY (`Product_id`) REFERENCES `Product` (`id`);

--
-- 資料表的 Constraints `Restock`
--
ALTER TABLE `Restock`
  ADD CONSTRAINT `Restock_ibfk_1` FOREIGN KEY (`Material_id`) REFERENCES `Material` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
