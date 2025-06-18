/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 100 GB (GB_100) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 21   *************************************/

        select top 100 *
         from(select w_warehouse_name
                    ,i_item_id
                    ,sum(case when (cast(d_date as date) < cast ('1998-03-11' as date))
        	                then inv_quantity_on_hand 
                              else 0 end) as inv_before
                    ,sum(case when (cast(d_date as date) >= cast ('1998-03-11' as date))
                              then inv_quantity_on_hand 
                              else 0 end) as inv_after
           from inventory
               ,warehouse
               ,item
               ,date_dim
           where i_current_price between 0.99 and 1.49
             and i_item_sk          = inv_item_sk
             and inv_warehouse_sk   = w_warehouse_sk
             and inv_date_sk    = d_date_sk
             and d_date between (dateadd(day, - 30, cast('1998-03-11' as date))) /*  and d_date between (cast ('1998-03-11' as date) - 30 days)  */
                            and (dateadd(day, + 30, cast('1998-03-11' as date))) /*  and (cast ('1998-03-11' as date) + 30 days)  */
           group by w_warehouse_name, i_item_id) x
         where (case when inv_before > 0 
                     then inv_after / inv_before 
                     else null
                     end) between 2.0/3.0 and 3.0/2.0
         order by w_warehouse_name
                 ,i_item_id
        OPTION (LABEL = 'TPC-DS Query 21');


