/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 3000 GB (TB_003) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 83   *************************************/

        ;with sr_items as
         (select i_item_id item_id,
                sum(sr_return_quantity) sr_item_qty
         from store_returns,
              item,
              date_dim
         where sr_item_sk = i_item_sk
         and   d_date    in 
        	(select d_date
        	from date_dim
        	where d_week_seq in 
        		(select d_week_seq
        		from date_dim
        	  where d_date in ('1998-07-05','1998-09-07','1998-11-13')))
         and   sr_returned_date_sk   = d_date_sk
         group by i_item_id),
         cr_items as
         (select i_item_id item_id,
                sum(cr_return_quantity) cr_item_qty
         from catalog_returns,
              item,
              date_dim
         where cr_item_sk = i_item_sk
         and   d_date    in 
        	(select d_date
        	from date_dim
        	where d_week_seq in 
        		(select d_week_seq
        		from date_dim
        	  where d_date in ('1998-07-05','1998-09-07','1998-11-13')))
         and   cr_returned_date_sk   = d_date_sk
         group by i_item_id),
         wr_items as
         (select i_item_id item_id,
                sum(wr_return_quantity) wr_item_qty
         from web_returns,
              item,
              date_dim
         where wr_item_sk = i_item_sk
         and   d_date    in 
        	(select d_date
        	from date_dim
        	where d_week_seq in 
        		(select d_week_seq
        		from date_dim
        		where d_date in ('1998-07-05','1998-09-07','1998-11-13')))
         and   wr_returned_date_sk   = d_date_sk
         group by i_item_id)
          select top 100 sr_items.item_id
               ,sr_item_qty
               ,sr_item_qty/(sr_item_qty+cr_item_qty+wr_item_qty)/3.0 * 100 sr_dev
               ,cr_item_qty
               ,cr_item_qty/(sr_item_qty+cr_item_qty+wr_item_qty)/3.0 * 100 cr_dev
               ,wr_item_qty
               ,wr_item_qty/(sr_item_qty+cr_item_qty+wr_item_qty)/3.0 * 100 wr_dev
               ,(sr_item_qty+cr_item_qty+wr_item_qty)/3.0 average
         from sr_items
             ,cr_items
             ,wr_items
         where sr_items.item_id=cr_items.item_id
           and sr_items.item_id=wr_items.item_id 
         order by sr_items.item_id
                 ,sr_item_qty
        OPTION (LABEL = 'TPC-DS Query 83');


