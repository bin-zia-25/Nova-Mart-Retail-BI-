# NovaMart --- End-to-End Retail Sales Analytics

An end-to-end **Business Intelligence and Data Engineering project**
built around a fictional retail company, NovaMart.

## Project Overview

NovaMart demonstrates a complete BI pipeline:

**Source Database → SSIS Incremental/CDC Load → Staging → Data Warehouse
→ FactSales → Power BI**

The goal is to transform transactional retail data into a reliable
analytical model for sales, product, customer, and profitability
analysis.

## Architecture

``` text
┌──────────────────────┐
│    SQL SERVER        │
│    SOURCE SYSTEM     │
└──────────┬───────────┘
           ↓
┌──────────────────────┐
│   SSIS / CDC / CT    │
│ Incremental Loading  │
└──────────┬───────────┘
           ↓
┌──────────────────────┐
│       STAGING        │
│ Raw + Data Quality   │
└──────────┬───────────┘
           ↓
┌────────────────────────────┐
│      DATA WAREHOUSE        │
│                            │
│ SCD Type 2 Dimensions      │
│ FactSales                  │
│ Star Schema                │
└────────────┬───────────────┘
             ↓
┌────────────────────────────┐
│    SEMANTIC MODEL          │
│                            │
│ Relationships              │
│ DAX Measures               │
│ KPIs                       │
│ Hierarchies                │
│ Business Logic             │
│ RLS                        │
└────────────┬───────────────┘
             ↓
┌────────────────────────────┐
│         POWER BI           │
│ Reports & Dashboards       │
└────────────┬───────────────┘
             
```

## Source Database

The source system is built in SQL Server and contains:

-   Customers
-   Categories
-   Products
-   Stores
-   Employees
-   Orders
-   OrderDetails

The source tables use appropriate **Primary Keys, Foreign Keys, Unique
Constraints, Check Constraints, and NOT NULL constraints**.

### Demo Data

  Entity            Records
  --------------- ---------
  Categories             10
  Customers           1,000
  Products              100
  Stores                 10
  Employees              50
  Orders             10,000
  Order Details      30,000

All data is fictional and created for demonstration purposes.

## SSIS & Incremental Loading

SSIS is used to move source data into the staging layer.

The project demonstrates:

-   Full initial loading
-   Incremental loading
-   Change Data Capture (CDC)
-   Change Tracking (CT)
-   LSN-based CDC processing
-   Audit/control information
-   Data validation and error handling

The CDC process maintains a watermark based on the last successfully
processed LSN.

``` text
Last Processed LSN
        ↓
Get New Changes
        ↓
Process Changes
        ↓
Successful Load
        ↓
Update LSN
```

## Staging Layer

Staging acts as the landing area between the source system and the Data
Warehouse.

Typical activities include:

-   Data validation
-   NULL checks
-   Duplicate checks
-   Referential integrity checks
-   Data standardization
-   Transformations
-   Incremental processing

The staging layer is intentionally more permissive than the source
database so incoming data can be validated before entering the
warehouse.

## Data Warehouse

The warehouse follows a **Star Schema**.

### Dimensions

-   DimDate
-   DimCustomer
-   DimProduct
-   DimStore
-   DimEmployee

### Fact

-   FactSales

### FactSales Grain

**One row in FactSales represents one OrderDetail / sales transaction
line.**

This supports analysis by date, customer, product, store, employee,
quantity, sales, cost, and profit.

## Slowly Changing Dimensions --- SCD Type 2

SCD Type 2 is used to maintain historical versions of changing
dimensions.

The ETL checks the incoming business key/ID and compares the incoming
attributes with the current warehouse record.

``` text
Incoming Record
      ↓
Does ID exist?
   /        No         Yes
 |           |
Insert    Compare
            |
        Changed?
        /           No       Yes
      |          |
   Nothing    Expire Old
                 ↓
             Insert New
```

Historical versions are maintained using fields such as:

-   EffectiveStartDate
-   EffectiveEndDate
-   IsCurrent

## FactSales

After the dimensions are populated, FactSales is loaded from the
required transactional data from Orders and OrderDetails.

