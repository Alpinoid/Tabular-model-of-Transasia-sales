SELECT
	CONVERT(varchar(32), Element._IDRRef, 2) AS ID
	,Element._Description AS Description
	,ISNULL(Branches._Description, 'Без филиала') AS Branch
FROM dbo._Reference63 AS Element
LEFT JOIN  dbo._Reference70 AS Branches ON Branches._IDRRef = Element._Fld278RRef
UNION ALL
SELECT
	'00000000000000000000000000000000' AS ID
	,'Без склада' AS [Description]
	,'Без филиала' AS Branch