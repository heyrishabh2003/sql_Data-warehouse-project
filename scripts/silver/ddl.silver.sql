/* 
=================================================================================
DDL script : Create silver Tables
=================================================================================
Scripts Purpose:
	This script create Tables in the 'silver' schemas, dropping existing tables
	if they already exists
	Run this script to re-define the DDL structure of 'Bronze' Tables

=================================================================================
*/


IF OBJECT_ID ('silver.crm_cust_info', 'U') IS NOT NULL 
	DROP TABLE silver.crm_cust_info;
-- Create the tables
CREATE TABLE silver.crm_cust_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_first_name NVARCHAR(50),
    cst_last_name NVARCHAR(50),
    cst_material_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE,
    
);
GO

IF OBJECT_ID ('silver.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE silver.crm_prd_info;
CREATE TABLE silver.crm_prd_info (
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt DATETIME
);
GO


IF OBJECT_ID ('silver.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE silver.crm_sales_details;
CREATE TABLE silver.crm_sales_details (
    sls_ord_num VARCHAR(50),
    sls_prd_key VARCHAR(50),
    sls_cust_id INT,
    sls_order_dt VARCHAR(50),
    sls_ship_dt VARCHAR(50),
    sls_due_dt VARCHAR(50),
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);
GO

IF OBJECT_ID ('silver.erp_loc_A101', 'U') IS NOT NULL
	DROP TABLE silver.erp_loc_A101;
CREATE TABLE silver.erp_loc_A101 (
    cid NVARCHAR(50),
    cntry NVARCHAR(50)
);
GO


IF OBJECT_ID ('silver.erp_cust_AZ12', 'U') IS NOT NULL
	DROP TABLE silver.erp_cust_AZ12;
CREATE TABLE silver.erp_cust_AZ12 (
    cid NVARCHAR(50),
    bdate DATE,
    gen NVARCHAR(50)
);
GO


IF OBJECT_ID ('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
	DROP TABLE silver.erp_px_cat_g1v2;
CREATE TABLE silver.erp_px_cat_g1v2 (
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
);
GO
