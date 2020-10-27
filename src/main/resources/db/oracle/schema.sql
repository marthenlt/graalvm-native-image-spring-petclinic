DROP TABLE vet_specialties PURGE;
DROP TABLE vets PURGE;
DROP TABLE specialties PURGE;
DROP TABLE visits PURGE;
DROP TABLE pets PURGE;
DROP TABLE types PURGE;
DROP TABLE owners PURGE;

CREATE table vets (
       id number(10,0) generated as identity,
        first_name varchar2(255 char),
        last_name varchar2(255 char),
        primary key (id)
);
CREATE INDEX vets_last_name ON vets(last_name);

CREATE table specialties (
       id number(10,0) generated as identity,
        name varchar2(255 char),
        primary key (id)
);
CREATE INDEX specialties_name ON specialties (name);

CREATE table vet_specialties (
       vet_id number(10,0) not null,
        specialty_id number(10,0) not null,
        primary key (vet_id, specialty_id)
);

CREATE table types (
       id number(10,0) generated as identity,
        name varchar2(255 char),
        primary key (id)
);
CREATE INDEX types_name ON types (name);

CREATE table owners (
       id number(10,0) generated as identity,
        first_name varchar2(255 char),
        last_name varchar2(255 char),
        address varchar2(255 char),
        city varchar2(255 char),
        telephone varchar2(255 char),
        primary key (id)
);
CREATE INDEX owners_last_name ON owners (last_name);

CREATE table pets (
       id number(10,0) generated as identity,
        name varchar2(255 char),
        birth_date date,
        owner_id number(10,0),
        type_id number(10,0),
        primary key (id)
);
CREATE INDEX pets_name ON pets(name);

CREATE table visits (
       id number(10,0) generated as identity,
        visit_date date,
        description varchar2(255 char),
        pet_id number(10,0),
        primary key (id)
);
CREATE INDEX visits_pet_id ON visits (pet_id);


ALTER TABLE vet_specialties ADD CONSTRAINT fk_vet_specialties_vets FOREIGN KEY (vet_id) REFERENCES vets (id);
ALTER TABLE vet_specialties ADD CONSTRAINT fk_vet_specialties_specialties FOREIGN KEY (specialty_id) REFERENCES specialties (id);
ALTER TABLE pets ADD CONSTRAINT fk_pets_owners FOREIGN KEY (owner_id) REFERENCES owners (id);
ALTER TABLE pets ADD CONSTRAINT fk_pets_types FOREIGN KEY (type_id) REFERENCES types (id);
ALTER TABLE visits ADD CONSTRAINT fk_visits_pets FOREIGN KEY (pet_id) REFERENCES pets (id);


