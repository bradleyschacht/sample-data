/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 300 GB (GB_300) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 85   *************************************/

        select top 100 substring(r_reason_desc,1,20) /* select top 100 substr(r_reason_desc,1,20) */
               ,avg(ws_quantity)
               ,avg(wr_refunded_cash)
               ,avg(wr_fee)
         from web_sales, web_returns, web_page, customer_demographics cd1,
              customer_demographics cd2, customer_address, date_dim, reason 
         where ws_web_page_sk = wp_web_page_sk
           and ws_item_sk = wr_item_sk
           and ws_order_number = wr_order_number
           and ws_sold_date_sk = d_date_sk and d_year = 1998
           and cd1.cd_demo_sk = wr_refunded_cdemo_sk 
           and cd2.cd_demo_sk = wr_returning_cdemo_sk
           and ca_address_sk = wr_refunded_addr_sk
           and r_reason_sk = wr_reason_sk
           and
           (
            (
             cd1.cd_marital_status = 'M'
             and
             cd1.cd_marital_status = cd2.cd_marital_status
             and
             cd1.cd_education_status = '4 yr Degree'
             and 
             cd1.cd_education_status = cd2.cd_education_status
             and
             ws_sales_price between 100.00 and 150.00
            )
           or
            (
             cd1.cd_marital_status = 'U'
             and
             cd1.cd_marital_status = cd2.cd_marital_status
             and
             cd1.cd_education_status = '2 yr Degree' 
             and
             cd1.cd_education_status = cd2.cd_education_status
             and
             ws_sales_price between 50.00 and 100.00
            )
           or
            (
             cd1.cd_marital_status = 'D'
             and
             cd1.cd_marital_status = cd2.cd_marital_status
             and
             cd1.cd_education_status = 'Advanced Degree'
             and
             cd1.cd_education_status = cd2.cd_education_status
             and
             ws_sales_price between 150.00 and 200.00
            )
           )
           and
           (
            (
             ca_country = 'United States'
             and
             ca_state in ('TN', 'IA', 'MS')
             and ws_net_profit between 100 and 200  
            )
            or
            (
             ca_country = 'United States'
             and
             ca_state in ('GA', 'VA', 'TX')
             and ws_net_profit between 150 and 300  
            )
            or
            (
             ca_country = 'United States'
             and
             ca_state in ('MI', 'SD', 'IL')
             and ws_net_profit between 50 and 250  
            )
           )
        group by r_reason_desc
        order by substring(r_reason_desc,1,20) /* order by substr(r_reason_desc,1,20) */
                ,avg(ws_quantity)
                ,avg(wr_refunded_cash)
                ,avg(wr_fee)
        OPTION (LABEL = 'TPC-DS Query 85');


