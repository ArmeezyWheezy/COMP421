-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!


INSERT INTO CATEGORY (CNAME, PRIORITYNUM)
VALUES ('Health Care Worker', 1),
       ('Elder > 65', 1),
       ('Imuno Compromised', 1),
       ('Teachers', 2),
       ('Children < 10', 2),
       ('In proxi to 1', 2),
       ('Essential Service Workers', 3),
       ('In proxi to 2', 3),
       ('Everybody else', 4);

INSERT INTO PERSON (HINSURNUM, NAME, GENDER, DOB, PHONE, CITY, POSTALCD, STREETADDR, REGDATE, CNAME)
VALUES ('IZAA', 'Arman Izadi', 'Male', Date('1998-01-26'), 5146918658, 'Montreal', 'H3H 2N9', '2000 rue saint marc', Date('2021-02-25'), 'Everybody else'),
       ('IZAM', 'MS Izadi', 'Male', Date('1968-12-29'), 09122173182, 'Tehran', 'khodami', 'sheikh bahai', Date('2021-01-25'), 'In proxi to 2'),
       ('SEHM', 'Mahshid Sehizadeh', 'Female', Date('1970-11-03'), 09126057853, 'Tehran', 'khodami', 'sheikh bahai', Date('2020-01-25'), 'Teachers'),
       ('DJUB', 'Boyana Djurovic', 'Female', Date('2000-11-24'), 5146928459, 'Vancouver', 'H3B 2B2', 'Avenue Canadiennes', Date('2020-01-24'), 'Elder > 65'),
       ('DOEJAN', 'Jane Doe', 'Female', Date('2001-12-24'), 5144242520, 'Calgary', 'A1B 2C4', 'Smith st', Date('2021-01-24'), 'Everybody else'),
       ('GHAM', 'Mohammad Ali Ghasemi', 'Male', Date('1996-02-08'), 5146969420, 'Montreal', 'H3A 0E9', 'rue de la rotonde', Date('2020-01-26'), 'Children < 10');

INSERT INTO VACCINE (VNAME, WAITPERIOD, DOSE)
VALUES ('Pfizer-BioNTech', 28, 2),
       ('Moderna', 26, 2),
       ('Johnson & Johnson', 30, 1);

INSERT INTO VACCLOCATION (LOCNAME, LCITY, LPOSTALCD, LSTREETADDR)
VALUES ('Jewish General', 'Montreal', 'H3H 2M9', 'Cote des Neige'),
       ('Montreal General', 'Montreal', 'H3H 4B4', 'Chemin CDN'),
       ('Clinic Alpha', 'Montreal', 'H2A 0E9', 'Guy-Concordia');

INSERT INTO VACCINEBATCH (VNAME, BATCHNO, MFGDATE, EXPRYDATE, NUMDOSES, LOCNAME)
VALUES ('Pfizer-BioNTech', 1, CURRENT_DATE, DATE('2022-01-01'), 4000, 'Jewish General'),
       ('Pfizer-BioNTech', 2, CURRENT_DATE, DATE('2022-01-01'), 4000, 'Montreal General'),
       ('Pfizer-BioNTech', 3, CURRENT_DATE, DATE('2022-01-01'), 100, 'Clinic Alpha'),
       ('Moderna', 1, CURRENT_DATE, DATE('2022-09-01'), 6000, 'Jewish General'),
       ('Moderna', 2, CURRENT_DATE, DATE('2022-09-01'), 6000, 'Montreal General'),
       ('Moderna', 3, CURRENT_DATE, DATE('2022-09-01'), 200, 'Clinic Alpha'),
       ('Johnson & Johnson', 1, CURRENT_DATE, DATE('2021-12-30'), 500, 'Jewish General'),
       ('Johnson & Johnson', 2, CURRENT_DATE, DATE('2021-12-30'), 500, 'Montreal General'),
       ('Johnson & Johnson', 3, CURRENT_DATE, DATE('2021-12-30'), 500, 'Clinic Alpha');

INSERT INTO HOSPITAL (LOCNAME) VALUES ('Jewish General'), ('Montreal General');

INSERT INTO NURSE (LICENSENUM, NAME, LOCNAME)
VALUES (16548484, 'Joy Joyous', 'Jewish General'),
       (15489652, 'Sad Sadous', 'Jewish General'),
       (16875423, 'Mad Madous', 'Jewish General'),
       (23578796, 'Lois Lane', 'Montreal General'),
       (58769546, 'Karim Abduljabbar', 'Montreal General'),
       (96523112, 'Tony Hawk', 'Montreal General'),
       (32789952, 'Barack Obama', 'Jewish General');

-- Date data from mockaroo
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-10-19');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-06-19');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-02-12');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-08-29');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-02-28');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-01-09');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-08-25');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-09-26');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-06-26');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-03-24');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-06-28');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-10-13');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-10-04');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-11-10');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-06-27');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-04-15');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-11-27');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-08-11');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-01-17');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-09-13');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-05-11');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-04-21');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-01-25');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-03-17');
insert into VACCDATES (locname, vdate) values ('Jewish General', '2021-03-20');

insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-10-19');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-09-12');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-06-19');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-02-12');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-08-29');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-02-28');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-01-09');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-08-25');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-09-26');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-06-26');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-03-24');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-06-28');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-10-13');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-10-04');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-11-10');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-06-27');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-04-15');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-11-27');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-08-11');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-01-17');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-09-13');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-05-11');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-04-21');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-01-25');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-03-17');
insert into VACCDATES (locname, vdate) values ('Montreal General', '2021-02-06');

