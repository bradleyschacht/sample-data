/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 1 GB (GB_001) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 73   *************************************/

        select c_last_name
               ,c_first_name
               ,c_salutation
               ,c_preferred_cust_flag 
               ,ss_ticket_number
               ,cnt from
           (select ss_ticket_number
                  ,ss_customer_sk
                  ,count(*) cnt
            from store_sales,date_dim,store,household_demographics
            where store_sales.ss_sold_date_sk = date_dim.d_date_sk
            and store_sales.ss_store_sk = store.s_store_sk  
            and store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk
            and date_dim.d_dom between 1 and 2 
            and (household_demographics.hd_buy_potential = '>10000' or
                 household_demographics.hd_buy_potential = '0-500')
            and household_demographics.hd_vehicle_count > 0
            and case when household_demographics.hd_vehicle_count > 0 then 
                     household_demographics.hd_dep_count/ household_demographics.hd_vehicle_count else null end > 1
            and date_dim.d_year in (1998,1998+1,1998+2)
            and store.s_county in ('Williamson County','Williamson County','Williamson County','Williamson County')
            group by ss_ticket_number,ss_customer_sk) dj,customer
            where ss_customer_sk = c_customer_sk
              and cnt between 1 and 5
    order by cnt desc, c_last_name asc
        OPTION (LABEL = 'TPC-DS Query 73');


