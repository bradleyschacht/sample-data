/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 100 GB (GB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 30   *************************************/

        ;with customer_total_return as
         (select wr_returning_customer_sk as ctr_customer_sk
                ,ca_state as ctr_state, 
         	sum(wr_return_amt) as ctr_total_return
         from web_returns
             ,date_dim
             ,customer_address
         where wr_returned_date_sk = d_date_sk 
           and d_year =2000
           and wr_returning_addr_sk = ca_address_sk 
         group by wr_returning_customer_sk
                 ,ca_state)
          select top 100 c_customer_id,c_salutation,c_first_name,c_last_name,c_preferred_cust_flag
               ,c_birth_day,c_birth_month,c_birth_year,c_birth_country,c_login,c_email_address
               ,c_last_review_date_sk,ctr_total_return
         from customer_total_return ctr1
             ,customer_address
             ,customer
         where ctr1.ctr_total_return > (select avg(ctr_total_return)*1.2
         			  from customer_total_return ctr2 
                          	  where ctr1.ctr_state = ctr2.ctr_state)
               and ca_address_sk = c_current_addr_sk
               and ca_state = 'TN'
               and ctr1.ctr_customer_sk = c_customer_sk
         order by c_customer_id,c_salutation,c_first_name,c_last_name,c_preferred_cust_flag
                          ,c_birth_day,c_birth_month,c_birth_year,c_birth_country,c_login,c_email_address
                          ,c_last_review_date_sk,ctr_total_return
        OPTION (LABEL = 'TPC-DS Query 30');


