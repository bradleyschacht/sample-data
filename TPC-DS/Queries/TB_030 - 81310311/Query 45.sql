/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 30000 GB (TB_030) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 45   *************************************/

        select top 100 ca_zip, ca_city, sum(ws_sales_price)
         from web_sales, customer, customer_address, date_dim, item
         where ws_bill_customer_sk = c_customer_sk
         	and c_current_addr_sk = ca_address_sk 
         	and ws_item_sk = i_item_sk 
        and ( substring(ca_zip,1,5) in ('85669', '86197','88274','83405','86475', '85392', '85460', '80348', '81792') /* and ( substr(ca_zip,1,5) in ('85669', '86197','88274','83405','86475', '85392', '85460', '80348', '81792') */
         	      or 
         	      i_item_id in (select i_item_id
                                     from item
                                     where i_item_sk in (2, 3, 5, 7, 11, 13, 17, 19, 23, 29)
                                     )
         	    )
         	and ws_sold_date_sk = d_date_sk
         	and d_qoy = 2 and d_year = 2001
         group by ca_zip, ca_city
         order by ca_zip, ca_city
        OPTION (LABEL = 'TPC-DS Query 45');


