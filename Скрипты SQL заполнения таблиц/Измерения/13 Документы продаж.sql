DECLARE @Offset int
DECLARE @StartDate datetime
DECLARE @EndDate datetime

SET @Offset = (SELECT TOP 1 Offset FROM dbo._YearOffset)
SET @StartDate = DATEADD(year, @Offset, '2014-01-01 00:00:00')
SET @EndDate = DATEADD(year, @Offset, '2014-31-12 23:59:59')

SELECT
	CONVERT(varchar(32), DocSales._IDRRef, 2) AS ID
	,DATEADD(year, -1*@Offset, CAST(DocSales._Date_Time AS date)) AS DocDate		-- ���� ���������
	,DocSales._Number AS DocNumber													-- ����� ���������
	,CONVERT(varchar(32), DocSales._Fld584RRef, 2) AS DocumentTypeID				-- ID ���� ���������
	,CONVERT(varchar(32), DocSales._Fld583RRef, 2) AS PaymentMethodID				-- ID ������� ������ ���������
	,CASE
		WHEN YEAR(CAST(DocSales._Fld1244 AS date))-@Offset = 1753
			OR YEAR(CAST(DocSales._Fld1244 AS date))-@Offset = 1 THEN NULL
		ELSE DATEADD(year, -1*@Offset, CAST(DocSales._Fld1244 AS date))
	END AS DocDeliveryDate															-- ���� ��������
	,DATEADD(year, -1*@Offset, CAST(DocSales._Fld574 AS date)) AS DocPaymentDay		-- ���� ������
FROM dbo._Document81 AS DocSales
WHERE DocSales._Posted = 0x01
	AND DocSales._Date_Time BETWEEN @StartDate AND @EndDate