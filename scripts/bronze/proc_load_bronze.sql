
/*
=================================================================================================

Stored Procedure : Load Bronze Layer (source >> Bronze schema

=================================================================================================
Script purpose:
    This stored procedure load data into 'bronze' schema from external CSV files.
    It performs the following actions :
- Truncates the bronze tables before loading the data
- uses the bulk insert command to load data from the csv files to bronze tables.

Parameters :
  Note :
    This stored procedure does not accept any parameters or return any values.

Uses Example :
    EXEC bronze.load_bronze;

=================================================================================================

*/




CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    DECLARE @start_time DATETIME = GETDATE();
    DECLARE @end_time DATETIME;

    BEGIN TRY
        PRINT '====================================';
        PRINT 'Loading Bronze Layer';
        PRINT 'Start Time: ' + CAST(@start_time AS NVARCHAR);
        PRINT '====================================';

        PRINT '------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '------------------------------------';

        PRINT '>>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>>> Inserting Data Into: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'G:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        PRINT '>>> Truncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>>> Inserting Data Into: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'G:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        PRINT '>>> Truncating Table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>>> Inserting Data Into: bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'G:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        PRINT '------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '------------------------------------';

        PRINT '>>> Truncating Table: bronze.erp_cust_AZ12';
        TRUNCATE TABLE bronze.erp_cust_AZ12;

        PRINT '>>> Inserting Data Into: bronze.erp_cust_AZ12';
        BULK INSERT bronze.erp_cust_AZ12
        FROM 'G:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        PRINT '>>> Truncating Table: bronze.erp_loc_A101';
        TRUNCATE TABLE bronze.erp_loc_A101;

        PRINT '>>> Inserting Data Into: bronze.erp_loc_A101';
        BULK INSERT bronze.erp_loc_A101
        FROM 'G:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        PRINT '>>> Truncating Table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>>> Inserting Data Into: bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'G:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '====================================';
        PRINT 'Bronze Layer Load Completed Successfully';
        PRINT 'End Time: ' + CAST(@end_time AS NVARCHAR);
        PRINT 'Duration (min): ' + CAST(DATEDIFF(MINUTE, @start_time, @end_time) AS NVARCHAR);
        PRINT '====================================';

    END TRY
    BEGIN CATCH
        PRINT '=======================================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '=======================================================';
    END CATCH
END;

   