INSERT INTO VIAL (VNAME, BATCHNO, VIALID)
VALUES ('Moderna', '1', '0001'),
       ('Moderna', '1', '0002'),
       ('Moderna', '1', '0003'),
       ('Moderna', '1', '0004'),
       ('Moderna', '1', '0005'),
       ('Moderna', '1', '0006'),
       ('Moderna', '1', '0007'),
       ('Moderna', '1', '0008'),
       ('Moderna', '1', '0009'),
       ('Moderna', '1', '0010'),
       ('Moderna', '1', '0011'),
       ('Moderna', '1', '0012'),
       ('Moderna', '1', '0013'),
       ('Moderna', '1', '0014'),
       ('Moderna', '1', '0015'),
       ('Moderna', '1', '0016'),
       ('Moderna', '1', '0017'),
       ('Moderna', '1', '0018'),
       ('Moderna', '1', '0019'),
       ('Moderna', '1', '0020'),
       ('Pfizer-BioNTech', '1', '0001'),
       ('Pfizer-BioNTech', '1', '0002'),
       ('Pfizer-BioNTech', '1', '0003'),
       ('Pfizer-BioNTech', '1', '0004'),
       ('Pfizer-BioNTech', '1', '0005'),
       ('Pfizer-BioNTech', '1', '0006'),
       ('Pfizer-BioNTech', '1', '0007'),
       ('Pfizer-BioNTech', '1', '0008'),
       ('Pfizer-BioNTech', '1', '0009'),
       ('Pfizer-BioNTech', '1', '0010'),
       ('Pfizer-BioNTech', '1', '0011'),
       ('Pfizer-BioNTech', '1', '0012'),
       ('Pfizer-BioNTech', '1', '0013'),
       ('Pfizer-BioNTech', '1', '0014'),
       ('Pfizer-BioNTech', '1', '0015'),
       ('Pfizer-BioNTech', '1', '0016'),
       ('Pfizer-BioNTech', '1', '0017'),
       ('Pfizer-BioNTech', '1', '0018'),
       ('Pfizer-BioNTech', '1', '0019'),
       ('Pfizer-BioNTech', '1', '0020');



INSERT INTO VACCSLOT (LOCNAME, VDATE, VTIME, VSLOT, HINSURNUM, ASGNDATE, LICENSENUM, VNAME, BATCHNO, VIALID)
VALUES ('Jewish General', '2021-10-19', '06:36:47', 1, 'IZAA', DATE('2020-02-23'), 16548484, 'Moderna', '1', '0001'),
       ('Jewish General', '2021-11-27', '18:13:22', 1, 'IZAA', DATE('2020-02-23'), 16548484, 'Moderna', '1', '0002'),
       ('Jewish General', '2021-03-20', '09:05:18', 1, null, null, null, null, null, null),
       ('Jewish General', '2021-03-20', '19:00:56', 2, null, null, null, null, null, null),
       ('Jewish General', '2021-03-20', '21:30:56', 3, null, null, null, null, null, null),
       ('Jewish General', '2021-03-20', '22:30:56', 4, 'IZAM', DATE('2020-02-25'), 15489652, 'Pfizer-BioNTech', '1', '0001'),
       ('Montreal General', '2021-01-09', '14:28:30', 1, 'DOEJAN', DATE('2020-02-25'), 32789952, 'Pfizer-BioNTech', '1', '0003'),
       ('Montreal General', '2021-01-09', '15:30:30', 2, 'SEHM', DATE('2020-02-25'), 32789952, 'Pfizer-BioNTech', '1', '0016'),
       ('Montreal General', '2021-02-06', '16:28:30', 1, 'DOEJAN', DATE('2020-02-25'), 32789952, 'Pfizer-BioNTech', '1', '0004'),
       ('Montreal General', '2021-10-19', '13:33:37', 2, 'GHAM', DATE('2020-02-25'), 32789952, 'Pfizer-BioNTech', '1', '0018');

INSERT INTO VACCSLOT VALUES ('Montreal General', '2021-04-21', '15:30:30', 1, null, null, null, null, null, null);
INSERT INTO VACCSLOT VALUES ('Montreal General', '2021-04-21', '16:30:30', 2, null, null, null, null, null, null);
INSERT INTO VACCSLOT VALUES ('Montreal General', '2021-04-21', '17:30:30', 3, null, null, null, null, null, null);
INSERT INTO VACCSLOT VALUES ('Montreal General', '2021-04-21', '18:30:30', 4, null, null, null, null, null, null);
INSERT INTO VACCSLOT VALUES ('Jewish General', '2021-04-21', '15:30:30', 1, null, null, null, null, null, null);
INSERT INTO VACCSLOT VALUES ('Jewish General', '2021-04-21', '16:30:30', 2, null, null, null, null, null, null);
INSERT INTO VACCSLOT VALUES ('Jewish General', '2021-04-21', '17:30:30', 3, null, null, null, null, null, null);
INSERT INTO VACCSLOT VALUES ('Jewish General', '2021-04-21', '18:30:30', 4, null, null, null, null, null, null);

INSERT INTO NURSEASSIGNMENTS (LICENSENUM, LOCNAME, VDATE)
VALUES (16548484, 'Jewish General', '2021-10-19'),
       (16548484, 'Jewish General', '2021-11-27'),
       (15489652, 'Jewish General', '2021-03-20'),
       (32789952, 'Montreal General', '2021-01-09'),
       (32789952, 'Montreal General', '2021-10-19'),
       (32789952, 'Montreal General', '2021-03-17'),
       (32789952, 'Montreal General', '2021-02-06');