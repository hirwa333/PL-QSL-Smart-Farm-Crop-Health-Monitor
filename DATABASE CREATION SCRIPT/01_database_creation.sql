-- ===============================================
-- Smart Farm Crop Health Monitor - Database Creation
-- Author: HIRWA Roy (ID: 24174)
-- Phase IV: Database Creation Script
-- ===============================================

-- ===============================================
-- STEP 1: Create Pluggable Database (Run as SYSTEM)
-- ===============================================

-- Connect as SYSTEM user first
-- CONNECT system/<your_password>

-- Create the PDB with proper naming convention
CREATE PLUGGABLE DATABASE tue_24174_hirwa_smartfarm_db
ADMIN USER farm_admin IDENTIFIED BY hirwa
FILE_NAME_CONVERT=(
    '/u01/app/oracle/oradata/XE/pdbseed/', 
    '/u01/app/oracle/oradata/XE/tue_24174_hirwa_smartfarm_db/'
);

-- Open the new PDB
ALTER PLUGGABLE DATABASE tue_24174_hirwa_smartfarm_db OPEN;

-- ===============================================
-- STEP 2: Switch to the new PDB and create tablespaces
-- ===============================================

-- Switch to the new PDB
ALTER SESSION SET CONTAINER = tue_24174_hirwa_smartfarm_db;

-- Create tablespace for data
CREATE TABLESPACE farm_data 
DATAFILE '/u01/app/oracle/oradata/XE/tue_24174_hirwa_smartfarm_db/farm_data01.dbf' 
SIZE 100M 
AUTOEXTEND ON 
NEXT 25M 
MAXSIZE UNLIMITED;

-- Create tablespace for indexes
CREATE TABLESPACE farm_index 
DATAFILE '/u01/app/oracle/oradata/XE/tue_24174_hirwa_smartfarm_db/farm_index01.dbf' 
SIZE 50M 
AUTOEXTEND ON 
NEXT 15M 
MAXSIZE UNLIMITED;

-- Create temporary tablespace
CREATE TEMPORARY TABLESPACE farm_temp
TEMPFILE '/u01/app/oracle/oradata/XE/tue_24174_hirwa_smartfarm_db/farm_temp01.dbf'
SIZE 50M
AUTOEXTEND ON;

-- ===============================================
-- STEP 3: Create application user with proper privileges
-- ===============================================

-- Create the application user
CREATE USER farm_app_user IDENTIFIED BY farm2025
DEFAULT TABLESPACE farm_data
TEMPORARY TABLESPACE farm_temp
QUOTA UNLIMITED ON farm_data
QUOTA UNLIMITED ON farm_index;

-- Grant necessary privileges
GRANT CONNECT, RESOURCE TO farm_app_user;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO farm_app_user;
GRANT CREATE PROCEDURE, CREATE FUNCTION, CREATE TRIGGER TO farm_app_user;
GRANT CREATE SEQUENCE, CREATE TYPE, CREATE SYNONYM TO farm_app_user;
GRANT UNLIMITED TABLESPACE TO farm_app_user;

-- ===============================================
-- STEP 4: Database Configuration
-- ===============================================

-- Set memory parameters (adjust based on your Oracle version)
ALTER SYSTEM SET sga_target=256M SCOPE=spfile;
ALTER SYSTEM SET pga_aggregate_target=128M SCOPE=spfile;

-- Enable archive logging (if needed for your project)
-- ALTER DATABASE ARCHIVELOG;

-- Set autoextend parameters
ALTER DATABASE DATAFILE 
'/u01/app/oracle/oradata/XE/tue_24174_hirwa_smartfarm_db/farm_data01.dbf'
AUTOEXTEND ON MAXSIZE UNLIMITED;

-- ===============================================
-- STEP 5: Verification Queries
-- ===============================================

-- Verify PDB creation
SELECT name, open_mode FROM v$pdbs WHERE name = 'TUE_24174_HIRWA_SMARTFARM_DB';

-- Verify tablespaces
SELECT tablespace_name, status, contents FROM dba_tablespaces 
WHERE tablespace_name LIKE 'FARM%';

-- Verify user creation
SELECT username, account_status, default_tablespace, temporary_tablespace
FROM dba_users WHERE username = 'FARM_APP_USER';

-- Verify privileges
SELECT privilege FROM dba_sys_privs WHERE grantee = 'FARM_APP_USER';

-- ===============================================
-- STEP 6: Connection Instructions for Application User
-- ===============================================

/*
After running this script, connect as the application user:

SQL> CONNECT farm_app_user/farm2025@localhost:1521/tue_24174_hirwa_smartfarm_db

Or using full connection string:
CONNECT farm_app_user/farm2025@//localhost:1521/tue_24174_hirwa_smartfarm_db

Then run your table creation scripts in this order:
1. Your existing tables.sql
2. Your existing seed_data.sql (with fixes)
3. Your existing functions.sql
4. Your existing procedures.sql
5. Your existing trigger.sql
*/
