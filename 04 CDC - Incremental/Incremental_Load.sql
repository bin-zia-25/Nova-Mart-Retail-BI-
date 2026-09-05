Create Table ETL.ETL_Check
(
	Id int Identity(1,1) Primary Key,
	TableName Varchar(100),
	LastLoadDate DateTime2
)
-------------------------------------
-- Insertion
INSERT INTO ETL.ETL_Check (TableName, LastLoadDate) values
('Customers', '1900-01-01 00:00:00'),
('Products', '1900-01-01 00:00:00'),
('Categories', '1900-01-01 00:00:00'),
('Stores', '1900-01-01 00:00:00'),
('Orders', '1900-01-01 00:00:00'),
('OrderDetails', '1900-01-01 00:00:00'),
('Employees', '1900-01-01 00:00:00');


