/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-03
    This is the TPC-DS 1000 GB (TB_001) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 70   *************************************/

        select top 100 
            sum(ss_net_profit) as total_sum
           ,s_state
           ,s_county
           ,grouping(s_state)+grouping(s_county) as lochierarchy
           ,rank() over (
         	partition by grouping(s_state)+grouping(s_county),
         	case when grouping(s_county) = 0 then s_state end 
         	order by sum(ss_net_profit) desc) as rank_within_parent
         from
            store_sales
           ,date_dim       d1
           ,store
         where
            d1.d_month_seq between 1219 and 1219+11
         and d1.d_date_sk = ss_sold_date_sk
         and s_store_sk  = ss_store_sk
         and s_state in
                     ( select s_state
                       from  (select s_state as s_state,
         			    rank() over ( partition by s_state order by sum(ss_net_profit) desc) as ranking
                              from   store_sales, store, date_dim
                              where  d_month_seq between 1219 and 1219+11
         			    and d_date_sk = ss_sold_date_sk
         			    and s_store_sk  = ss_store_sk
                              group by s_state
                             ) tmp1 
                       where ranking <= 5
                     )
         group by rollup(s_state,s_county)
         order by
           lochierarchy desc
        ,case when grouping(s_state)+grouping(s_county) = 0 then s_state end /* ,case when lochierarchy = 0 then s_state end */
          ,rank_within_parent
        OPTION (LABEL = 'TPC-DS Query 70');


