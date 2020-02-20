-- http://www.dba-oracle.com/t_11g_read_only_tables.htm
-- A table can be returned to read and write using the following command:
-- ALTER TABLE READ ONLY;
-- ALTER TABLE READ WRITE;
CREATE TABLE universities (
    id NUMBER(10) PRIMARY KEY,
    title VARCHAR2(10)
);

INSERT INTO universities VALUES (1, 'USM');
INSERT INTO universities VALUES (2, 'ASEM');

ALTER TABLE universities READ ONLY;


INSERT INTO universities VALUES (3, 'USMF'); -- will fail
TRUNCATE TABLE universities; --will fail
ALTER TABLE universities drop COLUMN title; --will fail
ALTER TABLE universities set UNUSED COLUMN title; --fail
ALTER TABLE institutions RENAME COLUMN title to name; --fail


ALTER TABLE universities ADD description VARCHAR2(10); --OK
alter table universities drop COLUMN description; --FAIL cannot drop it
COMMENT ON TABLE universities IS 'hehe'; -- OK
COMMENT ON COLUMN universities.description IS 'haha'; -- OK

ALTER TABLE universities modify title not null; --OK
ALTER TABLE universities RENAME TO institutions; --OK
DROP TABLE institutions --OK


-- In READ-ONLY mode, the following operations are PERMITTED on the table:
    -- Select
    -- Management indexes, constraints, supplemental log
    -- Dropping and deallocation of unused columns
    -- Renaming and moving of the table
    -- Altering the table for physical property changes, row movement, and shrinking the segment
    -- Drop table (!!!)


-- The following operations are NOT PERMITTED on a table in READ-ONLY mode:
    -- DML on table or any table partitions
    -- Truncation of table
    -- Select for update
    -- Adding, removing, renaming, dropping, or setting a column to unused
    -- Dropping a partition or sub partition belonging to the table
    -- Online redefinition
    -- Flashback on the table