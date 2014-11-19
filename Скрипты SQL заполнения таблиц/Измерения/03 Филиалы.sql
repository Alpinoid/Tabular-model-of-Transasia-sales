SELECT
	CONVERT(varchar(32), Element._IDRRef, 2) AS ID
	,Element._Code AS Code
	,Element._Description AS _Description
	,CASE
		WHEN SUM(1) OVER (PARTITION BY Parent._Description) <=1 THEN Element._Code
		ELSE Parent._Code
	END AS ParentCode
	,CASE
		WHEN SUM(1) OVER (PARTITION BY Parent._Description) <=1 THEN Element._Description
		ELSE Parent._Description
	END AS ParentDescription
	,CASE
		WHEN SUM(1) OVER (PARTITION BY Parent._Description) <=1 THEN 'BLANK'
		ELSE Element._Description
	END AS ChildDescription
FROM dbo._Reference70 AS Element
LEFT JOIN dbo._Reference70 AS Parent ON Parent._IDRRef = Element._ParentIDRRef OR (Parent._IDRRef = Element._IDRRef AND Element._ParentIDRRef = 0)
UNION ALL
SELECT
	'00000000000000000000000000000000' AS ID
	,'ZZ9999999' AS Code
	,'Без филиала' AS Description
	,'ZZ9999999' AS ParentCode
	,'Без филиала' AS ParentDescription
	,'BLANK' AS ChildDescription