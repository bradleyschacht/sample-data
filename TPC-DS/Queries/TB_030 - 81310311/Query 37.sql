/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-07
    This is the TPC-DS 30000 GB (TB_030) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 37   *************************************/

        select top 100 i_item_id
               ,i_item_desc
               ,i_current_price
         from item, inventory, date_dim, catalog_sales
         where i_current_price between 50 and 50 + 30
         and inv_item_sk = i_item_sk
         and d_date_sk=inv_date_sk
         and d_date between cast('1999-05-09' as date) and (dateadd(day, +  60, cast('1999-05-09' as date))) /*  and d_date between cast('1999-05-09' as date) and (cast('1999-05-09' as date) +  60 days)  */
         and i_manufact_id in (709,998,694,769)
         and inv_quantity_on_hand between 100 and 500
         and cs_item_sk = i_item_sk
         group by i_item_id,i_item_desc,i_current_price
         order by i_item_id
        OPTION (LABEL = 'TPC-DS Query 37');


