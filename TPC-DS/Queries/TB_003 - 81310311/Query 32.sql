/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 3000 GB (TB_003) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 32   *************************************/

        select top 100 sum(cs_ext_discount_amt)  as "excess discount amount" 
        from 
           catalog_sales 
           ,item 
           ,date_dim
        where
        i_manufact_id = 263
        and i_item_sk = cs_item_sk 
        and d_date between '1998-01-13' and 
                (dateadd(day, + 90, cast('1998-01-13' as date))) /*  (cast('1998-01-13' as date) + 90 days)  */
        and d_date_sk = cs_sold_date_sk 
        and cs_ext_discount_amt  
             > ( 
                 select 
                    1.3 * avg(cs_ext_discount_amt) 
                 from 
                    catalog_sales 
                   ,date_dim
                 where 
                      cs_item_sk = i_item_sk 
                  and d_date between '1998-01-13' and
                                     (dateadd(day, + 90, cast('1998-01-13' as date))) /*  (cast('1998-01-13' as date) + 90 days)  */
                  and d_date_sk = cs_sold_date_sk 
              ) 
        OPTION (LABEL = 'TPC-DS Query 32');


