/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 30000 GB (TB_030) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 95   *************************************/

        ;with ws_wh as
        (select ws1.ws_order_number,ws1.ws_warehouse_sk wh1,ws2.ws_warehouse_sk wh2
         from web_sales ws1,web_sales ws2
         where ws1.ws_order_number = ws2.ws_order_number
           and ws1.ws_warehouse_sk <> ws2.ws_warehouse_sk)
         select top 100 
           count(distinct ws_order_number) as "order count"
          ,sum(ws_ext_ship_cost) as "total shipping cost"
          ,sum(ws_net_profit) as "total net profit"
        from
           web_sales ws1
          ,date_dim
          ,customer_address
          ,web_site
        where
            d_date between '2001-3-01' and 
                   (dateadd(day, + 60, cast('2001-3-01' as date))) /*  (cast('2001-3-01' as date) + 60 days)  */
        and ws1.ws_ship_date_sk = d_date_sk
        and ws1.ws_ship_addr_sk = ca_address_sk
        and ca_state = 'FL'
        and ws1.ws_web_site_sk = web_site_sk
        and web_company_name = 'pri'
        and ws1.ws_order_number in (select ws_order_number
                                    from ws_wh)
        and ws1.ws_order_number in (select wr_order_number
                                    from web_returns,ws_wh
                                    where wr_order_number = ws_wh.ws_order_number)
        order by count(distinct ws_order_number)
        OPTION (LABEL = 'TPC-DS Query 95');


