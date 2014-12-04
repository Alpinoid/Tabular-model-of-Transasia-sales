DECLARE @Offset int
DECLARE @StartDate datetime
DECLARE @EndDate datetime

SET @Offset = (SELECT TOP 1 Offset FROM dbo._YearOffset)
SET @StartDate = DATEADD(year, @Offset, '2014-01-01 00:00:00')
SET @EndDate = DATEADD(year, @Offset, '2014-31-12 23:59:59')

SELECT
	CONVERT(varchar(32), DocSales._IDRRef, 2) AS ID
	,'���������� �������' AS Document
	,DATEADD(year, -1*@Offset, CAST(DocSales._Date_Time AS date)) AS DocDate		-- ���� ���������
	,DocSales._Number AS DocNumber													-- ����� ���������
FROM dbo._Document81 AS DocSales
WHERE DocSales._Posted = 0x01
	AND DocSales._Date_Time BETWEEN @StartDate AND @EndDate
UNION ALL
SELECT
	CONVERT(varchar(32), DocRefunds._IDRRef, 2) AS ID
	,'������� ������� �� ����������' AS Document
	,DATEADD(year, -1*@Offset, CAST(DocRefunds._Date_Time AS date)) AS DocDate		-- ���� ���������
	,DocRefunds._Number AS DocNumber												-- ����� ���������
FROM dbo._Document1292 AS DocRefunds
WHERE DocRefunds._Posted = 0x01
	AND DocRefunds._Date_Time BETWEEN @StartDate AND @EndDate
UNION ALL
SELECT
	'00000000000000000000000000000000' AS ID
	,'�������� �� ���������' AS Document
	,NULL AS DocDate
	,NULL AS DocNumber