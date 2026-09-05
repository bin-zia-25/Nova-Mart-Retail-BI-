Declare @StartDate Date = '2024-01-02'
Declare @EndDate Date = '2026-06-08'

;WITH DateCTE AS
(
    SELECT @StartDate AS FullDate

    UNION ALL

    SELECT DATEADD(DAY, 1, FullDate)
    FROM DateCTE
    WHERE FullDate < @EndDate
)
INSERT INTO Dim.Date
(
    DateKey,
    FullDate,
    Day,
    Month,
    MonthName,
    Quarter,
    Year,
    Week,
    DayOfWeek,
    DayName
)
SELECT
    CONVERT(INT, FORMAT(FullDate, 'yyyyMMdd')) AS DateKey,
    FullDate,
    DAY(FullDate) AS Day,
    MONTH(FullDate) AS Month,
    DATENAME(MONTH, FullDate) AS MonthName,
    DATEPART(QUARTER, FullDate) AS Quarter,
    YEAR(FullDate) AS Year,
    DATEPART(WEEK, FullDate) AS Week,
    DATEPART(WEEKDAY, FullDate) AS DayOfWeek,
    DATENAME(WEEKDAY, FullDate) AS DayName
FROM DateCTE
OPTION (MAXRECURSION 0);

-----------------------------------------------








