Create Database Nova_Retail_DW
------------------------------
-- Schemas
CREATE SCHEMA Dim;
GO

CREATE SCHEMA Fact;
GO
------------------------------
-- DimCustomer
CREATE TABLE Dim.Customer
(
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    
    CustomerID VARCHAR(50) NOT NULL,
    CustomerName VARCHAR(100),
    Email VARCHAR(150),
    Phone VARCHAR(50),
    Gender VARCHAR(50),
    City VARCHAR(50),
    Country VARCHAR(50),
    CustomerType VARCHAR(20),
    
    CreatedDate DATETIME2,
    ModifiedDate DATETIME2,

    EffectiveStartDate DATETIME2 NOT NULL,
    EffectiveEndDate DATETIME2 NULL,
    IsCurrent BIT NOT NULL
);
-- DimProducts
CREATE TABLE Dim.Product
(
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,

    ProductID VARCHAR(50) NOT NULL,
    ProductName VARCHAR(100),
    
    CategoryID VARCHAR(50),
    CategoryName VARCHAR(50),

    UnitCost DECIMAL(18,2),
    UnitPrice DECIMAL(18,2),
    StockQuantity INT,
    ProductStatus VARCHAR(20),

    CreatedDate DATETIME2,
    ModifiedDate DATETIME2
);

-- DimStore
CREATE TABLE Dim.Store
(
    StoreKey INT IDENTITY(1,1) PRIMARY KEY,

    StoreID VARCHAR(50) NOT NULL,
    StoreName VARCHAR(100),
    City VARCHAR(50),
    Country VARCHAR(50),
    Region VARCHAR(50),
    StoreType VARCHAR(20),
    OpeningDate DATE,

    EffectiveStartDate DATETIME2 NOT NULL,
    EffectiveEndDate DATETIME2 NULL,
    IsCurrent BIT NOT NULL
);

-- DimEmployee
CREATE TABLE Dim.Employee
(
    EmployeeKey INT IDENTITY(1,1) PRIMARY KEY,

    EmployeeID VARCHAR(50) NOT NULL,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    JobTitle VARCHAR(20),
    StoreID VARCHAR(50),
    HireDate DATETIME2,

    EffectiveStartDate DATETIME2 NOT NULL,
    EffectiveEndDate DATETIME2 NULL,
    IsCurrent BIT NOT NULL
);

-- DimDate
CREATE TABLE Dim.Date
(
    DateKey INT PRIMARY KEY,

    FullDate DATETime2 NOT NULL,
    Day INT,
    Month INT,
    MonthName VARCHAR(20),
    Quarter INT,
    Year INT,
    Week INT,
    DayOfWeek INT,
    DayName VARCHAR(20)
);

-- FactSales
CREATE TABLE Fact.Sales
(
    SalesKey BIGINT IDENTITY(1,1) PRIMARY KEY,

    DateKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    ProductKey INT NOT NULL,
    StoreKey INT NOT NULL,
    EmployeeKey INT NULL,

    OrderID VARCHAR(50) NOT NULL,
    OrderDetailID VARCHAR(100) NOT NULL,

    Quantity INT,
    UnitCost DECIMAL(18,2),
    UnitPrice DECIMAL(18,2),
    Discount DECIMAL(5,2),

    SalesAmount DECIMAL(18,2),
    CostAmount DECIMAL(18,2),
    ProfitAmount DECIMAL(18,2),

    OrderStatus VARCHAR(20),
    SalesChannel VARCHAR(30),
    
    -- FK's
    CONSTRAINT FK_FactSales_Date FOREIGN KEY (DateKey) REFERENCES Dim.Date(DateKey),
    CONSTRAINT FK_FactSales_Customer FOREIGN KEY (CustomerKey) REFERENCES Dim.Customer(CustomerKey),
    CONSTRAINT FK_FactSales_Product FOREIGN KEY (ProductKey) REFERENCES Dim.Product(ProductKey),
    CONSTRAINT FK_FactSales_Store FOREIGN KEY (StoreKey) REFERENCES Dim.Store(StoreKey),
    CONSTRAINT FK_FactSales_Employee FOREIGN KEY (EmployeeKey) REFERENCES Dim.Employee(EmployeeKey)
)