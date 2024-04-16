DROP TABLE IF EXISTS dbo.customer;
DROP TABLE IF EXISTS dbo.lineitem;
DROP TABLE IF EXISTS dbo.nation;
DROP TABLE IF EXISTS dbo.orders;
DROP TABLE IF EXISTS dbo.part;
DROP TABLE IF EXISTS dbo.partsupp;
DROP TABLE IF EXISTS dbo.region;
DROP TABLE IF EXISTS dbo.supplier;


CREATE TABLE dbo.customer
	(
		c_custkey 			bigint 			,
		c_name 				varchar(25) 	,
		c_address 			varchar(40) 	,
		c_nationkey 		int 			,
		c_phone 			varchar(15) 	,
		c_acctbal 			decimal(15, 2) 	,
		c_mktsegment 		varchar(10)		,
		c_comment 			varchar(117) 			
	);


CREATE TABLE dbo.lineitem
	(
		l_orderkey 			bigint 			,
		l_partkey 			bigint 			,
		l_suppkey 			bigint 			,
		l_linenumber 		int				,
		l_quantity 			decimal(15, 2) 	,
		l_extendedprice 	decimal(15, 2) 	,
		l_discount 			decimal(15, 2) 	,
		l_tax 				decimal(15, 2) 	,
		l_returnflag 		varchar(1) 		,
		l_linestatus 		varchar(1) 		,
		l_shipdate 			date 			,
		l_commitdate 		date 			,
		l_receiptdate 		date 			,
		l_shipInstruct 		varchar(25) 	,
		l_shipmode 			varchar(10) 	,
		l_comment 			varchar(44) 		
	);


CREATE TABLE dbo.nation
	(
		n_nationkey 		int 			,
		n_name 				varchar(25) 	,
		n_regionkey 		int 			,
		n_comment 			varchar(152) 			
	);


CREATE TABLE dbo.orders
	(
		o_orderkey 			bigint			,
		o_custkey 			bigint 			,
		o_orderstatus 		varchar(1) 		,
		o_totalprice 		decimal(15, 2) 	,
		o_orderdate 		date 			,
		o_orderpriority 	varchar(15) 	,
		o_clerk 			varchar(15) 	,
		o_shippriority 		int 			,
		o_comment 			varchar(79) 		
	);


CREATE TABLE dbo.part
	(
		p_partkey 			bigint 			,
		p_name 				varchar(55) 	,
		p_mfgr 				varchar(25) 	,
		p_brand 			varchar(10) 	,
		p_type 				varchar(25) 	,
		p_size 				int 			,
		p_container 		varchar(10) 	,
		p_retailprice 		decimal(15, 2) 	,
		p_comment 			varchar(23) 		
	);


CREATE TABLE dbo.partsupp
	(
		ps_partkey 			bigint 			,
		ps_suppkey 			bigint 			,
		ps_availqty 		int 			,
		ps_supplycost 		decimal(15, 2) 	,
		ps_comment 			varchar(199) 		
	);


CREATE TABLE dbo.region
	(
		r_regionkey 		int 			,
		r_name 				varchar(25) 	,
		r_comment 			varchar(152) 			
	);


CREATE TABLE dbo.supplier
	(
		s_suppkey 			bigint 			,
		s_name 				varchar(25)		,
		s_address 			varchar(40) 	,
		s_nationkey 		int 			,
		s_phone 			varchar(15) 	,
		s_acctbal 			decimal(15, 2)	,
		s_comment 			varchar(101) 			
	);