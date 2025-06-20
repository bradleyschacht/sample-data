/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 1000 GB (TB_001) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 90   *************************************/

        select top 100 cast(amc as decimal(15,4))/cast(pmc as decimal(15,4)) am_pm_ratio
         from ( select count(*) amc
               from web_sales, household_demographics , time_dim, web_page
               where ws_sold_time_sk = time_dim.t_time_sk
                 and ws_ship_hdemo_sk = household_demographics.hd_demo_sk
                 and ws_web_page_sk = web_page.wp_web_page_sk
                 and time_dim.t_hour between 12 and 12+1
                 and household_demographics.hd_dep_count = 2
                 and web_page.wp_char_count between 5000 and 5200) at,
              ( select count(*) pmc
               from web_sales, household_demographics , time_dim, web_page
               where ws_sold_time_sk = time_dim.t_time_sk
                 and ws_ship_hdemo_sk = household_demographics.hd_demo_sk
                 and ws_web_page_sk = web_page.wp_web_page_sk
                 and time_dim.t_hour between 16 and 16+1
                 and household_demographics.hd_dep_count = 2
                 and web_page.wp_char_count between 5000 and 5200) pt
         order by am_pm_ratio
        OPTION (LABEL = 'TPC-DS Query 90');


