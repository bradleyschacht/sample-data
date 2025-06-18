/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 100 GB (GB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 55   *************************************/

        select top 100 i_brand_id brand_id, i_brand brand,
         	sum(ss_ext_sales_price) ext_price
         from date_dim, store_sales, item
         where d_date_sk = ss_sold_date_sk
         	and ss_item_sk = i_item_sk
         	and i_manager_id=86
         	and d_moy=12
         	and d_year=2000
         group by i_brand, i_brand_id
         order by ext_price desc, i_brand_id
        OPTION (LABEL = 'TPC-DS Query 55');


