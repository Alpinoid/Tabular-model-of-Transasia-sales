SELECT
	CONVERT(varchar(32), Customers._IDRRef, 2) AS ID
	,Customers._Code AS Code
	,Customers._Fld170 AS INN
	,Customers._Description AS Description
FROM dbo._Reference50 AS Customers
INNER JOIN dbo._Reference1044 AS CustomerType ON CustomerType._IDRRef = Customers._Fld1216RRef AND CustomerType._Code = '000000003'
WHERE Customers._Fld176 = 1 -- Покупатели