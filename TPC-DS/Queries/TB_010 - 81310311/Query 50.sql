/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 10000 GB (TB_010) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 50   *************************************/

        select top 100 
           s_store_name
          ,s_company_id
          ,s_street_number
          ,s_street_name
          ,s_street_type
          ,s_suite_number
          ,s_city
          ,s_county
          ,s_state
          ,s_zip
          ,sum(case when (sr_returned_date_sk - ss_sold_date_sk <= 30 ) then 1 else 0 end)  as "30 days" 
          ,sum(case when (sr_returned_date_sk - ss_sold_date_sk > 30) and 
                         (sr_returned_date_sk - ss_sold_date_sk <= 60) then 1 else 0 end )  as "31-60 days" 
          ,sum(case when (sr_returned_date_sk - ss_sold_date_sk > 60) and 
                         (sr_returned_date_sk - ss_sold_date_sk <= 90) then 1 else 0 end)  as "61-90 days" 
          ,sum(case when (sr_returned_date_sk - ss_sold_date_sk > 90) and
                         (sr_returned_date_sk - ss_sold_date_sk <= 120) then 1 else 0 end)  as "91-120 days" 
          ,sum(case when (sr_returned_date_sk - ss_sold_date_sk  > 120) then 1 else 0 end)  as ">120 days" 
        from
           store_sales
          ,store_returns
          ,store
          ,date_dim d1
          ,date_dim d2
        where
            d2.d_year = 2001
        and d2.d_moy  = 8
        and ss_ticket_number = sr_ticket_number
        and ss_item_sk = sr_item_sk
        and ss_sold_date_sk   = d1.d_date_sk
        and sr_returned_date_sk   = d2.d_date_sk
        and ss_customer_sk = sr_customer_sk
        and ss_store_sk = s_store_sk
        group by
           s_store_name
          ,s_company_id
          ,s_street_number
          ,s_street_name
          ,s_street_type
          ,s_suite_number
          ,s_city
          ,s_county
          ,s_state
          ,s_zip
        order by s_store_name
                ,s_company_id
                ,s_street_number
                ,s_street_name
                ,s_street_type
                ,s_suite_number
                ,s_city
                ,s_county
                ,s_state
                ,s_zip
        OPTION (LABEL = 'TPC-DS Query 50');


