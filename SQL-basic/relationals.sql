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
