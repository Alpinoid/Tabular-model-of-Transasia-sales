SELECT
	CONVERT(varchar(32), Element._IDRRef, 2) AS ID
	,Element._Description AS Description
	,ISNULL(Bussiness._Description, 'None') AS Business
FROM dbo._Reference51 AS Element
LEFT JOIN dbo._Reference54 AS Bussiness ON Bussiness._IDRRef = Element._Fld165RRef
INNER JOIN dbo._Enum102 AS CreditType ON CreditType._IDRRef = Element._Fld209RRef AND CreditType._EnumOrder = 1
WHERE Element._ParentIDRRef <> 0
UNION ALL
SELECT
	'00000000000000000000000000000000' AS ID
	,'Без кредитного направления' AS Description
	,'None' AS Business
	


