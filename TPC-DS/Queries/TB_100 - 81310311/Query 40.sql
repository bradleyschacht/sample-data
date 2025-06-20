/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 100000 GB (TB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 40   *************************************/

        select top 100 
           w_state
          ,i_item_id
          ,sum(case when (cast(d_date as date) < cast ('1998-03-11' as date)) 
         		then cs_sales_price - coalesce(cr_refunded_cash,0) else 0 end) as sales_before
          ,sum(case when (cast(d_date as date) >= cast ('1998-03-11' as date)) 
         		then cs_sales_price - coalesce(cr_refunded_cash,0) else 0 end) as sales_after
         from
           catalog_sales left outer join catalog_returns on
               (cs_order_number = cr_order_number 
                and cs_item_sk = cr_item_sk)
          ,warehouse 
          ,item
          ,date_dim
         where
             i_current_price between 0.99 and 1.49
         and i_item_sk          = cs_item_sk
         and cs_warehouse_sk    = w_warehouse_sk 
         and cs_sold_date_sk    = d_date_sk
         and d_date between (dateadd(day, - 30, cast('1998-03-11' as date))) /*  and d_date between (cast ('1998-03-11' as date) - 30 days)  */
                        and (dateadd(day, + 30, cast('1998-03-11' as date)))  /*  and (cast ('1998-03-11' as date) + 30 days)  */
         group by
            w_state,i_item_id
         order by w_state,i_item_id
        OPTION (LABEL = 'TPC-DS Query 40');


