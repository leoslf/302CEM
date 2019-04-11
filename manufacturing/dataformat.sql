-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- 主機: localhost
-- 產生時間： 2019 年 04 月 10 日 07:59
-- 伺服器版本: 10.1.36-MariaDB
-- PHP 版本： 7.3.4

--
-- 資料庫： 302CEM
--

-- --------------------------------------------------------

--
-- 資料表結構 Customer
--

CREATE OR REPLACE TABLE Customer (
	id varchar(12) PRIMARY KEY NOT NULL,
	name varchar(32) UNIQUE NOT NULL,
	address1 varchar(255) NOT NULL,
	address2 varchar(255) DEFAULT NULL,
	address3 varchar(255) DEFAULT NULL,
	email varchar(255) DEFAULT 'name@email.com',
	contact varchar(8) DEFAULT '98765432'
);


-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- 資料表結構 Logistics
--

CREATE OR REPLACE TABLE Logistics (
	id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name varchar(64) UNIQUE NOT NULL,
	address1 varchar(255) NOT NULL,
	address2 varchar(255) DEFAULT NULL,
	address3 varchar(255) DEFAULT NULL
);

-- --------------------------------------------------------

--
-- 資料表結構 Logistics_Request
--

CREATE OR REPLACE TABLE Logistics_Request (
	id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	quantity int(11) NOT NULL,
	weight float NOT NULL,
	Customer_id varchar(12) NOT NULL,
	FOREIGN KEY (Customer_id) REFERENCES Customer (id)
);

-- --------------------------------------------------------

--
-- 資料表結構 Product
--

CREATE OR REPLACE TABLE Product (
	id varchar(12) PRIMARY KEY NOT NULL,
	name varchar(255) NOT NULL,
	description varchar(255) NOT NULL,
	weight float NOT NULL
);

-- --------------------------------------------------------

--
-- 資料表結構 Request
--

CREATE OR REPLACE TABLE Request (
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
);

-- --------------------------------------------------------

--
-- 資料表結構 Logistics_Request_Request
--

CREATE OR REPLACE TABLE Logistics_Request_Request (
	Logistics_Request_id int(11) NOT NULL,
	Request_id int(11) NOT NULL,
	PRIMARY KEY (Logistics_Request_id, Request_id),
	FOREIGN KEY (Logistics_Request_id) REFERENCES Logistics_Request (id),
	FOREIGN KEY (Request_id) REFERENCES Request (id)
);

-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- 資料表結構 Material
--

CREATE OR REPLACE TABLE Material (
	id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name varchar(64) NOT NULL
);

--
-- 資料表的匯出資料 Material
--

-- --------------------------------------------------------

--
-- 資料表結構 Production
--

CREATE OR REPLACE TABLE Production (
	id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Product_id varchar(12) NOT NULL,
	qty int(11) NOT NULL,
	create_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	Request_id int(11) NOT NULL,
	FOREIGN KEY (Product_id) REFERENCES Product (id),
	FOREIGN KEY (Request_id) REFERENCES Request (id)
);

-- --------------------------------------------------------

--
-- 資料表結構 Consumption
--

CREATE OR REPLACE TABLE Consumption (
	Production_id int(11) NOT NULL,
	Material_id int(11) NOT NULL,
	qty int(11) NOT NULL,
	create_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (Production_id, Material_id),
	FOREIGN KEY (Production_id) REFERENCES Production (id),
	FOREIGN KEY (Material_id) REFERENCES Material (id)
);

-- --------------------------------------------------------

--
-- 資料表結構 Recipe
--

CREATE OR REPLACE TABLE Recipe (
	Product_id varchar(12) NOT NULL,
	Material_id int(11) NOT NULL,
	qty int(11) NOT NULL,
	PRIMARY KEY (Product_id,Material_id),
	FOREIGN KEY (Product_id) REFERENCES Product (id),
	FOREIGN KEY (Material_id) REFERENCES Material (id)
);

-- --------------------------------------------------------


-- --------------------------------------------------------

--
-- 資料表結構 Restock
--

CREATE OR REPLACE TABLE Restock (
	id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Material_id int(11) NOT NULL,
	qty int(11) NOT NULL,
	create_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (Material_id) REFERENCES Material (id)
);


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


