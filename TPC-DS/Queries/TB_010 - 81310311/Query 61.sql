/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 10000 GB (TB_010) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 61   *************************************/

        select top 100 promotions,total,cast(promotions as decimal(15,4))/cast(total as decimal(15,4))*100
        from
          (select sum(ss_ext_sales_price) promotions
           from  store_sales
                ,store
                ,promotion
                ,date_dim
                ,customer
                ,customer_address 
                ,item
           where ss_sold_date_sk = d_date_sk
           and   ss_store_sk = s_store_sk
           and   ss_promo_sk = p_promo_sk
           and   ss_customer_sk= c_customer_sk
           and   ca_address_sk = c_current_addr_sk
           and   ss_item_sk = i_item_sk 
           and   ca_gmt_offset = -7
           and   i_category = 'Books'
           and   (p_channel_dmail = 'Y' or p_channel_email = 'Y' or p_channel_tv = 'Y')
           and   s_gmt_offset = -7
           and   d_year = 1998
           and   d_moy  = 11) promotional_sales,
          (select sum(ss_ext_sales_price) total
           from  store_sales
                ,store
                ,date_dim
                ,customer
                ,customer_address
                ,item
           where ss_sold_date_sk = d_date_sk
           and   ss_store_sk = s_store_sk
           and   ss_customer_sk= c_customer_sk
           and   ca_address_sk = c_current_addr_sk
           and   ss_item_sk = i_item_sk
           and   ca_gmt_offset = -7
           and   i_category = 'Books'
           and   s_gmt_offset = -7
           and   d_year = 1998
           and   d_moy  = 11) all_sales
        order by promotions, total
        OPTION (LABEL = 'TPC-DS Query 61');


