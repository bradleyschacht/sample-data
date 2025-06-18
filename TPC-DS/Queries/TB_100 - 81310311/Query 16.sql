/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 100000 GB (TB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 16   *************************************/

        select top 100 
           count(distinct cs_order_number) as "order count"
          ,sum(cs_ext_ship_cost) as "total shipping cost"
          ,sum(cs_net_profit) as "total net profit"
        from
           catalog_sales cs1
          ,date_dim
          ,customer_address
          ,call_center
        where
            d_date between '2001-3-01' and 
                   (dateadd(day, + 60, cast('2001-3-01' as date))) /*  (cast('2001-3-01' as date) + 60 days)  */
        and cs1.cs_ship_date_sk = d_date_sk
        and cs1.cs_ship_addr_sk = ca_address_sk
        and ca_state = 'VA'
        and cs1.cs_call_center_sk = cc_call_center_sk
        and cc_county in ('Barrow County','Richland County','Bronx County','Mobile County',
                          'Ziebach County'
        )
        and exists (select *
                    from catalog_sales cs2
                    where cs1.cs_order_number = cs2.cs_order_number
                      and cs1.cs_warehouse_sk <> cs2.cs_warehouse_sk)
        and not exists(select *
                       from catalog_returns cr1
                       where cs1.cs_order_number = cr1.cr_order_number)
        order by count(distinct cs_order_number)
        OPTION (LABEL = 'TPC-DS Query 16');


