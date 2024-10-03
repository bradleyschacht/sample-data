/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-03
    This is the TPC-DS 10000 GB (TB_010) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 93   *************************************/

        select top 100 ss_customer_sk
                    ,sum(act_sales) sumsales
              from (select ss_item_sk
                          ,ss_ticket_number
                          ,ss_customer_sk
                          ,case when sr_return_quantity is not null then (ss_quantity-sr_return_quantity)*ss_sales_price
                                                                    else (ss_quantity*ss_sales_price) end act_sales
                    from store_sales left outer join store_returns on (sr_item_sk = ss_item_sk
                                                                       and sr_ticket_number = ss_ticket_number)
                        ,reason
                    where sr_reason_sk = r_reason_sk
                      and r_reason_desc = 'reason 61') t
              group by ss_customer_sk
              order by sumsales, ss_customer_sk
        OPTION (LABEL = 'TPC-DS Query 93');


