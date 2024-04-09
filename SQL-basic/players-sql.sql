USE practica;

SELECT * from practica.descripcion_jugadores;

SELECT Nombre, Apellidos, Nacionalidad, Edad, Salario_eur from practica.descripcion_jugadores
WHERE Nacionalidad = 'ARG' AND Edad < 30;

SELECT Nombre, Apellidos, Nacionalidad, Edad, Salario_eur from practica.descripcion_jugadores
WHERE Nacionalidad != 'ARG' AND Edad < 30
ORDER BY Salario_eur DESC;

SELECT Nombre, Apellidos, FechaNacimiento FROM practica.descripcion_jugadores
WHERE FechaNacimiento < '31/12/1991';

SELECT Nombre, Apellidos, FechaNacimiento FROM practica.descripcion_jugadores;

SELECT Posicion, SUM(Valor_eur) FROM practica.descripcion_jugadores
group by Posicion
order by Posicion desc;

SELECT Nacionalidad, sum(Peso_kg) AS Peso FROM practica.descripcion_jugadores
group by Nacionalidad
order by Nacionalidad ASC;

/*SINTAXIS EQUIVALENTE*/
SELECT COUNT(*) FROM practica.descripcion_jugadores;
SELECT COUNT(1) FROM practica.descripcion_jugadores;

SELECT COUNT(idJugador) FROM practica.descripcion_jugadores
WHERE Edad > 30;

SELECT Nacionalidad, COUNT(*) FROM practica.descripcion_jugadores
GROUP BY Nacionalidad;

SELECT Nacionalidad, COUNT(*) FROM practica.descripcion_jugadores
WHERE Salario_eur > 50
GROUP BY Nacionalidad;

SELECT Nombre, Apellidos, Edad 
FROM practica.descripcion_jugadores
WHERE Edad > 25 AND Edad < 30;

SELECT Nacionalidad, avg(Edad) 
FROM practica.descripcion_jugadores
group by Nacionalidad;

SELECT Nombre, Apellidos, Edad 
FROM practica.descripcion_jugadores
WHERE Edad < 30 AND Nacionalidad = 'ARG';

SELECT Nombre, Apellidos, Nacionalidad
FROM practica.descripcion_jugadores
where Nacionalidad IN ('ARG', 'BRA');

SELECT * FROM practica.descripcion_jugadores
WHERE Club IN ('Real Madrid CF', 'Liverpool');

SELECT * FROM practica.descripcion_jugadores
WHERE Edad IN (25 , '30')
ORDER BY Nombre ASC;

SELECT Nacionalidad, COUNT(*) FROM practica.descripcion_jugadores
group by Nacionalidad;

select Nacionalidad, Club from practica.descripcion_jugadores
group by Nacionalidad, Club;

/*sintaxis HAVING*/

SELECT Nacionalidad, avg(Edad) FROM practica.descripcion_jugadores
group by Nacionalidad
having avg(Edad) >28
order by avg(Edad) DESC;


SELECT Nacionalidad, avg(Valor_eur) FROM practica.descripcion_jugadores
WHERE Nacionalidad IN ('ARG', 'BRA', 'ESP', 'FRA')
group by Nacionalidad
having avg(Valor_eur) >30
order by avg(Valor_eur) ASC;

/*sintaxis SELECT DISTINCT*/
SELECT DISTINCT Club, count(*) from practica.descripcion_jugadores
group by Club
order by COUNT(*) DESC;

/*sintaxis CREATE TEMPORARY TABLE*/
CREATE TEMPORARY TABLE tabla_temporal
SELECT Nombre, Apellidos, Edad, Nacionalidad FROM practica.descripcion_jugadores;

SELECT * FROM tabla_temporal;

CREATE TEMPORARY TABLE tabla_temporal3
SELECT Nombre, Apellidos, Edad, Nacionalidad FROM practica.descripcion_jugadores
WHERE Edad >25 AND
		Nacionalidad IN ('ARG');

SELECT * FROM tabla_temporal3;

 

