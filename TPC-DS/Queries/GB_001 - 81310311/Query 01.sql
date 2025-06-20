/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 1 GB (GB_001) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 01   *************************************/

        ;with customer_total_return as
        (select sr_customer_sk as ctr_customer_sk
        ,sr_store_sk as ctr_store_sk
        ,sum(sr_fee) as ctr_total_return
        from store_returns
        ,date_dim
        where sr_returned_date_sk = d_date_sk
        and d_year =2001
        group by sr_customer_sk
        ,sr_store_sk)
         select top 100 c_customer_id
        from customer_total_return ctr1
        ,store
        ,customer
        where ctr1.ctr_total_return > (select avg(ctr_total_return)*1.2
        from customer_total_return ctr2
        where ctr1.ctr_store_sk = ctr2.ctr_store_sk)
        and s_store_sk = ctr1.ctr_store_sk
        and s_state = 'TN'
        and ctr1.ctr_customer_sk = c_customer_sk
        order by c_customer_id
        OPTION (LABEL = 'TPC-DS Query 01');


