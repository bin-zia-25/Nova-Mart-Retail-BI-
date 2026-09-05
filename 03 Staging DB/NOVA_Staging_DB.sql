Create Database Nova_Retail_Staging_DB
-- We Never apply Constraints and Checks in StagingDB, Because we let invalud or Suspicious data to in for analysis.
-- And we apply checks etc only on DB_Source not on Excel and other Source, So Duplicate IDs etc might be in from different sources possibly.

Create Schema Stg

-- Customers
CREATE TABLE Stg.Customers(
    CustomerID varchar(50) ,
    CustomerName varchar(100),
    Email varchar(150),
    Phone varchar(50),
    Gender varchar(50),
    City varchar(50),
    Country varchar(50),
    CustomerType varchar(20),
    CreatedDate datetime2 ,
    ModifiedDate datetime2 
);

-- Categories
CREATE TABLE Stg.Categories(
    CategoryID varchar(50),
    CategoryName varchar(50) 
);

-- Products
Drop table Stg.Products
Select * From Stg.Products
CREATE TABLE Stg.Products(
    ProductID varchar(50),
    ProductName varchar(100),
    CategoryID varchar(50),
    UnitCost decimal(18,2) ,
    UnitPrice decimal(18,2) ,
    StockQuantity int,
    ProductStatus varchar(20),
    CreatedDate datetime2,
    ModifiedDate datetime2
);

-- Rejects table for invalid / no-match products
Select * from Stg.ProductRejects
Drop Table Stg.ProductRejects
CREATE TABLE Stg.ProductRejects (
    ProductID VARCHAR(50),
    ProductName VARCHAR(100),
    CategoryID varchar(50),
    UnitCost DECIMAL(18,2),
    UnitPrice DECIMAL(18,2),
    StockQuantity INT,
    ProductStatus VARCHAR(20),
    RejectReason NVARCHAR(200),
    RejectDate DATETIME DEFAULT GETDATE()
);
---------------------------------------------------------



-- Stores
CREATE TABLE Stg.Stores(
    StoreID varchar(50) ,
    StoreName varchar(100),
    City varchar(50),
    Country varchar(50),
    Region varchar(50),
    StoreType varchar(20),
    OpeningDate date
);

-- Employees
CREATE TABLE Stg.Employees(
    EmployeeID varchar(50),
    EmployeeName varchar(100),
    Department varchar(50),
    JobTitle varchar(20),
    StoreID varchar(50),
    HireDate datetime2
);

-- Orders
Select * from Stg.Orders
CREATE TABLE Stg.Orders(
    OrderID varchar(50) ,
    CustomerID varchar(50) ,
    EmployeeID varchar(50),
    StoreID varchar(50),
    OrderDate datetime2 ,
    OrderStatus varchar(20),
    SalesChannel varchar(30),
    ModifiedDate datetime2 
);
-----------------------------------------------
-- RejectOrders
CREATE TABLE Stg.OrdersReject(
    OrderID varchar(50) ,
    CustomerID varchar(50) ,
    EmployeeID varchar(50),
    StoreID varchar(50),
    OrderDate datetime2 ,
    OrderStatus varchar(20),
    SalesChannel varchar(30),
    RejectReason NVARCHAR(200),
    RejectDate DATETIME DEFAULT GETDATE()
);



-- Order Details
CREATE TABLE Stg.OrderDetails(
    OrderDetailID varchar(100),
    OrderID varchar(50),
    ProductID varchar(50),
    Quantity int,
    UnitPrice decimal(18,2),
    Discount decimal(5,2)
);
------------------------------------------
-- Rejected
CREATE TABLE Stg.RejectedOrderDetails(
    OrderDetailID varchar(100),
    OrderID varchar(50),
    ProductID varchar(50),
    Quantity int,
    UnitPrice decimal(18,2),
    Discount decimal(5,2),
    RejectReason NVARCHAR(200),
    RejectDate DATETIME DEFAULT GETDATE()
);