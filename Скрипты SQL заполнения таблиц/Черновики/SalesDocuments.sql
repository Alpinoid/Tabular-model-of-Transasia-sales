DECLARE @Offset int
DECLARE @StartDate datetime
DECLARE @EndDate datetime

SET @Offset = (SELECT TOP 1 Offset FROM dbo._YearOffset)
SET @StartDate = DATEADD(year, @Offset, '2014-01-01 00:00:00')
SET @EndDate = DATEADD(year, @Offset, '2014-31-12 23:59:59')

SELECT
 _IDRRef AS DocID             -- ID ���������
 ,DATEADD(year, -1*@Offset, CAST(_Date_Time as date)) AS DocDate
 ,_Number AS DocNumber            -- ����� ���������
 ,'�������' AS Operation            -- ��������
 ,CASE
  WHEN _Fld584RRef = 0xA57FD241A35A93CF4774BE469D5DDACE THEN '������'
  WHEN _Fld584RRef = 0x8FA83114B4E8D59B4E0F722D43D4877A THEN '����-�������'
  ELSE NULL
 END AS DocumentType             -- ������������
 ,CASE
  WHEN _Fld583RRef = 0x84583E209B794AB747946E1EF1A5F121 THEN '����'
  WHEN _Fld583RRef = 0x9FA7448A744582D540608D7CDD89AC9A THEN '�����'
  ELSE NULL
 END AS PaymentMethod            -- ������� ������
 ,CONVERT(varchar(32), _Fld165RRef, 2) AS BusinessID     -- ID ����������� �������
 ,CONVERT(varchar(32), _Fld148RRef, 2) AS CompanyID     -- ID �����������
 ,CONVERT(varchar(32), _Fld589RRef, 2) AS BranchID     -- ID �������
 ,CONVERT(varchar(32), _Fld582RRef, 2) AS StorehouseID    -- ID ������
 ,CONVERT(varchar(32), _Fld579RRef, 2) AS CustomerID     -- ID �����������
 ,CONVERT(varchar(32), _Fld588RRef, 2) AS TardeShopID    -- ID ����� �������� (�������)
 ,CONVERT(varchar(32), _Fld973RRef, 2) AS CreditLineID    -- ID ��������� �����������
 ,Details._LineNo592 AS LineNumber         -- ����� ������
 ,CONVERT(varchar(32), Details._Fld1283RRef, 2) AS RouteID   -- ID �������� (��������� �������������)
 ,CONVERT(varchar(32), Details._Fld1285RRef, 2) AS PriceTypeID  -- ID ���� ����
 ,CONVERT(varchar(32), Details._Fld600RRef, 2) AS GoodsID   -- ID ������������
 ,CONVERT(varchar(32), Details._Fld595RRef, 2) AS MeasureID   -- ID ������� ���������
 ,Details._Fld979 AS Factor           -- �����������
 ,Details._Fld596 AS DocQuantity          -- ���������� � �������� ��������� ���������
 ,Details._Fld596 / Details._Fld979 AS BasicQuantity     -- ���������� � ������� �������� ���������
 ,Details._Fld606 AS Price           -- ����
 ,CASE
  WHEN _Fld603RRef = 0xBED2A6C6C317EE4749006F93132BFE45 THEN 20
  WHEN _Fld603RRef = 0xB92D7177D27DB9AF4E0950F1FD8FEF33 THEN 18
  WHEN _Fld603RRef = 0x81347F75948BF3DC4DC5AAA17CCF7072 THEN 10
  WHEN _Fld603RRef = 0xADF7CD6B7D1C92E04DA9E986EAE36B09 THEN 0
  ELSE NULL
 END AS RateVAT              -- ������ ���
 ,Details._Fld605 AS AmountVAT          -- ����� ���
 ,Details._Fld604 AS Amount           -- �����
