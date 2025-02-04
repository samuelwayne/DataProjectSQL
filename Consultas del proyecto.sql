-- 2 - Películas catalogadas 'R'
SELECT "title" AS "films_R_rated", "rating" AS "film_rating" -- Añado "rating" para comprobar los resultados
FROM "film"
WHERE "rating" = 'R';

-- 3 - Actores cuyo ID está entre 30 y 40
SELECT "actor_id" AS "id_between_30_and_40", CONCAT("first_name", ' ', "last_name") AS "actor_name" -- Añado "actor_id" para comprobar los resultados
FROM "actor"
WHERE "actor_id" between 30 and 40;

-- 4 - Películas cuyo idioma sea igual al original
SELECT "title" AS "film_in_original_language", "language_id" AS "film_language", "original_language_id" AS "film_original_language" -- Añado "language_id" y "original_language_id" para comprobar los resultados
FROM "film"
WHERE "language_id" = "original_language_id";

-- 5 - Películas ordenadas por duración
SELECT "title" AS "film_title", "length" AS "film_length" -- Añado "length" para comprobar los resultados
FROM "film"
ORDER BY "length";

-- 6 - Actores apellido 'ALLEN'
SELECT CONCAT("first_name", ' ', "last_name") AS "actor_with_last_name_ALLEN"
FROM "actor"
WHERE "last_name" = 'ALLEN';

-- 7-  Clasificaciones de películas y sus recuentos
SELECT "rating" AS "film_rating", COUNT("film_id") AS "num_films"
FROM "film"
GROUP BY "rating";

-- 8 - Películas clasificadas 'PG-13' o duración > 180 min
SELECT "title" AS "films_PG_13_or_length>180", "rating" AS "film_rating", "length" AS "film_length" -- Añado "rating" y "length" para comprobar los resultados obtenidos
FROM "film"
WHERE ("rating" = 'PG-13') OR ("length" > 180);

-- 9 - Variabilidad de reemplazar las películas
SELECT MIN("replacement_cost") AS "film_min_replacement_cost", MAX("replacement_cost") AS "film_max_replacement_cost"
FROM "film";

-- 10 - Mayor y menor duración de películas
SELECT MIN("length") AS "film_min_length", MAX("length") AS "film_max_length"
FROM "film";

-- 11 - Coste antepenúltimo alquiler ordenado por día
SELECT "r"."rental_id" AS "thrid_last_rent", "rental_date" AS "third_last_date", "amount" AS "third_last_amount"
FROM "rental" AS "r"
INNER JOIN "payment" AS "p" ON "r"."rental_id" = "p"."rental_id"  
ORDER BY DATE_TRUNC('day', "rental_date") DESC -- DATE_TRUNC('day', "DATE") me permite pasar a ordenar por día el valor designado
LIMIT 1 OFFSET 2;

-- 12 - Películas que no son 'NC-17' ni 'G'
SELECT "title" AS "film_title", "rating" AS "rating_not_NC_17_or_G"
FROM "film"
WHERE "rating" NOT IN ('NC-17', 'G');

-- 13 - Promedios de duración según su clasificación
SELECT "rating" AS "film_rating", ROUND(AVG("length")) AS "film_avg_length"
FROM "film" 
GROUP BY "rating";

-- 14 - Películas con duración > 180 min
SELECT "title" AS "film_title", "length" AS "film_length>180" 
FROM "film" 
WHERE "length" > 180;

-- 15 - Total beneficios
SELECT SUM("amount") AS "total_income"
FROM "payment";

-- 16 - Diez clientes con mayor valor de ID
SELECT "customer_id" AS "ten_higher_customer_id", CONCAT("first_name", ' ', "last_name") AS "customer_name"
FROM "customer"
ORDER BY "customer_id" DESC 
LIMIT 10;

-- 17 - Actores que salen en 'Egg Igby'
SELECT CONCAT("first_name", ' ', "last_name") AS "actor_name_from_EGG_IGBY", "title" AS "film_title"
FROM "actor" AS "a" 
INNER JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id" 
INNER JOIN "film" AS "f" ON "fa"."film_id" = "f"."film_id" 
WHERE "title" = 'EGG IGBY';

-- 18 - Nombres de las películas únicos
SELECT COUNT(DISTINCT "title") AS "film_unique_title"
FROM "film";

