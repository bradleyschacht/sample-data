/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-03
    This is the TPC-DS 10000 GB (TB_010) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 27   *************************************/

        select top 100 i_item_id,
                s_state, grouping(s_state) g_state,
                avg(ss_quantity) agg1,
                avg(ss_list_price) agg2,
                avg(ss_coupon_amt) agg3,
                avg(ss_sales_price) agg4
         from store_sales, customer_demographics, date_dim, store, item
         where ss_sold_date_sk = d_date_sk and
               ss_item_sk = i_item_sk and
               ss_store_sk = s_store_sk and
               ss_cdemo_sk = cd_demo_sk and
               cd_gender = 'F' and
               cd_marital_status = 'U' and
               cd_education_status = 'College' and
               d_year = 2000 and
               s_state in ('OH','CO', 'NM', 'GA', 'AL', 'MI')
         group by rollup (i_item_id, s_state)
         order by i_item_id
                 ,s_state
        OPTION (LABEL = 'TPC-DS Query 27');


