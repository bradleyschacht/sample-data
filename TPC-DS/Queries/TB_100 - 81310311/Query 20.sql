/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 100000 GB (TB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 20   *************************************/

        select top 100 i_item_id
               ,i_item_desc 
               ,i_category 
               ,i_class 
               ,i_current_price
               ,sum(cs_ext_sales_price) as itemrevenue 
               ,sum(cs_ext_sales_price)*100/sum(sum(cs_ext_sales_price)) over
                   (partition by i_class) as revenueratio
         from	catalog_sales
             ,item 
             ,date_dim
         where cs_item_sk = i_item_sk 
           and i_category in ('Home', 'Music', 'Children')
           and cs_sold_date_sk = d_date_sk
         and d_date between cast('2002-03-10' as date) 
         				and (dateadd(day, + 30, cast('2002-03-10' as date))) /*  and (cast('2002-03-10' as date) + 30 days)  */
         group by i_item_id
                 ,i_item_desc 
                 ,i_category
                 ,i_class
                 ,i_current_price
         order by i_category
                 ,i_class
                 ,i_item_id
                 ,i_item_desc
                 ,revenueratio
        OPTION (LABEL = 'TPC-DS Query 20');


