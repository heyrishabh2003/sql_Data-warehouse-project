
--- checking

------ check for null 
-------Exectation: no result

SELECT cst_id,
COUNT(cst_id) as dublicates_count
FROM bronze.crm_prd_info
GROUP BY cst_id
HAVING COUNT(cst_id) > 1 OR cst_id IS NULL


--- unwanted spaces

SELECT prd_key,
	TRIM(prd_key)
FROM bronze.crm_prd_info
WHERE prd_key != TRIM(prd_key)


--- Data Standarization & Consistency
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

SELECT * FROM bronze.crm_prd_info

SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 or prd_cost is null


-- check for invalid Date Orders

SELECT
prd_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt,
LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS prd_end_dt_test
FROM bronze.crm_prd_info
WHERE prd_key IN ('AC-HE-HL-U509-R','AC-HE-HL-U509')




---- check invaild date
SELECT 
NULLIF(sls_order_dt, 0) AS sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0 
or len(sls_order_dt) != 8 
OR sls_order_dt > 20250101

SELECT * FROM silver.crm_sales_details

WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt


SELECT DISTINCT
	sls_sales,
	sls_quantity,
	sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales,
	sls_quantity,
	sls_price



SELECT 
	id,
	cat,
	subcat,
	maintenance
FROM bronze.erp_px_cat_g1v2


SELECT *
FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
OR subcat != TRIM(subcat) 
OR TRIM(maintenance) != maintenance

--- 
