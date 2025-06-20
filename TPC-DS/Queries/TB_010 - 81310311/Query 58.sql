/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 10000 GB (TB_010) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 58   *************************************/

        ;with ss_items as
         (select i_item_id item_id
                ,sum(ss_ext_sales_price) ss_item_rev 
         from store_sales
             ,item
             ,date_dim
         where ss_item_sk = i_item_sk
           and d_date in (select d_date
                          from date_dim
                          where d_week_seq = (select d_week_seq 
                                              from date_dim
                                              where d_date = '1998-07-11'))
           and ss_sold_date_sk   = d_date_sk
         group by i_item_id),
         cs_items as
         (select i_item_id item_id
                ,sum(cs_ext_sales_price) cs_item_rev
          from catalog_sales
              ,item
              ,date_dim
         where cs_item_sk = i_item_sk
          and  d_date in (select d_date
                          from date_dim
                          where d_week_seq = (select d_week_seq 
                                              from date_dim
                                              where d_date = '1998-07-11'))
          and  cs_sold_date_sk = d_date_sk
         group by i_item_id),
         ws_items as
         (select i_item_id item_id
                ,sum(ws_ext_sales_price) ws_item_rev
          from web_sales
              ,item
              ,date_dim
         where ws_item_sk = i_item_sk
          and  d_date in (select d_date
                          from date_dim
                          where d_week_seq =(select d_week_seq 
                                             from date_dim
                                             where d_date = '1998-07-11'))
          and ws_sold_date_sk   = d_date_sk
         group by i_item_id)
          select top 100 ss_items.item_id
               ,ss_item_rev
               ,ss_item_rev/((ss_item_rev+cs_item_rev+ws_item_rev)/3) * 100 ss_dev
               ,cs_item_rev
               ,cs_item_rev/((ss_item_rev+cs_item_rev+ws_item_rev)/3) * 100 cs_dev
               ,ws_item_rev
               ,ws_item_rev/((ss_item_rev+cs_item_rev+ws_item_rev)/3) * 100 ws_dev
               ,(ss_item_rev+cs_item_rev+ws_item_rev)/3 average
         from ss_items,cs_items,ws_items
         where ss_items.item_id=cs_items.item_id
           and ss_items.item_id=ws_items.item_id 
           and ss_item_rev between 0.9 * cs_item_rev and 1.1 * cs_item_rev
           and ss_item_rev between 0.9 * ws_item_rev and 1.1 * ws_item_rev
           and cs_item_rev between 0.9 * ss_item_rev and 1.1 * ss_item_rev
           and cs_item_rev between 0.9 * ws_item_rev and 1.1 * ws_item_rev
           and ws_item_rev between 0.9 * ss_item_rev and 1.1 * ss_item_rev
           and ws_item_rev between 0.9 * cs_item_rev and 1.1 * cs_item_rev
         order by item_id
                 ,ss_item_rev
        OPTION (LABEL = 'TPC-DS Query 58');


