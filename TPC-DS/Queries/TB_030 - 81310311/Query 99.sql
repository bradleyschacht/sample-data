/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-03
    This is the TPC-DS 30000 GB (TB_030) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 99   *************************************/

        select top 100 
        substring(w_warehouse_name,1,20) /* substr(w_warehouse_name,1,20) */
          ,sm_type
          ,cc_name
          ,sum(case when (cs_ship_date_sk - cs_sold_date_sk <= 30 ) then 1 else 0 end)  as "30 days" 
          ,sum(case when (cs_ship_date_sk - cs_sold_date_sk > 30) and 
                         (cs_ship_date_sk - cs_sold_date_sk <= 60) then 1 else 0 end )  as "31-60 days" 
          ,sum(case when (cs_ship_date_sk - cs_sold_date_sk > 60) and 
                         (cs_ship_date_sk - cs_sold_date_sk <= 90) then 1 else 0 end)  as "61-90 days" 
          ,sum(case when (cs_ship_date_sk - cs_sold_date_sk > 90) and
                         (cs_ship_date_sk - cs_sold_date_sk <= 120) then 1 else 0 end)  as "91-120 days" 
          ,sum(case when (cs_ship_date_sk - cs_sold_date_sk  > 120) then 1 else 0 end)  as ">120 days" 
        from
           catalog_sales
          ,warehouse
          ,ship_mode
          ,call_center
          ,date_dim
        where
            d_month_seq between 1219 and 1219 + 11
        and cs_ship_date_sk   = d_date_sk
        and cs_warehouse_sk   = w_warehouse_sk
        and cs_ship_mode_sk   = sm_ship_mode_sk
        and cs_call_center_sk = cc_call_center_sk
        group by
        substring(w_warehouse_name,1,20) /* substr(w_warehouse_name,1,20) */
          ,sm_type
          ,cc_name
        order by substring(w_warehouse_name,1,20) /* order by substr(w_warehouse_name,1,20) */
                ,sm_type
                ,cc_name
        OPTION (LABEL = 'TPC-DS Query 99');


