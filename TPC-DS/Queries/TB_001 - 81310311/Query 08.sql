/*************************************   Notes   *************************************/
/*
    Generated on 2024-10-07
    This is the TPC-DS 1000 GB (TB_001) scale factor queries modified for Fabric DW T-SQL syntax.

    TPC-DS Parameter Substitution (Version 3.2.0)
    Using 81310311 as a seed to the RNG
*/



    /*************************************   TPC-DS Query 08   *************************************/

        select top 100 s_store_name
              ,sum(ss_net_profit)
         from store_sales
             ,date_dim
             ,store,
             (select ca_zip
             from (
        SELECT substring(ca_zip,1,5) ca_zip /* SELECT substr(ca_zip,1,5) ca_zip */
              FROM customer_address
        WHERE substring(ca_zip,1,5) IN ( /* WHERE substr(ca_zip,1,5) IN ( */
                                  '93893','70193','29654','74991','93788','84160',
                                  '21477','23180','52545','32610','69745',
                                  '36831','18768','33479','10604','71145',
                                  '27769','14029','61926','46869','44164',
                                  '22319','52049','40871','29990','87871',
                                  '67487','39129','64856','55215','14258',
                                  '12781','33393','14445','40149','85824',
                                  '65400','86298','44044','40732','62967',
                                  '45657','34346','21238','61531','77879',
                                  '16404','18051','46854','87968','64471',
                                  '81438','98018','64865','11866','84847',
                                  '51205','46738','40144','74746','77433',
                                  '77416','11464','45869','56240','28425',
                                  '78924','27709','30172','38727','42110',
                                  '60193','78608','73384','79783','10757',
                                  '44548','37505','95867','74433','62842',
                                  '75676','55691','91254','18520','68526',
                                  '59988','21080','95122','23978','73602',
                                  '21673','13197','46990','44944','64901',
                                  '73172','23131','45882','98130','66111',
                                  '61146','70668','86502','70299','24229',
                                  '54275','24242','97798','91414','95343',
                                  '52166','75601','82199','92056','49629',
                                  '21501','16687','72249','41388','96417',
                                  '55219','51021','31020','41890','37264',
                                  '58861','86028','56673','28197','19887',
                                  '26459','35373','69269','26696','54731',
                                  '19813','46340','24760','51919','51133',
                                  '55956','34941','41220','14227','12629',
                                  '68796','77083','45370','30824','47815',
                                  '43403','66758','54965','23547','67275',
                                  '92645','72693','94471','70692','22024',
                                  '87121','99212','48385','24385','49491',
                                  '42410','11632','16559','20090','99227',
                                  '85943','21588','71272','27113','11768',
                                  '47456','39210','47685','24410','49225',
                                  '29580','33448','54928','22575','28745',
                                  '48792','24469','97271','13620','14343',
                                  '87837','17194','94704','76192','11383',
                                  '19062','14807','14452','56826','53206',
                                  '82666','24146','10346','49566','93326',
                                  '10216','15725','19801','65131','27161',
                                  '58461','63932','15041','65595','50030',
                                  '59043','73793','58622','14579','63809',
                                  '76766','91555','92888','32808','33890',
                                  '40920','14479','62802','72784','83672',
                                  '28738','36923','58217','90104','38585',
                                  '15967','95625','61601','94520','17503',
                                  '11416','85268','31036','23089','24721',
                                  '32452','13273','60482','17949','66684',
                                  '79931','50251','84470','57993','70757',
                                  '46843','55560','28447','77035','86384',
                                  '56094','57376','33325','33781','70747',
                                  '22808','80129','32126','62810','24082',
                                  '37875','66238','92704','69665','24549',
                                  '69386','71807','46875','84382','63452',
                                  '62655','17733','42292','29911','13459',
                                  '89989','89944','38439','27802','39654',
                                  '41632','13979','26653','27137','79376',
                                  '60499','30586','16893','54026','42453',
                                  '82772','52911','31145','71472','14869',
                                  '30970','61220','42249','14066','94492',
                                  '95661','12955','65426','16787','54038',
                                  '21284','36288','11377','71345','98174',
                                  '93630','57896','10566','65359','56655',
                                  '33130','77512','63591','48420','72517',
                                  '57453','18184','80352','20020','24328',
                                  '69607','99126','14026','35665','78363',
                                  '35473','10798','34571','47093','17715',
                                  '51380','29144','86836','33108','53843',
                                  '43381','38372','66335','21762','32395',
                                  '49496','73735','39286','48946','80015',
                                  '33117','35070','90963','64522','81237',
                                  '41072','83957','13490','27581','36213',
                                  '20551','44968','38844','20612','40818',
                                  '39595','62483','12491','31377','32831',
                                  '42998','97626','17010','54134','76214',
                                  '73079','22996','49827','14193','94783',
                                  '46928','26107','60623','36501','16748',
                                  '62464','95585','48132','44415')
             intersect
              select ca_zip
        from (SELECT substring(ca_zip,1,5) ca_zip,count(*) cnt /* from (SELECT substr(ca_zip,1,5) ca_zip,count(*) cnt */
                    FROM customer_address, customer
                    WHERE ca_address_sk = c_current_addr_sk and
                          c_preferred_cust_flag='Y'
                    group by ca_zip
                    having count(*) > 10)A1)A2) V1
         where ss_store_sk = s_store_sk
          and ss_sold_date_sk = d_date_sk
          and d_qoy = 1 and d_year = 1999
        and (substring(s_zip,1,2) = substring(V1.ca_zip,1,2)) /* and (substr(s_zip,1,2) = substr(V1.ca_zip,1,2)) */
         group by s_store_name
         order by s_store_name
        OPTION (LABEL = 'TPC-DS Query 08');


