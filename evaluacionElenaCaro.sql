# Evaluación módulo 2 Elena Caro 

USE SAKILA

# Ejercicios

#1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

SELECT DISTINCT title 
FROM film;

# - Explicación: Se utiliza distinct para que solo nos indique las películas eliminando posibles duplicados

# 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

SELECT
title,
rating
FROM film
WHERE rating = 'PG-13';

# - Explicación: elegimos las columnas título y rating de la tabla film para filtrar con where las que tengan una clasificación PG-13

# 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

SELECT 
title, 
description 
FROM film
WHERE description LIKE '%amazing%';

# - Explicación: elegimos las columnas título y description de la tabla film usamos like para que nos muestre la palabra y el % en ambos lados para que los busque en cualquier parte de la descripción.

# 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

SELECT 
title,
length
FROM film
WHERE length > 120;

# - Explicación: elegimos las columnas título y length de la tabla film para filtrar con where las que tengan una duración mayor a 120

# 5. Recupera los nombres de todos los actores.

SELECT
first_name AS Nombre,
last_name AS Apellido
FROM  actor;

# - Explicación: elegimos las columnas first_name y last_name de la tabla actor y les damos otro nombre para identificarlos mejor

# 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

SELECT
first_name AS Nombre,
last_name AS Apellido
FROM  actor
WHERE last_name LIKE '%Gibson%';

# - Explicación: elegimos las columnas first_name y last_name de la tabla actor y usamos like para que nos muestre el apellido y el % en ambos lados para que lo busque en todas las posiciones aunque también valdría sin %.

# 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

SELECT
first_name AS Nombre,
last_name AS Apellido,
actor_id
FROM  actor
WHERE actor_id >= 10 AND actor_id <= 20;

# - Explicación: elegimos las columnas first_name y last_name de la tabla actor y usamos mayor o igual que y menor o igual que, para encontrar el grupo exacto.

# 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.

SELECT 
title AS título
FROM film 
WHERE rating NOT IN ('R', 'PG-13');

# - Explicación: usamos not in para excluir las películas que sean r o PG-13

# 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.

SELECT 
rating, 
COUNT(*) AS totalpeliculas
FROM film
GROUP BY rating;

# - Explicación: para contar las películas agrupándolas por clasificación utilizamos el group by y count con el asterisco para que me cuente todas las filas de las clasificaciones.

# 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

SELECT 
customer.customer_id,
customer.first_name AS NOMBRE, 
customer.last_name AS APELLIDO, 
COUNT(rental.rental_id) AS diasalquiler
FROM customer
INNER JOIN rental ON customer.customer_id = rental.rental_id
GROUP BY customer.customer_id,
customer.first_name, 
customer.last_name;

# - Explicación: Se relacionan las tablas customer y rental para encontrar el total de películas alquiladas

# 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

SELECT 
category.name AS Categoría,
COUNT(rental.rental_id) AS diasalquiler
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN inventory ON film_category.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY category.name;

# - Explicación: para contar la cantidad total de películas alquiladas por categoría tenemos que identificar que en esta BBDD la tabla category
# se relaciona con la tabla film_category y la tabla film se relaciona con inventory e inventory se relaciona con rental como no hay una relación directa 
# tenemos que usar varias veces INNER JOIN relacionando las tablas y las columnas correctas mediante las foreing keys (puede hacerse tambien con subqueries, pero me parece mucho más sencillo como lo he realizado)

# 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

SELECT 
rating, 
AVG(length) AS Duraciónpromedio
FROM film 
GROUP BY rating;

# - Explicación: Se utiliza AVG para calcular el promedio de la duración de las películas agrupadas por la clasificación.

# 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

SELECT
actor.first_name, 
actor.last_name
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'Indian Love';

# - Explicación: para relacionar las tablas actor y film_actor y film utilizamos INNER JOIN y así podemos encongtrar los actores asociados a la película que indiquemos

# 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

SELECT 
title AS 'Título de la película', 
description
FROM film 
WHERE description LIKE '%dog%' OR description LIKE '%cat%';

# - Explicación: mostramos los títulos de las películas donde en las descripciones se incluya en todos los lados con % dog o cat 

# 15. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

SELECT 
title AS 'Título de la película',
release_year AS 'Año de estreno'
FROM film 
WHERE release_year BETWEEN 2005 AND 2010;

# - Explicación: mostramos los títulos de las películas que se hayan estrenado entre el 2005 y 2010 con between

# 16. Encuentra el título de todas las películas que son de la misma categoría que "Family".

SELECT
film.title, 
category.name
FROM film 
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

# - Explicación: Conectamos las tablas film, film_category y category con INNER JOIN y busca las películas relacionadas en la categoría family

# 17. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.

SELECT 
title, 
length,
rating
FROM film
WHERE rating = 'R' AND length > 120;

# - Explicación: usamos las dos condiciones con AND para que nos muestre las películas que coinciden

# 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

SELECT
actor.first_name, 
actor.last_name,
COUNT(film_actor.film_id) AS películas
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY 
actor.actor_id,
actor.first_name, 
actor.last_name
HAVING COUNT(film_actor.film_id) > 10;

# - Explicación: uso inner join para relacionar las tablas actor y film_actor, se agrupa por cada actor para que se puedan contar las películas
# y utilizamos having para que me muestre solo los actores en los que hayan participado más de 10

# 19. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.

SELECT
actor.first_name, 
actor.last_name
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE film_actor.film_id IS NULL;

# - Explicación: en este problema he usado left join porque quiero incluir todos los actores no solo los que coinciden con los de la tabla film_actor
# luego uso where con null para encontrar los actores que no tengan películas en film_actor

# 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.

SELECT 
category.name AS 'Categoría', 
AVG(film.length) AS 'Promedio Duración'
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN film ON film_category.film_id = film.film_id
GROUP BY 
category.category_id, 
category.name 
HAVING AVG (film.length) > 120;

# - Explicación: hay que relacionar category con film así que lo hacemos através de film_category caqlculamos el promedio de duración con AVG 
# y lo agrupamos por el name de cada categoria y usamos having para filtrar solo los promedios superiores a 120

# 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.

SELECT
actor.first_name AS nombre, 
actor.last_name AS apellido,
COUNT(film_actor.film_id) AS películas
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY 
actor.actor_id,
actor.first_name, 
actor.last_name
HAVING COUNT(film_actor.film_id) >= 5;

# - Explicación: igual que en el ejercicio 8 pero poniendo igual o mayor a 5