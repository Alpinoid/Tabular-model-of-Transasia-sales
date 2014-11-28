SELECT
	CONVERT(varchar(32), _IDRRef, 2) AS ID	-- ID клпссификатора
	,_Code AS Code							-- Код
	,_Description AS Description			-- Наименовнаие
	,_Fld164 AS FullName					-- Полное наименовнаие
FROM dbo._Reference48
WHERE _Marked = 0