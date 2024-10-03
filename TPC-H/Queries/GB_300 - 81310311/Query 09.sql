/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-03
    This is the TPC-H 300 GB (GB_300) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-H Parameter Substitution (Version 3.0.0 build 0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-H Query 09   *************************************/

        select
        	nation,
        	o_year,
        	sum(amount) as sum_profit
        from
        	(
        		select
        			n_name as nation,
        datepart(year, o_orderdate) as o_year, /* extract(year from o_orderdate) as o_year, */
        			l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity as amount
        		from
        			part,
        			supplier,
        			lineitem,
        			partsupp,
        			orders,
        			nation
        		where
        			s_suppkey = l_suppkey
        			and ps_suppkey = l_suppkey
        			and ps_partkey = l_partkey
        			and p_partkey = l_partkey
        			and o_orderkey = l_orderkey
        			and s_nationkey = n_nationkey
        			and p_name like '%bisque%'
        	) as profit
        group by
        	nation,
        	o_year
        order by
        	nation,
        	o_year desc
        option (label = 'TPC-H Query 09');


