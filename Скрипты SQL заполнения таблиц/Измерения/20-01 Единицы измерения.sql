SELECT
	CONVERT(varchar(32), Units._IDRRef, 2) AS ID						-- ID единицы измерения
	,CONVERT(varchar(32), Units._OwnerIDRRef, 2) AS GoodsID				-- ID номенклатуры-владельца
	,CONVERT(varchar(32), Units._Fld151RRef, 2) AS ClassifierUnitsID	-- ID классификатора единиц ищзмерения
	,Units._Fld152 AS Factor											-- Коэффициент
	,Units._Fld153 AS Volume											-- Объем
	,Units._Fld154 AS NetWeight											-- Вес нетто
	,Units._Fld155 AS GrossWeight										-- Вес брутто
	,Units._Fld156 AS Lenght											-- Длина
	,Units._Fld157 AS Widt												-- Ширина
	,Units._Fld158 AS Height											-- Высота
	,Units._Fld159 AS CodeEAN											-- Код EAN
	,CASE
		WHEN Goods._IDRRef IS NULL THEN  0
		ELSE 1
	END AS IsBasicUnit													-- Признак базовой единицы измерения
FROM dbo._Reference46 AS Units
LEFT JOIN dbo._Reference55 AS Goods ON Goods._Fld222RRef = Units._IDRRef AND Goods._IDRRef = Units._OwnerIDRRef
WHERE Units._Marked = 0