/*

===========================================================================
Create Database and schemas
===========================================================================
Scripts purpose:
		This script create a new database named 'datawarehouse' after checking if it already exists.
		If the database exists, it is dropped and recreated. Additionally, the script setup up three schemas
		within the database: 'bronze', 'silver', and 'gold'

Warning :
	Running this script will drop the entire 'Datawarehouse' database if it exists.
	All data in the datbase will permanently deleted. proccesd with caution.
	and ensure you have proper backups before running this scripts.

*/


-- Switch to master before dropping database
USE master;
GO

-- Drop the database if it exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END
GO

-- Create the database
CREATE DATABASE DataWarehouse;
GO

-- Use the newly created database
USE DataWarehouse;
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'silver')
BEGIN
    EXEC('CREATE SCHEMA silver');
END
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
BEGIN
    EXEC('CREATE SCHEMA bronze');
END
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'gold')
BEGIN
    EXEC('CREATE SCHEMA gold');
END
GO
