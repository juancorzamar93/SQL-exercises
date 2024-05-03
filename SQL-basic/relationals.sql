--RELACIONES N:N (uno a uno)

CREATE TABLE users(
	user_id int IDENTITY PRIMARY KEY,
	name varchar(100) not null,
	surname varchar(100) not null,
	age int,
	email varchar(100),
	created datetime DEFAULT CURRENT_TIMESTAMP,
	--PRIMARY KEY(user_id),
	CHECK(age>=18));


INSERT INTO users(name, surname, age, email) VALUES ('Kairo','Koldo', 30, 'kaikoldo@python.com')
INSERT INTO users(name, surname, age, email) VALUES ('Ivan','Pino', 56, 'ivanp@python.com')
INSERT INTO users(name, surname, age, email) VALUES ('Noelia','Carrot', 45, 'noecarrot@python.com')

SELECT * FROM users;


CREATE TABLE dni(
	dni_id int IDENTITY PRIMARY KEY,
	dni_number int NOT NULL,
	user_id int,
	UNIQUE(dni_id),
	FOREIGN KEY(user_id) REFERENCES users(user_id)
);


CREATE TABLE companies(
	company_id int IDENTITY PRIMARY KEY,
	name varchar(100) not null,
);

ALTER TABLE users
ADD company_id VARCHAR(100)

ALTER TABLE users
ALTER COLUMN company_id int

ALTER TABLE users
ADD FOREIGN KEY (company_id) REFERENCES companies(company_id);

---otra alternativa a este:
--ALTER TABLE users
--ADD CONSTRAINT FK_users_companies FOREIGN KEY (company_id) REFERENCES companies(company_id);


--RELACIONES N:M (uno a muchos)
-- Relacion que indica que un registro de la tabla A puede relacionarse con varios registros en la tabla B y viceversa. Se requiere de una tabla intermedia o de union para establecer la relacion
CREATE TABLE languages(
	language_id int IDENTITY PRIMARY KEY,
	name varchar(100) NOT NULL
);

CREATE TABLE users_languages(
	user_language_id int IDENTITY PRIMARY KEY,
	user_id int,
	language_id int,
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	FOREIGN KEY (language_id) REFERENCES languages(language_id),
	UNIQUE (user_id, language_id)

-- "dni" (Relación 1:1)
INSERT INTO dni (dni_number, user_id) VALUES (11111111, 1);
INSERT INTO dni (dni_number, user_id) VALUES (22222222, 2);
INSERT INTO dni (dni_number, user_id) VALUES (33333333, 3);
INSERT INTO dni (dni_number) VALUES (44444444);

-- "companies" y "users" (Relacion 1:N)
INSERT INTO companies (name) VALUES ('Biotech');
INSERT INTO companies (name) VALUES ('MaxTech');
INSERT INTO companies (name) VALUES ('PunaBio');


UPDATE users SET company_id = 1 WHERE user_id = 1;
UPDATE users SET company_id = 2 WHERE user_id = 3;
UPDATE users SET company_id = 3 WHERE user_id = 2;

