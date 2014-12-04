SELECT 
	CONVERT(varchar(32), Element._IDRRef, 2) AS ID
	,Element._Description AS Description
FROM dbo._Reference54 AS Element
UNION ALL
SELECT
	'00000000000000000000000000000000' AS ID
	,'None' AS Description