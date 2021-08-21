-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been created.

-- This is only an example of how you add create table ddls to this file.
--   You may remove it.
CREATE TABLE Category
(
    cname       VARCHAR(200) NOT NULL,
    prioritynum INTEGER,
    PRIMARY KEY (cname)
);

CREATE TABLE Person
(
    hinsurnum VARCHAR(200) NOT NULL,
    name       VARCHAR(200),
    gender     VARCHAR(200),
    dob        DATE,
    phone      VARCHAR(10),
    city       VARCHAR(200),
    postalcd   VARCHAR(10),
    streetaddr VARCHAR(200),
    regdate    DATE,
    cname      VARCHAR(20),
    PRIMARY KEY (hinsurnum),
    FOREIGN KEY (cname) REFERENCES Category
);

CREATE TABLE Vaccine
(
    vname      VARCHAR(200) NOT NULL,
    waitperiod INT,
    dose       INT,
    PRIMARY KEY (vname)
);

CREATE TABLE VaccLocation
(
    locname     VARCHAR(200) NOT NULL,
    lcity       VARCHAR(200),
    lpostalcd   VARCHAR(10),
    lstreetaddr VARCHAR(200),
    PRIMARY KEY (locname)
);

CREATE TABLE VaccineBatch
(
    vname     VARCHAR(200) NOT NULL,
    batchno   INT          NOT NULL,
    mfgdate   DATE,
    exprydate DATE,
    numdoses  INT,
    locname   VARCHAR(200),
    PRIMARY KEY (vname, batchno),
    FOREIGN KEY (vname) REFERENCES Vaccine,
    FOREIGN KEY (locname) REFERENCES VaccLocation
);

CREATE TABLE Vial
(
    vname   VARCHAR(200) NOT NULL,
    batchno INT          NOT NULL,
    vialid  VARCHAR(100) NOT NULL,
    PRIMARY KEY (vname, batchno, vialid),
    FOREIGN KEY (vname, batchno) references VaccineBatch
);

CREATE TABLE Hospital
(
    locname VARCHAR(200) NOT NULL,
    PRIMARY KEY (locname),
    FOREIGN KEY (locname) REFERENCES VaccLocation
);

CREATE TABLE Nurse
(
    licensenum INT NOT NULL,
    name       VARCHAR(100),
    locname    VARCHAR(200),
    PRIMARY KEY (licensenum),
    FOREIGN KEY (locname) REFERENCES Hospital
);

CREATE TABLE VaccDates
(
    locname VARCHAR(200) NOT NULL,
    vdate   DATE         NOT NULL,
    PRIMARY KEY (locname, vdate),
    FOREIGN KEY (locname) REFERENCES VaccLocation
);

CREATE TABLE VaccSlot
(
    locname    VARCHAR(200) NOT NULL,
    vdate      DATE         NOT NULL,
    vtime      TIME         NOT NULL,
    vslot      INT          NOT NULL,
    hinsurnum VARCHAR(200),
    asgndate   DATE,
    licensenum INT,
    vname      VARCHAR(200),
    batchno    INT,
    vialid     VARCHAR(100),
    PRIMARY KEY (locname, vdate, vtime, vslot),
    FOREIGN KEY (locname, vdate) REFERENCES VaccDates,
    FOREIGN KEY (licensenum) REFERENCES Nurse,
    FOREIGN KEY (hinsurnum) REFERENCES Person,
    FOREIGN KEY (vname, batchno, vialid) REFERENCES Vial
);

CREATE TABLE NurseAssignments
(
    licensenum INT          NOT NULL,
    locname    VARCHAR(200) NOT NULL,
    vdate      DATE         NOT NULL,
    PRIMARY KEY (licensenum, locname, vdate),
    FOREIGN KEY (licensenum) REFERENCES Nurse,
    FOREIGN KEY (locname, vdate) references VaccDates
);