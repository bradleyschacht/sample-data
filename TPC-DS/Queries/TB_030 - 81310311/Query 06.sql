/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-03
    This is the TPC-DS 30000 GB (TB_030) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 06   *************************************/

        select top 100 a.ca_state state, count_big(*) cnt /* select top 100 a.ca_state state, count(*) cnt */
         from customer_address a
             ,customer c
             ,store_sales s
             ,date_dim d
             ,item i
         where       a.ca_address_sk = c.c_current_addr_sk
         	and c.c_customer_sk = s.ss_customer_sk
         	and s.ss_sold_date_sk = d.d_date_sk
         	and s.ss_item_sk = i.i_item_sk
         	and d.d_month_seq = 
         	     (select distinct (d_month_seq)
         	      from date_dim
                       where d_year = 2001
         	        and d_moy = 2 )
         	and i.i_current_price > 1.2 * 
                     (select avg(j.i_current_price) 
         	     from item j 
         	     where j.i_category = i.i_category)
         group by a.ca_state
         having count(*) >= 10
         order by cnt, a.ca_state 
        OPTION (LABEL = 'TPC-DS Query 06');


