-- One to Many relationship:
-- Student 1:N Groups

CREATE TABLE groups
(
    id          NUMBER(6) PRIMARY KEY,
    title       VARCHAR2(32) UNIQUE,
    description VARCHAR2(255)
);

-- Anonymous in-line constraints
CREATE TABLE students
(
    id          NUMBER(6) PRIMARY KEY,
    login       VARCHAR2(32) NOT NULL UNIQUE CHECK (LENGTH(login) >= 5),
    group_id    NUMBER(6) REFERENCES groups,
--     group_id NUMBER(6) REFERENCES groups (id)
    group_title VARCHAR2(6) REFERENCES groups (title) ON DELETE CASCADE -- we can refer to unique columns from groups table
--     group_title NUMBER(6) REFERENCES groups (title) ON DELETE SET NULL
);

-- Explicit in-line constraints
CREATE TABLE students
(
    id       NUMBER(6)
        CONSTRAINT pk_students PRIMARY KEY,
    login    VARCHAR2(32)
        CONSTRAINT nn_students_login NOT NULL
        CONSTRAINT uq_students_login UNIQUE
        CONSTRAINT ck_students_login CHECK (LENGTH(login) >= 5),
    group_id NUMBER(6)
        CONSTRAINT fk_students_group_id REFERENCES groups
);

-- Explicit constraints
CREATE TABLE students
(
    id       NUMBER(6),
    login    VARCHAR2(32),
    group_id NUMBER(6),
    CONSTRAINT pk_students PRIMARY KEY (id),
    CONSTRAINT fk_students_group_id FOREIGN KEY (group_id) REFERENCES groups (id),
    CONSTRAINT uq_students_login UNIQUE (login),
    CONSTRAINT ck_students_login CHECK (LENGTH(login) >= 5)
--     CONSTRAINT nn_students_login NOT NULL,  <---- YOU CANNOT HAVE OUT OF LINE NOT NULL CONSTRAINTS
);


-- Anonymous constraints
CREATE TABLE students
(
    id       NUMBER(6),
    login    VARCHAR2(32),
    group_id NUMBER(6),
    PRIMARY KEY (id),
    FOREIGN KEY (group_id) REFERENCES groups (id),
    UNIQUE (login),
    CHECK (LENGTH(login) >= 5)
--  NOT NULL(login),  <---- YOU CANNOT HAVE OUT OF LINE NOT NULL CONSTRAINTS
);


