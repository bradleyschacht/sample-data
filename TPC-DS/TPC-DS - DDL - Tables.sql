DROP TABLE IF EXISTS dbo.call_center;
DROP TABLE IF EXISTS dbo.catalog_page;
DROP TABLE IF EXISTS dbo.catalog_returns;
DROP TABLE IF EXISTS dbo.catalog_sales;
DROP TABLE IF EXISTS dbo.customer;
DROP TABLE IF EXISTS dbo.customer_address;
DROP TABLE IF EXISTS dbo.customer_demographics;
DROP TABLE IF EXISTS dbo.date_dim;
DROP TABLE IF EXISTS dbo.dbgen_version;
DROP TABLE IF EXISTS dbo.household_demographics;
DROP TABLE IF EXISTS dbo.income_band;
DROP TABLE IF EXISTS dbo.inventory;
DROP TABLE IF EXISTS dbo.item;
DROP TABLE IF EXISTS dbo.promotion;
DROP TABLE IF EXISTS dbo.reason;
DROP TABLE IF EXISTS dbo.ship_mode;
DROP TABLE IF EXISTS dbo.store;
DROP TABLE IF EXISTS dbo.store_returns;
DROP TABLE IF EXISTS dbo.store_sales;
DROP TABLE IF EXISTS dbo.time_dim;
DROP TABLE IF EXISTS dbo.warehouse;
DROP TABLE IF EXISTS dbo.web_page;
DROP TABLE IF EXISTS dbo.web_returns;
DROP TABLE IF EXISTS dbo.web_sales;
DROP TABLE IF EXISTS dbo.web_site;


CREATE TABLE dbo.call_center
	(
		cc_call_center_sk         		INT               	NOT NULL,
		cc_call_center_id         		CHAR(16)            NOT NULL,
		cc_rec_start_date         		DATE   				NULL,
		cc_rec_end_date           		DATE   				NULL,
		cc_closed_date_sk         		INT					NULL,
		cc_open_date_sk           		INT					NULL,
		cc_name                   		VARCHAR(50)			NULL,
		cc_class                  		VARCHAR(50)			NULL,
		cc_employees              		INT					NULL,
		cc_sq_ft                  		INT					NULL,
		cc_hours                  		CHAR(20)			NULL,
		cc_manager                		VARCHAR(40)			NULL,
		cc_mkt_id                 		INT					NULL,
		cc_mkt_class              		CHAR(50)			NULL,
		cc_mkt_desc               		VARCHAR(100)		NULL,
		cc_market_manager         		VARCHAR(40)			NULL,
		cc_division               		INT					NULL,
		cc_division_name          		VARCHAR(50)			NULL,
		cc_company                		INT					NULL,
		cc_company_name           		CHAR(50)			NULL,
		cc_street_number          		CHAR(10)			NULL,
		cc_street_name            		VARCHAR(60)			NULL,
		cc_street_type            		CHAR(15)			NULL,
		cc_suite_number           		CHAR(10)			NULL,
		cc_city                   		VARCHAR(60)			NULL,
		cc_county                 		VARCHAR(30)			NULL,
		cc_state                  		CHAR(2)				NULL,
		cc_zip                    		CHAR(10)			NULL,
		cc_country                		VARCHAR(20)			NULL,
		cc_gmt_offset             		DECIMAL(5,2)		NULL,
		cc_tax_percentage         		DECIMAL(5,2)		NULL
	);


CREATE TABLE dbo.catalog_page
	(
		cp_catalog_page_sk        		INT					NOT NULL,
		cp_catalog_page_id        		CHAR(16)            NOT NULL,
		cp_start_date_sk          		INT					NULL,
		cp_end_date_sk            		INT					NULL,
		cp_department             		VARCHAR(50)         NULL,
		cp_catalog_number         		INT					NULL,
		cp_catalog_page_number    		INT					NULL,
		cp_description            		VARCHAR(100)        NULL,
		cp_type                   		VARCHAR(100)        NULL
	);


