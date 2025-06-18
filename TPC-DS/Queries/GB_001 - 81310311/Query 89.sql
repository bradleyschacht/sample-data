/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 1 GB (GB_001) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 89   *************************************/

        select top 100 *
        from(
        select i_category, i_class, i_brand,
               s_store_name, s_company_name,
               d_moy,
               sum(ss_sales_price) sum_sales,
               avg(sum(ss_sales_price)) over
                 (partition by i_category, i_brand, s_store_name, s_company_name)
                 avg_monthly_sales
        from item, store_sales, date_dim, store
        where ss_item_sk = i_item_sk and
              ss_sold_date_sk = d_date_sk and
              ss_store_sk = s_store_sk and
              d_year in (2000) and
                ((i_category in ('Sports','Jewelry','Shoes') and
                  i_class in ('optics','costume','athletic')
                 )
              or (i_category in ('Home','Books','Women') and
                  i_class in ('decor','parenting','fragrances') 
                ))
        group by i_category, i_class, i_brand,
                 s_store_name, s_company_name, d_moy) tmp1
        where case when (avg_monthly_sales <> 0) then (abs(sum_sales - avg_monthly_sales) / avg_monthly_sales) else null end > 0.1
        order by sum_sales - avg_monthly_sales, s_store_name
        OPTION (LABEL = 'TPC-DS Query 89');


