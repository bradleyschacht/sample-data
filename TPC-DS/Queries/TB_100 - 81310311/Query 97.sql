/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 100000 GB (TB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 97   *************************************/

        ;with ssci as (
        select ss_customer_sk customer_sk
              ,ss_item_sk item_sk
        from store_sales,date_dim
        where ss_sold_date_sk = d_date_sk
          and d_month_seq between 1219 and 1219 + 11
        group by ss_customer_sk
                ,ss_item_sk),
        csci as(
         select cs_bill_customer_sk customer_sk
              ,cs_item_sk item_sk
        from catalog_sales,date_dim
        where cs_sold_date_sk = d_date_sk
          and d_month_seq between 1219 and 1219 + 11
        group by cs_bill_customer_sk
                ,cs_item_sk)
        select top 100 sum(convert(bigint, case when ssci.customer_sk is not null and csci.customer_sk is null then 1 else 0 end)) store_only /* select top 100 sum(case when ssci.customer_sk is not null and csci.customer_sk is null then 1 else 0 end)) store_only */ /* select top 100 sum(convert(bigint, case when ssci.customer_sk is not null and csci.customer_sk is null then 1 else 0 end) store_only /* select top 100 sum(case when ssci.customer_sk is not null and csci.customer_sk is null then 1 else 0 end) store_only */ */
        ,sum(convert(bigint, case when ssci.customer_sk is null and csci.customer_sk is not null then 1 else 0 end)) catalog_only /* ,sum(case when ssci.customer_sk is null and csci.customer_sk is not null then 1 else 0 end)) catalog_only */ /* ,sum(convert(bigint, case when ssci.customer_sk is null and csci.customer_sk is not null then 1 else 0 end) catalog_only /* ,sum(case when ssci.customer_sk is null and csci.customer_sk is not null then 1 else 0 end) catalog_only */ */
        ,sum(convert(bigint, case when ssci.customer_sk is not null and csci.customer_sk is not null then 1 else 0 end)) store_and_catalog /* ,sum(case when ssci.customer_sk is not null and csci.customer_sk is not null then 1 else 0 end)) store_and_catalog */ /* ,sum(convert(bigint, case when ssci.customer_sk is not null and csci.customer_sk is not null then 1 else 0 end) store_and_catalog /* ,sum(case when ssci.customer_sk is not null and csci.customer_sk is not null then 1 else 0 end) store_and_catalog */ */
        from ssci full outer join csci on (ssci.customer_sk=csci.customer_sk
                                       and ssci.item_sk = csci.item_sk)
        OPTION (LABEL = 'TPC-DS Query 97');


