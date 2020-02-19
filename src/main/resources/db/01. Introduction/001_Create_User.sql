--Connect to container database first.
--login: sys as sysdba
ALTER SESSION SET CONTAINER=PDB112;

CREATE USER ocasql IDENTIFIED BY "oracle-sql";

GRANT CREATE SESSION TO ocasql;
GRANT CREATE TABLE TO ocasql;
GRANT CREATE VIEW TO ocasql;
GRANT CREATE SEQUENCE TO ocasql;

GRANT UNLIMITED TABLESPACE to ocasql; -- We need to allocated some space to hold our data
ALTER user ocasql QUOTA 128M on users ; -- Or we can make it a little bit more limited

-- users is a tablespace. First let's see what data dictionaries we have with TABLESPACE keyword:
SELECT *
FROM dictionary where table_name like '%TABLESPACE%';

-- user_tablespaces contains the definition of our tablespaces
SELECT *
FROM user_tablespaces;


