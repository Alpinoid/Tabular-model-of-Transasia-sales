DECLARE @Offset int
DECLARE @CostPriceType varchar(32)

SET @Offset = (SELECT TOP 1 Offset FROM dbo._YearOffset)
SET @CostPriceType = (SELECT TOP 1 CONVERT(varchar(32), _IDRRef, 2) FROM dbo.t_PredefinedValue WHERE ID = 38)

SELECT
	DATEADD(year, -1*@Offset, CAST(Cost._Period AS date)) AS Date
	,CONVERT(varchar(32), Cost._Fld1586RRef, 2) AS GoodID
	,@CostPriceType AS PriceType
	,Cost._Fld1587 AS Price
FROM dbo._InfoRg1585 AS Cost
WHERE Cost._Active = 0x01
UNION ALL
SELECT
	DATEADD(year, -1*@Offset, CAST(Price._Period AS date)) AS Date
	,CONVERT(varchar(32), Price._Fld821RRef, 2) AS GoodID
	,CONVERT(varchar(32), Price._Fld820RRef, 2) AS PriceType
	,Price._Fld822 AS Price
FROM dbo._InfoRg819 AS Price
