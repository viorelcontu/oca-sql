--ALTER COLUMN DATA TYPE RULES
-- ALTER TABLE MODIFY -> can change column datatype only if it is empty or contains nulls only.



-------------------------------------------------------------------------------------
--DEFAULT ON NULL
-- You cannot reference another column in a DEFAULT
-- DEFAULT does not prevent explicit nulls, you need DEFAULT ON NULL for that
-- You can ALTER table <tablename> MODIFY, not null constaint only if there are no rows at all, otherwise you need to add a default value

-------------------------------------------------------------------------------------
--VISIBLE INVISIBLE



--------------------------------------------------------------------------------------
-- SET UNUSED