CREATE TABLE dbo.catalog_returns
	(
		cr_returned_date_sk       		INT                 NULL,
		cr_returned_time_sk       		INT                 NULL,
		cr_item_sk                		INT               	NOT NULL,
		cr_refunded_customer_sk   		INT 				NULL,
		cr_refunded_cdemo_sk      		INT 				NULL,
		cr_refunded_hdemo_sk      		INT 				NULL,
		cr_refunded_addr_sk       		INT 				NULL,
		cr_returning_customer_sk  		INT 				NULL,
		cr_returning_cdemo_sk     		INT 				NULL,
		cr_returning_hdemo_sk     		INT 				NULL,
		cr_returning_addr_sk      		INT 				NULL,
		cr_call_center_sk         		INT 				NULL,
		cr_catalog_page_sk        		INT 				NULL,
		cr_ship_mode_sk           		INT 				NULL,
		cr_warehouse_sk           		INT 				NULL,
		cr_reason_sk              		INT 				NULL,
		cr_order_number           		BIGINT				NOT NULL,
		cr_return_quantity        		INT		 			NULL,
		cr_return_amount          		DECIMAL(7,2) 		NULL,
		cr_return_tax             		DECIMAL(7,2) 		NULL,
		cr_return_amt_inc_tax     		DECIMAL(7,2) 		NULL,
		cr_fee                    		DECIMAL(7,2) 		NULL,
		cr_return_ship_cost       		DECIMAL(7,2) 		NULL,
		cr_refunded_cash          		DECIMAL(7,2) 		NULL,
		cr_reversed_charge        		DECIMAL(7,2) 		NULL,
		cr_store_credit           		DECIMAL(7,2) 		NULL,
		cr_net_loss               		DECIMAL(7,2) 		NULL
	);


CREATE TABLE dbo.catalog_sales
	(
		cs_sold_date_sk 				INT 				NULL,
		cs_sold_time_sk 				INT 				NULL,
		cs_ship_date_sk 				INT 				NULL,
		cs_bill_customer_sk 			INT 				NULL,
		cs_bill_cdemo_sk 				INT 				NULL,
		cs_bill_hdemo_sk 				INT 				NULL,
		cs_bill_addr_sk 				INT 				NULL,
		cs_ship_customer_sk 			INT 				NULL,
		cs_ship_cdemo_sk 				INT 				NULL,
		cs_ship_hdemo_sk 				INT 				NULL,
		cs_ship_addr_sk 				INT 				NULL,
		cs_call_center_sk 				INT 				NULL,
		cs_catalog_page_sk 				INT 				NULL,
		cs_ship_mode_sk 				INT 				NULL,
		cs_warehouse_sk 				INT 				NULL,
		cs_item_sk 						INT 				NOT NULL,
		cs_promo_sk 					INT 				NULL,
		cs_order_number 				BIGINT 				NOT NULL,
		cs_quantity 					INT 				NULL,
		cs_wholesale_cost 				DECIMAL(7, 2) 		NULL,
		cs_list_price 					DECIMAL(7, 2) 		NULL,
		cs_sales_price 					DECIMAL(7, 2) 		NULL,
		cs_ext_discount_amt 			DECIMAL(7, 2) 		NULL,
		cs_ext_sales_price 				DECIMAL(7, 2) 		NULL,
		cs_ext_wholesale_cost 			DECIMAL(7, 2) 		NULL,
		cs_ext_list_price 				DECIMAL(7, 2) 		NULL,
		cs_ext_tax 						DECIMAL(7, 2) 		NULL,
		cs_coupon_amt 					DECIMAL(7, 2) 		NULL,
		cs_ext_ship_cost 				DECIMAL(7, 2) 		NULL,
		cs_net_paid 					DECIMAL(7, 2) 		NULL,
		cs_net_paid_inc_tax 			DECIMAL(7, 2) 		NULL,
		cs_net_paid_inc_ship 			DECIMAL(7, 2) 		NULL,
		cs_net_paid_inc_ship_tax 		DECIMAL(7, 2) 		NULL,
		cs_net_profit 					DECIMAL(7, 2) 		NULL
	);


