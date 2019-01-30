# vim: ft=mysql

CREATE TABLE Product (
	id VARCHAR(12) PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	description VARCHAR(255) NOT NULL,
	weight FLOAT NOT NULL
);

CREATE TABLE Customer (
	id VARCHAR(12) PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255) UNIQUE NOT NULL,
	address1 VARCHAR(255) NOT NULL,
	address2 VARCHAR(255),
	address3 VARCHAR(255)
);

CREATE TABLE Request (
	id INT PRIMARY KEY AUTO_INCREMENT,
	Customer_id VARCHAR(12) NOT NULL,
	Manufacturer_id VARCHAR(12), -- dummy for manufacturer side
	Product_id VARCHAR(12) NOT NULL,
	qty INT NOT NULL,
	order_date DATE NOT NULL,
	due_date DATE NOT NULL,
	FOREIGN KEY (Customer_id)
		REFERENCES Customer (id),
	FOREIGN KEY (Product_id)
		REFERENCES Product (id)
);



		
