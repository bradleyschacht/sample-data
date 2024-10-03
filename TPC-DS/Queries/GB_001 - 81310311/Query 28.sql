/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-03
    This is the TPC-DS 1 GB (GB_001) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 28   *************************************/

        select top 100 *
        from (select avg(ss_list_price) B1_LP
                    ,count(ss_list_price) B1_CNT
                    ,count(distinct ss_list_price) B1_CNTD
              from store_sales
              where ss_quantity between 0 and 5
                and (ss_list_price between 179 and 179+10 
                     or ss_coupon_amt between 1490 and 1490+1000
                     or ss_wholesale_cost between 54 and 54+20)) B1,
             (select avg(ss_list_price) B2_LP
                    ,count(ss_list_price) B2_CNT
                    ,count(distinct ss_list_price) B2_CNTD
              from store_sales
              where ss_quantity between 6 and 10
                and (ss_list_price between 86 and 86+10
                  or ss_coupon_amt between 8268 and 8268+1000
                  or ss_wholesale_cost between 13 and 13+20)) B2,
             (select avg(ss_list_price) B3_LP
                    ,count(ss_list_price) B3_CNT
                    ,count(distinct ss_list_price) B3_CNTD
              from store_sales
              where ss_quantity between 11 and 15
                and (ss_list_price between 131 and 131+10
                  or ss_coupon_amt between 3031 and 3031+1000
                  or ss_wholesale_cost between 45 and 45+20)) B3,
             (select avg(ss_list_price) B4_LP
                    ,count(ss_list_price) B4_CNT
                    ,count(distinct ss_list_price) B4_CNTD
              from store_sales
              where ss_quantity between 16 and 20
                and (ss_list_price between 75 and 75+10
                  or ss_coupon_amt between 9829 and 9829+1000
                  or ss_wholesale_cost between 73 and 73+20)) B4,
             (select avg(ss_list_price) B5_LP
                    ,count(ss_list_price) B5_CNT
                    ,count(distinct ss_list_price) B5_CNTD
              from store_sales
              where ss_quantity between 21 and 25
                and (ss_list_price between 37 and 37+10
                  or ss_coupon_amt between 8079 and 8079+1000
                  or ss_wholesale_cost between 34 and 34+20)) B5,
             (select avg(ss_list_price) B6_LP
                    ,count(ss_list_price) B6_CNT
                    ,count(distinct ss_list_price) B6_CNTD
              from store_sales
              where ss_quantity between 26 and 30
                and (ss_list_price between 183 and 183+10
                  or ss_coupon_amt between 4309 and 4309+1000
                  or ss_wholesale_cost between 18 and 18+20)) B6
        OPTION (LABEL = 'TPC-DS Query 28');


