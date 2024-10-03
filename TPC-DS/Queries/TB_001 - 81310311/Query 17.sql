/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-03
    This is the TPC-DS 1000 GB (TB_001) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 17   *************************************/

        select top 100 i_item_id
               ,i_item_desc
               ,s_state
               ,count(ss_quantity) as store_sales_quantitycount
               ,avg(ss_quantity) as store_sales_quantityave
        ,stdev(ss_quantity) as store_sales_quantitystdev /* ,stddev_samp(ss_quantity) as store_sales_quantitystdev */
        ,stdev(ss_quantity)/avg(ss_quantity) as store_sales_quantitycov /* ,stddev_samp(ss_quantity)/avg(ss_quantity) as store_sales_quantitycov */
               ,count(sr_return_quantity) as store_returns_quantitycount
               ,avg(sr_return_quantity) as store_returns_quantityave
        ,stdev(sr_return_quantity) as store_returns_quantitystdev /* ,stddev_samp(sr_return_quantity) as store_returns_quantitystdev */
        ,stdev(sr_return_quantity)/avg(sr_return_quantity) as store_returns_quantitycov /* ,stddev_samp(sr_return_quantity)/avg(sr_return_quantity) as store_returns_quantitycov */
               ,count(cs_quantity) as catalog_sales_quantitycount ,avg(cs_quantity) as catalog_sales_quantityave
        ,stdev(cs_quantity) as catalog_sales_quantitystdev /* ,stddev_samp(cs_quantity) as catalog_sales_quantitystdev */
        ,stdev(cs_quantity)/avg(cs_quantity) as catalog_sales_quantitycov /* ,stddev_samp(cs_quantity)/avg(cs_quantity) as catalog_sales_quantitycov */
         from store_sales
             ,store_returns
             ,catalog_sales
             ,date_dim d1
             ,date_dim d2
             ,date_dim d3
             ,store
             ,item
         where d1.d_quarter_name = '1998Q1'
           and d1.d_date_sk = ss_sold_date_sk
           and i_item_sk = ss_item_sk
           and s_store_sk = ss_store_sk
           and ss_customer_sk = sr_customer_sk
           and ss_item_sk = sr_item_sk
           and ss_ticket_number = sr_ticket_number
           and sr_returned_date_sk = d2.d_date_sk
           and d2.d_quarter_name in ('1998Q1','1998Q2','1998Q3')
           and sr_customer_sk = cs_bill_customer_sk
           and sr_item_sk = cs_item_sk
           and cs_sold_date_sk = d3.d_date_sk
           and d3.d_quarter_name in ('1998Q1','1998Q2','1998Q3')
         group by i_item_id
                 ,i_item_desc
                 ,s_state
         order by i_item_id
                 ,i_item_desc
                 ,s_state
        OPTION (LABEL = 'TPC-DS Query 17');


