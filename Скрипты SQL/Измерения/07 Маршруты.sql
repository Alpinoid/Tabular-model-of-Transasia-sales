SELECT
	CONVERT(varchar(32), Element._IDRRef, 2) AS ID
	,CONVERT(varchar(32), Element._OwnerIDRRef, 2) AS TeamID
	,Element._Description AS Description
	,ISNULL(Branches._Description, 'Без филиала') AS Branch
FROM dbo._Reference52 AS Element
LEFT JOIN  dbo._Reference70 AS Branches ON Branches._IDRRef = Element._Fld213RRef
WHERE Element._Folder = 0x01
UNION ALL
SELECT
	'00000000000000000000000000000000' AS ID
	,'00000000000000000000000000000000' AS TeamID
	,'Без маршрута' AS Description
	,'Без филиала' AS Branch