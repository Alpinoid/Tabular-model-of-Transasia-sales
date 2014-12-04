SELECT
	CONVERT(varchar(32), _IDRRef, 2) AS ID
	,CASE
		WHEN _ParentIDRRef = 0x00000000000000000000000000000000 THEN NULL
		ELSE CONVERT(varchar(32),_ParentIDRRef, 2)
	END AS ParentID
	,_Code AS Code
	,_Description AS [Description]
	,_Fld221 AS Article
	,CONVERT(varchar(32), _Fld165RRef, 2) AS BusinessID
FROM dbo._Reference55