/*
Original Version
CREATE TABLE dbo.customer
	(
		c_customer_sk             		INT					NOT NULL,
		c_customer_id             		CHAR(16)			NOT NULL,
		c_current_cdemo_sk        		INT					NULL,
		c_current_hdemo_sk        		INT					NULL,
		c_current_addr_sk         		INT					NULL,
		c_first_shipto_date_sk    		INT					NULL,
		c_first_sales_date_sk     		INT					NULL,
		c_salutation              		CHAR(10)			NULL,
		c_first_name              		CHAR(20)			NULL,
		c_last_name               		CHAR(30)			NULL,
		c_preferred_cust_flag     		CHAR(1)				NULL,
		c_birth_day               		INT					NULL,
		c_birth_month             		INT					NULL,
		c_birth_year              		INT					NULL,
		c_birth_country           		VARCHAR(20)			NULL,
		c_login                   		CHAR(13)			NULL,
		c_email_address           		CHAR(50)			NULL,
		c_last_review_date        		CHAR(10)			NULL
	);

version 3.2.0.  Changed c_last_review_date to c_last_review_date_sk and modified datatype
*/
CREATE TABLE dbo.customer
	(
		c_customer_sk             		INT					NOT NULL,
		c_customer_id             		CHAR(16)			NOT NULL,
		c_current_cdemo_sk        		INT					NULL,
		c_current_hdemo_sk        		INT					NULL,
		c_current_addr_sk         		INT					NULL,
		c_first_shipto_date_sk    		INT					NULL,
		c_first_sales_date_sk     		INT					NULL,
		c_salutation              		CHAR(10)			NULL,
		c_first_name              		CHAR(20)			NULL,
		c_last_name               		CHAR(30)			NULL,
		c_preferred_cust_flag     		CHAR(1)				NULL,
		c_birth_day               		INT					NULL,
		c_birth_month             		INT					NULL,
		c_birth_year              		INT					NULL,
		c_birth_country           		VARCHAR(20)			NULL,
		c_login                   		CHAR(13)			NULL,
		c_email_address           		CHAR(50)			NULL,
		c_last_review_date_sk     		INT					NULL
	);


CREATE TABLE dbo.customer_address
	(
		ca_address_sk             		INT					NOT NULL,
		ca_address_id             		CHAR(16)			NOT NULL,
		ca_street_number          		CHAR(10)			NULL,
		ca_street_name            		VARCHAR(60)			NULL,
		ca_street_type            		CHAR(15)			NULL,
		ca_suite_number           		CHAR(10)			NULL,
		ca_city                   		VARCHAR(60)			NULL,
		ca_county                 		VARCHAR(30)			NULL,
		ca_state                  		CHAR(2)				NULL,
		ca_zip                    		CHAR(10)			NULL,
		ca_country                		VARCHAR(20)			NULL,
		ca_gmt_offset             		DECIMAL(5,2)		NULL,
		ca_location_type          		CHAR(20)			NULL
	);


CREATE TABLE dbo.customer_demographics
	(
		cd_demo_sk                		INT					NOT NULL,
		cd_gender                 		CHAR(1)				NULL,
		cd_marital_status         		CHAR(1)				NULL,
		cd_education_status       		CHAR(20)			NULL,
		cd_purchase_estimate      		INT					NULL,
		cd_credit_rating          		CHAR(10)			NULL,
		cd_dep_count              		INT					NULL,
		cd_dep_employed_count     		INT					NULL,
		cd_dep_college_count      		INT					NULL
	);