-- 19 - Comedias > 180 min
SELECT "title" as "film_title_comedy", "name" AS "film_category_name", "length" AS "film_length"
FROM "film" AS "f" 
INNER JOIN "film_category" AS "fc" ON "f"."film_id" = "fc"."film_id" 
INNER JOIN "category" AS "c" ON "fc"."category_id" = "c"."category_id"
WHERE ("c"."name" = 'Comedy') AND ("f"."length" > 180);

-- 20 - Categorías con promedio de duración > 110
SELECT "c"."name" AS "film_category_name", ROUND(AVG("length")) AS"film_length>110"
FROM "film" AS "f" 
INNER JOIN "film_category" AS "fc" ON "f"."film_id" = "fc"."film_id" 
INNER JOIN "category" AS "c" ON "fc"."category_id" = "c"."category_id"
GROUP BY "c"."name" 
HAVING AVG("length") > 110;

-- 21 - Duración media de los alquileres
SELECT ROUND(AVG(EXTRACT(DAY FROM "return_date"::TIMESTAMP - "rental_date"::TIMESTAMP)), 2) AS "avg_days_rented"
FROM "rental";

-- 22 - Nombres y apellidos de Actores y actrices
SELECT CONCAT("first_name", ' ', "last_name") AS "full_name_actors" 
FROM "actor";

-- 23 - Números de alquiler por día orden descendente
SELECT DATE_TRUNC('DAY', "rental_date") AS "day_date", COUNT("rental_id") AS "total_rentals"
FROM "rental"
GROUP BY DATE_TRUNC('DAY', "rental_date")
ORDER BY COUNT("rental_id") DESC;

-- 24 - Películas con duración superior al promedio
SELECT "title" AS "film_title", "length" AS "film_length_>avg"
FROM "film" 
WHERE "length" > (SELECT AVG("length") FROM "film");

-- 25 - Alquileres registrados por mes
SELECT DATE_TRUNC('MONTH', "rental_date") AS "rental_month_date", COUNT("rental_id") AS "num_rentals"
FROM "rental" 
GROUP BY DATE_TRUNC('MONTH', "rental_date");

-- 26 - Media, desviación estándar y varianza de los pagos
SELECT ROUND(AVG("amount"), 2) AS "average", ROUND(STDDEV("amount"), 2) AS "std_dev", ROUND(VARIANCE("amount"), 2) AS "variance"
FROM "payment";

-- 27 - Películas que cuesta alquilar por encima de avg
SELECT "title" AS "film_title", "rental_rate" AS "film_rental_rate>avg"
FROM "film" 
WHERE "rental_rate" > (SELECT AVG("rental_rate") FROM "film");

-- 28 - Actores que han participado en  más de 40 películas
SELECT CONCAT("first_name", ' ', "last_name") AS "actor_name", COUNT("film_id") AS "num_films_made"
FROM "actor" AS "a" 
LEFT JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
GROUP BY "a"."actor_id" 
HAVING COUNT("film_id") > 40;

-- 29 - Películas con su disponibilidad en el inventario
SELECT "title" AS "film_title", COUNT("inventory_id") AS "qty_available"
FROM "film"
LEFT JOIN "inventory" AS "i" ON "f"."film_id" = "i"."film_id" 
GROUP BY "f"."film_id";

-- 30 - Actores y número de películas en los que han actuado
SELECT CONCAT("first_name", ' ', "last_name") AS "actor_name", COUNT("film_id") AS "num_films_made"
FROM "actor" AS "a" 
LEFT JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
GROUP BY "a"."actor_id";

-- 31 - Todas las películas con actores que han actuado
SELECT "title" AS "film_title", CONCAT("first_name", ' ', "last_name") AS "actor_in_film_by_name"
FROM "film_actor" AS "fa" 
INNER JOIN "film" AS "f" ON "fa"."film_id" = "f"."film_id" 
LEFT JOIN "actor" AS "a" ON "fa"."actor_id" = "a.actor_id"
ORDER BY "title";

-- 32 - Todos los actores con las películas en las que han actuado
SELECT CONCAT("first_name", ' ', "last_name") AS "actor_name", "title" AS "film_made"
FROM "film_actor" AS "fa" 
INNER JOIN "actor" AS "a" ON "fa"."actor_id" = "a.actor_id"
LEFT JOIN "film" AS "f" ON "fa"."film_id" = "f"."film_id"
ORDER BY "a"."actor_id";

-- 33 - Películas y sus registros de alquiler
SELECT "title" AS "film_title", "rental_date" AS "rental_date_registered"
FROM "film" AS "f" 
LEFT JOIN "inventory" AS "i" ON "f"."film_id" = "i"."film_id" 
LEFT JOIN "rental" AS "r" ON "i"."inventory_id" = "r"."inventory_id";

