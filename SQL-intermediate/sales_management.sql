
CREATE DATABASE gestion_ventas;

USE gestion_ventas
go

--GESTION DE VENTAS

CREATE TABLE comercial(
	id_comercial int PRIMARY KEY,
	nombre varchar(100),
	apellido varchar(100),
	ciudad VARCHAR(100),
	comision DECIMAL
);


CREATE TABLE cliente(
	id_cliente int PRIMARY KEY,
	nombre varchar(100),
	apellido varchar(100),
	ciudad varchar(100),
	categoria int
);

ALTER TABLE cliente
ADD apellido2 varchar(100);


CREATE TABLE pedido(
	id_pedido int IDENTITY PRIMARY KEY,
	cantidad decimal,
	fecha datetime DEFAULT CURRENT_TIMESTAMP,
	id_cliente int,
	id_comercial int,
	FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
	FOREIGN KEY (id_comercial) REFERENCES comercial(id_comercial)
);

--1) Devuelve un listado con todos los pedidos que se han realizado. Los pedidos deben estar ordenados por la fecha de realización,
--   mostrando en primer lugar los pedidos más recientes

SELECT * FROM pedido
ORDER BY fecha DESC;

--2) Devuelve todos los datos de los dos pedidos de mayor valor

SELECT TOP 2 * FROM pedido
ORDER BY cantidad DESC;

--3) Devuelve un listado con los identificadores de los clientes que han realizado algún pedido. Tenga en cuenta que no debe mostrar 
--   identificadores que estén repetidos.

SELECT DISTINCT id_cliente FROM pedido;
--SELECT DISTINCT p.id_cliente FROM pedido p;

--4) Devuelve un listado de todos los pedidos que se realizaron durante el año 2017, cuya cantidad total sea superior a 500€.

SELECT cantidad, fecha FROM pedido
WHERE YEAR(fecha) = 2017 AND cantidad > 500;

--5) Devuelve un listado con el nombre y los apellidos de los comerciales que tienen una comisión entre 0.05 y 0.11.
SELECT c.nombre, c. apellido FROM comercial c
WHERE c.comision BETWEEN 0.05 AND 0.11;

--6) Devuelve el valor de la comisión de mayor valor que existe en la tabla comercial.
SELECT MAX(c.comision) AS 'Comisión máximo' FROM comercial c

--7) Devuelve el identificador, nombre y apellido de aquellos clientes cuyo segunfo apellido no es NULL.
--El listado deberá estar ordenado alfabéticamente por apellidos y nombre.

SELECT c.nombre, c.apellido, c.apellido2 FROM cliente c
WHERE c.apellido2 IS NOT NULL
ORDER BY 3 ASC, 2 ASC

--8) Devuelve un listado de los nombres de los clientes que empiezan por A y terminan por n y también los nombres que empiezan por P. 
--   El listado deberá estar ordenado alfabéticamente.

SELECT c.nombre FROM cliente c
WHERE c.nombre LIKE 'a%' AND c.nombre LIKE '%n' OR c.nombre LIKE 'p%'
ORDER BY c.nombre ASC;

--9) Devuelve un listado de los nombres de los clientes que no empiezan por A. El listado deberá estar ordenado alfabéticamente.

SELECT c.nombre FROM cliente c
WHERE c.nombre NOT LIKE 'a%'
ORDER BY c.nombre ASC;

--10) Devuelve un listado con los nombres de los comerciales que terminan por 'el' u 'o'. 
--   Tenga en cuenta que se deberán eliminar los nombres repetidos.

SELECT DISTINCT c.nombre FROM comercial c
WHERE c.nombre LIKE '%el' OR c.nombre LIKE '%o';

--CONSULTAS MULTITABLAS (INTERNA: INNER JOIN)

--1) Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido. 
-- El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.

SELECT DISTINCT c.id_cliente, c.nombre, c.apellido, c.apellido2
FROM cliente c INNER JOIN pedido p ON c.id_cliente = p.id_cliente
ORDER BY 3 ASC, 4 ASC, 2 ASC

--2) Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. 
-- El resultado debe mostrar todos los datos de los pedidos y del cliente. 
-- El listado debe mostrar los datos de los clientes ordenados alfabéticamente.

SELECT c.id_cliente, c.nombre, c.apellido, p.id_cliente, p.fecha, p.cantidad 
FROM cliente c
INNER JOIN pedido p
ON c.id_cliente = p.id_cliente
ORDER BY 1 ASC, 3 ASC, 1 ASC;

