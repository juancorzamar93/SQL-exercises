use practica;
use kin_security;

/*sub-query*/
SELECT * FROM practica.descripcion_jugadores
WHERE Edad >
		( SELECT Edad FROM practica.descripcion_jugadores
			WHERE idJugador = 1);
            
SELECT surname, gender, geography, estimatedSalary FROM practica.clientes
WHERE estimatedSalary IN 
					( SELECT estimatedSalary FROM clientes
                    WHERE estimatedSalary >  240000);
        
select geography, estimatedSalary from practica.clientes
where estimatedSalary >=
				(select MAX(estimatedSalary) AS max_salary from practica.clientes
					where geography = 'Germany');

select geography, estimatedSalary from practica.clientes
where estimatedSalary >=
				(select avg(estimatedSalary) AS avg_salary from practica.clientes
					where geography = 'Germany');


				
SELECT c.surname, c.geography AS paisTabla_c, c.estimatedSalary AS salarioTabla_c,
		l.geography AS paisTabla_l, avg_salary
FROM clientes AS c
INNER JOIN (SELECT geography, AVG(estimatedSalary) AS avg_salary
                FROM clientes
                WHERE geography IS NOT NULL and geography != ''
                GROUP BY geography) as l
ON c.geography = l.geography
WHERE c.estimatedSalary >= avg_salary;

SELECT productos.products, COUNT(productos.products)
FROM productos
INNER JOIN clientes ON clientes.customerId = productos.customerId
GROUP BY productos.products
HAVING COUNT(productos.products) > (SELECT COUNT(clientes.customerId) AS clientes_productos
                                    FROM clientes INNER JOIN productos
                                    ON clientes.customerId = productos.customerId
                                    WHERE productos.products = 'Product B');

                                    
SELECT COUNT(clientes.customerId) AS clientes_productos
FROM clientes 
INNER JOIN productos
ON clientes.customerId = productos.customerId
WHERE productos.products = 'Product B';