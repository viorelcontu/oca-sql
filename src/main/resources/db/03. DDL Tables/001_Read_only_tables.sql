-- http://www.dba-oracle.com/t_11g_read_only_tables.htm
-- A table can be returned to read and write using the following command:
-- ALTER TABLE READ ONLY;
-- ALTER TABLE READ WRITE;

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