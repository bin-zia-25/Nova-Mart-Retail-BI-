/* =========================================================
   1. CATEGORIES
   ========================================================= */
Truncate Table Categories
INSERT INTO Categories
    (CategoryID, CategoryName)
VALUES
    ('C001', 'Electronics'),
    ('C002', 'Home Appliances'),
    ('C003', 'Furniture'),
    ('C004', 'Computers & Accessories'),
    ('C005', 'Mobile & Tablets'),
    ('C006', 'Gaming'),
    ('C007', 'Audio'),
    ('C008', 'Cameras'),
    ('C009', 'Office Supplies'),
    ('C010', 'Smart Home');
GO


/* =========================================================
   2. STORES
   ========================================================= */

INSERT INTO Stores
    (StoreID, StoreName, City, Country, Region, StoreType, OpeningDate)
VALUES
    ('S001', 'NovaMart Lahore Central', 'Lahore', 'Pakistan', 'Punjab', 'Retail', '2019-03-15'),
    ('S002', 'NovaMart Islamabad', 'Islamabad', 'Pakistan', 'Capital', 'Retail', '2020-06-20'),
    ('S003', 'NovaMart Karachi Mall', 'Karachi', 'Pakistan', 'Sindh', 'Retail', '2018-11-10'),
    ('S004', 'NovaMart Rawalpindi', 'Rawalpindi', 'Pakistan', 'Punjab', 'Retail', '2021-02-05'),
    ('S005', 'NovaMart Faisalabad', 'Faisalabad', 'Pakistan', 'Punjab', 'Retail', '2021-08-18'),
    ('S006', 'NovaMart Multan', 'Multan', 'Pakistan', 'Punjab', 'Retail', '2022-01-12'),
    ('S007', 'NovaMart Peshawar', 'Peshawar', 'Pakistan', 'KPK', 'Retail', '2020-09-25'),
    ('S008', 'NovaMart Quetta', 'Quetta', 'Pakistan', 'Balochistan', 'Retail', '2022-05-30'),
    ('S009', 'NovaMart Gujranwala', 'Gujranwala', 'Pakistan', 'Punjab', 'Retail', '2023-01-15'),
    ('S010', 'NovaMart Sialkot', 'Sialkot', 'Pakistan', 'Punjab', 'Retail', '2023-07-10');
GO


/* =========================================================
   3. CUSTOMERS
   1,000 customers
   Some NULL Email / Phone values intentionally included
   Time-of-day added to CreatedDate / ModifiedDate via a
   SECOND offset (0-86399) layered on top of the DAY offset,
   using different prime multipliers so the two columns don't
   share the same time pattern for a given row.
   ========================================================= */
   
