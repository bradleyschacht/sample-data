DROP VIEW IF EXISTS dbo.revenue;


EXEC (
	'CREATE VIEW dbo.revenue (supplier_no, total_revenue)
	AS
	SELECT
		l_suppkey,
		SUM(l_extendedprice * (1 - l_discount))
	FROM
		lineitem
	WHERE
		l_shipdate >= ''1996-01-01''
		AND l_shipdate < DATEADD(mm, 3, ''1996-01-01'')
	GROUP BY
		l_suppkey;')