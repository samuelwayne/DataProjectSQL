-- 2 - Películas catalogadas 'R'
select "film_id", "title" as films_R_rated
from "film" f 
where "rating" = 'R';

-- 3 - Actores cuyo ID está entre 30 y 40
select "actor_id", concat("first_name", ' ', "last_name") as actor_name 
from actor a 
where "actor_id" between 30 and 40;

-- 4 - Películas cuyo idioma sea igual al original
select film_id , title as film_original_language
from film f 
where language_id = original_language_id;

-- 5 - Películas ordenadas por duración
select film_id , title, length 
from film f 
order by "length";

-- 6 - Actores apellido 'Allen'
select "actor_id", concat("first_name", ' ', "last_name") as actor_name 
from actor a 
where last_name = 'ALLEN';

-- 7-  Clasificaciones de películas y sus recuentos
select rating, count(*) as num_films
from film f 
group by rating;

-- 8 - Películas clasificadas 'PG-13' o curación > 180 min
select film_id, title
from film f 
where rating = 'PG-13' or length > 180;

-- 9 - Variabilidad de reemplazar las películas
select min(replacement_cost) as min_replacement_cost, max(replacement_cost) as max_replacement_cost
from film f;

-- 10 - Mayor y menor duración de películas
select min(length) as min_duration, max(length) as max_duration
from film f;

-- 11 - Coste antepenúltimo alquiler ordenado por día
select r.rental_id as thrid_last_rent, rental_date as third_last_date, amount as third_last_amount
from rental r
inner join payment p on r.rental_id = p.rental_id  
order by date_trunc('day', "rental_date") desc 
limit 1 offset 2;

-- 12 - Películas que no son 'NC-17' ni 'G'
select film_id , title , rating 
from film f 
where rating not in ('NC-17', 'G');

-- 13 - Promedios de duración según su clasificación
select rating, round(avg(length)) as avg_length
from film f 
group by rating;

-- 14 - Películas con duración > 180 min
select film_id, title, length 
from film f 
where length > 180;

-- 15 - Total beneficios
select sum(amount) as total_income
from payment p;

-- 16 - 10 Clientes con mayor valor de ID
select customer_id, concat(first_name, ' ', last_name) as customer_name
from customer c
order by customer_id desc 
limit 10;

-- 17 - Actores que salen en 'Egg Igby'
select concat(first_name, ' ', last_name) as actor_name
from actor a 
inner join film_actor fa
on a.actor_id = fa.actor_id 
	inner join film f 
	on fa.film_id = f.film_id 
where f.title = 'EGG IGBY';

-- 18 - Nombres de las películas únicos
select count(distinct (title)) as titulos_unicos
from film f;

-- 19 - Comedias > 180 min
select title as title_comedy, c.name as cat_name, f.length
from film f 
inner join film_category fc on f.film_id = fc.film_id 
inner join category c on fc.category_id = c.category_id
where c."name" = 'Comedy' and f.length > 180;

-- 20 - Categorías con promedio de duración > 110
select c.name as cat_name, round(avg(f.length)) as length_higher_110
from film f 
inner join film_category fc 
on f.film_id = fc.film_id 
	inner join category c 
	on fc.category_id = c.category_id
group by c."name" 
having avg(f.length) > 110;

-- 21 - Media duración alquiler
select round(avg(extract (day from r.return_date::timestamp - r.rental_date::timestamp)), 2) as avg_days_rented
from rental r;

-- 22 - Nombres y apellidos de Actores y  actrices
select concat(first_name, ' ', last_name) as full_name_actors 
from actor a;

-- 23 - Números de alquiler por día orden descendente
select date_trunc('day', rental_date) as day_date, count(rental_id) as total_rentals
from rental r 
group by date_trunc('day', rental_date)
order by count(rental_id) desc;

-- 24 - Películas con duración superior al promedio
select title, length as length_higher_avg
from film f 
where length > (select avg(length) from film);

-- 25 - Alquileres registrados por mes
select date_trunc('month', rental_date) as month_date, count(rental_id) as num_rentals
from rental r 
group by date_trunc('month', rental_date);

-- 26 - avg, stddev, variance de los pagos
select round(avg(amount), 2) as average, round(stddev(amount), 2) as std_dev, round(variance(amount), 2) as variance
from payment p;

-- 27 - Películas que cuesta alquilar por encima de avg
select title, rental_rate 
from film f 
where rental_rate > (select avg(rental_rate) from film);

-- 28 - Actores que han participado en  más de 40 películas
select a.actor_id, concat(first_name, ' ', last_name) as actor_name, count(fa.film_id) as num_films
from actor a 
left join film_actor fa
on a.actor_id = fa.actor_id
group by a.actor_id 
having count(fa.film_id) > 40;

-- 29 - Películas con su disponibilidad en el inventario
select f.title, count(i.inventory_id) as num_available
from film f 
left join inventory i 
on f.film_id = i.film_id 
group by f.title;

