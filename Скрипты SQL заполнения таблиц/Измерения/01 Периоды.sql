DECLARE @StartDay Date
DECLARE @EndDay Date

SET @StartDay = '2013-12-31'--(SELECT TOP 1 DATEADD(year, -1*(SELECT TOP 1 Offset FROM dbo._YearOffset), MIN(CAST(_Period as date))) AS [Date] FROM dbo._AccumRg2026)
SET @EndDay = (SELECT TOP 1 DATEADD(year, -1*(SELECT TOP 1 Offset FROM dbo._YearOffset), MAX(CAST(_Period as date))) AS [Date] FROM dbo._AccumRg2026)
;
WITH Calendar AS 
(
SELECT
	@StartDay AS [Date]
UNION ALL
SELECT
	DATEADD(DAY, 1, [Date])
FROM Calendar
WHERE [Date] <= @EndDay
)
SELECT
	[Date]
	,DATENAME(year, [Date]) AS [Year]
	,DATENAME(quarter, [Date]) AS [Quarter]
	,DATENAME(quarter, [Date])+' квартал' AS [NameQuarter]
	,DATEPART(month, [Date]) AS [Month]
	,DATENAME(month, [Date]) AS [NameOfMonth]
	,DATENAME(week, [Date]) AS [Week]
	,DATENAME(dayofyear, [Date]) AS [DayOfYear]
	,DATENAME(day, [Date]) AS [DayOfMonth]
	,DATEPART(weekday, [Date]) AS [Weekday]
	,DATENAME(weekday, [Date]) AS [WeekdayName]
FROM Calendar
OPTION (MAXRECURSION 7300)