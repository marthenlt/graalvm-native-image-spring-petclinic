INSERT INTO vets(FIRST_NAME,LAST_NAME) VALUES ('James', 'Carter');
INSERT INTO vets(FIRST_NAME,LAST_NAME) VALUES ('Helen', 'Leary');
INSERT INTO vets(FIRST_NAME,LAST_NAME) VALUES ('Linda', 'Douglas');
INSERT INTO vets(FIRST_NAME,LAST_NAME) VALUES ('Rafael', 'Ortega');
INSERT INTO vets(FIRST_NAME,LAST_NAME) VALUES ('Henry', 'Stevens');
INSERT INTO vets(FIRST_NAME,LAST_NAME) VALUES ('Sharon', 'Jenkins');

INSERT INTO specialties(NAME) VALUES ('radiology');
INSERT INTO specialties(NAME) VALUES ('surgery');
INSERT INTO specialties(NAME) VALUES ('dentistry');

INSERT INTO types(NAME) VALUES ('cat');
INSERT INTO types(NAME) VALUES ('dog');
INSERT INTO types(NAME) VALUES ('lizard');
INSERT INTO types(NAME) VALUES ('snake');
INSERT INTO types(NAME) VALUES ('bird');
INSERT INTO types(NAME) VALUES ('hamster');

INSERT INTO owners(FIRST_NAME,LAST_NAME,ADDRESS,CITY,TELEPHONE) VALUES ('George', 'Franklin', '110 W. Liberty St.', 'Madison', '6085551023');
INSERT INTO owners(FIRST_NAME,LAST_NAME,ADDRESS,CITY,TELEPHONE) VALUES ('Betty', 'Davis', '638 Cardinal Ave.', 'Sun Prairie', '6085551749');
INSERT INTO owners(FIRST_NAME,LAST_NAME,ADDRESS,CITY,TELEPHONE) VALUES ('Eduardo', 'Rodriquez', '2693 Commerce St.', 'McFarland', '6085558763');
INSERT INTO owners(FIRST_NAME,LAST_NAME,ADDRESS,CITY,TELEPHONE) VALUES ('Harold', 'Davis', '563 Friendly St.', 'Windsor', '6085553198');
INSERT INTO owners(FIRST_NAME,LAST_NAME,ADDRESS,CITY,TELEPHONE) VALUES ('Peter', 'McTavish', '2387 S. Fair Way', 'Madison', '6085552765');
INSERT INTO owners(FIRST_NAME,LAST_NAME,ADDRESS,CITY,TELEPHONE) VALUES ('Jean', 'Coleman', '105 N. Lake St.', 'Monona', '6085552654');
INSERT INTO owners(FIRST_NAME,LAST_NAME,ADDRESS,CITY,TELEPHONE) VALUES ('Jeff', 'Black', '1450 Oak Blvd.', 'Monona', '6085555387');
INSERT INTO owners(FIRST_NAME,LAST_NAME,ADDRESS,CITY,TELEPHONE) VALUES ('Maria', 'Escobito', '345 Maple St.', 'Madison', '6085557683');
INSERT INTO owners(FIRST_NAME,LAST_NAME,ADDRESS,CITY,TELEPHONE) VALUES ('David', 'Schroeder', '2749 Blackhawk Trail', 'Madison', '6085559435');
INSERT INTO owners(FIRST_NAME,LAST_NAME,ADDRESS,CITY,TELEPHONE) VALUES ('Carlos', 'Estaban', '2335 Independence La.', 'Waunakee', '6085555487');

INSERT INTO vet_specialties(VET_ID,SPECIALTY_ID) VALUES (2, 1);
INSERT INTO vet_specialties(VET_ID,SPECIALTY_ID) VALUES (3, 2);
INSERT INTO vet_specialties(VET_ID,SPECIALTY_ID) VALUES (3, 3);
INSERT INTO vet_specialties(VET_ID,SPECIALTY_ID) VALUES (4, 2);
INSERT INTO vet_specialties(VET_ID,SPECIALTY_ID) VALUES (5, 1);