-- 34 - Cinco clientes que más dinero se han gastado
SELECT CONCAT("first_name", ' ', "last_name") AS "customer_name", SUM("amount") AS "total_spent" 
FROM "customer" AS "c" 
INNER JOIN "payment"  AS "p" ON "c"."customer_id" = "p"."customer_id" 
GROUP BY "c"."customer_id" 
ORDER BY SUM("amount") DESC 
LIMIT 5;

-- 35 y 36 - Actores cuyo primer nombre 'JOHNNY'
SELECT CONCAT("first_name", ' ', "last_name") AS "actor_named_JOHNNY"
FROM "actor"
WHERE "first_name" = 'JOHNNY';

-- 37 - ID min y max en actor
SELECT "actor_id", CONCAT("first_name", ' ', "last_name") AS "actor_order_by_last_name"
FROM "actor"
WHERE ("actor_id" = (SELECT MIN("actor_id") FROM "actor")) OR ("actor_id" = (SELECT MAX("actor_id") FROM "actor"));

-- 38 - Cantidad de actores en tabla actor
SELECT COUNT("actor_id") AS "total_num_actors"
FROM "actor";

-- 39 - Actores order by last name
SELECT CONCAT("first_name", ' ', "last_name") AS "actor_order_by_last_name"
FROM "actor"
ORDER BY "last_name";

-- 40 - Cinco primeras películas tabla film
SELECT "film_id", "title" AS "film_title"
FROM "film" 
LIMIT 5;

-- 41 - Agrupar actores por nombre, y nombre más repetido
SELECT "first_name" AS "actors_first_name", COUNT(DISTINCT "actor_id") AS "num_actors_with_that_name"
FROM "actor"
GROUP BY "first_name" 
ORDER BY COUNT(DISTINCT "actor_id") DESC; -- Ordenado en orden DESC para ver el primero, que será el nombre más repetido

-- 42 - Nombres de los clientes
SELECT "rental_id" AS "rental_num_id", CONCAT("first_name", ' ', "last_name")
FROM "customer" AS "c" 
INNER JOIN "rental" AS "r" ON "c"."customer_id" = "r"."customer_id";

-- 43 - Clientes y sus alquileres
SELECT CONCAT("first_name", ' ', "last_name") AS "customer_name", "rental_id" AS "rental_num_id" ,"title" AS "film_rented"
FROM "customer" AS "c" 
LEFT JOIN "rental" AS "r" ON "c"."customer_id" = "r"."customer_id"
LEFT JOIN "inventory" AS "i" ON "r"."inventory_id" = "i"."inventory_id" 
LEFT JOIN "film" AS "f" ON "i"."film_id" = "f"."film_id";

-- 44 - Cross join entre film y category
SELECT *
FROM "film"
CROSS JOIN "category";
-- Esta consulta no tiene utilidad porque genera muchos datos que además no nos sirven porque ni siquiera sabemos a qué categoría corresponde cada película originalmente


-- 45 - Actores de la categoría Action
SELECT CONCAT("first_name", ' ', "last_name") AS "action_actor", "name" AS "film_category_name"
FROM "actor" AS "a"
LEFT JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
LEFT JOIN "film_category" AS "fc" ON "fa"."film_id" = "fc"."film_id" 
LEFT JOIN "category" AS "c" ON "fc"."category_id" = "c"."category_id" 
WHERE "c"."name" = 'Action';

-- 46 - Actores que no han participado en películas
SELECT CONCAT("first_name", ' ', "last_name") AS "actor_name", "f"."film_id" AS "num_films_made" 
FROM "actor" AS "a"
LEFT JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
LEFT JOIN "film" AS "f" ON "fa"."film_id" = "f"."film_id" 
WHERE "f"."film_id" = NULL;

-- 47 - Actores y cantidad de películas en que han participado
SELECT CONCAT("first_name", ' ', "last_name") AS "actor_name", COUNT("film_id") AS "num_films_made" 
FROM "actor" AS "a"
LEFT JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
GROUP BY "a"."actor_id";

-- 48 - Vista actores y cantidad de películas en que han participado
CREATE VIEW "actor_num_peliculas" AS(
	SELECT CONCAT("first_name", ' ', "last_name") AS "actor_name", COUNT("film_id") AS "num_films_made" 
    FROM "actor" AS "a"
    LEFT JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
    GROUP BY "a"."actor_id"
)
SELECT *
FROM "actor_num_peliculas";

