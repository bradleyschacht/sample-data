/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 300 GB (GB_300) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 35   *************************************/

        select top 100  
          ca_state,
          cd_gender,
          cd_marital_status,
          cd_dep_count,
          count(*) cnt1,
          max(cd_dep_count),
          avg(cd_dep_count),
          sum(cd_dep_count),
          cd_dep_employed_count,
          count(*) cnt2,
          max(cd_dep_employed_count),
          avg(cd_dep_employed_count),
          sum(cd_dep_employed_count),
          cd_dep_college_count,
          count(*) cnt3,
          max(cd_dep_college_count),
          avg(cd_dep_college_count),
          sum(cd_dep_college_count)
         from
          customer c,customer_address ca,customer_demographics
         where
          c.c_current_addr_sk = ca.ca_address_sk and
          cd_demo_sk = c.c_current_cdemo_sk and 
          exists (select *
                  from store_sales,date_dim
                  where c.c_customer_sk = ss_customer_sk and
                        ss_sold_date_sk = d_date_sk and
                        d_year = 2001 and
                        d_qoy < 4) and
           (exists (select *
                    from web_sales,date_dim
                    where c.c_customer_sk = ws_bill_customer_sk and
                          ws_sold_date_sk = d_date_sk and
                          d_year = 2001 and
                          d_qoy < 4) or 
            exists (select * 
                    from catalog_sales,date_dim
                    where c.c_customer_sk = cs_ship_customer_sk and
                          cs_sold_date_sk = d_date_sk and
                          d_year = 2001 and
                          d_qoy < 4))
         group by ca_state,
                  cd_gender,
                  cd_marital_status,
                  cd_dep_count,
                  cd_dep_employed_count,
                  cd_dep_college_count
         order by ca_state,
                  cd_gender,
                  cd_marital_status,
                  cd_dep_count,
                  cd_dep_employed_count,
                  cd_dep_college_count
        OPTION (LABEL = 'TPC-DS Query 35');


