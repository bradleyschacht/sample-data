/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 100 GB (GB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 22   *************************************/

        select top 100 i_product_name
                     ,i_brand
                     ,i_class
                     ,i_category
                     ,avg(inv_quantity_on_hand) qoh
               from inventory
                   ,date_dim
                   ,item
               where inv_date_sk=d_date_sk
                      and inv_item_sk=i_item_sk
                      and d_month_seq between 1219 and 1219 + 11
               group by rollup(i_product_name
                               ,i_brand
                               ,i_class
                               ,i_category)
        order by qoh, i_product_name, i_brand, i_class, i_category
        OPTION (LABEL = 'TPC-DS Query 22');


