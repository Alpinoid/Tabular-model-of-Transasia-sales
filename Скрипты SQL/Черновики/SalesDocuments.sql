DECLARE @Offset int
DECLARE @StartDate datetime
DECLARE @EndDate datetime

SET @Offset = (SELECT TOP 1 Offset FROM dbo._YearOffset)
SET @StartDate = DATEADD(year, @Offset, '2014-01-01 00:00:00')
SET @EndDate = DATEADD(year, @Offset, '2014-31-12 23:59:59')

SELECT
 _IDRRef AS DocID             -- ID документа
 ,DATEADD(year, -1*@Offset, CAST(_Date_Time as date)) AS DocDate
 ,_Number AS DocNumber            -- Номер документа
 ,'Продажа' AS Operation            -- Операция
 ,CASE
  WHEN _Fld584RRef = 0xA57FD241A35A93CF4774BE469D5DDACE THEN 'Список'
  WHEN _Fld584RRef = 0x8FA83114B4E8D59B4E0F722D43D4877A THEN 'Счет-фактура'
  ELSE NULL
 END AS DocumentType             -- ТипДокумента
 ,CASE
  WHEN _Fld583RRef = 0x84583E209B794AB747946E1EF1A5F121 THEN 'Банк'
  WHEN _Fld583RRef = 0x9FA7448A744582D540608D7CDD89AC9A THEN 'Касса'
  ELSE NULL
 END AS PaymentMethod            -- Спсособ оплаты
 ,CONVERT(varchar(32), _Fld165RRef, 2) AS BusinessID     -- ID направления бизнеса
 ,CONVERT(varchar(32), _Fld148RRef, 2) AS CompanyID     -- ID организации
 ,CONVERT(varchar(32), _Fld589RRef, 2) AS BranchID     -- ID филиала
 ,CONVERT(varchar(32), _Fld582RRef, 2) AS StorehouseID    -- ID склада
 ,CONVERT(varchar(32), _Fld579RRef, 2) AS CustomerID     -- ID контрагента
 ,CONVERT(varchar(32), _Fld588RRef, 2) AS TardeShopID    -- ID точки доставки (продажи)
 ,CONVERT(varchar(32), _Fld973RRef, 2) AS CreditLineID    -- ID крединого направления
 ,Details._LineNo592 AS LineNumber         -- Номер строки
 ,CONVERT(varchar(32), Details._Fld1283RRef, 2) AS RouteID   -- ID марушрта (торгового представителя)
 ,CONVERT(varchar(32), Details._Fld1285RRef, 2) AS PriceTypeID  -- ID типа цены
 ,CONVERT(varchar(32), Details._Fld600RRef, 2) AS GoodsID   -- ID номенклатуры
 ,CONVERT(varchar(32), Details._Fld595RRef, 2) AS MeasureID   -- ID единицы измерения
 ,Details._Fld979 AS Factor           -- Коэффициент
 ,Details._Fld596 AS DocQuantity          -- Количество в единицах ихмерения документа
 ,Details._Fld596 / Details._Fld979 AS BasicQuantity     -- Количество в базовых единицах ихмерения
 ,Details._Fld606 AS Price           -- Цена
 ,CASE
  WHEN _Fld603RRef = 0xBED2A6C6C317EE4749006F93132BFE45 THEN 20
  WHEN _Fld603RRef = 0xB92D7177D27DB9AF4E0950F1FD8FEF33 THEN 18
  WHEN _Fld603RRef = 0x81347F75948BF3DC4DC5AAA17CCF7072 THEN 10
  WHEN _Fld603RRef = 0xADF7CD6B7D1C92E04DA9E986EAE36B09 THEN 0
  ELSE NULL
 END AS RateVAT              -- Ставка НДС
 ,Details._Fld605 AS AmountVAT          -- Сумма НДС
 ,Details._Fld604 AS Amount           -- Сумма
