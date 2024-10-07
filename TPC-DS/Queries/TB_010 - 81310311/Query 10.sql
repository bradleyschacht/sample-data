/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-07
    This is the TPC-DS 10000 GB (TB_010) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 10   *************************************/

        select top 100 
          cd_gender,
          cd_marital_status,
          cd_education_status,
          count(*) cnt1,
          cd_purchase_estimate,
          count(*) cnt2,
          cd_credit_rating,
          count(*) cnt3,
          cd_dep_count,
          count(*) cnt4,
          cd_dep_employed_count,
          count(*) cnt5,
          cd_dep_college_count,
          count(*) cnt6
         from
          customer c,customer_address ca,customer_demographics
         where
          c.c_current_addr_sk = ca.ca_address_sk and
          ca_county in ('Dickinson County','McMinn County','Houston County','Carter County','Pickens County') and
          cd_demo_sk = c.c_current_cdemo_sk and 
          exists (select *
                  from store_sales,date_dim
                  where c.c_customer_sk = ss_customer_sk and
                        ss_sold_date_sk = d_date_sk and
                        d_year = 2000 and
                        d_moy between 2 and 2+3) and
           (exists (select *
                    from web_sales,date_dim
                    where c.c_customer_sk = ws_bill_customer_sk and
                          ws_sold_date_sk = d_date_sk and
                          d_year = 2000 and
                          d_moy between 2 ANd 2+3) or 
            exists (select * 
                    from catalog_sales,date_dim
                    where c.c_customer_sk = cs_ship_customer_sk and
                          cs_sold_date_sk = d_date_sk and
                          d_year = 2000 and
                          d_moy between 2 and 2+3))
         group by cd_gender,
                  cd_marital_status,
                  cd_education_status,
                  cd_purchase_estimate,
                  cd_credit_rating,
                  cd_dep_count,
                  cd_dep_employed_count,
                  cd_dep_college_count
         order by cd_gender,
                  cd_marital_status,
                  cd_education_status,
                  cd_purchase_estimate,
                  cd_credit_rating,
                  cd_dep_count,
                  cd_dep_employed_count,
                  cd_dep_college_count
        OPTION (LABEL = 'TPC-DS Query 10');


