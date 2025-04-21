/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-18
    This is the TPC-DS 100 GB (GB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 03   *************************************/

        select top 100 dt.d_year 
               ,item.i_brand_id brand_id 
               ,item.i_brand brand
               ,sum(ss_ext_discount_amt) sum_agg
         from  date_dim dt 
              ,store_sales
              ,item
         where dt.d_date_sk = store_sales.ss_sold_date_sk
           and store_sales.ss_item_sk = item.i_item_sk
           and item.i_manufact_id = 486
           and dt.d_moy=12
         group by dt.d_year
              ,item.i_brand
              ,item.i_brand_id
         order by dt.d_year
                 ,sum_agg desc
                 ,brand_id
        OPTION (LABEL = 'TPC-DS Query 03');