-- 49 - Total de alquileres por cliente
SELECT CONCAT("first_name", ' ', "last_name") AS "customer_name", COUNT("rental_id") AS "num_rentals"
FROM "customer" AS "c" 
LEFT JOIN "rental" AS "r" ON "c"."customer_id" = "r"."customer_id"
GROUP BY "c"."customer_id";

-- 50 - Duración total películas 'Action'
SELECT "c"."name" AS "film_category_name", SUM("length") AS "action_films_total_length"
FROM "film" AS "f"
INNER JOIN "film_category" AS "fc" ON "f"."film_id" = "fc"."film_id" 
INNER JOIN "category" AS "c" ON "fc"."category_id" = "c"."category_id" 
WHERE "c"."name" = 'Action'
GROUP BY "c"."name";

-- 51 - CTE "temporal_customer_rentals"
WITH "temporal_customer_rentals" AS (
	SELECT CONCAT("first_name", ' ', "last_name") AS "customer_name", COUNT("rental_id") AS "num_rentals"
    FROM "customer" AS "c" 
    LEFT JOIN "rental" AS "r" ON "c"."customer_id" = "r"."customer_id"
    GROUP BY "c"."customer_id"
)
SELECT "customer_name", "num_rentals"
FROM "temporal_customer_rentals";

-- 52 - CTE "films_rented" (al menos 10 veces)
WITH "films_rented" AS (
	SELECT "title" AS "film_title", COUNT("rental_id") AS "num_rentals"
	FROM "film" AS "f" 
	INNER JOIN "inventory" AS "i" ON "f"."film_id" = "i"."film_id"
	INNER JOIN "rental" AS "r" ON "i"."inventory_id" = "r"."inventory_id"
	GROUP BY "f"."film_id"
	HAVING COUNT("rental_id") > 10
)
SELECT "film_title", "num_rentals"
FROM "films_rented";

-- 53 - Peliculas que no ha devuelto 'TAMMY SANDERS' por orden alfabético
SELECT CONCAT("first_name", ' ', "last_name") AS "customer_name", "title" AS "films_not_return_yet"
FROM "customer" AS "c" 
INNER JOIN "rental" AS "r" ON "c"."customer_id" = "r"."customer_id" 
INNER JOIN "inventory" AS "i" on "r"."inventory_id" = "i"."inventory_id" 
INNER JOIN "film" AS "f" ON "i"."film_id" = "f"."film_id" 
WHERE (CONCAT("first_name", ' ', "last_name") = 'TAMMY SANDERS') AND
	("return_date" = NULL)
ORDER BY "title";

-- 54 - Actores que actuaron al menos 1 vez en 'Sci-Fi' por orden alfabético
SELECT CONCAT("last_name", ', ', "first_name") AS "actor_name", ROUND(COUNT("fa"."film_id")) AS "num_films_made_by_sci_fi_actors"
FROM "actor" AS "a"
LEFT JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
LEFT JOIN "film_category" AS "fc" ON "fa"."film_id" = "fc"."film_id" 
LEFT JOIN "category" AS "c" ON "fc"."category_id" = "c"."category_id" 
WHERE "c"."name" in ('Sci-Fi')
GROUP BY "a"."actor_id"
ORDER BY "last_name";

-- 55 - Actores que han actuado en películas que se alquilaron después de que ‘Spartacus Cheaper' se alquilara por primera vez, alfabéticamente por apellido
WITH "spartacus_cheaper_first_rental" AS (
	SELECT "rental_date" AS "scfr"
	FROM "rental" AS "r"
	INNER JOIN "inventory" AS "i" ON "r"."inventory_id" = "i"."inventory_id"
	INNER JOIN "film" AS "f" ON "i"."film_id" = "f"."film_id"
	WHERE "title" = 'SPARTACUS CHEAPER'
	LIMIT 1	
)
SELECT CONCAT("last_name", ', ', "first_name") AS "actor_name", COUNT("fa"."film_id") AS "films_rented_after_SPARTACUS_CHEAPER_first_rental" 
FROM "actor" AS "a"
LEFT JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
LEFT JOIN "inventory" AS "i" ON "fa"."film_id" = "i"."film_id"
LEFT JOIN "rental" AS "r" ON "i"."inventory_id" = "r"."inventory_id"
WHERE "rental_date" > (SELECT "scfr" FROM "spartacus_cheaper_first_rental")
GROUP BY "a"."actor_id" 
ORDER BY "last_name";