--3) Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. 
--  El resultado debe mostrar todos los datos de los pedidos y de los comerciales. 
--  El listado debe mostrar los datos de los comerciales ordenados alfabéticamente.

SELECT co.id_comercial, co.apellido, co.nombre, p.id_pedido, p.fecha, p.cantidad FROM comercial co
INNER JOIN pedido p
ON co.id_comercial = p.id_comercial
ORDER BY 2 ASC, 3 ASC;

--4)Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado 
-- y con los datos de los comerciales asociados a cada pedido.

SELECT * FROM cliente c
INNER JOIN pedido p ON c.id_cliente = p.id_cliente
INNER JOIN comercial co ON p.id_cliente = co.id_comercial;

--5)Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, cuya cantidad esté entre 300 € y 1000 €.

SELECT * FROM cliente c
INNER JOIN pedido p ON	c.id_cliente = p.id_cliente
WHERE YEAR(p.fecha) = 2017 AND p.cantidad BETWEEN 300 AND 1000;

--6)Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún pedido realizado por María Santana Moreno.

SELECT co.nombre, co. apellido  FROM comercial co
INNER JOIN pedido p ON co.id_comercial = p.id_comercial
INNER JOIN cliente c ON p.id_cliente = c.id_cliente
WHERE c.apellido = 'Santana' AND c.apellido2 = 'Moreno' AND c.nombre = 'María'

--7)Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega.

SELECT c.nombre, c.apellido FROM cliente c
INNER JOIN pedido p ON c.id_cliente = p.id_cliente
INNER JOIN comercial co ON p.id_comercial = co.id_comercial
WHERE co.nombre = 'Daniel' AND co.apellido = 'Sáez'


--CONSULTAS MULTITABLAS (EXTERNA: LEFT JOIN y RIGHT JOIN)

--1) Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado. 
--   Este listado también debe incluir los clientes que no han realizado ningún pedido. 
--   El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los clientes.

SELECT *
FROM cliente c
LEFT JOIN pedido p
ON c.id_cliente = p.id_cliente
ORDER BY c.apellido ASC, c.apellido2 ASC, c.nombre ASC;

--2) Devuelve un listado con todos los comerciales junto con los datos de los pedidos que han realizado. 
--   Este listado también debe incluir los comerciales que no han realizado ningún pedido. 
--   El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los comerciales.

SELECT * FROM comercial c
LEFT JOIN pedido p
ON c.id_comercial = p.id_cliente
ORDER BY c.apellido ASC, c.nombre ASC

--3) Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido

SELECT * FROM cliente c
LEFT JOIN pedido p
ON c.id_cliente = p.id_cliente
WHERE p.id_cliente IS NULL;

--4) Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido

SELECT * FROM comercial c
LEFT JOIN pedido p
ON c.id_comercial = p.id_comercial
WHERE p.id_comercial IS NULL;

--5) Devuelve un listado con los clientes que no han realizado ningún pedido y de los comerciales que no han participado en ningún pedido. 
--  Ordene el listado alfabéticamente por los apellidos y el nombre. En en listado deberá diferenciar de algún modo los clientes 
--  y los comerciales.
SELECT CONCAT(c.nombre, ' ', c.apellido, ' ', c.apellido2, ' (Cliente)') AS 'Resultado'
FROM cliente c
LEFT JOIN pedido p
ON c.id_cliente = p.id_cliente
WHERE p.id_cliente IS NULL
UNION
SELECT CONCAT(co.nombre, ' ', co.apellido, ' ', ' (Comercial)') 
FROM pedido p
RIGHT JOIN comercial co
ON co.id_comercial = p.id_comercial
WHERE p.id_comercial IS NULL;

--6) ¿Se podrían realizar las consultas anteriores con NATURAL LEFT JOIN o NATURAL RIGHT JOIN? Justifique su respuesta.
/*
No se podría utilizar NATURAL LEFT JOIN o NATURAL RIGHT JOIN ya que los nombres de los campos no coinciden en ambas tablas.
En la tabla Comercial, su Id se llama "Id", mientras que en la tabla Pedido, el campo que es la clave foránea se llama "Id_Comercial".
Lo mismo sucede con la tabla Clientem donde su PK se llama "Id", mientras que en la tabla Pedido, el campo se llama "Id_Cliente".
*/ 

