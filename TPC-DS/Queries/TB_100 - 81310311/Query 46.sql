/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-03
    This is the TPC-DS 100000 GB (TB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 46   *************************************/

        select top 100 c_last_name
               ,c_first_name
               ,ca_city
               ,bought_city
               ,ss_ticket_number
               ,amt,profit 
         from
           (select ss_ticket_number
                  ,ss_customer_sk
                  ,ca_city bought_city
                  ,sum(ss_coupon_amt) amt
                  ,sum(ss_net_profit) profit
            from store_sales,date_dim,store,household_demographics,customer_address 
            where store_sales.ss_sold_date_sk = date_dim.d_date_sk
            and store_sales.ss_store_sk = store.s_store_sk  
            and store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk
            and store_sales.ss_addr_sk = customer_address.ca_address_sk
            and (household_demographics.hd_dep_count = 3 or
                 household_demographics.hd_vehicle_count= 4)
            and date_dim.d_dow in (6,0)
            and date_dim.d_year in (2000,2000+1,2000+2) 
            and store.s_city in ('Englewood','Lexington','Greenwood','Scotland','Millville') 
            group by ss_ticket_number,ss_customer_sk,ss_addr_sk,ca_city) dn,customer,customer_address current_addr
            where ss_customer_sk = c_customer_sk
              and customer.c_current_addr_sk = current_addr.ca_address_sk
              and current_addr.ca_city <> bought_city
          order by c_last_name
                  ,c_first_name
                  ,ca_city
                  ,bought_city
                  ,ss_ticket_number
        OPTION (LABEL = 'TPC-DS Query 46');