INSERT INTO pets(NAME,BIRTH_DATE,TYPE_ID,OWNER_ID) VALUES ('Leo', to_date('2010-09-07', 'yyyy-mm-dd'), 1, 1);
INSERT INTO pets(NAME,BIRTH_DATE,TYPE_ID,OWNER_ID) VALUES ('Basil', to_date('2012-08-06', 'yyyy-mm-dd'), 6, 2);
INSERT INTO pets(NAME,BIRTH_DATE,TYPE_ID,OWNER_ID) VALUES ('Rosy', to_date('2011-04-17', 'yyyy-mm-dd'), 2, 3);
INSERT INTO pets(NAME,BIRTH_DATE,TYPE_ID,OWNER_ID) VALUES ('Jewel', to_date('2010-03-07', 'yyyy-mm-dd'), 2, 3);
INSERT INTO pets(NAME,BIRTH_DATE,TYPE_ID,OWNER_ID) VALUES ('Iggy', to_date('2010-11-30', 'yyyy-mm-dd'), 3, 4);
INSERT INTO pets(NAME,BIRTH_DATE,TYPE_ID,OWNER_ID) VALUES ('George', to_date('2010-01-20', 'yyyy-mm-dd'), 4, 5);
INSERT INTO pets(NAME,BIRTH_DATE,TYPE_ID,OWNER_ID) VALUES ('Samantha', to_date('2012-09-04', 'yyyy-mm-dd'), 1, 6);
INSERT INTO pets(NAME,BIRTH_DATE,TYPE_ID,OWNER_ID) VALUES ('Max', to_date('2012-09-04', 'yyyy-mm-dd'), 1, 6);
INSERT INTO pets(NAME,BIRTH_DATE,TYPE_ID,OWNER_ID) VALUES ('Lucky', to_date('2011-08-06', 'yyyy-mm-dd'), 5, 7);
INSERT INTO pets(NAME,BIRTH_DATE,TYPE_ID,OWNER_ID) VALUES ('Mulligan', to_date('2007-02-24', 'yyyy-mm-dd'), 2, 8);
INSERT INTO pets(NAME,BIRTH_DATE,TYPE_ID,OWNER_ID) VALUES ('Freddy', to_date('2010-03-09', 'yyyy-mm-dd'), 5, 9);
INSERT INTO pets(NAME,BIRTH_DATE,TYPE_ID,OWNER_ID) VALUES ('Lucky', to_date('2010-06-24', 'yyyy-mm-dd'), 2, 10);
INSERT INTO pets(NAME,BIRTH_DATE,TYPE_ID,OWNER_ID) VALUES ('Sly', to_date('2012-06-08', 'yyyy-mm-dd'), 1, 10);

INSERT INTO visits(PET_ID,VISIT_DATE,DESCRIPTION) VALUES (7, to_date('2013-01-01', 'yyyy-mm-dd'), 'rabies shot');
INSERT INTO visits(PET_ID,VISIT_DATE,DESCRIPTION) VALUES (8, to_date('2013-01-02', 'yyyy-mm-dd'), 'rabies shot');
INSERT INTO visits(PET_ID,VISIT_DATE,DESCRIPTION) VALUES (8, to_date('2013-01-03', 'yyyy-mm-dd'), 'neutered');
INSERT INTO visits(PET_ID,VISIT_DATE,DESCRIPTION) VALUES (7, to_date('2013-01-04', 'yyyy-mm-dd'), 'spayed');





