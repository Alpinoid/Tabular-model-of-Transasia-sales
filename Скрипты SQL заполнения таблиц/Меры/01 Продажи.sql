DECLARE @Offset int
DECLARE @StartDate datetime
DECLARE @EndDate datetime

SET @Offset = (SELECT TOP 1 Offset FROM dbo._YearOffset)
SET @StartDate = DATEADD(year, @Offset, '2014-01-01 00:00:00')
SET @EndDate = DATEADD(year, @Offset, '2014-31-12 23:59:59')

SELECT
	DATEADD(year, -1*@Offset, CAST(RegSales._Period AS date)) AS TransactionDate	-- Дата операции
	,CASE
		WHEN RegSales._RecorderTRef = 0x00000051 THEN DocSales._Number
		WHEN RegSales._RecorderTRef = 0x0000050C THEN DocRefunds._Number
		ELSE 'UNKNOW'
	END AS DocNumber																-- Номер документа
	,CONVERT(varchar(32), RegSales._Fld2037RRef, 2) AS TransactionTypeID			-- ID типа операции
	,CASE
		WHEN RegSales._RecorderTRef = 0x00000051 THEN CONVERT(varchar(32), DocSales._Fld584RRef, 2)
		WHEN RegSales._RecorderTRef = 0x0000050C THEN CONVERT(varchar(32), DocRefunds._Fld1397RRef, 2)
	END AS DocumentTypeID															-- ID типа документа
	,CASE
		WHEN RegSales._RecorderTRef = 0x00000051 THEN CONVERT(varchar(32), DocSales._Fld583RRef, 2)
		WHEN RegSales._RecorderTRef = 0x0000050C THEN CONVERT(varchar(32), DocRefunds._Fld1429RRef, 2)
	END AS PaymentMethodID															-- ID спсособа оплаты
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
LEFT JOIN dbo._Document81 AS DocSales ON DocSales._IDRRef = RegSales._RecorderRRef AND RegSales._RecorderTRef = 0x00000051			-- Документы продаж
LEFT JOIN dbo._Document1292 AS DocRefunds ON DocRefunds._IDRRef = RegSales._RecorderRRef AND RegSales._RecorderTRef = 0x0000050C	-- Документы возврата
WHERE RegSales._Active = 0x01
	AND RegSales._Period BETWEEN @StartDate AND @EndDate