-- 56 - Actores que no han actuado en peliculas cat 'Music'
SELECT CONCAT("first_name", ' ', "last_name") AS "actor_name", COUNT("c"."name") AS "num_other_film_categories" 
FROM "actor" AS "a"
LEFT JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
LEFT JOIN "film_category" AS "fc" ON "fa"."film_id" = "fc"."film_id"
LEFT JOIN "category" AS "c" ON "fc"."category_id" = "c"."category_id"
WHERE "c"."name" NOT IN ('Music')
GROUP BY "a"."actor_id";

-- 57 - Título de todas las películas alquiladas por más de 8 días
SELECT "title" AS "film_title", EXTRACT(DAY FROM "return_date"::TIMESTAMP - "rental_date"::TIMESTAMP) AS "days_rented"
FROM "rental" AS "r"
INNER JOIN "inventory" AS "i" ON "r"."inventory_id" = "i"."inventory_id"
INNER JOIN "film" AS "f" ON "i"."film_id" = "f"."film_id"
WHERE EXTRACT(DAY FROM "return_date"::TIMESTAMP - "rental_date"::TIMESTAMP) > 8;

-- 58 - Películas categoría 'Animation'
SELECT "title" AS "animation_film_tile", "c"."name" AS "film_category"
FROM "film" AS "f" 
INNER JOIN "film_category" AS "fc" ON "f"."film_id" = "fc"."film_id" 
INNER JOIN "category" AS "c" ON "fc"."category_id" = "c"."category_id" 
WHERE "c"."name" = 'Animation';

-- 59 - Películas con la misma duración que 'Dancing Fever' alfabéticamente
WITH "dancing_fever_length" AS (
	SELECT "length" AS "dfl"
	FROM "film" 
	WHERE "title" = 'DANCING FEVER'
	)
SELECT "title" AS "film_title", "length" AS "film_length"
FROM "film"
WHERE "length" = (SELECT "dfl" FROM "dancing_fever_length")
ORDER BY "title";

-- 60 - Clientes que han alquilado >= 7 películas distintas, apellido alfabeticamente
SELECT CONCAT("first_name", ' ', "last_name") AS "customer_name", COUNT(DISTINCT "title") AS "num_different_films_rented"
FROM "customer" AS "c" 
INNER JOIN "rental" AS "r" ON "c"."customer_id" = "r"."customer_id"
INNER JOIN "inventory" AS "i" ON "r"."inventory_id" = "i"."inventory_id" 
INNER JOIN "film" AS "f" ON "i"."film_id" = "f"."film_id"; 
GROUP BY "c"."customer_id" 
HAVING COUNT(DISTINCT "title") >= 7
ORDER BY "last_name";

-- 61 - Categorías con sus totales de alquileres
SELECT "c"."name" AS "film_category_name", COUNT("rental_id") AS "total_rentals"
FROM "category" AS "c"
LEFT JOIN "film_category" AS "fc" ON "c"."category_id" = "fc"."category_id" 
LEFT JOIN "inventory" AS "i" ON "fc"."film_id" = "i"."film_id" 
LEFT JOIN "rental" AS "r" ON "i"."inventory_id" = "r"."inventory_id"
GROUP BY "c"."name";

-- 62 - Películas por categoría estrenadas en 2006
SELECT "c"."name" AS "film_category_name", COUNT("release_year") AS "released_2006"
FROM "category" AS "c"
INNER JOIN "film_category" AS "fc" ON "c"."category_id" = "fc"."category_id" 
INNER JOIN "film" AS "f" ON "fc"."film_id" = "f"."film_id"
WHERE "release_year" = '2006'
GROUP BY "c"."name";

-- 63 - Cross join trabajadores y tiendas
SELECT CONCAT("first_name", ' ', "last_name") AS "staff_name", "store_id" as "num_store", "a"."address" 
FROM "staff" 
CROSS JOIN "store" AS "st"
INNER JOIN "address" AS "a" ON "st"."address_id" = "a"."address_id";

-- 64 - Cantidad de películas por clientes
SELECT COUNT("rental_id") AS "films_rented", CONCAT("first_name", ' ', "last_name", '-', COUNT("rental_id")) AS "customer_info"
FROM "customer" AS "c" 
LEFT JOIN "rental" AS "r" ON "c"."customer_id" = "r"."customer_id" 
GROUP BY "c"."customer_id";