-- 30 - Actores y número de películas en los que han actuado
select a.actor_id, concat(first_name, ' ', last_name) as actor_name, count(fa.film_id) as num_films_made
from actor a 
left join film_actor fa
on a.actor_id = fa.actor_id
group by a.actor_id;

-- 31 - Todas las películas con actores que han actuado
select f.title, concat(first_name, ' ', last_name) as actor_name
from film_actor fa 
inner join film f on fa.film_id = f.film_id 
left join actor a  on fa.actor_id = a.actor_id
order by f.title;

-- 32 - Todos los actores con las películas en las que han actuado
select concat(first_name, ' ', last_name) as actor_namee, f.title
from film_actor fa 
inner join actor a on fa.actor_id = a.actor_id
left join film f on fa.film_id = f.film_id
order by a.actor_id;

-- 33 - Películas y sus registros de alquiler
select title, rental_date
from film f 
left join inventory i on f.film_id = i.film_id 
left join rental r on i.inventory_id = r.inventory_id;

-- 34 - 5 Clientes que más dinero se han gastado
select concat(first_name, ' ', last_name) as customer_name, sum(amount) as total_spent 
from customer c 
inner join payment p on c.customer_id = p.customer_id 
group by c.customer_id 
order by sum(amount) desc 
limit 5;

-- 35 y 36 - Actores cuyo primer nombre 'JOHNNY'
select first_name as nombre, last_name as apellido
from actor a 
where first_name = 'JOHNNY';

-- 37 - ID min y max en actor
select actor_id , concat(first_name, ' ', last_name) 
from actor a 
where (actor_id = (select min(actor_id) from actor)) or (actor_id = (select max(actor_id) from actor));

-- 38 - Count actores en tabla actor
select count(actor_id);
from actor a 

-- 39 - Actores order by last name
select concat(first_name, ' ', last_name)
from actor a 
order by last_name;

-- 40 - 5 primeras películas tabla film
select film_id, title
from film f 
limit 5;

-- 41 - Agrupar actores por nombre y nombre más repetido
select first_name , count(distinct actor_id)
from actor a 
group by first_name 
order by count(distinct actor_id) desc;

-- 42 - Nombres de los clientes
select rental_id, concat(first_name, ' ', last_name)
from rental r 
inner join customer c on r.customer_id = c.customer_id;

-- 43 - Clientes y sus alquileres
select concat(c.first_name, ' ', c.last_name), title 
from customer c 
left join rental r on c.customer_id = r.customer_id
left join inventory i on r.inventory_id = i.inventory_id 
left join film f on i.film_id = f.film_id;

-- 44 - Cross join entre film y category
select *
from film f 
cross join category c;
-- ESTA CONSULTA NO TIENE UTILIDAD PORQUE GENERA MUCHOS DATOS QUE ADEMÁS NO NOS SIRVEN
-- PORQUE NI SIQUIERA SABEMOS A QUE CATEGORÍA CORRESPONDE CADA PELÍCULA ORIGINALMENTE

-- 45 - Actores de la categoría Action
select concat(first_name, ' ', last_name) as action_actor
from actor a 
left join film_actor fa on a.actor_id = fa.actor_id
left join film_category fc  on fa.film_id = fc.category_id 
left join category c on fc.category_id = c.category_id 
where c."name" = 'Action';

-- 46 - Actores que nno han participado en películas
select a.actor_id, fa.film_id 
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
left join film f on fa.film_id = f.film_id 
where f.film_id = null;

-- 47 - Actores y cantidad de películas en que han participado
select concat(first_name, ' ', last_name) as actor_name, count(film_id) as num_films
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id ;

-- 48 - Vista actores y cantidad de películas en que han participado
create view actor_num_peliculas as
	select concat(first_name, ' ', last_name) as actor_name, count(film_id) as num_films
	from actor a
	left join film_actor fa on a.actor_id = fa.actor_id
	group by concat(first_name, ' ', last_name)
select *
from actor_num_peliculas;

-- 49 - Total de alquileres por cliente
select concat(first_name, ' ', last_name) as customer_name, count(rental_id) as num_rentals 
from rental r 
inner join customer c on r.customer_id = c.customer_id 
group by c.customer_id ;

-- 50 - Duración total películas 'Action'
select c."name" as cat_name, sum(f.length) as total_length
from film f 
inner join film_category fc on f.film_id = fc.film_id 
inner join category c on fc.category_id = c.category_id 
where c.name = 'Action'
group by c."name";

-- 51 - CTE "cliente_rentas_temporal"
with cliente_rentas_temporal as(
	select concat(first_name, ' ', last_name) as customer_name, count(rental_id) as num_rentals 
	from rental r 
	inner join customer c on r.customer_id = c.customer_id 
	group by c.customer_id
)
select customer_name, num_rentals
from cliente_rentas_temporal;

-- 52 - CTE "peliculas_alquiladas" (al menos 10 veces)
with peliculas_alquiladas as(
	select f.title as film_title, count(rental_id) as num_rentals
	from film f 
	inner join inventory i on f.film_id = i.film_id
	inner join rental r on i.inventory_id = r.inventory_id
	group by f.film_id
	having count(rental_id) > 10
)
select film_title, num_rentals
from peliculas_alquiladas;

