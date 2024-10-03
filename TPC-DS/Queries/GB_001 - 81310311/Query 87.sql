/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-03
    This is the TPC-DS 1 GB (GB_001) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 87   *************************************/

        select count(*) 
        from ((select distinct c_last_name, c_first_name, d_date
               from store_sales, date_dim, customer
               where store_sales.ss_sold_date_sk = date_dim.d_date_sk
                 and store_sales.ss_customer_sk = customer.c_customer_sk
                 and d_month_seq between 1219 and 1219+11)
               except
              (select distinct c_last_name, c_first_name, d_date
               from catalog_sales, date_dim, customer
               where catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
                 and catalog_sales.cs_bill_customer_sk = customer.c_customer_sk
                 and d_month_seq between 1219 and 1219+11)
               except
              (select distinct c_last_name, c_first_name, d_date
               from web_sales, date_dim, customer
               where web_sales.ws_sold_date_sk = date_dim.d_date_sk
                 and web_sales.ws_bill_customer_sk = customer.c_customer_sk
                 and d_month_seq between 1219 and 1219+11)
        ) cool_cust
        OPTION (LABEL = 'TPC-DS Query 87');


