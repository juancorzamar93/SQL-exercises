CREATE TABLE persons(
	id int,
	name varchar(100),
	age int,
	email varchar(100),
	created date );

CREATE TABLE persons2(
	id int not null, --obliga a que el campo posea siempre un valor no nulo
	name varchar(100),
	age int,
	email varchar(100),
	created date);

CREATE TABLE persons3(
	id int unique not null, --para que el campo id posea valores diferentes
	name varchar(100),
	age int,
	email varchar(100),
	created datetime);
	--tambien podes especificar aqui UNIQUE(id) en caso que no hayas puesto arriba

CREATE TABLE persons4(
	id int unique not null,
	name varchar(100) not null,
	age int,
	email varchar(100),
	created datetime,
	PRIMARY KEY(id));

	--CHECK: Establece que el campo sólo podrá contener valores mayores o iguales a 18 años
CREATE TABLE persons5(
	id int unique not null,
	name varchar(100) not null,
	age int,
	email varchar(100),
	created datetime,
	PRIMARY KEY(id),
	CHECK(age >=18));

--DEFAULT: Establece un valor por defecto en el campo created correspondiente a la fecha del sistema

CREATE TABLE persons6(
	id int unique not null,
	name varchar(100) not null,
	age int,
	email varchar(100),
	created datetime DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id),
	CHECK(age >= 18));

-- si queres usar AUTOINCREMENT, tenes que tener en cuenta que hay diferencias con respecto a diferentes tipos de SQL:
-- MYSQL: id NOT NULL AUTOINCREMENT
-- POSTGRESQL: id SERIAL PRIMARY KEY
-- SQL SERVER: id int IDENTITY

CREATE TABLE persons7(
	id int not null IDENTITY,
	name varchar(100) not null,
	age int,
	email varchar(100),
	created datetime DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id),
	CHECK(age>=18));

--DROP:

DROP TABLE persons;

If Exists(Select * From Information_Schema.Tables
Where Table_Schema = 'dbo'
And Table_Name = 'persons7')
Drop Table dbo.persons7;

--ALTER:
-- para AGREGAR nueva columna:
ALTER TABLE persons7
ADD surname VARCHAR(100) NOT NULL;

--para RENOMBRAR columna:
EXEC sp_rename 'persons7.surname', 'descripcion', 'COLUMN';
--mysql: RENAME COLUMN surname TO descripcion;

--para ALTERAR/MODIFICAR el tipo de dato del atributo "descripcion" de la tabla PERSONS7:
ALTER TABLE persons7
ALTER COLUMN descripcion VARCHAR(50);

ALTER TABLE persons7
DROP COLUMN descripcion;