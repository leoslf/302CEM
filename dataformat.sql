# vim: ft=mysql

CREATE TABLE Product (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	description VARCHAR(255) NOT NULL,
	weight FLOAT NOT NULL
);

CREATE TABLE Customer (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255) UNIQUE NOT NULL,
	address1 VARCHAR(255) NOT NULL,
	address2 VARCHAR(255) NOT NULL,
	address3 VARCHAR(255) NOT NULL
);

CREATE TABLE Request (
	id INT PRIMARY KEY AUTO_INCREMENT,
	Customer_id INT NOT NULL,
	Manufacturer_id INT, -- dummy for manufacturer side
	Product_id INT NOT NULL,
	qty INT NOT NULL,
	order_date DATE NOT NULL,
	due_date DATE NOT NULL,
	FOREIGN KEY (Customer_id)
		REFERENCES Customer (id),
	FOREIGN KEY (Product_id)
		REFERENCES Product (id),
	CHECK (order_date < due_date)
);



		
