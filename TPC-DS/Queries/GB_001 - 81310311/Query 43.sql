/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 1 GB (GB_001) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 43   *************************************/

        select top 100 s_store_name, s_store_id,
                sum(case when (d_day_name='Sunday') then ss_sales_price else null end) sun_sales,
                sum(case when (d_day_name='Monday') then ss_sales_price else null end) mon_sales,
                sum(case when (d_day_name='Tuesday') then ss_sales_price else  null end) tue_sales,
                sum(case when (d_day_name='Wednesday') then ss_sales_price else null end) wed_sales,
                sum(case when (d_day_name='Thursday') then ss_sales_price else null end) thu_sales,
                sum(case when (d_day_name='Friday') then ss_sales_price else null end) fri_sales,
                sum(case when (d_day_name='Saturday') then ss_sales_price else null end) sat_sales
         from date_dim, store_sales, store
         where d_date_sk = ss_sold_date_sk and
               s_store_sk = ss_store_sk and
               s_gmt_offset = -5 and
               d_year = 1998 
         group by s_store_name, s_store_id
         order by s_store_name, s_store_id,sun_sales,mon_sales,tue_sales,wed_sales,thu_sales,fri_sales,sat_sales
        OPTION (LABEL = 'TPC-DS Query 43');


