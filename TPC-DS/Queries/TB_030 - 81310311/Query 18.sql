/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 30000 GB (TB_030) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 18   *************************************/

        select top 100 i_item_id,
                ca_country,
                ca_state, 
                ca_county,
                avg( cast(cs_quantity as decimal(12,2))) agg1,
                avg( cast(cs_list_price as decimal(12,2))) agg2,
                avg( cast(cs_coupon_amt as decimal(12,2))) agg3,
                avg( cast(cs_sales_price as decimal(12,2))) agg4,
                avg( cast(cs_net_profit as decimal(12,2))) agg5,
                avg( cast(c_birth_year as decimal(12,2))) agg6,
                avg( cast(cd1.cd_dep_count as decimal(12,2))) agg7
         from catalog_sales, customer_demographics cd1, 
              customer_demographics cd2, customer, customer_address, date_dim, item
         where cs_sold_date_sk = d_date_sk and
               cs_item_sk = i_item_sk and
               cs_bill_cdemo_sk = cd1.cd_demo_sk and
               cs_bill_customer_sk = c_customer_sk and
               cd1.cd_gender = 'M' and 
               cd1.cd_education_status = '2 yr Degree' and
               c_current_cdemo_sk = cd2.cd_demo_sk and
               c_current_addr_sk = ca_address_sk and
               c_birth_month in (11,10,8,9,4,5) and
               d_year = 2002 and
               ca_state in ('TN','CA','KS'
                           ,'MS','AL','WI','VA')
         group by rollup (i_item_id, ca_country, ca_state, ca_county)
         order by ca_country,
                ca_state, 
                ca_county,
        	i_item_id
        OPTION (LABEL = 'TPC-DS Query 18');


