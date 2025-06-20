/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 100000 GB (TB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 67   *************************************/

        select top 100 *
        from (select i_category
                    ,i_class
                    ,i_brand
                    ,i_product_name
                    ,d_year
                    ,d_qoy
                    ,d_moy
                    ,s_store_id
                    ,sumsales
                    ,rank() over (partition by i_category order by sumsales desc) rk
              from (select i_category
                          ,i_class
                          ,i_brand
                          ,i_product_name
                          ,d_year
                          ,d_qoy
                          ,d_moy
                          ,s_store_id
                          ,sum(coalesce(ss_sales_price*ss_quantity,0)) sumsales
                    from store_sales
                        ,date_dim
                        ,store
                        ,item
               where  ss_sold_date_sk=d_date_sk
                  and ss_item_sk=i_item_sk
                  and ss_store_sk = s_store_sk
                  and d_month_seq between 1219 and 1219+11
               group by  rollup(i_category, i_class, i_brand, i_product_name, d_year, d_qoy, d_moy,s_store_id))dw1) dw2
        where rk <= 100
        order by i_category
                ,i_class
                ,i_brand
                ,i_product_name
                ,d_year
                ,d_qoy
                ,d_moy
                ,s_store_id
                ,sumsales
                ,rk
        OPTION (LABEL = 'TPC-DS Query 67');


