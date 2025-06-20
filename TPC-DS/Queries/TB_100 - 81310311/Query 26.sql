/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 100000 GB (TB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 26   *************************************/

        select top 100 i_item_id, 
                avg(cs_quantity) agg1,
                avg(cs_list_price) agg2,
                avg(cs_coupon_amt) agg3,
                avg(cs_sales_price) agg4 
         from catalog_sales, customer_demographics, date_dim, item, promotion
         where cs_sold_date_sk = d_date_sk and
               cs_item_sk = i_item_sk and
               cs_bill_cdemo_sk = cd_demo_sk and
               cs_promo_sk = p_promo_sk and
               cd_gender = 'F' and 
               cd_marital_status = 'D' and
               cd_education_status = 'Unknown' and
               (p_channel_email = 'N' or p_channel_event = 'N') and
               d_year = 1998 
         group by i_item_id
         order by i_item_id
        OPTION (LABEL = 'TPC-DS Query 26');