-- 53 - Peliculas que no ha devuelto 'TAMMY SANDERS' por orden alfabético
select concat(first_name, ' ', last_name) as customer_name, f.title as film_not_return_yet
from customer c 
inner join rental r on c.customer_id = r.customer_id 
inner join inventory i on r.inventory_id = i.inventory_id 
inner join film f on i.film_id = f.film_id 
where (concat(first_name, ' ', last_name) = 'TAMMY SANDERS') and
	(r.return_date = null)
order by f.title;

-- 54 - Actores que actuaron al menos 1 vez en 'Sci-Fi' por orden alfabético
select concat(last_name, ', ', first_name) as actor_name, round(count(f.film_id)) as num_sci_fi_films
from actor a 
inner join film_actor fa on a.actor_id = fa.actor_id
inner join film f on fa.film_id = f.film_id
inner join film_category fc  on f.film_id = fc.film_id 
inner join category c on fc.category_id = c.category_id
where c.name in ('Sci-Fi')
group by actor_id 
order by concat(last_name, ', ', first_name);

-- 55 - Actores que han actuado en películas que se alquilaron después de que ‘Spartacus
-- Cheaper' se alquilara por primera vez, alfabéticamente por apellido
with spartacus_cheaper_first_rental as(
	select rental_date as scfr
	from rental r
	inner join inventory i on r.inventory_id = i.inventory_id
	inner join film f on i.film_id = f.film_id
	where f.title = 'SPARTACUS CHEAPER'
	limit 1	
)
select concat(last_name, ', ', first_name) as actor_name, count(f.film_id) as film_aparitions 
from rental r
inner join inventory i on r.inventory_id = i.inventory_id
inner join film f on i.film_id = f.film_id
inner join film_actor fa on f.film_id = fa.film_id 
inner join actor a on fa.actor_id = a.actor_id 
where r.rental_date > (select scfr from spartacus_cheaper_first_rental)
group by actor_id 
order by concat(last_name, ', ', first_name);

-- 56 - Actores que no han actuado en peliculas cat 'Music'
select concat(first_name, ' ', last_name) as actor_name, count(c."name") as other_cats 
from actor a 
inner join film_actor fa on a.actor_id = fa.actor_id
inner join film f on fa.film_id = f.film_id
inner join film_category fc  on f.film_id = fc.film_id 
inner join category c on fc.category_id = c.category_id
where c.name not in ('Music')
group by actor_id;

-- 57 - Título de todas las películas alquiladas por más de 8 días
select f.title, extract(day from return_date::timestamp - rental_date::timestamp) as days_rented
from rental r
inner join inventory i on r.inventory_id = i.inventory_id
inner join film f on i.film_id = f.film_id
where (extract(day from return_date::timestamp - rental_date::timestamp)) > 8;

-- 58 - Películas categoría 'Animation'
select f.title as film_animation
from film f 
inner join film_category fc on f.film_id = fc.film_id 
inner join category c on fc.category_id = c.category_id 
where c."name" = 'Animation';

-- 59 - Películas con la misma duración que 'Dancing Fever' alfabéticamente
with dancing_fever_length as(
	select length as dfl
	from film f 
	where title = 'DANCING FEVER'
	)
select title, length
from film f
where length = (select dfl from dancing_fever_length)
order by title;

-- 60 - Clientes que han alquilado >= 7 películas distintas, apellido alfabeticamente.
select concat(last_name, ', ', first_name) as customer_name, count(distinct title) as num_rentals
from customer c 
inner join rental r on c.customer_id = r.customer_id 
inner join inventory i on r.inventory_id = i.inventory_id 
inner join film f on i.film_id = f.film_id 
group by c.customer_id 
having count(distinct title) >= 7
order by concat(last_name, ', ', first_name);

-- 61 - Categorías con sus totales de alquileres
select c.name as cat_name, count(rental_id) as total_rentals
from category c
inner join film_category fc on c.category_id = fc.category_id 
inner join film f on fc.film_id =f.film_id 
inner join inventory i on f.film_id = i.film_id 
inner join rental r on i.inventory_id = r.inventory_id 
group by c.name;

-- 62 - Películas por categoría estrenadas en 2006
select c.name as cat_name, count(release_year) as released_2006
from category c
inner join film_category fc on c.category_id = fc.category_id 
inner join film f on fc.film_id =f.film_id
where release_year = '2006'
group by c."name";

-- 63 - Cross join trabajadores y tiendas
select concat(first_name, ' ', last_name) as staff_name, s2.store_id as num_store, address 
from staff s 
cross join store s2
inner join address a on s2.address_id = a.address_id;

-- 64 - Cantidad de películas por clientes
select count(rental_id) as films_rented,
	concat(first_name, ' ', last_name, '-', count(rental_id)) as customer_info
from customer c 
inner join rental r on c.customer_id = r.customer_id 
group by c.customer_id;