/*
Original Version
CREATE TABLE dbo.date_dim
	(
		d_date_sk                 		INT					NOT NULL,
		d_date_id                 		CHAR(16)			NOT NULL,
		d_date                    		DATE				NULL,
		d_month_seq               		INT					NULL,
		d_week_seq                		INT					NULL,
		d_quarter_seq             		INT					NULL,
		d_year                    		INT					NULL,
		d_dow                     		INT					NULL,
		d_moy                     		INT					NULL,
		d_dom                     		INT					NULL,
		d_qoy                     		INT					NULL,
		d_fy_year                 		INT					NULL,
		d_fy_quarter_seq          		INT					NULL,
		d_fy_week_seq             		INT					NULL,
		d_day_name                		CHAR(9)				NULL,
		d_quarter_name            		CHAR(6)				NULL,
		d_holiday                 		CHAR(1)				NULL,
		d_weekend                 		CHAR(1)				NULL,
		d_following_holiday       		CHAR(1)				NULL,
		d_first_dom               		INT					NULL,
		d_last_dom                		INT					NULL,
		d_same_day_ly             		INT					NULL,
		d_same_day_lq             		INT					NULL,
		d_current_day             		CHAR(1)				NULL,
		d_current_week            		CHAR(1)				NULL,
		d_current_month           		CHAR(1)				NULL,
		d_current_quarter         		CHAR(1)				NULL,
		d_current_year            		CHAR(1)				NULL
	);

version 3.2.0.  Added NOT NULL to d_date
*/
CREATE TABLE dbo.date_dim
	(
		d_date_sk                 		INT					NOT NULL,
		d_date_id                 		CHAR(16)			NOT NULL,
		d_date                    		DATE				NOT NULL,
		d_month_seq               		INT					NULL,
		d_week_seq                		INT					NULL,
		d_quarter_seq             		INT					NULL,
		d_year                    		INT					NULL,
		d_dow                     		INT					NULL,
		d_moy                     		INT					NULL,
		d_dom                     		INT					NULL,
		d_qoy                     		INT					NULL,
		d_fy_year                 		INT					NULL,
		d_fy_quarter_seq          		INT					NULL,
		d_fy_week_seq             		INT					NULL,
		d_day_name                		CHAR(9)				NULL,
		d_quarter_name            		CHAR(6)				NULL,
		d_holiday                 		CHAR(1)				NULL,
		d_weekend                 		CHAR(1)				NULL,
		d_following_holiday       		CHAR(1)				NULL,
		d_first_dom               		INT					NULL,
		d_last_dom                		INT					NULL,
		d_same_day_ly             		INT					NULL,
		d_same_day_lq             		INT					NULL,
		d_current_day             		CHAR(1)				NULL,
		d_current_week            		CHAR(1)				NULL,
		d_current_month           		CHAR(1)				NULL,
		d_current_quarter         		CHAR(1)				NULL,
		d_current_year            		CHAR(1)				NULL
	);


CREATE TABLE dbo.dbgen_version
	(
		dv_version                		VARCHAR(16)			NOT NULL,
		dv_create_date            		DATE   				NOT NULL,
		dv_create_time            		TIME(0)				NOT NULL,
		dv_cmdline_args           		VARCHAR(200)		NOT NULL
	);


CREATE TABLE dbo.household_demographics
	(
		hd_demo_sk                		INT               	NOT NULL,
		hd_income_band_sk         		INT					NULL,
		hd_buy_potential          		CHAR(15)			NULL,
		hd_dep_count              		INT					NULL,
		hd_vehicle_count          		INT					NULL
	);


CREATE TABLE dbo.income_band
	(
		ib_income_band_sk         		INT               	NOT NULL,
		ib_lower_bound            		INT					NULL,
		ib_upper_bound            		INT					NULL
	); 


/*
Original Version
CREATE TABLE dbo.inventory
	(
		inv_date_sk               		INT               	NOT NULL,
		inv_item_sk               		INT               	NOT NULL,
		inv_warehouse_sk          		INT               	NOT NULL,
		inv_quantity_on_hand      		INT
	);

version 3.1.0 preventing overflow
*/
CREATE TABLE dbo.inventory
	(
		inv_date_sk               		INT               	NOT NULL,
		inv_item_sk               		INT               	NOT NULL,
		inv_warehouse_sk          		INT               	NOT NULL,
		inv_quantity_on_hand      		BIGINT
	);


