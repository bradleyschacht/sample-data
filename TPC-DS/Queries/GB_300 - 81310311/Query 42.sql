/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 300 GB (GB_300) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 42   *************************************/

        select top 100 dt.d_year
         	,item.i_category_id
         	,item.i_category
         	,sum(ss_ext_sales_price)
         from 	date_dim dt
         	,store_sales
         	,item
         where dt.d_date_sk = store_sales.ss_sold_date_sk
         	and store_sales.ss_item_sk = item.i_item_sk
         	and item.i_manager_id = 1  	
         	and dt.d_moy=12
         	and dt.d_year=1998
         group by 	dt.d_year
         		,item.i_category_id
         		,item.i_category
         order by       sum(ss_ext_sales_price) desc,dt.d_year
         		,item.i_category_id
         		,item.i_category
        OPTION (LABEL = 'TPC-DS Query 42');


