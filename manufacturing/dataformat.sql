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
-- 資料庫： 302CEM
--



-- --------------------------------------------------------

--
-- 資料表結構 Customer
--

CREATE TABLE IF NOT EXISTS Customer (
	id varchar(12) PRIMARY KEY NOT NULL,
	name varchar(32) UNIQUE NOT NULL,
	address1 varchar(255) NOT NULL,
	address2 varchar(255) DEFAULT NULL,
	address3 varchar(255) DEFAULT NULL,
	email varchar(255) DEFAULT 'name@email.com',
	contact varchar(8) DEFAULT '98765432'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 Customer
--

INSERT IGNORE INTO Customer (id, name, address1, address2, address3, email, contact) VALUES
('', 'DUMMY', 'DUMMY Building, -1 DUMMY Street', 'DUMMY District ', 'DUMMY', 'name@email.com', '98765432'),
('000000000001', 'Web Store 1', 'NO.45, WO HING TSUEN,NO. 45, WO HING TSUEN', 'NORTH', 'NT', 'name@email.com', '98765432'),
('000000000002', 'Web Store 2', 'BLOCK A23,EUROPA GARDEN,NO. 48,KWU TUNG ROAD', 'NORTH', 'NT', 'name@email.com', '98765432'),
('000000000003', 'Web Store 3', '338, FAN KAM ROAD, The Green , Maple Drive F2', 'NORTH', 'NT', 'name@email.com', '98765432');

-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- 資料表結構 Logistics
--

CREATE TABLE IF NOT EXISTS Logistics (
	id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name varchar(64) UNIQUE NOT NULL,
	address1 varchar(255) NOT NULL,
	address2 varchar(255) DEFAULT NULL,
	address3 varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT IGNORE INTO Logistics (id, name, address1, address2, address3) VALUES
(-1, 'DUMMY Logistics Company', 'DUMMY Address', NULL, NULL),
(1, 'Logistics Company 1', 'Logistics Company 1 Address', NULL, NULL),
(2, 'Logistics Company 2', 'Logistics Company 2 Company', NULL, NULL),
(3, 'Logistics Company 3', 'Logistics Company 3 Address', NULL, NULL);
-- --------------------------------------------------------

--
-- 資料表結構 Logistics_Request
--

CREATE TABLE IF NOT EXISTS Logistics_Request (
	id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	quantity int(11) NOT NULL,
	weight float NOT NULL,
	Customer_id varchar(12) NOT NULL,
	FOREIGN KEY (Customer_id) REFERENCES Customer (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 Product
--

CREATE TABLE IF NOT EXISTS Product (
	id varchar(12) PRIMARY KEY NOT NULL,
	name varchar(255) NOT NULL,
	description varchar(255) NOT NULL,
	weight float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 Product
--

INSERT IGNORE INTO Product (id, name, description, weight) VALUES
('', 'DUMMY', 'Dummy to occupy the empty string ID', 0),
('000000000001', 'Custom Product 1', 'Test Product', 1),
('000000000002', 'Custom Product 2', 'Test Product 2', 2),
('000000000003', 'Custom Product 3', 'Test Product 3', 3);


-- --------------------------------------------------------

--
-- 資料表結構 Request
--

CREATE TABLE IF NOT EXISTS Request (
	id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Customer_id varchar(12) NOT NULL,
	Manufacturer_id varchar(12) DEFAULT NULL,
	Product_id varchar(12) NOT NULL,
	qty int(11) NOT NULL,
	order_date date NOT NULL,
	due_date date NOT NULL,
	Invoice_id int(11) NOT NULL,
	FOREIGN KEY (Customer_id) REFERENCES Customer (id),
	FOREIGN KEY (Product_id) REFERENCES Product (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 Request
--

INSERT IGNORE INTO Request (id, Customer_id, Manufacturer_id, Product_id, qty, order_date, due_date, Invoice_id) VALUES
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
-- 資料表結構 Logistics_Request_Request
--

CREATE TABLE IF NOT EXISTS Logistics_Request_Request (
	Logistics_Request_id int(11) NOT NULL,
	Request_id int(11) NOT NULL,
	PRIMARY KEY (Logistics_Request_id, Request_id),
	FOREIGN KEY (Logistics_Request_id) REFERENCES Logistics_Request (id),
	FOREIGN KEY (Request_id) REFERENCES Request (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- 資料表結構 Material
--

CREATE TABLE IF NOT EXISTS Material (
	id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 Material
--

INSERT IGNORE INTO Material (id, name) VALUES
(1, 'Test Material');

-- --------------------------------------------------------

--
-- 資料表結構 Production
--

CREATE TABLE IF NOT EXISTS Production (
	id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Product_id varchar(12) NOT NULL,
	qty int(11) NOT NULL,
	create_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	Request_id int(11) NOT NULL,
	FOREIGN KEY (Product_id) REFERENCES Product (id),
	FOREIGN KEY (Request_id) REFERENCES Request (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 Consumption
--

CREATE TABLE IF NOT EXISTS Consumption (
	Production_id int(11) NOT NULL,
	Material_id int(11) NOT NULL,
	qty int(11) NOT NULL,
	create_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (Production_id, Material_id),
	FOREIGN KEY (Production_id) REFERENCES Production (id),
	FOREIGN KEY (Material_id) REFERENCES Material (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 Recipe
--

CREATE TABLE IF NOT EXISTS Recipe (
	Product_id varchar(12) NOT NULL,
	Material_id int(11) NOT NULL,
	qty int(11) NOT NULL,
	PRIMARY KEY (Product_id,Material_id),
	FOREIGN KEY (Product_id) REFERENCES Product (id),
	FOREIGN KEY (Material_id) REFERENCES Material (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 Recipe
--

INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES
('10', 1, 1000);

-- --------------------------------------------------------


-- --------------------------------------------------------

--
-- 資料表結構 Restock
--

CREATE TABLE IF NOT EXISTS Restock (
	id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Material_id int(11) NOT NULL,
	qty int(11) NOT NULL,
	create_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (Material_id) REFERENCES Material (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------

--
-- 檢視表結構 Consumption_View
--
CREATE OR REPLACE VIEW Consumption_View  AS  select Consumption.Material_id AS Material_id, sum(Consumption.qty) AS qty from Consumption GROUP BY Consumption.Material_id;

-- --------------------------------------------------------

--
-- 檢視表結構 Restock_View
--
CREATE OR REPLACE VIEW Restock_View  AS  select Restock.Material_id AS Material_id, sum(Restock.qty) AS qty from Restock GROUP BY Restock.Material_id;

-- --------------------------------------------------------

--
-- 檢視表結構 Inventory
--


CREATE OR REPLACE VIEW Inventory AS
SELECT
    m.*,
    COALESCE(SUM(IF(m.id = r.Material_id, r.qty, 0)) - SUM(IF(m.id = c.Material_id, c.qty, 0)), 0) AS qty
FROM
    Material m
LEFT JOIN Restock_View r ON
    r.Material_id = m.id
LEFT JOIN Consumption_View c ON
    c.Material_id = m.id
GROUP BY m.id;
-- --------------------------------------------------------

--
-- 檢視表結構 Logistics_Request_View
--

CREATE OR REPLACE VIEW Logistics_Request_View  AS  select d.name AS shipper_name,d.email AS shipper_email,l.id AS id,l.quantity AS quantity,l.weight AS weight,l.Customer_id AS Customer_id,c.name AS receiver_name, CONCAT_WS(', ', c.address1, c.address2, c.address3) AS receiver_address,c.contact AS receiver_contact from ((Logistics_Request l join Customer d on((d.id = ''))) join Customer c on((c.id = l.Customer_id))) ;

-- --------------------------------------------------------

--
-- 檢視表結構 Request_View
--
CREATE OR REPLACE VIEW Request_View AS
SELECT
    r.id AS Request_id,
    r.Invoice_id AS Invoice_id,
    lrr.Logistics_Request_id AS Logistics_Request_id,
    lrv.shipper_name AS shipper_name,
    lrv.shipper_email AS shipper_email,
    lrv.id AS id,
    lrv.quantity AS quantity,
    lrv.weight AS weight,
    lrv.Customer_id AS Customer_id,
    lrv.receiver_name AS receiver_name,
    lrv.receiver_address AS receiver_address,
    lrv.receiver_contact AS receiver_contact
FROM
    Request r
LEFT JOIN
    Logistics_Request_Request lrr
ON
    lrr.Request_id = r.id
LEFT JOIN
    Logistics_Request_View lrv
ON
    lrv.id = lrr.Logistics_Request_id;
-- --------------------------------------------------------





COMMIT;

START TRANSACTION;

INSERT IGNORE INTO Customer (id, `name`, address1, address2, address3, email, contact) VALUES('', 'DUMMY', 'DUMMY Building, -1 DUMMY Street', 'DUMMY District ', 'DUMMY', 'name@email.com', '98765432');
INSERT IGNORE INTO Customer (id, `name`, address1, address2, address3, email, contact) VALUES('000000000001', 'Web Store 1', 'NO.45, WO HING TSUEN,NO. 45, WO HING TSUEN', 'NORTH', 'NT', 'name@email.com', '98765432');
INSERT IGNORE INTO Customer (id, `name`, address1, address2, address3, email, contact) VALUES('000000000002', 'Web Store 2', 'BLOCK A23,EUROPA GARDEN,NO. 48,KWU TUNG ROAD', 'NORTH', 'NT', 'name@email.com', '98765432');
INSERT IGNORE INTO Customer (id, `name`, address1, address2, address3, email, contact) VALUES('000000000003', 'Web Store 3', '338, FAN KAM ROAD, The Green , Maple Drive F2', 'NORTH', 'NT', 'name@email.com', '98765432');
INSERT IGNORE INTO Logistics (id, `name`, address1, address2, address3) VALUES(-1, 'DUMMY Logistics Company', 'DUMMY Address', NULL, NULL);
INSERT IGNORE INTO Logistics (id, `name`, address1, address2, address3) VALUES(1, 'Logistics Company 1', 'Logistics Company 1 Address', NULL, NULL);
INSERT IGNORE INTO Logistics (id, `name`, address1, address2, address3) VALUES(2, 'Logistics Company 2', 'Logistics Company 2 Company', NULL, NULL);
INSERT IGNORE INTO Logistics (id, `name`, address1, address2, address3) VALUES(3, 'Logistics Company 3', 'Logistics Company 3 Address', NULL, NULL);
INSERT IGNORE INTO Material (id, `name`) VALUES(1, 'Test Material');
INSERT IGNORE INTO Material (id, `name`) VALUES(2, 'Test Material 2');
INSERT IGNORE INTO Material (id, `name`) VALUES(3, 'Test Material 3');
INSERT IGNORE INTO Material (id, `name`) VALUES(4, 'Test Material 4');
INSERT IGNORE INTO Material (id, `name`) VALUES(5, 'Test Material 5');
INSERT IGNORE INTO Material (id, `name`) VALUES(6, 'Test Material 6');
INSERT IGNORE INTO Material (id, `name`) VALUES(7, 'Test Material 7');
INSERT IGNORE INTO Material (id, `name`) VALUES(8, 'Test Material 8');
INSERT IGNORE INTO Material (id, `name`) VALUES(9, 'Test Material 9');
INSERT IGNORE INTO Material (id, `name`) VALUES(10, 'Test Material 10');
INSERT IGNORE INTO Product (id, `name`, description, weight) VALUES('', 'DUMMY', 'Dummy to occupy the empty string ID', 0);
INSERT IGNORE INTO Product (id, `name`, description, weight) VALUES('000000000001', 'Custom Product 1', 'Test Product', 1);
INSERT IGNORE INTO Product (id, `name`, description, weight) VALUES('000000000002', 'Custom Product 2', 'Test Product 2', 2);
INSERT IGNORE INTO Product (id, `name`, description, weight) VALUES('000000000003', 'Custom Product 3', 'Test Product 3', 3);
INSERT IGNORE INTO Product (id, `name`, description, weight) VALUES('000000000004', 'Custom Product 4', 'Test Product 4', 4.5);
INSERT IGNORE INTO Product (id, `name`, description, weight) VALUES('000000000005', 'Custom Product 5', 'Test Product 5', 5);
INSERT IGNORE INTO Product (id, `name`, description, weight) VALUES('000000000006', 'Custom Product 6', 'Test Product 6', 6.5);
INSERT IGNORE INTO Product (id, `name`, description, weight) VALUES('000000000007', 'Custom Product 7', 'Test Product 7', 7);
INSERT IGNORE INTO Product (id, `name`, description, weight) VALUES('000000000008', 'Custom Product 8', 'Test Product 8', 8.5);
INSERT IGNORE INTO Product (id, `name`, description, weight) VALUES('000000000009', 'Custom Product 9', 'Test Product 9', 9);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000001', 1, 7);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000001', 4, 10);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000001', 5, 7);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000001', 7, 9);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000001', 8, 5);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000001', 9, 1);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000001', 10, 10);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000002', 3, 1);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000002', 4, 4);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000002', 6, 1);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000002', 9, 1);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000003', 2, 2);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000003', 3, 2);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000003', 4, 3);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000003', 5, 10);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000003', 6, 2);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000003', 7, 11);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000003', 8, 4);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000003', 9, 1);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000003', 10, 3);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000004', 2, 3);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000004', 4, 9);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000004', 5, 4);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000004', 7, 11);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000004', 9, 5);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000004', 10, 9);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000005', 1, 3);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000005', 4, 5);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000005', 5, 8);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000005', 6, 5);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000005', 7, 4);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000005', 8, 6);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000005', 9, 8);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000005', 10, 3);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000006', 1, 8);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000006', 2, 8);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000006', 3, 1);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000006', 7, 8);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000007', 1, 4);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000007', 2, 7);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000007', 3, 2);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000007', 4, 11);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000007', 5, 2);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000007', 6, 7);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000007', 7, 2);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000007', 8, 8);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000007', 9, 4);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000007', 10, 7);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000008', 1, 5);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000008', 5, 6);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000008', 6, 1);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000009', 5, 7);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000009', 7, 10);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000009', 9, 7);
INSERT IGNORE INTO Recipe (Product_id, Material_id, qty) VALUES('000000000009', 10, 5);
INSERT IGNORE INTO Request (id, Customer_id, Manufacturer_id, Product_id, qty, order_date, due_date, Invoice_id) VALUES(3, '000000000002', '012', '10', 10, '0000-00-00', '0000-00-00', 413);
INSERT IGNORE INTO Request (id, Customer_id, Manufacturer_id, Product_id, qty, order_date, due_date, Invoice_id) VALUES(4, '000000000002', '012', '10', 10, '0000-00-00', '0000-00-00', 413);
INSERT IGNORE INTO Request (id, Customer_id, Manufacturer_id, Product_id, qty, order_date, due_date, Invoice_id) VALUES(5, '000000000002', '012', '10', 10, '0000-00-00', '0000-00-00', 413);
INSERT IGNORE INTO Request (id, Customer_id, Manufacturer_id, Product_id, qty, order_date, due_date, Invoice_id) VALUES(6, '000000000002', '012', '10', 10, '0000-00-00', '0000-00-00', 413);
INSERT IGNORE INTO Request (id, Customer_id, Manufacturer_id, Product_id, qty, order_date, due_date, Invoice_id) VALUES(7, '000000000002', '012', '10', 10, '0000-00-00', '0000-00-00', 413);
INSERT IGNORE INTO Request (id, Customer_id, Manufacturer_id, Product_id, qty, order_date, due_date, Invoice_id) VALUES(8, '000000000002', '012', '10', 10, '0000-00-00', '0000-00-00', 413);
INSERT IGNORE INTO Request (id, Customer_id, Manufacturer_id, Product_id, qty, order_date, due_date, Invoice_id) VALUES(9, '000000000002', '012', '10', 10, '0000-00-00', '0000-00-00', 413);
INSERT IGNORE INTO Request (id, Customer_id, Manufacturer_id, Product_id, qty, order_date, due_date, Invoice_id) VALUES(10, '000000000002', '012', '10', 10, '0000-00-00', '0000-00-00', 413);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
