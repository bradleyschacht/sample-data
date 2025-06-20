/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 1 GB (GB_001) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 76   *************************************/

        select top 100 channel, col_name, d_year, d_qoy, i_category, COUNT(*) sales_cnt, SUM(ext_sales_price) sales_amt FROM (
                SELECT 'store' as channel, 'ss_addr_sk' col_name, d_year, d_qoy, i_category, ss_ext_sales_price ext_sales_price
                 FROM store_sales, item, date_dim
                 WHERE ss_addr_sk IS NULL
                   AND ss_sold_date_sk=d_date_sk
                   AND ss_item_sk=i_item_sk
                UNION ALL
                SELECT 'web' as channel, 'ws_ship_mode_sk' col_name, d_year, d_qoy, i_category, ws_ext_sales_price ext_sales_price
                 FROM web_sales, item, date_dim
                 WHERE ws_ship_mode_sk IS NULL
                   AND ws_sold_date_sk=d_date_sk
                   AND ws_item_sk=i_item_sk
                UNION ALL
                SELECT 'catalog' as channel, 'cs_bill_addr_sk' col_name, d_year, d_qoy, i_category, cs_ext_sales_price ext_sales_price
                 FROM catalog_sales, item, date_dim
                 WHERE cs_bill_addr_sk IS NULL
                   AND cs_sold_date_sk=d_date_sk
                   AND cs_item_sk=i_item_sk) foo
        GROUP BY channel, col_name, d_year, d_qoy, i_category
        ORDER BY channel, col_name, d_year, d_qoy, i_category
        OPTION (LABEL = 'TPC-DS Query 76');


