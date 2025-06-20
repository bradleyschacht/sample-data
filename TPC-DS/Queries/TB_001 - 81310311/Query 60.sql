/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 1000 GB (TB_001) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 60   *************************************/

        ;with ss as (
         select
                  i_item_id,sum(ss_ext_sales_price) total_sales
         from
         	store_sales,
         	date_dim,
                 customer_address,
                 item
         where
                 i_item_id in (select
          i_item_id
        from
         item
        where i_category in ('Children'))
         and     ss_item_sk              = i_item_sk
         and     ss_sold_date_sk         = d_date_sk
         and     d_year                  = 1998
         and     d_moy                   = 8
         and     ss_addr_sk              = ca_address_sk
         and     ca_gmt_offset           = -5 
         group by i_item_id),
         cs as (
         select
                  i_item_id,sum(cs_ext_sales_price) total_sales
         from
         	catalog_sales,
         	date_dim,
                 customer_address,
                 item
         where
                 i_item_id               in (select
          i_item_id
        from
         item
        where i_category in ('Children'))
         and     cs_item_sk              = i_item_sk
         and     cs_sold_date_sk         = d_date_sk
         and     d_year                  = 1998
         and     d_moy                   = 8
         and     cs_bill_addr_sk         = ca_address_sk
         and     ca_gmt_offset           = -5 
         group by i_item_id),
         ws as (
         select
                  i_item_id,sum(ws_ext_sales_price) total_sales
         from
         	web_sales,
         	date_dim,
                 customer_address,
                 item
         where
                 i_item_id               in (select
          i_item_id
        from
         item
        where i_category in ('Children'))
         and     ws_item_sk              = i_item_sk
         and     ws_sold_date_sk         = d_date_sk
         and     d_year                  = 1998
         and     d_moy                   = 8
         and     ws_bill_addr_sk         = ca_address_sk
         and     ca_gmt_offset           = -5
         group by i_item_id)
          select top 100  
          i_item_id
        ,sum(total_sales) total_sales
         from  (select * from ss 
                union all
                select * from cs 
                union all
                select * from ws) tmp1
         group by i_item_id
         order by i_item_id
              ,total_sales
        OPTION (LABEL = 'TPC-DS Query 60');


