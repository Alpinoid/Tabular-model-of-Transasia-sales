SELECT
	CONVERT(varchar(32), _IDRRef, 2) AS ID	-- ID ��������������
	,_Code AS Code							-- ���
	,_Description AS Description			-- ������������
	,_Fld164 AS FullName					-- ������ ������������
FROM dbo._Reference48
WHERE _Marked = 0