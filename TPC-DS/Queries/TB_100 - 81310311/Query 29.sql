/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-07
    This is the TPC-DS 100000 GB (TB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 29   *************************************/

        select top 100  
             i_item_id
            ,i_item_desc
            ,s_store_id
            ,s_store_name
            ,sum(ss_quantity)        as store_sales_quantity
            ,sum(sr_return_quantity) as store_returns_quantity
            ,sum(cs_quantity)        as catalog_sales_quantity
         from
            store_sales
           ,store_returns
           ,catalog_sales
           ,date_dim             d1
           ,date_dim             d2
           ,date_dim             d3
           ,store
           ,item
         where
             d1.d_moy               = 4 
         and d1.d_year              = 1998
         and d1.d_date_sk           = ss_sold_date_sk
         and i_item_sk              = ss_item_sk
         and s_store_sk             = ss_store_sk
         and ss_customer_sk         = sr_customer_sk
         and ss_item_sk             = sr_item_sk
         and ss_ticket_number       = sr_ticket_number
         and sr_returned_date_sk    = d2.d_date_sk
         and d2.d_moy               between 4 and  4 + 3 
         and d2.d_year              = 1998
         and sr_customer_sk         = cs_bill_customer_sk
         and sr_item_sk             = cs_item_sk
         and cs_sold_date_sk        = d3.d_date_sk     
         and d3.d_year              in (1998,1998+1,1998+2)
         group by
            i_item_id
           ,i_item_desc
           ,s_store_id
           ,s_store_name
         order by
            i_item_id 
           ,i_item_desc
           ,s_store_id
           ,s_store_name
        OPTION (LABEL = 'TPC-DS Query 29');


