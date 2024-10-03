/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-03
    This is the TPC-DS 100000 GB (TB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 53   *************************************/

        select top 100 * from 
        (select i_manufact_id,
        sum(ss_sales_price) sum_sales,
        avg(sum(ss_sales_price)) over (partition by i_manufact_id) avg_quarterly_sales
        from item, store_sales, date_dim, store
        where ss_item_sk = i_item_sk and
        ss_sold_date_sk = d_date_sk and
        ss_store_sk = s_store_sk and
        d_month_seq in (1219,1219+1,1219+2,1219+3,1219+4,1219+5,1219+6,1219+7,1219+8,1219+9,1219+10,1219+11) and
        ((i_category in ('Books','Children','Electronics') and
        i_class in ('personal','portable','reference','self-help') and
        i_brand in ('scholaramalgamalg #14','scholaramalgamalg #7',
        		'exportiunivamalg #9','scholaramalgamalg #9'))
        or(i_category in ('Women','Music','Men') and
        i_class in ('accessories','classical','fragrances','pants') and
        i_brand in ('amalgimporto #1','edu packscholar #1','exportiimporto #1',
        		'importoamalg #1')))
        group by i_manufact_id, d_qoy ) tmp1
        where case when avg_quarterly_sales > 0 
        	then abs (sum_sales - avg_quarterly_sales)/ avg_quarterly_sales 
        	else null end > 0.1
        order by avg_quarterly_sales,
        	 sum_sales,
        	 i_manufact_id
        OPTION (LABEL = 'TPC-DS Query 53');


