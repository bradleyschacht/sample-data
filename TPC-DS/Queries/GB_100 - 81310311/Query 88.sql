/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 100 GB (GB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 88   *************************************/

        select  *
        from
         (select count(*) h8_30_to_9
         from store_sales, household_demographics , time_dim, store
         where ss_sold_time_sk = time_dim.t_time_sk   
             and ss_hdemo_sk = household_demographics.hd_demo_sk 
             and ss_store_sk = s_store_sk
             and time_dim.t_hour = 8
             and time_dim.t_minute >= 30
             and ((household_demographics.hd_dep_count = 1 and household_demographics.hd_vehicle_count<=1+2) or
                  (household_demographics.hd_dep_count = 3 and household_demographics.hd_vehicle_count<=3+2) or
                  (household_demographics.hd_dep_count = 4 and household_demographics.hd_vehicle_count<=4+2)) 
             and store.s_store_name = 'ese') s1,
         (select count(*) h9_to_9_30 
         from store_sales, household_demographics , time_dim, store
         where ss_sold_time_sk = time_dim.t_time_sk
             and ss_hdemo_sk = household_demographics.hd_demo_sk
             and ss_store_sk = s_store_sk 
             and time_dim.t_hour = 9 
             and time_dim.t_minute < 30
             and ((household_demographics.hd_dep_count = 1 and household_demographics.hd_vehicle_count<=1+2) or
                  (household_demographics.hd_dep_count = 3 and household_demographics.hd_vehicle_count<=3+2) or
                  (household_demographics.hd_dep_count = 4 and household_demographics.hd_vehicle_count<=4+2))
             and store.s_store_name = 'ese') s2,
         (select count(*) h9_30_to_10 
         from store_sales, household_demographics , time_dim, store
         where ss_sold_time_sk = time_dim.t_time_sk
             and ss_hdemo_sk = household_demographics.hd_demo_sk
             and ss_store_sk = s_store_sk
             and time_dim.t_hour = 9
             and time_dim.t_minute >= 30
             and ((household_demographics.hd_dep_count = 1 and household_demographics.hd_vehicle_count<=1+2) or
                  (household_demographics.hd_dep_count = 3 and household_demographics.hd_vehicle_count<=3+2) or
                  (household_demographics.hd_dep_count = 4 and household_demographics.hd_vehicle_count<=4+2))
             and store.s_store_name = 'ese') s3,
         (select count(*) h10_to_10_30
         from store_sales, household_demographics , time_dim, store
         where ss_sold_time_sk = time_dim.t_time_sk
             and ss_hdemo_sk = household_demographics.hd_demo_sk
             and ss_store_sk = s_store_sk
             and time_dim.t_hour = 10 
             and time_dim.t_minute < 30
             and ((household_demographics.hd_dep_count = 1 and household_demographics.hd_vehicle_count<=1+2) or
                  (household_demographics.hd_dep_count = 3 and household_demographics.hd_vehicle_count<=3+2) or
                  (household_demographics.hd_dep_count = 4 and household_demographics.hd_vehicle_count<=4+2))
             and store.s_store_name = 'ese') s4,
         (select count(*) h10_30_to_11
         from store_sales, household_demographics , time_dim, store
         where ss_sold_time_sk = time_dim.t_time_sk
             and ss_hdemo_sk = household_demographics.hd_demo_sk
             and ss_store_sk = s_store_sk
             and time_dim.t_hour = 10 
             and time_dim.t_minute >= 30
             and ((household_demographics.hd_dep_count = 1 and household_demographics.hd_vehicle_count<=1+2) or
                  (household_demographics.hd_dep_count = 3 and household_demographics.hd_vehicle_count<=3+2) or
                  (household_demographics.hd_dep_count = 4 and household_demographics.hd_vehicle_count<=4+2))
             and store.s_store_name = 'ese') s5,
         (select count(*) h11_to_11_30
         from store_sales, household_demographics , time_dim, store
         where ss_sold_time_sk = time_dim.t_time_sk
             and ss_hdemo_sk = household_demographics.hd_demo_sk
             and ss_store_sk = s_store_sk 
             and time_dim.t_hour = 11
             and time_dim.t_minute < 30
             and ((household_demographics.hd_dep_count = 1 and household_demographics.hd_vehicle_count<=1+2) or
                  (household_demographics.hd_dep_count = 3 and household_demographics.hd_vehicle_count<=3+2) or
                  (household_demographics.hd_dep_count = 4 and household_demographics.hd_vehicle_count<=4+2))
             and store.s_store_name = 'ese') s6,
         (select count(*) h11_30_to_12
         from store_sales, household_demographics , time_dim, store
         where ss_sold_time_sk = time_dim.t_time_sk
             and ss_hdemo_sk = household_demographics.hd_demo_sk
             and ss_store_sk = s_store_sk
             and time_dim.t_hour = 11
             and time_dim.t_minute >= 30
             and ((household_demographics.hd_dep_count = 1 and household_demographics.hd_vehicle_count<=1+2) or
                  (household_demographics.hd_dep_count = 3 and household_demographics.hd_vehicle_count<=3+2) or
                  (household_demographics.hd_dep_count = 4 and household_demographics.hd_vehicle_count<=4+2))
             and store.s_store_name = 'ese') s7,
         (select count(*) h12_to_12_30
         from store_sales, household_demographics , time_dim, store
         where ss_sold_time_sk = time_dim.t_time_sk
             and ss_hdemo_sk = household_demographics.hd_demo_sk
             and ss_store_sk = s_store_sk
             and time_dim.t_hour = 12
             and time_dim.t_minute < 30
             and ((household_demographics.hd_dep_count = 1 and household_demographics.hd_vehicle_count<=1+2) or
                  (household_demographics.hd_dep_count = 3 and household_demographics.hd_vehicle_count<=3+2) or
                  (household_demographics.hd_dep_count = 4 and household_demographics.hd_vehicle_count<=4+2))
             and store.s_store_name = 'ese') s8
        OPTION (LABEL = 'TPC-DS Query 88');


