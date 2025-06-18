/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 100000 GB (TB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 15   *************************************/

        select top 100 ca_zip
               ,sum(cs_sales_price)
         from catalog_sales
             ,customer
             ,customer_address
             ,date_dim
         where cs_bill_customer_sk = c_customer_sk
         	and c_current_addr_sk = ca_address_sk 
        and ( substring(ca_zip,1,5) in ('85669', '86197','88274','83405','86475', /* and ( substr(ca_zip,1,5) in ('85669', '86197','88274','83405','86475', */
                                           '85392', '85460', '80348', '81792')
         	      or ca_state in ('CA','WA','GA')
         	      or cs_sales_price > 500)
         	and cs_sold_date_sk = d_date_sk
         	and d_qoy = 2 and d_year = 2001
         group by ca_zip
         order by ca_zip
        OPTION (LABEL = 'TPC-DS Query 15');


