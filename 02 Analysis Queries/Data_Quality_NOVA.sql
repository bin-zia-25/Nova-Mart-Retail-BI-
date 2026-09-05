-- Basic Data Quality Checks
-- Null Emails
Select * from Customers
-- If i use Column Name(Email) it count only Non-Nulls Rows for Email.
-- Id i use * it checks all rows and check the Where condition for this.
Select 
	Count(*) as Null_Emails 
From	
	Customers
Where 
	Email is Null

-- Null Phones
Select 
	Count(*) as Null_Phones 
From	
	Customers
Where 
	Phone is Null


-- Null Gender
Select
	Count(*) as Null_Genders
From
	Customers
Where
	Gender is Null

----------------------------------
-- But Client never wants the Numbers it demands Percentage.
Select
	Count(*) as Total,
	Count(*)-Count(Email) as MissingEmails,
	(Cast(Count(*) - Count(Email) as Float)/Count(*))*100 as MissingEmailPercentage  -- We use Cast to Float due to Division
From
	Customers



-- Invalid Quantity
Select 
	Count(*) as Invalid_Quantity
From 
	OrderDetails
Where 
	Quantity < 0

-- Invalid Discount
Select 
	Count(*) as Invalid_Discounts
From 
	OrderDetails
Where 
	Discount < 0


-- Duplication Detection
Select		
	CustomerName,
	Count(*) as Duplicate
From 
	Customers
Group by 
	CustomerName
Having
	Count(CustomerName) > 1



-- Referential Integrity 
Select 
	O.*
From 
	Orders O left join OrderDetails OD on O.OrderID = OD.OrderID
Where
	OD.OrderID is Null

-- Revenue
Select 
	'PKR  ' + Cast(Sum(UnitPrice * Quantity) as Varchar(50)) as TotalRevenue
From 
	OrderDetails
-- 
Select * from OrderDetails
Select * from Stores
Select * from Orders

Select 
	Sum(TotalRevenue) as Total
From
(
Select 
	S.StoreName,
	Sum(OD.UnitPrice * OD.Quantity*(1-OD.Discount/100)) as TotalRevenue
From		
	Stores S inner join Orders O on S.StoreID = O.StoreID
	Inner Join OrderDetails OD on O.OrderId = OD.OrderID
Group by 
	S.StoreName
) as T


----------------------------------------------------------
-- Highest Selling Store/ Revenue by Store
Select 
	StoreName,
	TotalRevenue
From
(
Select 
	StoreName,
	TotalRevenue,
	Row_Number() over (Order by TotalRevenue DESC) as Rank
From
(
Select 
	S.StoreName,
	Sum(OD.UnitPrice * OD.Quantity*(1-OD.Discount/100)) as TotalRevenue
From		
	Stores S inner join Orders O on S.StoreID = O.StoreID
	Inner Join OrderDetails OD on O.OrderId = OD.OrderID
Group by 
	S.StoreName
	) as T
) as F
Where 
	Rank = 1
------------------------------------------------------------
-- Revenue by Category
Select * from Categories
Select * from Products
Select * From OrderDetails
-- 
Select 
	C.CategoryName,
	Sum((OD.UnitPrice*OD.Quantity)*(1-(OD.Discount/100))) as Revenue
From 
	Categories C inner join Products P on C.CategoryID = P.CategoryID
	Inner join OrderDetails OD on P.ProductID = OD.ProductID
Group by 
	C.CategoryName
Order by 
	Revenue DESC

----------------------------------------------------------------------
-- Revenue by Sales Channel 
Select * from Orders
Select * from OrderDetails
Select * from Products

Select 
	O.SalesChannel,
	Sum((OD.UnitPrice*OD.Quantity)*(1-(OD.Discount/100))) as Revenue
From 
	Orders O inner join OrderDetails OD on O.OrderID = OD.OrderID
Group by 
	O.SalesChannel
Order by 
	Revenue DESC

--------------------------------------------------------------------
-- Top 10 Products
Select 
	Top 10
	P.ID,
	P.ProductName,
	Sum((OD.UnitPrice*OD.Quantity)*(1-(OD.Discount/100))) as Revenue
From 
	Products P Inner join OrderDetails OD on P.ProductID = OD.ProductID
Group by 
	P.Productname
	P.ID
Order by 
	Revenue DESC




