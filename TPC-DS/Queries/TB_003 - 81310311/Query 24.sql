/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 3000 GB (TB_003) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 24   *************************************/

        ;with ssales as
        (select c_last_name
              ,c_first_name
              ,s_store_name
              ,ca_state
              ,s_state
              ,i_color
              ,i_current_price
              ,i_manager_id
              ,i_units
              ,i_size
              ,sum(ss_ext_sales_price) netpaid
        from store_sales
            ,store_returns
            ,store
            ,item
            ,customer
            ,customer_address
        where ss_ticket_number = sr_ticket_number
          and ss_item_sk = sr_item_sk
          and ss_customer_sk = c_customer_sk
          and ss_item_sk = i_item_sk
          and ss_store_sk = s_store_sk
          and c_current_addr_sk = ca_address_sk
          and c_birth_country <> upper(ca_country)
          and s_zip = ca_zip
        and s_market_id=7
        group by c_last_name
                ,c_first_name
                ,s_store_name
                ,ca_state
                ,s_state
                ,i_color
                ,i_current_price
                ,i_manager_id
                ,i_units
                ,i_size)
        select c_last_name
              ,c_first_name
              ,s_store_name
              ,sum(netpaid) paid
        from ssales
        where i_color = 'frosted'
        group by c_last_name
                ,c_first_name
                ,s_store_name
        having sum(netpaid) > (select 0.05*avg(netpaid)
                                         from ssales)
        order by c_last_name
                ,c_first_name
                ,s_store_name
        ;
        with ssales as
        (select c_last_name
              ,c_first_name
              ,s_store_name
              ,ca_state
              ,s_state
              ,i_color
              ,i_current_price
              ,i_manager_id
              ,i_units
              ,i_size
              ,sum(ss_ext_sales_price) netpaid
        from store_sales
            ,store_returns
            ,store
            ,item
            ,customer
            ,customer_address
        where ss_ticket_number = sr_ticket_number
          and ss_item_sk = sr_item_sk
          and ss_customer_sk = c_customer_sk
          and ss_item_sk = i_item_sk
          and ss_store_sk = s_store_sk
          and c_current_addr_sk = ca_address_sk
          and c_birth_country <> upper(ca_country)
          and s_zip = ca_zip
          and s_market_id = 7
        group by c_last_name
                ,c_first_name
                ,s_store_name
                ,ca_state
                ,s_state
                ,i_color
                ,i_current_price
                ,i_manager_id
                ,i_units
                ,i_size)
        select c_last_name
              ,c_first_name
              ,s_store_name
              ,sum(netpaid) paid
        from ssales
        where i_color = 'brown'
        group by c_last_name
                ,c_first_name
                ,s_store_name
        having sum(netpaid) > (select 0.05*avg(netpaid)
                                   from ssales)
        order by c_last_name
                ,c_first_name
                ,s_store_name
        OPTION (LABEL = 'TPC-DS Query 24');


