--connect to: sys as sysdba
--use the following commands to create a user:

CREATE USER john identified BY johnpassword;

GRANT CREATE SESSION TO john;

GRANT UNLIMITED TABLESPACE TO john;

GRANT CREATE TABLE, CREATE SEQUENCE, CREATE VIEW TO john;



