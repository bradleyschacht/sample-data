/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-03
    This is the TPC-DS 3000 GB (TB_003) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 92   *************************************/

        select top 100 
           sum(ws_ext_discount_amt)  as "Excess Discount Amount" 
        from 
            web_sales 
           ,item 
           ,date_dim
        where
        i_manufact_id = 263
        and i_item_sk = ws_item_sk 
        and d_date between '1998-01-13' and 
                (dateadd(day, + 90, cast('1998-01-13' as date))) /*  (cast('1998-01-13' as date) + 90 days)  */
        and d_date_sk = ws_sold_date_sk 
        and ws_ext_discount_amt  
             > ( 
                 SELECT 
                    1.3 * avg(ws_ext_discount_amt) 
                 FROM 
                    web_sales 
                   ,date_dim
                 WHERE 
                      ws_item_sk = i_item_sk 
                  and d_date between '1998-01-13' and
                                     (dateadd(day, + 90, cast('1998-01-13' as date))) /*  (cast('1998-01-13' as date) + 90 days)  */
                  and d_date_sk = ws_sold_date_sk 
              ) 
        order by sum(ws_ext_discount_amt)
        OPTION (LABEL = 'TPC-DS Query 92');


