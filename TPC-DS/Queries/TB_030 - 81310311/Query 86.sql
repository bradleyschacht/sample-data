/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 30000 GB (TB_030) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 86   *************************************/

        select top 100  
            sum(ws_net_paid) as total_sum
           ,i_category
           ,i_class
           ,grouping(i_category)+grouping(i_class) as lochierarchy
           ,rank() over (
         	partition by grouping(i_category)+grouping(i_class),
         	case when grouping(i_class) = 0 then i_category end 
         	order by sum(ws_net_paid) desc) as rank_within_parent
         from
            web_sales
           ,date_dim       d1
           ,item
         where
            d1.d_month_seq between 1219 and 1219+11
         and d1.d_date_sk = ws_sold_date_sk
         and i_item_sk  = ws_item_sk
         group by rollup(i_category,i_class)
         order by
           lochierarchy desc,
        case when grouping(i_category)+grouping(i_class) = 0 then i_category end, /* case when lochierarchy = 0 then i_category end, */
           rank_within_parent
        OPTION (LABEL = 'TPC-DS Query 86');


