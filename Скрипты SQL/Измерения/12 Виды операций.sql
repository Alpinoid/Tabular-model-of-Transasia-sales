SELECT
	CONVERT(varchar(32), _IDRRef, 2) AS ID
	,CASE
		WHEN _EnumOrder = 5 THEN 'Возврат'
		WHEN _EnumOrder = 12 THEN 'Продажа'
	END AS Description
FROM dbo._Enum105
WHERE _EnumOrder IN (5, 12)
UNION ALL
SELECT
	'00000000000000000000000000000000' AS ID
	,'Без вида операции' AS Description