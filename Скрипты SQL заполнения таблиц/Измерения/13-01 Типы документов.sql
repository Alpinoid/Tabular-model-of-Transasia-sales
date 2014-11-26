SELECT
	CONVERT(varchar(32), _IDRRef, 2) AS ID
	,CASE
		WHEN _EnumOrder = 0 THEN '������'
		WHEN _EnumOrder = 1 THEN '����-�������'
	END AS Description
FROM dbo._Enum99
WHERE _EnumOrder IN (0, 1)
UNION ALL
SELECT
	'00000000000000000000000000000000' AS ID
	,'��� ���� ���������' AS Description