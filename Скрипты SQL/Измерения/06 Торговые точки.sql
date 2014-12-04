SELECT
	CONVERT(varchar(32), Element._IDRRef, 2) AS ID
	,Element._ParentIDRRef
	,Element._Code AS Code
	,Element._Description AS Description
	,CONVERT(varchar(32),Element._Fld165RRef, 2) AS BusinessID
FROM dbo._Reference51 AS Element
LEFT JOIN dbo._Reference51 AS Parent ON Parent._IDRRef = Element._ParentIDRRef
WHERE Element._ParentIDRRef <> 0