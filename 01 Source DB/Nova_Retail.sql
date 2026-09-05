Create Database Nova_Retail_DB_1
-- Customers
CREATE TABLE Customers(
    CustomerID varchar(50) PRIMARY KEY,
    CustomerName varchar(100) NOT NULL,
    Email varchar(150),
    Phone varchar(50),
    Gender varchar(50),
    City varchar(50),
    Country varchar(50),
    CustomerType varchar(20),
    CreatedDate datetime2 NOT NULL,
    ModifiedDate datetime2 NOT NULL
);
-- Categories
Drop Table Categories
Select * From Categories
Truncate Table Categories
CREATE TABLE Categories(
    CategoryID varchar(50) PRIMARY KEY,
    CategoryName varchar(50) NOT NULL
);
-- Products
Select * From Products
Drop Table Products
CREATE TABLE Products(
    ProductID varchar(50) PRIMARY KEY,
    ProductName varchar(100) NOT NULL,
    CategoryID varchar(50) NOT NULL,
    UnitCost decimal(18,2) NOT NULL,
    UnitPrice decimal(18,2) NOT NULL,
    StockQuantity int NOT NULL,
    ProductStatus varchar(20) NOT NULL,
    CreatedDate datetime2 NOT NULL,
    ModifiedDate datetime2 NOT NULL,

    CONSTRAINT FK_Products_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID),

    CONSTRAINT CK_Products_Price
        CHECK (UnitCost >= 0 AND UnitPrice >= 0),

    CONSTRAINT CK_Products_StockQuantity
        CHECK (StockQuantity >= 0)
);
-- Stores
CREATE TABLE Stores(
    StoreID varchar(50) PRIMARY KEY,
    StoreName varchar(100) NOT NULL,
    City varchar(50),
    Country varchar(50),
    Region varchar(50),
    StoreType varchar(20),
    OpeningDate date
);
-- Employees
Select * From Employees
Drop Table Employees
CREATE TABLE Employees(
    EmployeeID varchar(50) PRIMARY KEY,
    EmployeeName varchar(100) NOT NULL,
    Department varchar(50),
    JobTitle varchar(20),
    StoreID varchar(50),
    HireDate datetime2,

    CONSTRAINT FK_Employees_Stores
        FOREIGN KEY (StoreID)
        REFERENCES Stores(StoreID)
);
-- Orders
CREATE TABLE Orders(
    OrderID varchar(50) PRIMARY KEY,
    CustomerID varchar(50) NOT NULL,
    EmployeeID varchar(50),
    StoreID varchar(50),
    OrderDate datetime2 NOT NULL,
    OrderStatus varchar(20) NOT NULL,
    SalesChannel varchar(30) NOT NULL,
    ModifiedDate datetime2 NOT NULL,

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),

    CONSTRAINT FK_Orders_Employees
        FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID),

    CONSTRAINT FK_Orders_Stores
        FOREIGN KEY (StoreID)
        REFERENCES Stores(StoreID)
);
CREATE TABLE OrderDetails(
    OrderDetailID varchar(100) PRIMARY KEY,
    OrderID varchar(50) NOT NULL,
    ProductID varchar(50) NOT NULL,
    Quantity int NOT NULL,
    UnitPrice decimal(18,2) NOT NULL,
    Discount decimal(5,2) NOT NULL,

    CONSTRAINT FK_OrderDetails_Orders
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderDetails_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID),

    CONSTRAINT CK_OrderDetails_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT CK_OrderDetails_UnitPrice
        CHECK (UnitPrice >= 0),

    CONSTRAINT CK_OrderDetails_Discount
        CHECK (Discount >= 0 AND Discount <= 100)
);