;WITH Numbers AS
(
    SELECT TOP (1000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS N
    FROM sys.all_objects A
    CROSS JOIN sys.all_objects B
)
INSERT INTO Customers
(
    CustomerID,
    CustomerName,
    Email,
    Phone,
    Gender,
    City,
    Country,
    CustomerType,
    CreatedDate,
    ModifiedDate
)
SELECT
    'CUST' + RIGHT('0000' + CAST(N AS varchar(4)), 4),

    CASE
        WHEN N % 5 = 0 THEN 'Ahmed Khan ' + CAST(N AS varchar(10))
        WHEN N % 5 = 1 THEN 'Ali Raza ' + CAST(N AS varchar(10))
        WHEN N % 5 = 2 THEN 'Hassan Malik ' + CAST(N AS varchar(10))
        WHEN N % 5 = 3 THEN 'Usman Sheikh ' + CAST(N AS varchar(10))
        ELSE 'Bilal Ahmed ' + CAST(N AS varchar(10))
    END,

    CASE
        WHEN N % 17 = 0 THEN NULL
        ELSE 'customer' + CAST(N AS varchar(10)) + '@novamart.com'
    END,

    CASE
        WHEN N % 23 = 0 THEN NULL
        ELSE '+92-3' +
             RIGHT('00000000' + CAST(10000000 + N AS varchar(8)), 8)
    END,

    CASE
        WHEN N % 3 = 0 THEN 'Male'
        WHEN N % 3 = 1 THEN 'Female'
        ELSE NULL
    END,

    CASE
        WHEN N % 8 = 0 THEN 'Lahore'
        WHEN N % 8 = 1 THEN 'Islamabad'
        WHEN N % 8 = 2 THEN 'Karachi'
        WHEN N % 8 = 3 THEN 'Rawalpindi'
        WHEN N % 8 = 4 THEN 'Faisalabad'
        WHEN N % 8 = 5 THEN 'Multan'
        WHEN N % 8 = 6 THEN 'Peshawar'
        ELSE 'Gujranwala'
    END,

    'Pakistan',

    CASE
        WHEN N % 10 < 7 THEN 'Regular'
        WHEN N % 10 < 9 THEN 'Premium'
        ELSE 'VIP'
    END,

    -- CreatedDate: day offset + pseudo-random seconds-of-day (multiplier 37)
    DATEADD(
        SECOND,
        (N * 37) % 86400,
        DATEADD(
            DAY,
            -(N % 1000),
            CAST('2025-12-31' AS datetime2)
        )
    ),

    -- ModifiedDate: day offset + pseudo-random seconds-of-day (multiplier 53)
    DATEADD(
        SECOND,
        (N * 53) % 86400,
        DATEADD(
            DAY,
            -(N % 300),
            CAST('2026-08-01' AS datetime2)
        )
    )

FROM Numbers;
GO


/* =========================================================
   4. PRODUCTS
   100 PRODUCTS
   Same seconds-of-day treatment applied to CreatedDate /
   ModifiedDate (multipliers 41 and 61).
   ========================================================= */

;WITH Numbers AS
(
    SELECT TOP (100)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS N
    FROM sys.all_objects
)
Select * From Stg.Products
Select * From Products

INSERT INTO Products
(
    ProductID,
    ProductName,
    CategoryID,
    UnitCost,
    UnitPrice,
    StockQuantity,
    ProductStatus,
    CreatedDate,
    ModifiedDate
)
SELECT
    'P' + RIGHT('000' + CAST(N AS varchar(3)), 3),

    CASE
        WHEN N % 10 = 1 THEN 'Nova Wireless Mouse ' + CAST(N AS varchar(10))
        WHEN N % 10 = 2 THEN 'Nova Mechanical Keyboard ' + CAST(N AS varchar(10))
        WHEN N % 10 = 3 THEN 'Nova LED Monitor ' + CAST(N AS varchar(10))
        WHEN N % 10 = 4 THEN 'Nova Bluetooth Speaker ' + CAST(N AS varchar(10))
        WHEN N % 10 = 5 THEN 'Nova Smart Watch ' + CAST(N AS varchar(10))
        WHEN N % 10 = 6 THEN 'Nova Gaming Headset ' + CAST(N AS varchar(10))
        WHEN N % 10 = 7 THEN 'Nova Laptop Stand ' + CAST(N AS varchar(10))
        WHEN N % 10 = 8 THEN 'Nova Security Camera ' + CAST(N AS varchar(10))
        WHEN N % 10 = 9 THEN 'Nova Office Chair ' + CAST(N AS varchar(10))
        ELSE 'Nova Smart Plug ' + CAST(N AS varchar(10))
    END,

    'C' + RIGHT('000' + CAST(((N - 1) % 10) + 1 AS varchar(3)), 3),

    CAST(
        CASE
            WHEN N % 10 = 1 THEN 500 + N * 5
            WHEN N % 10 = 2 THEN 1000 + N * 7
            WHEN N % 10 = 3 THEN 15000 + N * 50
            WHEN N % 10 = 4 THEN 2500 + N * 10
            WHEN N % 10 = 5 THEN 5000 + N * 15
            WHEN N % 10 = 6 THEN 3500 + N * 12
            WHEN N % 10 = 7 THEN 1800 + N * 8
            WHEN N % 10 = 8 THEN 7000 + N * 20
            WHEN N % 10 = 9 THEN 12000 + N * 30
            ELSE 1500 + N * 6
        END
        AS decimal(18,2)
    ),

    CAST(
        CASE
            WHEN N % 10 = 1 THEN 800 + N * 8
            WHEN N % 10 = 2 THEN 1600 + N * 10
            WHEN N % 10 = 3 THEN 22000 + N * 70
            WHEN N % 10 = 4 THEN 4000 + N * 15
            WHEN N % 10 = 5 THEN 8000 + N * 25
            WHEN N % 10 = 6 THEN 5500 + N * 18
            WHEN N % 10 = 7 THEN 3000 + N * 12
            WHEN N % 10 = 8 THEN 11000 + N * 30
            WHEN N % 10 = 9 THEN 18000 + N * 45
            ELSE 2500 + N * 10
        END
        AS decimal(18,2)
    ),

    10 + ((N * 17) % 200),

    CASE
        WHEN N % 15 = 0 THEN 'Discontinued'
        WHEN N % 7 = 0 THEN 'Inactive'
        ELSE 'Active'
    END,

    -- CreatedDate: day offset + pseudo-random seconds-of-day (multiplier 41)
    DATEADD(
        SECOND,
        (N * 41) % 86400,
        DATEADD(
            DAY,
            -(N % 700),
            CAST('2026-07-01' AS datetime2)
        )
    ),

    -- ModifiedDate: day offset + pseudo-random seconds-of-day (multiplier 61)
    DATEADD(
        SECOND,
        (N * 61) % 86400,
        DATEADD(
            DAY,
            -(N % 90),
            CAST('2026-08-01' AS datetime2)
        )
    )

FROM Numbers;
GO
/* =========================================================
   5. EMPLOYEES
   50 EMPLOYEES
   Seconds-of-day added to HireDate (multiplier 29).
   ======================================================== */

;WITH Numbers AS
(
    SELECT TOP (50)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS N
    FROM sys.all_objects
)
INSERT INTO Employees
(
    EmployeeID,
    EmployeeName,
    Department,
    JobTitle,
    StoreID,
    HireDate
)
SELECT
    'EMP' + RIGHT('000' + CAST(N AS varchar(3)), 3),

    CASE
        WHEN N % 4 = 0 THEN 'Muhammad Hamza'
        WHEN N % 4 = 1 THEN 'Ahsan Ali'
        WHEN N % 4 = 2 THEN 'Saad Ahmed'
        ELSE 'Zain Malik'
    END + ' ' + CAST(N AS varchar(10)),

    CASE
        WHEN N % 4 = 0 THEN 'Sales'
        WHEN N % 4 = 1 THEN 'Operations'
        WHEN N % 4 = 2 THEN 'Customer Service'
        ELSE 'Management'
    END,

    CASE
        WHEN N % 5 = 0 THEN 'Manager'
        WHEN N % 5 = 1 THEN 'Sales Executive'
        WHEN N % 5 = 2 THEN 'Cashier'
        WHEN N % 5 = 3 THEN 'Sales Associate'
        ELSE 'Supervisor'
    END,

    CASE
        WHEN N % 20 = 0 THEN NULL
        ELSE 'S' + RIGHT('000' + CAST(((N - 1) % 10) + 1 AS varchar(3)), 3)
    END,

    -- HireDate: day offset + pseudo-random seconds-of-day (multiplier 29)
    DATEADD(
        SECOND,
        (N * 29) % 86400,
        DATEADD(
            DAY,
            -(N * 25),
            CAST('2026-01-01' AS datetime2)
        )
    )

FROM Numbers;
GO


/* =========================================================
   6. ORDERS
   10,000 ORDERS
   OrderDate already varies by minute across the full day
   (DATEADD MINUTE, N % 1440) - left unchanged.
   ModifiedDate gets the same seconds-of-day treatment
   (multiplier 71) since it previously landed on midnight.
   ========================================================= */

;WITH Numbers AS
(
    SELECT TOP (10000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS N
    FROM sys.all_objects A
    CROSS JOIN sys.all_objects B
)
INSERT INTO Orders
(
    OrderID,
    CustomerID,
    EmployeeID,
    StoreID,
    OrderDate,
    OrderStatus,
    SalesChannel,
    ModifiedDate
)
SELECT
    'ORD' + RIGHT('00000' + CAST(N AS varchar(5)), 5),

    'CUST' +
    RIGHT(
        '0000' +
        CAST(((N - 1) % 1000) + 1 AS varchar(4)),
        4
    ),

    CASE
        WHEN N % 25 = 0 THEN NULL
        ELSE
            'EMP' +
            RIGHT(
                '000' +
                CAST(((N - 1) % 50) + 1 AS varchar(3)),
                3
            )
    END,

    CASE
        WHEN N % 30 = 0 THEN NULL
        ELSE
            'S' +
            RIGHT(
                '000' +
                CAST(((N - 1) % 10) + 1 AS varchar(3)),
                3
            )
    END,

    DATEADD(
        MINUTE,
        N % 1440,
        DATEADD(
            DAY,
            -(N % 730),
            CAST('2026-08-01' AS datetime2)
        )
    ),

    CASE
        WHEN N % 20 = 0 THEN 'Cancelled'
        WHEN N % 15 = 0 THEN 'Returned'
        WHEN N % 10 = 0 THEN 'Pending'
        ELSE 'Completed'
    END,

    CASE
        WHEN N % 4 = 0 THEN 'Online'
        WHEN N % 4 = 1 THEN 'Store'
        WHEN N % 4 = 2 THEN 'Mobile App'
        ELSE 'Marketplace'
    END,

    -- ModifiedDate: day offset + pseudo-random seconds-of-day (multiplier 71)
    DATEADD(
        SECOND,
        (N * 71) % 86400,
        DATEADD(
            DAY,
            -(N % 30),
            CAST('2026-08-01' AS datetime2)
        )
    )

FROM Numbers;
GO


/* =========================================================
   7. ORDER DETAILS
   ~30,000 DETAILS
   (No date/time columns here - unchanged)
   ========================================================= */

;WITH OrdersWithDetails AS
(
    SELECT
        O.OrderID,
        O.CustomerID,
        O.OrderDate,
        ROW_NUMBER() OVER (ORDER BY O.OrderID) AS OrderNumber
    FROM Orders O
),
DetailNumbers AS
(
    SELECT TOP (3)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS DetailNumber
    FROM sys.all_objects
)
INSERT INTO OrderDetails
(
    OrderDetailID,
    OrderID,
    ProductID,
    Quantity,
    UnitPrice,
    Discount
)
SELECT
    'OD' +
    RIGHT(
        '000000' +
        CAST(
            ((O.OrderNumber - 1) * 3) + D.DetailNumber
            AS varchar(10)
        ),
        6
    ),

    O.OrderID,

    'P' +
    RIGHT(
        '000' +
        CAST(
            (((O.OrderNumber * D.DetailNumber) % 100) + 1)
            AS varchar(3)
        ),
        3
    ),

    1 + ((O.OrderNumber + D.DetailNumber) % 5),

    P.UnitPrice,

    CASE
        WHEN O.OrderNumber % 12 = 0 THEN 20.00
        WHEN O.OrderNumber % 7 = 0 THEN 10.00
        WHEN O.OrderNumber % 5 = 0 THEN 5.00
        ELSE 0.00
    END

FROM OrdersWithDetails O
CROSS JOIN DetailNumbers D
INNER JOIN Products P
    ON P.ProductID =
       'P' +
       RIGHT(
           '000' +
           CAST(
               (((O.OrderNumber * D.DetailNumber) % 100) + 1)
               AS varchar(3)
           ),
           3
       );
GO
