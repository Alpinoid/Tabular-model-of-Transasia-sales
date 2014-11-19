SELECT
	CONVERT(varchar(32), Element._IDRRef, 2) AS ID
	,Element._Description AS Description
FROM dbo._Reference64 AS Element
WHERE Element._Folder = 0x01
UNION ALL
SELECT
	'00000000000000000000000000000000' AS ID
	,'Без сотрудника' AS Description