FROM dbo._Document81
LEFT JOIN dbo._Document81_VT591 AS Details ON Details._Document81_IDRRef = _IDRRef
WHERE _Posted = 0x01 AND Details._Fld596 != 0 AND Details._Fld979 != 0
 AND _Date_Time BETWEEN @StartDate AND @EndDate
UNION ALL
SELECT
 _IDRRef AS DocID             -- ID документа
 ,DATEADD(year, -1*@Offset, CAST(_Date_Time as date)) AS DocDate
 ,_Number AS DocNumber            -- Номер документа
  ,'Возврат' AS Operation           -- Операция
 ,CASE
  WHEN _Fld1397RRef = 0xA57FD241A35A93CF4774BE469D5DDACE THEN 'Список'
  WHEN _Fld1397RRef = 0x8FA83114B4E8D59B4E0F722D43D4877A THEN 'Счет-фактура'
  ELSE NULL
 END AS DocumentType             -- ТипДокумента
 ,CASE
  WHEN _Fld1429RRef = 0x84583E209B794AB747946E1EF1A5F121 THEN 'Банк'
  WHEN _Fld1429RRef = 0x9FA7448A744582D540608D7CDD89AC9A THEN 'Касса'
  ELSE NULL
 END AS PaymentMethod            -- Спсособ оплаты
 ,CONVERT(varchar(32), _Fld165RRef, 2) AS BusinessID     -- ID направления бизнеса
 ,CONVERT(varchar(32), _Fld148RRef, 2) AS CompanyID     -- ID организации
 ,CONVERT(varchar(32), _Fld1309RRef, 2) AS BranchID     -- ID филиала
 ,CONVERT(varchar(32), _Fld1297RRef, 2) AS StorehouseID    -- ID склада
 ,CONVERT(varchar(32), _Fld1298RRef, 2) AS CustomerID    -- ID контрагента
 ,CONVERT(varchar(32), _Fld1299RRef, 2) AS TardeShopID    -- ID точки доставки (продажи)
 ,CONVERT(varchar(32), _Fld1300RRef, 2) AS CreditLineID    -- ID крединого направления
 ,Details._LineNo1313 AS LineNumber         -- Номер строки
 ,CONVERT(varchar(32), Details._Fld1324RRef, 2) AS RouteID   -- ID марушрта (торгового представителя)
 ,CONVERT(varchar(32), Details._Fld1326RRef, 2) AS PriceTypeID  -- ID типа цены
 ,CONVERT(varchar(32), Details._Fld1314RRef, 2) AS GoodsID   -- ID номенклатуры
 ,CONVERT(varchar(32), Details._Fld1315RRef, 2) AS MeasureID   -- ID единицы измерения
 ,Details._Fld1316 AS Factor           -- Коэффициент
 ,-1 * Details._Fld1317 AS DocQuantity        -- Количество в единицах ихмерения документа
 ,-1 * Details._Fld1317 / Details._Fld1316 AS BasicQuantity   -- Количество в базовых единицах ихмерения
 ,Details._Fld1318 AS Price           -- Цена
 ,CASE
  WHEN _Fld1319RRef = 0xBED2A6C6C317EE4749006F93132BFE45 THEN 20
  WHEN _Fld1319RRef = 0xB92D7177D27DB9AF4E0950F1FD8FEF33 THEN 18
  WHEN _Fld1319RRef = 0x81347F75948BF3DC4DC5AAA17CCF7072 THEN 10
  WHEN _Fld1319RRef = 0xADF7CD6B7D1C92E04DA9E986EAE36B09 THEN 0
  ELSE NULL
 END AS RateVAT              -- Ставка НДС
 ,-1 * Details._Fld1320 AS AmountVAT         -- Сумма НДС
 ,-1 * Details._Fld1321 AS Amount         -- Сумма
FROM dbo._Document1292
LEFT JOIN dbo._Document1292_VT1312 AS Details ON Details._Document1292_IDRRef = _IDRRef
WHERE _Posted = 0x01 AND Details._Fld1317 != 0 AND Details._Fld1316 != 0
 AND _Date_Time BETWEEN @StartDate AND @EndDate