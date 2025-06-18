/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 100 GB (GB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 34   *************************************/

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
            and (date_dim.d_dom between 1 and 3 or date_dim.d_dom between 25 and 28)
            and (household_demographics.hd_buy_potential = '>10000' or
                 household_demographics.hd_buy_potential = '5001-10000')
            and household_demographics.hd_vehicle_count > 0
            and (case when household_demographics.hd_vehicle_count > 0 
        	then household_demographics.hd_dep_count/ household_demographics.hd_vehicle_count 
        	else null 
        	end)  > 1.2
            and date_dim.d_year in (1998,1998+1,1998+2)
            and store.s_county in ('Luce County','Ziebach County','Walker County','Barrow County',
                                   'Franklin Parish','Williamson County','Fairfield County','Richland County')
            group by ss_ticket_number,ss_customer_sk) dn,customer
            where ss_customer_sk = c_customer_sk
              and cnt between 15 and 20
    order by c_last_name,c_first_name,c_salutation,c_preferred_cust_flag desc, ss_ticket_number
        OPTION (LABEL = 'TPC-DS Query 34');


