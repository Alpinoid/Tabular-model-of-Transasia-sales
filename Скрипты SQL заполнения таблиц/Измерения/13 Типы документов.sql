SELECT
	CONVERT(varchar(32), _IDRRef, 2) AS ID
	,CASE
		WHEN _EnumOrder = 0 THEN 'Список'
		WHEN _EnumOrder = 1 THEN 'Счет-фактура'
	END AS Description
FROM dbo._Enum99
WHERE _EnumOrder IN (0, 1)
UNION ALL
SELECT
	'00000000000000000000000000000000' AS ID
	,'Без типа документа' AS Description