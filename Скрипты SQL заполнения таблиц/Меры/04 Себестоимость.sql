DECLARE @Offset int

SET @Offset = (SELECT TOP 1 Offset FROM dbo._YearOffset)

SELECT
	DATEADD(year, -1*@Offset, CAST(Cost._Period AS date)) AS Date
	,CONVERT(varchar(32), Cost._Fld1586RRef, 2) AS GoodID
	,Cost._Fld1587 AS Ammount
FROM dbo._InfoRg1585 AS Cost
WHERE Cost._Active = 0x01