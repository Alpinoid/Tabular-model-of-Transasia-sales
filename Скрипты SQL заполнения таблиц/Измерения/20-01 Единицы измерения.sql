SELECT
	CONVERT(varchar(32), Units._IDRRef, 2) AS ID						-- ID ������� ���������
	,CONVERT(varchar(32), Units._OwnerIDRRef, 2) AS GoodsID				-- ID ������������-���������
	,CONVERT(varchar(32), Units._Fld151RRef, 2) AS ClassifierUnitsID	-- ID �������������� ������ ����������
	,Units._Fld152 AS Factor											-- �����������
	,Units._Fld153 AS Volume											-- �����
	,Units._Fld154 AS NetWeight											-- ��� �����
	,Units._Fld155 AS GrossWeight										-- ��� ������
	,Units._Fld156 AS Lenght											-- �����
	,Units._Fld157 AS Widt												-- ������
	,Units._Fld158 AS Height											-- ������
	,Units._Fld159 AS CodeEAN											-- ��� EAN
	,CASE
		WHEN Goods._IDRRef IS NULL THEN  0
		ELSE 1
	END AS IsBasicUnit													-- ������� ������� ������� ���������
FROM dbo._Reference46 AS Units
LEFT JOIN dbo._Reference55 AS Goods ON Goods._Fld222RRef = Units._IDRRef AND Goods._IDRRef = Units._OwnerIDRRef
WHERE Units._Marked = 0