----CREATE TABLE IF NOT EXISTS vets (
----  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
----  first_name VARCHAR(30),
----  last_name VARCHAR(30),
----  INDEX(last_name)
----) engine=InnoDB;
--
--CREATE TABLE vets (
--  id NUMBER(10) GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
--  first_name VARCHAR2(30),
--  last_name VARCHAR2(30)
--);
--ALTER TABLE vets ADD (CONSTRAINT vets_id_pk PRIMARY KEY (id));
--ALTER TABLE vets ADD (CONSTRAINT vets_lastname_pk UNIQUE (last_name));
--
--
----CREATE TABLE IF NOT EXISTS specialties (
----  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
----  name VARCHAR(80),
----  INDEX(name)
----) engine=InnoDB;
--
--CREATE TABLE specialties (
--  id NUMBER(10) GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
--  name VARCHAR2(80)
--);
--ALTER TABLE specialties ADD (CONSTRAINT specialties_id_pk PRIMARY KEY (id));
--ALTER TABLE specialties ADD (CONSTRAINT specialties_name_pk UNIQUE (name));
--
--
----CREATE TABLE IF NOT EXISTS vet_specialties (
----  vet_id INT(4) UNSIGNED NOT NULL,
----  specialty_id INT(4) UNSIGNED NOT NULL,
----  FOREIGN KEY (vet_id) REFERENCES vets(id),
----  FOREIGN KEY (specialty_id) REFERENCES specialties(id),
----  UNIQUE (vet_id,specialty_id)
----) engine=InnoDB;
--
--CREATE TABLE vet_specialties (
--  vet_id NUMBER(10) NOT NULL,
--  specialty_id NUMBER(10) NOT NULL
--);
--ALTER TABLE vet_specialties ADD (FOREIGN KEY (vet_id) REFERENCES vets(id));
--ALTER TABLE vet_specialties ADD (FOREIGN KEY (specialty_id) REFERENCES specialties(id));
--ALTER TABLE vet_specialties ADD (CONSTRAINT specialties_ids_pk UNIQUE (vet_id,specialty_id));
--
--
----CREATE TABLE IF NOT EXISTS types (
----  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
----  name VARCHAR(80),
----  INDEX(name)
----) engine=InnoDB;
--
--CREATE TABLE types (
--  id NUMBER(10) GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
--  name VARCHAR2(80)
--);
--ALTER TABLE types ADD (CONSTRAINT types_id_pk PRIMARY KEY (id));
--ALTER TABLE types ADD (CONSTRAINT types_name_pk UNIQUE (name));
--
--
----CREATE TABLE IF NOT EXISTS owners (
----  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
----  first_name VARCHAR(30),
----  last_name VARCHAR(30),
----  address VARCHAR(255),
----  city VARCHAR(80),
----  telephone VARCHAR(20),
----  INDEX(last_name)
----) engine=InnoDB;
--
--CREATE TABLE owners (
--  id NUMBER(10) GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
--  first_name VARCHAR2(30),
--  last_name VARCHAR2(30),
--  address VARCHAR2(255),
--  city VARCHAR2(80),
--  telephone VARCHAR2(20)
--);
--ALTER TABLE owners ADD (CONSTRAINT owners_id_pk PRIMARY KEY (id));
--ALTER TABLE owners ADD (CONSTRAINT owners_last_name_pk UNIQUE (last_name));
--
--
----CREATE TABLE IF NOT EXISTS pets (
----  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
----  name VARCHAR(30),
----  birth_date DATE,
----  type_id INT(4) UNSIGNED NOT NULL,
----  owner_id INT(4) UNSIGNED NOT NULL,
----  INDEX(name),
----  FOREIGN KEY (owner_id) REFERENCES owners(id),
----  FOREIGN KEY (type_id) REFERENCES types(id)
----) engine=InnoDB;
--
--CREATE TABLE pets (
--  id NUMBER(10) GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
--  name VARCHAR2(30),
--  birth_date DATE,
--  type_id NUMBER(10) NOT NULL,
--  owner_id NUMBER(10) NOT NULL
--);
--ALTER TABLE pets ADD (CONSTRAINT pets_id_pk PRIMARY KEY (id));
--ALTER TABLE pets ADD (FOREIGN KEY (owner_id) REFERENCES owners(id));
--ALTER TABLE pets ADD (FOREIGN KEY (type_id) REFERENCES types(id));
--ALTER TABLE pets ADD (CONSTRAINT pets_name_pk UNIQUE (name));
--
--
----CREATE TABLE IF NOT EXISTS visits (
----  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
----  pet_id INT(4) UNSIGNED NOT NULL,
----  visit_date DATE,
----  description VARCHAR(255),
----  FOREIGN KEY (pet_id) REFERENCES pets(id)
----) engine=InnoDB;
--
--CREATE TABLE visits (
--  id NUMBER(10) GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
--  pet_id NUMBER(4)  NOT NULL,
--  visit_date DATE,
--  description VARCHAR2(255)
--);
--ALTER TABLE visits ADD (CONSTRAINT visits_id_pk PRIMARY KEY (id));
--ALTER TABLE visits ADD (FOREIGN KEY (pet_id) REFERENCES pets(id));
--
