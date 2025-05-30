/*
===============================================================================
Stored Procedure: Load Gold Layer (Silver -> Gold)
===============================================================================

Script Purpose:
    This stored procedure recreates all views in the 'gold' schema using
    transformed and enriched data from the 'silver' layer.
    Actions Performed:
    - Drops existing gold views if they exist
    - Recreates views for dimension and fact tables (star schema)

Usage Example:
    EXEC gold.load_gold;

===============================================================================
*/

-- Drop if already exists
IF OBJECT_ID('gold.load_gold', 'P') IS NOT NULL
    DROP PROCEDURE gold.load_gold;
GO

CREATE PROCEDURE gold.load_gold
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @startTime DATETIME = GETDATE();
    DECLARE @viewStart DATETIME;
    DECLARE @viewEnd DATETIME;

    BEGIN TRY

        -- Drop & Create dim_customers
        SET @viewStart = GETDATE();
        PRINT 'Creating View: gold.dim_customers';

        IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
            DROP VIEW gold.dim_customers;

        EXEC sp_executesql N'
            CREATE VIEW gold.dim_customers AS
            SELECT 
                ROW_NUMBER () OVER (ORDER BY cst_id) AS Customer_key,
                ci.cst_id AS Customer_ID,
                ci.cst_key AS Customer_name,
                ci.cst_first_name AS Customer_firstname,
                ci.cst_last_name AS Customer_lastname,
                ci.cst_marital_status AS Marital_status,
                CASE
                    WHEN ci.cst_gndr != ''n/a'' THEN ci.cst_gndr
                    ELSE COALESCE(ca.gen, ''n/a'')
                END AS Gender,
                ca.bdate AS Birthdate,
                la.cntry AS Country,
                ci.cst_create_date AS Create_Date
            FROM silver.crm_cust_info ci
            LEFT JOIN silver.erp_cust_AZ12 ca ON ci.cst_key = ca.cid
            LEFT JOIN silver.erp_loc_A101 la ON ci.cst_key = la.cid;
        ';
        SET @viewEnd = GETDATE();
        PRINT 'Created View: gold.dim_customers in ' + CAST(DATEDIFF(SECOND, @viewStart, @viewEnd) AS VARCHAR) + ' seconds';

        -- Drop & Create dim_products
        SET @viewStart = GETDATE();
        PRINT 'Creating View: gold.dim_products';

        IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
            DROP VIEW gold.dim_products;

        EXEC sp_executesql N'
            CREATE VIEW gold.dim_products AS
            SELECT 
                ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
                pn.prd_id AS product_id,
                pn.prd_key AS product_number,
                pn.prd_nm AS product_name,
                pn.cat_id AS category_id,
                pc.cat AS category,
                pc.subcat AS subcategory,
                pc.maintenance,
                pn.prd_cost AS cost,
                pn.prd_line AS product_line,
                pn.prd_start_dt AS start_date
            FROM silver.crm_prd_info pn
            LEFT JOIN silver.erp_px_cat_g1v2 pc ON pn.cat_id = pc.id
            WHERE prd_end_dt IS NULL;
        ';
        SET @viewEnd = GETDATE();
        PRINT 'Created View: gold.dim_products in ' + CAST(DATEDIFF(SECOND, @viewStart, @viewEnd) AS VARCHAR) + ' seconds';

        -- Drop & Create fact_sales
        SET @viewStart = GETDATE();
        PRINT 'Creating View: gold.fact_sales';

        IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
            DROP VIEW gold.fact_sales;

        EXEC sp_executesql N'
            CREATE VIEW gold.fact_sales AS
            SELECT 
                sd.sls_ord_num AS Order_number,
                pr.Product_key,
                cu.Customer_key,
                sd.sls_cust_id,
                sd.sls_order_dt AS Order_date,
                sd.sls_ship_dt AS Ship_date,
                sd.sls_due_dt AS Due_date,
                sd.sls_quantity AS Quantity,
                sd.sls_sales AS Sales_amount,
                sd.sls_price AS Price
            FROM silver.crm_sales_details sd
            LEFT JOIN gold.dim_products pr ON sd.sls_prd_key = pr.product_number
            LEFT JOIN gold.dim_customers cu ON sd.sls_cust_id = cu.Customer_ID;
        ';
        SET @viewEnd = GETDATE();
        PRINT 'Created View: gold.fact_sales in ' + CAST(DATEDIFF(SECOND, @viewStart, @viewEnd) AS VARCHAR) + ' seconds';

        -- Final log
        DECLARE @totalTime INT = DATEDIFF(SECOND, @startTime, GETDATE());
        PRINT 'Completed Loading Gold Layer in ' + CAST(@totalTime AS VARCHAR) + ' seconds';

    END TRY
    BEGIN CATCH
        PRINT 'Error in gold layer load: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
