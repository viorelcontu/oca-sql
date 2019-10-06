CREATE SEQUENCE user_id_seq MINVALUE 1 INCREMENT BY 1 ;

-- 1 to Many relationship: Student : Groups

CREATE TABLE groups
(
    group_id NUMBER(3) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    group_name  VARCHAR2(15) NOT NULL UNIQUE
);

-- Anonymous in-line constraints
CREATE TABLE students
(
    user_id NUMBER(6) DEFAULT user_id_seq.nextval PRIMARY KEY,
    user_name VARCHAR2(30) NOT NULL UNIQUE CHECK (LENGTH(user_name) >= 3),
    first_name NVARCHAR2(100),
    last_name NVARCHAR2(100),
    full_name NVARCHAR2(255) GENERATED ALWAYS AS (first_name || ' ' || last_name) VIRTUAL,
    group_id NUMBER(3) REFERENCES groups(group_id) on DELETE CASCADE,
    active  NUMBER(1) DEFAULT 1 NOT NULL CHECK ( active BETWEEN 0 and 1) -- similar to a boolean variable
);

-- Explicit/named in-line constraints
CREATE TABLE students
(
    user_id NUMBER(6) DEFAULT user_id_seq.nextval CONSTRAINT PK_STUDENTS PRIMARY KEY,
    user_name VARCHAR2(30)
        CONSTRAINT user_name_NN NOT NULL
        CONSTRAINT UQ_USER_NAME UNIQUE
        CONSTRAINT USER_NAME_LENGTH CHECK (LENGTH(user_name) >= 3),
    first_name NVARCHAR2(100),
    last_name NVARCHAR2(100),
    full_name NVARCHAR2(255) GENERATED ALWAYS AS (first_name || ' ' || last_name) VIRTUAL,
    group_id NUMBER(3) CONSTRAINT FK_GROUPS REFERENCES groups(group_id) ON DELETE CASCADE,
    active  NUMBER(1) DEFAULT 1
        CONSTRAINT ACTIVE_NN NOT NULL
        CONSTRAINT ACTIVE_BOOLEAN CHECK ( active BETWEEN 0 and 1)
);

-- Anonymous out-of-line constraints (added at the end of create statement)
CREATE TABLE students
(
    user_id NUMBER(6) DEFAULT user_id_seq.nextval,
    user_name VARCHAR2(30) NOT NULL, -- NOT NULL CAN NEVER BE OUT-OF-LINE
    first_name NVARCHAR2(100),
    last_name NVARCHAR2(100),
    full_name NVARCHAR2(255) GENERATED ALWAYS AS (first_name || ' ' || last_name) VIRTUAL,
    group_id NUMBER(3),
    active  NUMBER(1) DEFAULT 1 NOT NULL,
    PRIMARY KEY (user_id),
    UNIQUE (user_name),
    FOREIGN KEY (group_id) REFERENCES groups(group_id) ON DELETE CASCADE, -- Notice we have FOREIGN KEY
    CHECK (LENGTH(user_name) >= 3),
    CHECK ( active BETWEEN 0 and 1)
);

-- Explicit/named out-of-line constraints
CREATE TABLE students
(
    user_id NUMBER(6) DEFAULT user_id_seq.nextval,
    user_name VARCHAR2(30) CONSTRAINT user_name_nn NOT NULL,
    first_name NVARCHAR2(100),
    last_name NVARCHAR2(100),
    full_name NVARCHAR2(255) GENERATED ALWAYS AS (first_name || ' ' || last_name) VIRTUAL,
    group_id NUMBER(3),
    active  NUMBER(1) DEFAULT 1,
    CONSTRAINT PK_STUDENTS PRIMARY KEY (user_id),
    CONSTRAINT UQ_USER_NAME UNIQUE (user_name),
    CONSTRAINT group_fk FOREIGN KEY (group_id) REFERENCES groups(group_id) ON DELETE SET NULL, -- Notice set null
    CONSTRAINT USER_NAME_LENGTH CHECK (LENGTH(user_name) >= 3),
    CONSTRAINT ACTIVE_BOOLEAN CHECK ( active BETWEEN 0 and 1)
);


