/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 100000 GB (TB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 36   *************************************/

        select top 100 
            sum(ss_net_profit)/sum(ss_ext_sales_price) as gross_margin
           ,i_category
           ,i_class
           ,grouping(i_category)+grouping(i_class) as lochierarchy
           ,rank() over (
         	partition by grouping(i_category)+grouping(i_class),
         	case when grouping(i_class) = 0 then i_category end 
         	order by sum(ss_net_profit)/sum(ss_ext_sales_price) asc) as rank_within_parent
         from
            store_sales
           ,date_dim       d1
           ,item
           ,store
         where
            d1.d_year = 2002 
         and d1.d_date_sk = ss_sold_date_sk
         and i_item_sk  = ss_item_sk 
         and s_store_sk  = ss_store_sk
         and s_state in ('VT','OH','IL','GA',
                         'NM','MO','AL','NM')
         group by rollup(i_category,i_class)
         order by
           lochierarchy desc
        ,case when grouping(i_category)+grouping(i_class) = 0 then i_category end /* ,case when lochierarchy = 0 then i_category end */
          ,rank_within_parent
        OPTION (LABEL = 'TPC-DS Query 36');


