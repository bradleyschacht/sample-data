/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-03
    This is the TPC-DS 100000 GB (TB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 96   *************************************/

        select top 100 count(*) 
        from store_sales
            ,household_demographics 
            ,time_dim, store
        where ss_sold_time_sk = time_dim.t_time_sk   
            and ss_hdemo_sk = household_demographics.hd_demo_sk 
            and ss_store_sk = s_store_sk
            and time_dim.t_hour = 15
            and time_dim.t_minute >= 30
            and household_demographics.hd_dep_count = 5
            and store.s_store_name = 'ese'
        order by count(*)
        OPTION (LABEL = 'TPC-DS Query 96');


