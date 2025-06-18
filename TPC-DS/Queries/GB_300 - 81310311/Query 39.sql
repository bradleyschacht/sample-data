/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 300 GB (GB_300) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 39   *************************************/

        ;with inv as
        (select w_warehouse_name,w_warehouse_sk,i_item_sk,d_moy
               ,stdev,mean, case mean when 0 then null else stdev/mean end cov
         from(select w_warehouse_name,w_warehouse_sk,i_item_sk,d_moy
        ,stdev(inv_quantity_on_hand) stdev,avg(inv_quantity_on_hand) mean /* ,stddev_samp(inv_quantity_on_hand) stdev,avg(inv_quantity_on_hand) mean */
              from inventory
                  ,item
                  ,warehouse
                  ,date_dim
              where inv_item_sk = i_item_sk
                and inv_warehouse_sk = w_warehouse_sk
                and inv_date_sk = d_date_sk
                and d_year =1998
              group by w_warehouse_name,w_warehouse_sk,i_item_sk,d_moy) foo
         where case mean when 0 then 0 else stdev/mean end > 1)
        select inv1.w_warehouse_sk,inv1.i_item_sk,inv1.d_moy,inv1.mean, inv1.cov
                ,inv2.w_warehouse_sk,inv2.i_item_sk,inv2.d_moy,inv2.mean, inv2.cov
        from inv inv1,inv inv2
        where inv1.i_item_sk = inv2.i_item_sk
          and inv1.w_warehouse_sk =  inv2.w_warehouse_sk
          and inv1.d_moy=2
          and inv2.d_moy=2+1
        order by inv1.w_warehouse_sk,inv1.i_item_sk,inv1.d_moy,inv1.mean,inv1.cov
                ,inv2.d_moy,inv2.mean, inv2.cov
         OPTION (LABEL = 'TPC-DS Query 39A'); /* ; */
        with inv as
        (select w_warehouse_name,w_warehouse_sk,i_item_sk,d_moy
               ,stdev,mean, case mean when 0 then null else stdev/mean end cov
         from(select w_warehouse_name,w_warehouse_sk,i_item_sk,d_moy
        ,stdev(inv_quantity_on_hand) stdev,avg(inv_quantity_on_hand) mean /* ,stddev_samp(inv_quantity_on_hand) stdev,avg(inv_quantity_on_hand) mean */
              from inventory
                  ,item
                  ,warehouse
                  ,date_dim
              where inv_item_sk = i_item_sk
                and inv_warehouse_sk = w_warehouse_sk
                and inv_date_sk = d_date_sk
                and d_year =1998
              group by w_warehouse_name,w_warehouse_sk,i_item_sk,d_moy) foo
         where case mean when 0 then 0 else stdev/mean end > 1)
        select inv1.w_warehouse_sk,inv1.i_item_sk,inv1.d_moy,inv1.mean, inv1.cov
                ,inv2.w_warehouse_sk,inv2.i_item_sk,inv2.d_moy,inv2.mean, inv2.cov
        from inv inv1,inv inv2
        where inv1.i_item_sk = inv2.i_item_sk
          and inv1.w_warehouse_sk =  inv2.w_warehouse_sk
          and inv1.d_moy=2
          and inv2.d_moy=2+1
          and inv1.cov > 1.5
        order by inv1.w_warehouse_sk,inv1.i_item_sk,inv1.d_moy,inv1.mean,inv1.cov
                ,inv2.d_moy,inv2.mean, inv2.cov
        OPTION (LABEL = 'TPC-DS Query 39B');