CREATE TABLE dbo.item
	(
		i_item_sk                 		INT					NOT NULL,
		i_item_id                 		CHAR(16)			NOT NULL,
		i_rec_start_date          		DATE   				NULL,
		i_rec_end_date            		DATE   				NULL,
		i_item_desc               		VARCHAR(200)		NULL,
		i_current_price           		DECIMAL(7,2)		NULL,
		i_wholesale_cost          		DECIMAL(7,2)		NULL,
		i_brand_id                		INT					NULL,
		i_brand                   		CHAR(50)			NULL,
		i_class_id                		INT					NULL,
		i_class                   		CHAR(50)			NULL,
		i_category_id             		INT					NULL,
		i_category                		CHAR(50)			NULL,
		i_manufact_id             		INT					NULL,
		i_manufact                		CHAR(50)			NULL,
		i_size                    		CHAR(20)			NULL,
		i_formulation             		CHAR(20)			NULL,
		i_color                   		CHAR(20)			NULL,
		i_units                   		CHAR(10)			NULL,
		i_container               		CHAR(10)			NULL,
		i_manager_id              		INT					NULL,
		i_product_name            		CHAR(50)			NULL
	);


CREATE TABLE dbo.promotion
	(
		p_promo_sk                		INT               	NOT NULL,
		p_promo_id                		CHAR(16)            NOT NULL,
		p_start_date_sk           		INT					NULL,
		p_end_date_sk             		INT					NULL,
		p_item_sk                 		INT					NULL,
		p_cost                    		DECIMAL(15,2)		NULL,
		p_response_target         		INT					NULL,
		p_promo_name              		CHAR(50)			NULL,
		p_channel_dmail           		CHAR(1)				NULL,
		p_channel_email           		CHAR(1)				NULL,
		p_channel_catalog         		CHAR(1)				NULL,
		p_channel_tv              		CHAR(1)				NULL,
		p_channel_radio           		CHAR(1)				NULL,
		p_channel_press           		CHAR(1)				NULL,
		p_channel_event           		CHAR(1)				NULL,
		p_channel_demo            		CHAR(1)				NULL,
		p_channel_details         		VARCHAR(100)		NULL,
		p_purpose                 		CHAR(15)			NULL,
		p_discount_active         		CHAR(1)				NULL
	);


CREATE TABLE dbo.reason
	(
		r_reason_sk               		INT					NOT NULL,
		r_reason_id               		CHAR(16)			NOT NULL,
		r_reason_desc             		CHAR(100)			NULL
	);


CREATE TABLE dbo.ship_mode
	(
		sm_ship_mode_sk           		INT					NOT NULL,
		sm_ship_mode_id           		CHAR(16)			NOT NULL,
		sm_type                   		CHAR(30)			NULL,
		sm_code                   		CHAR(10)			NULL,
		sm_carrier                		CHAR(20)			NULL,
		sm_contract               		CHAR(20)			NULL
	);


CREATE TABLE dbo.store
	(
		s_store_sk                		INT					NOT NULL,
		s_store_id                		CHAR(16)			NOT NULL,
		s_rec_start_date          		DATE   				NULL,
		s_rec_end_date            		DATE   				NULL,
		s_closed_date_sk          		INT					NULL,
		s_store_name              		VARCHAR(50)			NULL,
		s_number_employees        		INT					NULL,
		s_floor_space             		INT					NULL,
		s_hours                   		CHAR(20)			NULL,
		s_manager                 		VARCHAR(40)			NULL,
		s_market_id               		INT					NULL,
		s_geography_class         		VARCHAR(100)		NULL,
		s_market_desc             		VARCHAR(100)		NULL,
		s_market_manager          		VARCHAR(40)			NULL,
		s_division_id             		INT					NULL,
		s_division_name           		VARCHAR(50)			NULL,
		s_company_id              		INT					NULL,
		s_company_name            		VARCHAR(50)			NULL,
		s_street_number           		VARCHAR(10)			NULL,
		s_street_name             		VARCHAR(60)			NULL,
		s_street_type             		CHAR(15)			NULL,
		s_suite_number            		CHAR(10)			NULL,
		s_city                    		VARCHAR(60)			NULL,
		s_county                  		VARCHAR(30)			NULL,
		s_state                   		CHAR(2)				NULL,
		s_zip                     		CHAR(10)			NULL,
		s_country                 		VARCHAR(20)			NULL,
		s_gmt_offset              		DECIMAL(5,2)		NULL,
		s_tax_precentage          		DECIMAL(5,2)		NULL
	);


