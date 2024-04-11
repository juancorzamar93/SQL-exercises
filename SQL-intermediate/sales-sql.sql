CREATE SCHEMA kin_security;
use kin_security;

/*Expand columns to see contents */
SHOW COLUMNS FROM kin_security.clientes;
SHOW COLUMNS FROM kin_security.productos;
SHOW COLUMNS FROM kin_security.score_crediticio;
SHOW COLUMNS FROM kin_security.transacciones;   

SELECT * FROM kin_security.clientes;
SELECT * FROM kin_security.productos;
SELECT * FROM kin_security.score_crediticio;
SELECT * FROM kin_security.transacciones;

SELECT COUNT(*) FROM kin_security.clientes;
SELECT COUNT(1) FROM kin_security.clientes;  #is the same

/*use two tables*/
SELECT clientes.customerId, clientes.surname, clientes.geography, clientes.gender, 
clientes.HasCrCard, clientes.isActiveMember, clientes.estimatedSalary, clientes.application_date,
clientes.exit_date, clientes.birth_date, #campos de la tabla clientes 
productos.products #campo de la tabla productos
FROM kin_security.clientes
INNER JOIN kin_security.productos
ON clientes.customerId = productos.customerId
WHERE clientes.surname IS NOT NULL
AND  clientes.surname != '';

/*use two tables with alias*/
SELECT a.customerId, a.surname, a.geography, a.gender, 
a.HasCrCard, a.isActiveMember, a.estimatedSalary, a.application_date,
a.exit_date, a.birth_date, #campos de la tabla clientes 
b.products #campo de la tabla productos
FROM kin_security.clientes AS a
INNER JOIN kin_security.productos AS b
ON a.customerId = b.customerId
WHERE a.surname IS NOT NULL
AND  a.surname != '';

/*use three tables with alias*/
SELECT a.customerId, a.surname, a.geography, a.gender, 
a.HasCrCard, a.isActiveMember, a.estimatedSalary, a.application_date,
a.exit_date, a.birth_date, #campos de la tabla clientes 
b.products, #campo de la tabla productos
c.score #campo de la tabla score
FROM kin_security.clientes AS a
INNER JOIN kin_security.productos AS b
ON a.customerId = b.customerId
INNER JOIN kin_security.score_crediticio AS c
ON a.customerId = c.customerId 
WHERE a.surname IS NOT NULL
AND  a.surname != '';

SELECT COUNT(*) FROM kin_security.clientes;
SELECT COUNT(1) FROM kin_security.clientes;  #es lo mismo



