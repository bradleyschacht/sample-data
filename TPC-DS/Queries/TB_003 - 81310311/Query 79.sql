/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 3000 GB (TB_003) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 79   *************************************/

        select top 100
        c_last_name,c_first_name,substring(s_city,1,30),ss_ticket_number,amt,profit /* c_last_name,c_first_name,substr(s_city,1,30),ss_ticket_number,amt,profit */
          from
           (select ss_ticket_number
                  ,ss_customer_sk
                  ,store.s_city
                  ,sum(ss_coupon_amt) amt
                  ,sum(ss_net_profit) profit
            from store_sales,date_dim,store,household_demographics
            where store_sales.ss_sold_date_sk = date_dim.d_date_sk
            and store_sales.ss_store_sk = store.s_store_sk  
            and store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk
            and (household_demographics.hd_dep_count = 2 or household_demographics.hd_vehicle_count > 2)
            and date_dim.d_dow = 1
            and date_dim.d_year in (1998,1998+1,1998+2) 
            and store.s_number_employees between 200 and 295
            group by ss_ticket_number,ss_customer_sk,ss_addr_sk,store.s_city) ms,customer
            where ss_customer_sk = c_customer_sk
        order by c_last_name,c_first_name,substring(s_city,1,30), profit /* order by c_last_name,c_first_name,substr(s_city,1,30), profit */
        OPTION (LABEL = 'TPC-DS Query 79');


