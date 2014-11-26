DECLARE @Offset int
DECLARE @StartDate datetime
DECLARE @EndDate datetime

SET @Offset = (SELECT TOP 1 Offset FROM dbo._YearOffset)
SET @StartDate = DATEADD(year, @Offset, '2014-01-01 00:00:00')
SET @EndDate = DATEADD(year, @Offset, '2014-31-12 23:59:59')

SELECT
	CONVERT(varchar(32), DocSales._IDRRef, 2) AS ID
	,'Реализация товаров' AS Document
	,DATEADD(year, -1*@Offset, CAST(DocSales._Date_Time AS date)) AS DocDate		-- Дата документа
	,DocSales._Number AS DocNumber													-- Номер документа
	,CONVERT(varchar(32), DocSales._Fld584RRef, 2) AS DocumentTypeID				-- ID типа документа
	,CONVERT(varchar(32), DocSales._Fld583RRef, 2) AS PaymentMethodID				-- ID способа оплаты документа
	,CASE
		WHEN YEAR(CAST(DocSales._Fld1244 AS date))-@Offset = 1753
			OR YEAR(CAST(DocSales._Fld1244 AS date))-@Offset = 1 THEN NULL
		ELSE DATEADD(year, -1*@Offset, CAST(DocSales._Fld1244 AS date))
	END AS DocDeliveryDate	-- Дата доставки
	,DATEADD(year, -1*@Offset, CAST(DocSales._Fld574 AS date)) AS DocPaymentDay		-- Дата оплаты
FROM dbo._Document81 AS DocSales
WHERE DocSales._Posted = 0x01
	AND DocSales._Date_Time BETWEEN @StartDate AND @EndDate
UNION ALL
SELECT
	CONVERT(varchar(32), DocRefunds._IDRRef, 2) AS ID
	,'Возврат товаров от покупателя' AS Document
	,DATEADD(year, -1*@Offset, CAST(DocRefunds._Date_Time AS date)) AS DocDate		-- Дата документа
	,DocRefunds._Number AS DocNumber												-- Номер документа
	,CONVERT(varchar(32), DocRefunds._Fld1397RRef, 2) AS DocumentTypeID				-- ID типа документа
	,CONVERT(varchar(32), DocRefunds._Fld1429RRef, 2) AS PaymentMethodID			-- ID способа оплаты документа
	,NULL AS DocDeliveryDate														-- Дата доставки
	,NULL AS DocPaymentDay															-- Дата оплаты
FROM dbo._Document1292 AS DocRefunds
WHERE DocRefunds._Posted = 0x01
	AND DocRefunds._Date_Time BETWEEN @StartDate AND @EndDate
UNION ALL
SELECT
	'00000000000000000000000000000000' AS ID
	,'Документ не определен' AS Document
	,NULL AS DocDate
	,NULL AS DocNumber
	,'00000000000000000000000000000000' AS DocumentTypeID
	,'00000000000000000000000000000000' AS PaymentMethodID
	,NULL AS DocDeliveryDate
	,NULL AS DocPaymentDay