SELECT
	CONVERT(varchar(32), Element._IDRRef, 2) AS ID
	,Element._Description AS Description
	,CONVERT(varchar(32), Element._Fld1041RRef, 2) AS SMT_ID
	,ISNULL(Bussiness._Description, 'None') AS Business
FROM dbo._Reference49 AS Element
LEFT JOIN dbo._Reference54 AS Bussiness ON Bussiness._IDRRef = Element._Fld165RRef
WHERE Element._Folder = 0x01
UNION ALL
SELECT
	'00000000000000000000000000000000' AS ID
	,'None' AS Description
	,'00000000000000000000000000000000' AS SMT_ID
	,'None' AS Business