CREATE TABLE dbo.store_returns
	(
		sr_returned_date_sk       		INT					NULL,
		sr_return_time_sk         		INT					NULL,
		sr_item_sk                		INT               	NOT NULL,
		sr_customer_sk            		INT					NULL,
		sr_cdemo_sk               		INT					NULL,
		sr_hdemo_sk               		INT					NULL,
		sr_addr_sk                		INT					NULL,
		sr_store_sk               		INT					NULL,
		sr_reason_sk              		INT					NULL,
		sr_ticket_number          		BIGINT              NOT NULL,
		sr_return_quantity        		INT					NULL,
		sr_return_amt             		DECIMAL(7,2)		NULL,
		sr_return_tax             		DECIMAL(7,2)		NULL,
		sr_return_amt_inc_tax     		DECIMAL(7,2)		NULL,
		sr_fee                    		DECIMAL(7,2)		NULL,
		sr_return_ship_cost       		DECIMAL(7,2)		NULL,
		sr_refunded_cash          		DECIMAL(7,2)		NULL,
		sr_reversed_charge        		DECIMAL(7,2)		NULL,
		sr_store_credit           		DECIMAL(7,2)		NULL,
		sr_net_loss               		DECIMAL(7,2)		NULL
	);


CREATE TABLE dbo.store_sales
	(
		ss_sold_date_sk           		INT		 			NULL,
		ss_sold_time_sk           		INT		 			NULL,
		ss_item_sk                		INT		            NOT NULL,
		ss_customer_sk            		INT		 			NULL,
		ss_cdemo_sk               		INT		 			NULL,
		ss_hdemo_sk               		INT		 			NULL,
		ss_addr_sk                		INT		 			NULL,
		ss_store_sk               		INT		 			NULL,
		ss_promo_sk               		INT		 			NULL,
		ss_ticket_number          		BIGINT              NOT NULL,
		ss_quantity               		INT 				NULL,
		ss_wholesale_cost         		DECIMAL(7,2) 		NULL,
		ss_list_price             		DECIMAL(7,2) 		NULL,
		ss_sales_price            		DECIMAL(7,2) 		NULL,
		ss_ext_discount_amt       		DECIMAL(7,2) 		NULL,
		ss_ext_sales_price        		DECIMAL(7,2) 		NULL,
		ss_ext_wholesale_cost     		DECIMAL(7,2) 		NULL,
		ss_ext_list_price         		DECIMAL(7,2) 		NULL,
		ss_ext_tax                		DECIMAL(7,2) 		NULL,
		ss_coupon_amt             		DECIMAL(7,2) 		NULL,
		ss_net_paid               		DECIMAL(7,2) 		NULL,
		ss_net_paid_inc_tax       		DECIMAL(7,2) 		NULL,
		ss_net_profit             		DECIMAL(7,2) 		NULL
	);


