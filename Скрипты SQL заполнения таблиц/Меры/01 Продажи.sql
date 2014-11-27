DECLARE @Offset int
DECLARE @StartDate datetime
DECLARE @EndDate datetime

SET @Offset = (SELECT TOP 1 Offset FROM dbo._YearOffset)
SET @StartDate = DATEADD(year, @Offset, '2014-01-01 00:00:00')
SET @EndDate = DATEADD(year, @Offset, '2014-31-12 23:59:59')

SELECT
	DATEADD(year, -1*@Offset, CAST(RegSales._Period AS date)) AS TransactionDate	-- Дата операции
	,CONVERT(varchar(32), RegSales._RecorderRRef, 2) AS DocumentID					-- ID документа
	,CONVERT(varchar(32), RegSales._Fld2034RRef, 2) AS SalesDocumentID				-- ID документа продажи
	,CONVERT(varchar(32), RegSales._Fld2037RRef, 2) AS TransactionTypeID			-- ID типа операции
	,CONVERT(varchar(32), RegSales._Fld2032RRef, 2) AS BusinessID					-- ID направления бизнеса
	,CONVERT(varchar(32), RegSales._Fld2030RRef, 2) AS CompanyID					-- ID организации
	,CONVERT(varchar(32), RegSales._Fld2031RRef, 2) AS BranchID						-- ID филиала
	,CONVERT(varchar(32), RegSales._Fld2106RRef, 2) AS StorehouseID					-- ID склада
	,CONVERT(varchar(32), RegSales._Fld2028RRef, 2) AS CustomerID					-- ID контрагента
	,CONVERT(varchar(32), RegSales._Fld2029RRef, 2) AS TardeShopID					-- ID точки доставки (продажи)
	,CONVERT(varchar(32), RegSales._Fld2033RRef, 2) AS CreditLineID					-- ID кредитного направления
	,CONVERT(varchar(32), RegSales._Fld2035RRef, 2) AS RouteID						-- ID марушрта (торгового представителя)
	,CONVERT(varchar(32), RegSales._Fld2036RRef, 2) AS AgentID						-- ID торгового агента (сотрудника)
	,CONVERT(varchar(32), RegSales._Fld2243RRef, 2) AS TypePriceID					-- ID типа цены
	,CONVERT(varchar(32), RegSales._Fld2027RRef, 2) AS GoodID						-- ID номенклатуры
	,RegSales._Fld2038 AS Quantity													-- Количество в базовых единицах измерения
	,RegSales._Fld2039 AS AmountVAT													-- Сумма НДС
	,RegSales._Fld2040 AS AmountWithoutDiscount										-- Сумма без скидки
	,RegSales._Fld2041 AS Amount													-- Сумма
	,(SELECT TOP 1
		Cost._Fld1587 AS Ammount
		FROM dbo._InfoRg1585 AS Cost
		WHERE Cost._Active = 0x01
		AND Cost._Fld1586RRef = RegSales._Fld2027RRef
		AND Cost._Period <= RegSales._Period
	ORDER BY Cost._Period DESC) * RegSales._Fld2038 AS Cost							-- Сумма себестоимости
FROM dbo._AccumRg2026 AS RegSales
WHERE RegSales._Active = 0x01
	AND RegSales._Period BETWEEN @StartDate AND @EndDate