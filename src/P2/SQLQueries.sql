-- Test commands / set up;
SELECT * FROM VACCINE WHERE VNAME = 'Moderna';
SELECT PERSON.HINSURNUM, NAME, VNAME, LOCNAME, VDATE, VSLOT FROM PERSON, VACCSLOT WHERE PERSON.HINSURNUM = VACCSLOT.HINSURNUM;

SELECT VDATE, COUNT(Name) AS numPeople
FROM (
         SELECT Name, VDATE
         FROM (
                  SELECT PERSON.HINSURNUM as Name, VDATE, COUNT(*) as numSlots
                  from PERSON,
                       VACCSLOT
                  WHERE PERSON.HINSURNUM = VACCSLOT.HINSURNUM
                    AND VNAME is not null
                  GROUP BY PERSON.HINSURNUM, VDATE)
         WHERE numSlots = 1
     ) GROUP BY VDATE ORDER BY VDATE;

INSERT INTO VACCSLOT (LOCNAME, VDATE, VTIME, VSLOT, HINSURNUM, ASGNDATE, LICENSENUM, VNAME, BATCHNO, VIALID)
VALUES ('Montreal General', '2021-01-09', '06:36:47', 3, 'RAND3', '2021-03-17', '1234', 'Moderna', 1, 0001);



-- SQL Queries

-- a
SELECT LOCNAME, VDATE, VTIME, VSLOT
FROM VACCSLOT
WHERE HINSURNUM IS NULL
  AND VDATE = '2021-03-20'
  AND LOCNAME = 'Jewish General';

-- b
SELECT EXPRYDATE
FROM VACCSLOT,
     VACCINEBATCH
WHERE VACCSLOT.VNAME = VACCINEBATCH.VNAME
  AND VACCSLOT.BATCHNO = VACCINEBATCH.BATCHNO
  AND VACCSLOT.HINSURNUM = 'DOEJAN'
  AND VACCSLOT.VDATE = '2021-02-06';

-- c
SELECT COUNT(*) as numPeople
FROM VACCSLOT,
     VACCLOCATION
WHERE VDATE = '2021-02-06'
  AND VACCSLOT.LOCNAME = VACCLOCATION.LOCNAME
  AND VACCLOCATION.LCITY = 'Montreal'
  AND HINSURNUM IS NOT NULL;

-- d
SELECT PERSON.NAME, PERSON.PHONE, PERSON.HINSURNUM
FROM PERSON,
     VACCSLOT
WHERE VACCSLOT.HINSURNUM = PERSON.HINSURNUM
  AND VACCSLOT.VDATE < DATE('2021-02-01')
  AND PERSON.HINSURNUM not in (
    SELECT PERSON.HINSURNUM
    FROM PERSON,
         VACCSLOT
    WHERE PERSON.HINSURNUM = VACCSLOT.HINSURNUM
    GROUP BY PERSON.HINSURNUM
    HAVING COUNT(*) > 1
);

-- e
SELECT PERSON.CNAME, CATEGORY.PRIORITYNUM, COUNT(*) as numPeople
FROM PERSON,
     CATEGORY
WHERE CATEGORY.CNAME = PERSON.CNAME
GROUP BY PERSON.CNAME, PRIORITYNUM
ORDER BY PRIORITYNUM;

-- Nurse View
CREATE VIEW mtlnurses (LICENSENUM, NAME, LOCNAME, VLPOSTALCD, LSTREETADDR)
AS
SELECT LICENSENUM, NURSE.NAME, HOSPITAL.LOCNAME, VACCLOCATION.LPOSTALCD, VACCLOCATION.LSTREETADDR
FROM NURSE,
     HOSPITAL,
     VACCLOCATION
WHERE NURSE.LOCNAME = HOSPITAL.LOCNAME
  AND HOSPITAL.LOCNAME = VACCLOCATION.LOCNAME
  AND VACCLOCATION.LCITY = 'Montreal';

drop view mtlnurses;

select *
from mtlnurses
limit 5;

select *
from mtlnurses
where LOCNAME = 'Jewish General'
limit 5;

insert into mtlnurses (LICENSENUM, NAME, LOCNAME, VLPOSTALCD, LSTREETADDR)
VALUES (98765432, 'New Person', 'Montreal General', 'H3H 4B4', 'Chemin CDN');

-- Check Constraint
ALTER TABLE VACCINEBATCH
    ADD CONSTRAINT exprDateCheck
        CHECK ( VaccineBatch.mfgdate < VaccineBatch.exprydate );

INSERT INTO VACCINEBATCH (VNAME, BATCHNO, MFGDATE, EXPRYDATE, NUMDOSES, LOCNAME)
VALUES ('Moderna', 4, DATE('2021-02-24'), DATE(2021 - 01 - 01), 500, 'Clinic Alpha');

INSERT INTO PERSON VALUES ('IZAA', 'Arman Izadi', 'Male', Date('1998-01-26'), 5146918658, 'Montreal', 'H3H 2N9', '2000 rue saint marc', Date('2021-02-25'), 'Everybody else');