/*
Original Version
CREATE TABLE dbo.time_dim
	(
		t_time_sk                 		INT					NOT NULL,
		t_time_id                 		CHAR(16)			NOT NULL,
		t_time                    		INT					NULL,
		t_hour                    		INT					NULL,
		t_minute                  		INT					NULL,
		t_second                  		INT					NULL,
		t_am_pm                   		CHAR(2)				NULL,
		t_shift                   		CHAR(20)			NULL,
		t_sub_shift               		CHAR(20)			NULL,
		t_meal_time               		CHAR(20)			NULL
	);

version 3.2.0.  Added NOT NULL to t_time
*/
CREATE TABLE dbo.time_dim
	(
		t_time_sk                 		INT					NOT NULL,
		t_time_id                 		CHAR(16)			NOT NULL,
		t_time                    		INT               	NOT NULL,
		t_hour                    		INT					NULL,
		t_minute                  		INT					NULL,
		t_second                  		INT					NULL,
		t_am_pm                   		CHAR(2)				NULL,
		t_shift                   		CHAR(20)			NULL,
		t_sub_shift               		CHAR(20)			NULL,
		t_meal_time               		CHAR(20)			NULL
	); 


CREATE TABLE dbo.warehouse
	(
		w_warehouse_sk            		INT					NOT NULL,
		w_warehouse_id            		CHAR(16)			NOT NULL,
		w_warehouse_name          		VARCHAR(20)			NULL,
		w_warehouse_sq_ft         		INT					NULL,
		w_street_number           		CHAR(10)			NULL,
		w_street_name             		VARCHAR(60)			NULL,
		w_street_type             		CHAR(15)			NULL,
		w_suite_number            		CHAR(10)			NULL,
		w_city                    		VARCHAR(60)			NULL,
		w_county                  		VARCHAR(30)			NULL,
		w_state                   		CHAR(2)				NULL,
		w_zip                     		CHAR(10)			NULL,
		w_country                 		VARCHAR(20)			NULL,
		w_gmt_offset              		DECIMAL(5,2)		NULL
	);


CREATE TABLE dbo.web_page
	(
		wp_web_page_sk            		INT               	NOT NULL,
		wp_web_page_id            		CHAR(16)            NOT NULL,
		wp_rec_start_date         		DATE				NULL,
		wp_rec_end_date           		DATE				NULL,
		wp_creation_date_sk       		INT					NULL,
		wp_access_date_sk         		INT					NULL,
		wp_autogen_flag           		CHAR(1)				NULL,
		wp_customer_sk            		INT					NULL, 
		wp_url                    		VARCHAR(100)		NULL,
		wp_type                   		CHAR(50)			NULL,
		wp_char_count             		INT					NULL,
		wp_link_count             		INT					NULL,
		wp_image_count            		INT					NULL,
		wp_max_ad_count           		INT					NULL
	);


CREATE TABLE dbo.web_returns
	(
		wr_returned_date_sk 			INT 				NULL,
		wr_returned_time_sk 			INT 				NULL,
		wr_item_sk 						INT 				NOT NULL,
		wr_refunded_customer_sk 		INT 				NULL,
		wr_refunded_cdemo_sk 			INT 				NULL,
		wr_refunded_hdemo_sk 			INT 				NULL,
		wr_refunded_addr_sk 			INT 				NULL,
		wr_returning_customer_sk 		INT 				NULL,
		wr_returning_cdemo_sk 			INT 				NULL,
		wr_returning_hdemo_sk 			INT 				NULL,
		wr_returning_addr_sk 			INT 				NULL,
		wr_web_page_sk 					INT 				NULL,
		wr_reason_sk 					INT 				NULL,
		wr_order_number 				BIGINT 				NOT NULL,
		wr_return_quantity 				INT 				NULL,
		wr_return_amt 					DECIMAL(7, 2) 		NULL,
		wr_return_tax 					DECIMAL(7, 2) 		NULL,
		wr_return_amt_inc_tax 			DECIMAL(7, 2) 		NULL,
		wr_fee 							DECIMAL(7, 2) 		NULL,
		wr_return_ship_cost 			DECIMAL(7, 2) 		NULL,
		wr_refunded_cash 				DECIMAL(7, 2) 		NULL,
		wr_reversed_charge 				DECIMAL(7, 2) 		NULL,
		wr_account_credit 				DECIMAL(7, 2) 		NULL,
		wr_net_loss 					DECIMAL(7, 2) 		NULL,
	);


