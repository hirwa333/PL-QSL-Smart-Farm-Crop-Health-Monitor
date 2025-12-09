-- ===============================================
-- Smart Farm Crop Health Monitor - SQL Developer Version
-- Author: HIRWA Roy (ID: 24174)
-- Windows 21c XE
-- ===============================================

-- ===============================================
-- STEP 1: Open the PDB if it exists
-- ===============================================
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'ALTER PLUGGABLE DATABASE tue_24174_hirwa_smartfarm_db OPEN READ WRITE';
        DBMS_OUTPUT.PUT_LINE('PDB opened successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('PDB may already be open or an error occurred: ' || SQLERRM);
    END;
END;
/

-- Verify PDB status
SELECT name, open_mode FROM v$pdbs;

-- ===============================================
-- STEP 2: Switch session to the PDB
-- ===============================================
BEGIN
    EXECUTE IMMEDIATE 'ALTER SESSION SET CONTAINER = tue_24174_hirwa_smartfarm_db';
END;
/

-- ===============================================
-- STEP 3: Create Tablespaces if missing
-- ===============================================
BEGIN
    -- FARM_DATA
    BEGIN
        EXECUTE IMMEDIATE 'CREATE TABLESPACE farm_data
            DATAFILE ''C:\APP\ROYHI\PRODUCT\21C\ORADATA\XE\TUE_24174_HIRWA_SMARTFARM_DB\farm_data01.dbf''
            SIZE 100M AUTOEXTEND ON NEXT 25M MAXSIZE UNLIMITED';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -1543 THEN
                DBMS_OUTPUT.PUT_LINE('Tablespace FARM_DATA already exists.');
            ELSE
                RAISE;
            END IF;
    END;

    -- FARM_INDEX
    BEGIN
        EXECUTE IMMEDIATE 'CREATE TABLESPACE farm_index
            DATAFILE ''C:\APP\ROYHI\PRODUCT\21C\ORADATA\XE\TUE_24174_HIRWA_SMARTFARM_DB\farm_index01.dbf''
            SIZE 50M AUTOEXTEND ON NEXT 15M MAXSIZE UNLIMITED';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -1543 THEN
                DBMS_OUTPUT.PUT_LINE('Tablespace FARM_INDEX already exists.');
            ELSE
                RAISE;
            END IF;
    END;

    -- FARM_TEMP
    BEGIN
        EXECUTE IMMEDIATE 'CREATE TEMPORARY TABLESPACE farm_temp
            TEMPFILE ''C:\APP\ROYHI\PRODUCT\21C\ORADATA\XE\TUE_24174_HIRWA_SMARTFARM_DB\farm_temp01.dbf''
            SIZE 50M AUTOEXTEND ON';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -1543 THEN
                DBMS_OUTPUT.PUT_LINE('Tablespace FARM_TEMP already exists.');
            ELSE
                RAISE;
            END IF;
    END;
END;
/

-- ===============================================
-- STEP 4: Create Application User if missing
-- ===============================================
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'CREATE USER farm_app_user IDENTIFIED BY farm2025
            DEFAULT TABLESPACE farm_data
            TEMPORARY TABLESPACE farm_temp
            QUOTA UNLIMITED ON farm_data
            QUOTA UNLIMITED ON farm_index';

        EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO farm_app_user';
        EXECUTE IMMEDIATE 'GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO farm_app_user';
        EXECUTE IMMEDIATE 'GRANT CREATE PROCEDURE, CREATE FUNCTION, CREATE TRIGGER TO farm_app_user';
        EXECUTE IMMEDIATE 'GRANT CREATE SEQUENCE, CREATE TYPE, CREATE SYNONYM TO farm_app_user';
        EXECUTE IMMEDIATE 'GRANT UNLIMITED TABLESPACE TO farm_app_user';

        DBMS_OUTPUT.PUT_LINE('User FARM_APP_USER created and privileges granted.');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -19617 THEN
                DBMS_OUTPUT.PUT_LINE('User FARM_APP_USER already exists.');
            ELSE
                RAISE;
            END IF;
    END;
END;
/

-- ===============================================
-- STEP 5: Verification Queries
-- ===============================================
-- Verify PDB status
SELECT name, open_mode FROM v$pdbs;

-- Verify tablespaces
SELECT tablespace_name, status, contents
FROM dba_tablespaces
WHERE tablespace_name LIKE 'FARM%';

-- Verify user
SELECT username, account_status, default_tablespace, temporary_tablespace
FROM dba_users
WHERE username = 'FARM_APP_USER';