FROM dbo._Document81
LEFT JOIN dbo._Document81_VT591 AS Details ON Details._Document81_IDRRef = _IDRRef
WHERE _Posted = 0x01 AND Details._Fld596 != 0 AND Details._Fld979 != 0
 AND _Date_Time BETWEEN @StartDate AND @EndDate
UNION ALL
SELECT
 _IDRRef AS DocID             -- ID ���������
 ,DATEADD(year, -1*@Offset, CAST(_Date_Time as date)) AS DocDate
 ,_Number AS DocNumber            -- ����� ���������
  ,'�������' AS Operation           -- ��������
 ,CASE
  WHEN _Fld1397RRef = 0xA57FD241A35A93CF4774BE469D5DDACE THEN '������'
  WHEN _Fld1397RRef = 0x8FA83114B4E8D59B4E0F722D43D4877A THEN '����-�������'
  ELSE NULL
 END AS DocumentType             -- ������������
 ,CASE
  WHEN _Fld1429RRef = 0x84583E209B794AB747946E1EF1A5F121 THEN '����'
  WHEN _Fld1429RRef = 0x9FA7448A744582D540608D7CDD89AC9A THEN '�����'
  ELSE NULL
 END AS PaymentMethod            -- ������� ������
 ,CONVERT(varchar(32), _Fld165RRef, 2) AS BusinessID     -- ID ����������� �������
 ,CONVERT(varchar(32), _Fld148RRef, 2) AS CompanyID     -- ID �����������
 ,CONVERT(varchar(32), _Fld1309RRef, 2) AS BranchID     -- ID �������
 ,CONVERT(varchar(32), _Fld1297RRef, 2) AS StorehouseID    -- ID ������
 ,CONVERT(varchar(32), _Fld1298RRef, 2) AS CustomerID    -- ID �����������
 ,CONVERT(varchar(32), _Fld1299RRef, 2) AS TardeShopID    -- ID ����� �������� (�������)
 ,CONVERT(varchar(32), _Fld1300RRef, 2) AS CreditLineID    -- ID ��������� �����������
 ,Details._LineNo1313 AS LineNumber         -- ����� ������
 ,CONVERT(varchar(32), Details._Fld1324RRef, 2) AS RouteID   -- ID �������� (��������� �������������)
 ,CONVERT(varchar(32), Details._Fld1326RRef, 2) AS PriceTypeID  -- ID ���� ����
 ,CONVERT(varchar(32), Details._Fld1314RRef, 2) AS GoodsID   -- ID ������������
 ,CONVERT(varchar(32), Details._Fld1315RRef, 2) AS MeasureID   -- ID ������� ���������
 ,Details._Fld1316 AS Factor           -- �����������
 ,-1 * Details._Fld1317 AS DocQuantity        -- ���������� � �������� ��������� ���������
 ,-1 * Details._Fld1317 / Details._Fld1316 AS BasicQuantity   -- ���������� � ������� �������� ���������
 ,Details._Fld1318 AS Price           -- ����
 ,CASE
  WHEN _Fld1319RRef = 0xBED2A6C6C317EE4749006F93132BFE45 THEN 20
  WHEN _Fld1319RRef = 0xB92D7177D27DB9AF4E0950F1FD8FEF33 THEN 18
  WHEN _Fld1319RRef = 0x81347F75948BF3DC4DC5AAA17CCF7072 THEN 10
  WHEN _Fld1319RRef = 0xADF7CD6B7D1C92E04DA9E986EAE36B09 THEN 0
  ELSE NULL
 END AS RateVAT              -- ������ ���
 ,-1 * Details._Fld1320 AS AmountVAT         -- ����� ���
 ,-1 * Details._Fld1321 AS Amount         -- �����
FROM dbo._Document1292
LEFT JOIN dbo._Document1292_VT1312 AS Details ON Details._Document1292_IDRRef = _IDRRef
WHERE _Posted = 0x01 AND Details._Fld1317 != 0 AND Details._Fld1316 != 0
 AND _Date_Time BETWEEN @StartDate AND @EndDate