--INSERT INTO vets(first_name, last_name) VALUES ('James', 'Carter');
--INSERT INTO vets(first_name, last_name) VALUES ('Helen', 'Leary');
--INSERT INTO vets(first_name, last_name) VALUES ('Linda', 'Douglas');
--INSERT INTO vets(first_name, last_name) VALUES ('Rafael', 'Ortega');
--INSERT INTO vets(first_name, last_name) VALUES ('Henry', 'Stevens');
--INSERT INTO vets(first_name, last_name) VALUES ('Sharon', 'Jenkins');
--
--INSERT INTO specialties(name) VALUES ('radiology');
--INSERT INTO specialties(name) VALUES ('surgery');
--INSERT INTO specialties(name) VALUES ('dentistry');
--
--INSERT INTO vet_specialties VALUES (2, 1);
--INSERT INTO vet_specialties VALUES (3, 2);
--INSERT INTO vet_specialties VALUES (3, 3);
--INSERT INTO vet_specialties VALUES (4, 2);
--INSERT INTO vet_specialties VALUES (5, 1);
--
--INSERT IGNORE INTO types VALUES (1, 'cat');
--INSERT IGNORE INTO types VALUES (2, 'dog');
--INSERT IGNORE INTO types VALUES (3, 'lizard');
--INSERT IGNORE INTO types VALUES (4, 'snake');
--INSERT IGNORE INTO types VALUES (5, 'bird');
--INSERT IGNORE INTO types VALUES (6, 'hamster');
--
--INSERT IGNORE INTO owners VALUES (1, 'George', 'Franklin', '110 W. Liberty St.', 'Madison', '6085551023');
--INSERT IGNORE INTO owners VALUES (2, 'Betty', 'Davis', '638 Cardinal Ave.', 'Sun Prairie', '6085551749');
--INSERT IGNORE INTO owners VALUES (3, 'Eduardo', 'Rodriquez', '2693 Commerce St.', 'McFarland', '6085558763');
--INSERT IGNORE INTO owners VALUES (4, 'Harold', 'Davis', '563 Friendly St.', 'Windsor', '6085553198');
--INSERT IGNORE INTO owners VALUES (5, 'Peter', 'McTavish', '2387 S. Fair Way', 'Madison', '6085552765');
--INSERT IGNORE INTO owners VALUES (6, 'Jean', 'Coleman', '105 N. Lake St.', 'Monona', '6085552654');
--INSERT IGNORE INTO owners VALUES (7, 'Jeff', 'Black', '1450 Oak Blvd.', 'Monona', '6085555387');
--INSERT IGNORE INTO owners VALUES (8, 'Maria', 'Escobito', '345 Maple St.', 'Madison', '6085557683');
--INSERT IGNORE INTO owners VALUES (9, 'David', 'Schroeder', '2749 Blackhawk Trail', 'Madison', '6085559435');
--INSERT IGNORE INTO owners VALUES (10, 'Carlos', 'Estaban', '2335 Independence La.', 'Waunakee', '6085555487');
--
--INSERT IGNORE INTO pets VALUES (1, 'Leo', '2000-09-07', 1, 1);
--INSERT IGNORE INTO pets VALUES (2, 'Basil', '2002-08-06', 6, 2);
--INSERT IGNORE INTO pets VALUES (3, 'Rosy', '2001-04-17', 2, 3);
--INSERT IGNORE INTO pets VALUES (4, 'Jewel', '2000-03-07', 2, 3);
--INSERT IGNORE INTO pets VALUES (5, 'Iggy', '2000-11-30', 3, 4);
--INSERT IGNORE INTO pets VALUES (6, 'George', '2000-01-20', 4, 5);
--INSERT IGNORE INTO pets VALUES (7, 'Samantha', '1995-09-04', 1, 6);
--INSERT IGNORE INTO pets VALUES (8, 'Max', '1995-09-04', 1, 6);
--INSERT IGNORE INTO pets VALUES (9, 'Lucky', '1999-08-06', 5, 7);
--INSERT IGNORE INTO pets VALUES (10, 'Mulligan', '1997-02-24', 2, 8);
--INSERT IGNORE INTO pets VALUES (11, 'Freddy', '2000-03-09', 5, 9);
--INSERT IGNORE INTO pets VALUES (12, 'Lucky', '2000-06-24', 2, 10);
--INSERT IGNORE INTO pets VALUES (13, 'Sly', '2002-06-08', 1, 10);
--
--INSERT IGNORE INTO visits VALUES (1, 7, '2010-03-04', 'rabies shot');
--INSERT IGNORE INTO visits VALUES (2, 8, '2011-03-04', 'rabies shot');
--INSERT IGNORE INTO visits VALUES (3, 8, '2009-06-04', 'neutered');
--INSERT IGNORE INTO visits VALUES (4, 7, '2008-09-04', 'spayed');
