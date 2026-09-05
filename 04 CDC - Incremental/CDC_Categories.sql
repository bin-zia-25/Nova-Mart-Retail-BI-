Execute sys.sp_cdc_enable_db
-- Check 
Select name,is_cdc_enabled from sys.databases where Database_ID = DB_ID()
-- Categories
Execute sys.sp_cdc_enable_table
	@Source_Schema = N'dbo',
	@Source_Name = N'Categories',
	@Role_Name = Null,
	@Supports_Net_Changes = 1
-- View 
Declare @from_lsn Binary(10), @to_lsn Binary(10)
Set @from_lsn = sys.fn_cdc_get_min_lsn('dbo_Categories')
Set @to_lsn = sys.fn_cdc_get_max_lsn()
Select * from cdc.fn_cdc_get_all_changes_dbo_categories(@from_lsn,@to_lsn,'all')

-- Creating Table for Tracking
CREATE TABLE CDC_Categories (
    TableName VARCHAR(100) PRIMARY KEY,
    LastLSN BINARY(10)
);

INSERT INTO CDC_Categories(TableName, LastLSN)
VALUES ('Categories', sys.fn_cdc_get_min_lsn('dbo_Categories'));
---------------------------------------------------------------
UPDATE dbo.CDC_Categories
SET LastLSN = sys.fn_cdc_get_max_lsn()
WHERE TableName = 'Categories';