/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-03
    This is the TPC-DS 30000 GB (TB_030) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 69   *************************************/

        select top 100 
          cd_gender,
          cd_marital_status,
          cd_education_status,
          count(*) cnt1,
          cd_purchase_estimate,
          count(*) cnt2,
          cd_credit_rating,
          count(*) cnt3
         from
          customer c,customer_address ca,customer_demographics
         where
          c.c_current_addr_sk = ca.ca_address_sk and
          ca_state in ('FL','TN','IA') and
          cd_demo_sk = c.c_current_cdemo_sk and 
          exists (select *
                  from store_sales,date_dim
                  where c.c_customer_sk = ss_customer_sk and
                        ss_sold_date_sk = d_date_sk and
                        d_year = 1999 and
                        d_moy between 2 and 2+2) and
           (not exists (select *
                    from web_sales,date_dim
                    where c.c_customer_sk = ws_bill_customer_sk and
                          ws_sold_date_sk = d_date_sk and
                          d_year = 1999 and
                          d_moy between 2 and 2+2) and
            not exists (select * 
                    from catalog_sales,date_dim
                    where c.c_customer_sk = cs_ship_customer_sk and
                          cs_sold_date_sk = d_date_sk and
                          d_year = 1999 and
                          d_moy between 2 and 2+2))
         group by cd_gender,
                  cd_marital_status,
                  cd_education_status,
                  cd_purchase_estimate,
                  cd_credit_rating
         order by cd_gender,
                  cd_marital_status,
                  cd_education_status,
                  cd_purchase_estimate,
                  cd_credit_rating
        OPTION (LABEL = 'TPC-DS Query 69');


