
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