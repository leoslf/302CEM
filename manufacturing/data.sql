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