CREATE TABLE dbo.web_sales
	(
		ws_sold_date_sk           		INT		 			NULL,
		ws_sold_time_sk           		INT		 			NULL,
		ws_ship_date_sk           		INT		 			NULL,
		ws_item_sk                		INT		            NOT NULL,
		ws_bill_customer_sk       		INT		 			NULL,
		ws_bill_cdemo_sk          		INT		 			NULL,
		ws_bill_hdemo_sk          		INT		 			NULL,
		ws_bill_addr_sk           		INT		 			NULL,
		ws_ship_customer_sk       		INT		 			NULL,
		ws_ship_cdemo_sk          		INT		 			NULL,
		ws_ship_hdemo_sk          		INT		 			NULL,
		ws_ship_addr_sk           		INT		 			NULL,
		ws_web_page_sk            		INT		 			NULL,
		ws_web_site_sk            		INT		 			NULL,
		ws_ship_mode_sk           		INT		 			NULL,
		ws_warehouse_sk           		INT		 			NULL,
		ws_promo_sk               		INT		 			NULL,
		ws_order_number           		BIGINT				NOT NULL,
		ws_quantity               		INT		 			NULL,
		ws_wholesale_cost         		DECIMAL(7,2) 		NULL,
		ws_list_price             		DECIMAL(7,2) 		NULL,
		ws_sales_price            		DECIMAL(7,2) 		NULL,
		ws_ext_discount_amt       		DECIMAL(7,2) 		NULL,
		ws_ext_sales_price        		DECIMAL(7,2) 		NULL,
		ws_ext_wholesale_cost     		DECIMAL(7,2) 		NULL,
		ws_ext_list_price         		DECIMAL(7,2) 		NULL,
		ws_ext_tax                		DECIMAL(7,2) 		NULL,
		ws_coupon_amt             		DECIMAL(7,2) 		NULL,
		ws_ext_ship_cost          		DECIMAL(7,2) 		NULL,
		ws_net_paid               		DECIMAL(7,2) 		NULL,
		ws_net_paid_inc_tax       		DECIMAL(7,2) 		NULL,
		ws_net_paid_inc_ship      		DECIMAL(7,2) 		NULL,
		ws_net_paid_inc_ship_tax  		DECIMAL(7,2) 		NULL,
		ws_net_profit             		DECIMAL(7,2) 		NULL
	);


CREATE TABLE dbo.web_site
	(
		web_site_sk               		INT               	NOT NULL,
		web_site_id               		CHAR(16)            NOT NULL,
		web_rec_start_date        		DATE   				NULL,
		web_rec_end_date          		DATE   				NULL,
		web_name                  		VARCHAR(50)			NULL,
		web_open_date_sk          		INT					NULL,
		web_close_date_sk         		INT					NULL,
		web_class                 		VARCHAR(50)			NULL,
		web_manager               		VARCHAR(40)			NULL,
		web_mkt_id                		INT					NULL,
		web_mkt_class             		VARCHAR(50)			NULL,
		web_mkt_desc              		VARCHAR(100)		NULL,
		web_market_manager        		VARCHAR(40)			NULL,
		web_company_id            		INT					NULL,
		web_company_name          		CHAR(50)			NULL,
		web_street_number         		CHAR(10)			NULL,
		web_street_name           		VARCHAR(60)			NULL,
		web_street_type           		CHAR(15)			NULL,
		web_suite_number          		CHAR(10)			NULL,
		web_city                  		VARCHAR(60)			NULL,
		web_county                		VARCHAR(30)			NULL,
		web_state                 		CHAR(2)				NULL,
		web_zip                   		CHAR(10)			NULL,
		web_country               		VARCHAR(20)			NULL,
		web_gmt_offset            		DECIMAL(5,2)		NULL,
		web_tax_percentage        		DECIMAL(5,2)		NULL
	);