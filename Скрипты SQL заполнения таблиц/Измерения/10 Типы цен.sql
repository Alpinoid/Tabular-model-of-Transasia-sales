SELECT
	CONVERT(varchar(32), Element._IDRRef, 2) AS ID
	,Element._Description AS Description
	,ISNULL(Bussiness._Description, 'Общие') AS Business
FROM dbo._Reference66 AS Element
LEFT JOIN dbo._Reference54 AS Bussiness ON Bussiness._IDRRef = Element._Fld165RRef
UNION ALL
SELECT
	'00000000000000000000000000000000' AS ID
	,'Без типа цены' AS Description
	,'Общие' AS Business