Dimension keys are resolved and sales measures are calculated.

Typical fields include:

-   OrderID
-   OrderDetailID
-   DateKey
-   CustomerKey
-   ProductKey
-   StoreKey
-   EmployeeKey
-   Quantity
-   UnitPrice
-   UnitCost
-   Discount
-   SalesAmount
-   CostAmount
-   ProfitAmount

## Power BI

The Data Warehouse is connected to Power BI using a star-schema model.

### Dashboard Pages

#### 1. Executive Overview

High-level business performance including sales, profit, margin, orders,
AOV, trends, categories, products, and sales channels.

#### 2. Sales Analysis

Time-based sales analysis including Sales LM, Sales LY, MoM Growth, YoY
Growth, profit, margin, quantity, and monthly performance.

#### 3. Product Analysis

Product and category performance including top products, rankings,
sales, quantity, profitability, and product-level analysis.

#### 4. Customer Analysis

Customer value and behavior including customers, orders, AOV, revenue
per customer, customer ranking, segmentation, and repeat customers.

## DAX & Time Intelligence

The report uses DAX measures for business calculations.

Examples:

``` dax
Total Sales =
SUM(FactSales[SalesAmount])
```

``` dax
Total Profit =
SUM(FactSales[ProfitAmount])
```

``` dax
Profit Margin % =
DIVIDE([Total Profit], [Total Sales], 0)
```

Time Intelligence includes:

-   MTD --- Month to Date
-   QTD --- Quarter to Date
-   YTD --- Year to Date
-   Previous Month
-   Previous Year
-   MoM Growth
-   YoY Growth
-   Running Total

Other DAX concepts demonstrated:

-   CALCULATE
-   FILTER
-   VALUES
-   REMOVEFILTERS
-   RANKX
-   SUMX
-   DIVIDE
-   Row Context
-   Filter Context
-   Context Transition

## Technology Stack

  Technology   Purpose
  ------------ -------------------------------------------
  SQL Server   Source Database & Data Warehouse
  SQL          Analysis Queries
  SSIS         ETL / Data Integration
  CDC / CT     Change Detection & Incremental Processing
  SCD Type 2   Historical Dimension Management
  Power BI     Reporting & Visualization
  DAX          Business Calculations & Time Intelligence

## Repository Structure

``` text
NovaMart-Retail-Analytics/
│
├── 01_Source_Database/
├── 02_Data_Analysis/
├── 03_Staging/
├── 04_CDC_CT/
├── 05_Data_Warehouse/
├── 06_SCD/
├── 07_SSIS/
├── 08_PowerBI/
├── 09_Documentation/
└── README.md
```

## Key Learning Outcomes

This project covers the complete BI lifecycle:

-   Relational database design
-   SQL and advanced SQL
-   Data quality
-   ETL
-   Incremental loading
-   CDC and Change Tracking
-   Staging architecture
-   Data Warehousing
-   Star Schema
-   Surrogate Keys
-   SCD Type 2
-   Fact and Dimension modeling
-   DAX
-   Time Intelligence
-   Power BI dashboard design

## Project Status

**Completed**

-   [x] Source Database
-   [x] Demo Data
-   [x] SQL Analysis
-   [x] Staging Layer
-   [x] SSIS ETL
-   [x] Incremental Loading
-   [x] CDC / Change Tracking
-   [x] Data Warehouse
-   [x] SCD Type 2
-   [x] FactSales
-   [x] Power BI Model
-   [x] DAX Measures
-   [x] Time Intelligence
-   [x] Executive Overview
-   [x] Sales Analysis
-   [x] Product Analysis
-   [x] Customer Analysis

## Final Outcome

NovaMart demonstrates how transactional data can be transformed into a
business-ready analytical platform:

Source Database → SSIS Incremental/CDC Loading → Staging → ETL & Conditional Checks → SCD Type 2 Data Warehouse → FactSales → Power BI → Business Insights

This project was created as a portfolio project to demonstrate practical
skills in **Business Intelligence, Data Engineering, SQL, ETL, Data
Warehousing, and Power BI**.
