/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-07
    This is the TPC-DS 1000 GB (TB_001) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 09   *************************************/

        select case when (select count_big(*) /* select case when (select count(*) */
                          from store_sales 
                          where ss_quantity between 1 and 20) > 14797487
                    then (select avg(ss_ext_list_price) 
                          from store_sales 
                          where ss_quantity between 1 and 20) 
                    else (select avg(ss_net_profit)
                          from store_sales
                          where ss_quantity between 1 and 20) end bucket1 ,
        case when (select count_big(*) /* case when (select count(*) */
                          from store_sales
                          where ss_quantity between 21 and 40) > 17121733
                    then (select avg(ss_ext_list_price)
                          from store_sales
                          where ss_quantity between 21 and 40) 
                    else (select avg(ss_net_profit)
                          from store_sales
                          where ss_quantity between 21 and 40) end bucket2,
        case when (select count_big(*) /* case when (select count(*) */
                          from store_sales
                          where ss_quantity between 41 and 60) > 7142264
                    then (select avg(ss_ext_list_price)
                          from store_sales
                          where ss_quantity between 41 and 60)
                    else (select avg(ss_net_profit)
                          from store_sales
                          where ss_quantity between 41 and 60) end bucket3,
        case when (select count_big(*) /* case when (select count(*) */
                          from store_sales
                          where ss_quantity between 61 and 80) > 37624992
                    then (select avg(ss_ext_list_price)
                          from store_sales
                          where ss_quantity between 61 and 80)
                    else (select avg(ss_net_profit)
                          from store_sales
                          where ss_quantity between 61 and 80) end bucket4,
        case when (select count_big(*) /* case when (select count(*) */
                          from store_sales
                          where ss_quantity between 81 and 100) > 416332
                    then (select avg(ss_ext_list_price)
                          from store_sales
                          where ss_quantity between 81 and 100)
                    else (select avg(ss_net_profit)
                          from store_sales
                          where ss_quantity between 81 and 100) end bucket5
        from reason
        where r_reason_sk = 1
        OPTION (LABEL = 'TPC-DS Query 09');

