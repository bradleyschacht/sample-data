/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-07
    This is the TPC-DS 1000 GB (TB_001) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 19   *************************************/

        select top 100 i_brand_id brand_id, i_brand brand, i_manufact_id, i_manufact,
         	sum(ss_ext_sales_price) ext_price
         from date_dim, store_sales, item,customer,customer_address,store
         where d_date_sk = ss_sold_date_sk
           and ss_item_sk = i_item_sk
           and i_manager_id=49
           and d_moy=11
           and d_year=1998
           and ss_customer_sk = c_customer_sk 
           and c_current_addr_sk = ca_address_sk
        and substring(ca_zip,1,5) <> substring(s_zip,1,5) /* and substr(ca_zip,1,5) <> substr(s_zip,1,5) */
           and ss_store_sk = s_store_sk 
         group by i_brand
              ,i_brand_id
              ,i_manufact_id
              ,i_manufact
         order by ext_price desc
                 ,i_brand
                 ,i_brand_id
                 ,i_manufact_id
                 ,i_manufact
        OPTION (LABEL = 'TPC-DS Query 19');

