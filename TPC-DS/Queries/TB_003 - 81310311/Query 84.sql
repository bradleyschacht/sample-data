/*************************************   Notes   *************************************/
/*
    Generated on 2025-04-23
    This is the TPC-DS 3000 GB (TB_003) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 84   *************************************/

        select top 100 c_customer_id as customer_id
               , coalesce(c_last_name,'')  +  ', '  +  coalesce(c_first_name,'') as customername /*  , coalesce(c_last_name,'') || ', ' || coalesce(c_first_name,'') as customername  */
         from customer
             ,customer_address
             ,customer_demographics
             ,household_demographics
             ,income_band
             ,store_returns
         where ca_city	        =  'Woodville'
           and c_current_addr_sk = ca_address_sk
           and ib_lower_bound   >=  46303
           and ib_upper_bound   <=  46303 + 50000
           and ib_income_band_sk = hd_income_band_sk
           and cd_demo_sk = c_current_cdemo_sk
           and hd_demo_sk = c_current_hdemo_sk
           and sr_cdemo_sk = cd_demo_sk
         order by c_customer_id
        OPTION (LABEL = 'TPC-DS Query 84');


