/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 1000 GB (TB_001) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 41   *************************************/

        select distinct top 100 (i_product_name) /* select top 100 distinct(i_product_name) */
         from item i1
         where i_manufact_id between 682 and 682+40 
           and (select count(*) as item_cnt
                from item
                where (i_manufact = i1.i_manufact and
                ((i_category = 'Women' and 
                (i_color = 'deep' or i_color = 'misty') and 
                (i_units = 'Dozen' or i_units = 'Pallet') and
                (i_size = 'petite' or i_size = 'medium')
                ) or
                (i_category = 'Women' and
                (i_color = 'olive' or i_color = 'lawn') and
                (i_units = 'Gross' or i_units = 'Tbl') and
                (i_size = 'extra large' or i_size = 'economy')
                ) or
                (i_category = 'Men' and
                (i_color = 'rosy' or i_color = 'beige') and
                (i_units = 'Ounce' or i_units = 'Lb') and
                (i_size = 'small' or i_size = 'large')
                ) or
                (i_category = 'Men' and
                (i_color = 'cream' or i_color = 'chiffon') and
                (i_units = 'Each' or i_units = 'Box') and
                (i_size = 'petite' or i_size = 'medium')
                ))) or
               (i_manufact = i1.i_manufact and
                ((i_category = 'Women' and 
                (i_color = 'tomato' or i_color = 'peru') and 
                (i_units = 'Pound' or i_units = 'Bunch') and
                (i_size = 'petite' or i_size = 'medium')
                ) or
                (i_category = 'Women' and
                (i_color = 'midnight' or i_color = 'floral') and
                (i_units = 'Case' or i_units = 'Cup') and
                (i_size = 'extra large' or i_size = 'economy')
                ) or
                (i_category = 'Men' and
                (i_color = 'blush' or i_color = 'dodger') and
                (i_units = 'Dram' or i_units = 'Bundle') and
                (i_size = 'small' or i_size = 'large')
                ) or
                (i_category = 'Men' and
                (i_color = 'chartreuse' or i_color = 'lavender') and
                (i_units = 'Tsp' or i_units = 'Oz') and
                (i_size = 'petite' or i_size = 'medium')
                )))) > 0
         order by i_product_name
        OPTION (LABEL = 'TPC-DS Query 41');


