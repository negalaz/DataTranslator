--1.1
SELECT  first_name,last_name 
FROM actor;
--1.2
SELECT first_name || ' ' || last_name as ActorName
FROM actor;
--1.3
SELECT actor_id,first_name,last_name
FROM actor
WHERE first_name like '%Joe%'; 
--1.4
SELECT first_name || ' ' || last_name as ActorName
FROM actor
WHERE last_name like '%GEN%'
--1.5
SELECT first_name || ' ' || last_name as ActorName
FROM actor
WHERE last_name like '%LI%'
ORDER BY last_name,first_name;
--1.6
SELECT country_id,country
FROM country
WHERE country in ('Afghanistan','Bangladesh','China')


--PARTE 2
--2.1
SELECT last_name,count(1) as contador
FROM actor
GROUP BY last_name
--2.2
SELECT last_name,count(1) as contador
FROM actor
GROUP BY last_name
HAVING count(1) >= 2
--2.3
SELECT S.last_name,S.last_name,A.address
FROM staff S
JOIN address A
ON S.address_id = A.address_id
--2.4
SELECT S.first_name,S.last_name,SUM(P.amount) as total
FROM staff S 
JOIN payment P
ON S.staff_id = P.staff_id
GROUP BY S.last_name,S.last_name

--2.5
SELECT f.title,count(1) as actores
FROM film f
JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY f.title
--2.6
select f.title,count(1) as copias 
from inventory i
JOIN film f
ON i.film_id = f.film_id
WHERE f.title = 'HUNCHBACK IMPOSSIBLE'
GROUP by f.title
--2.7
SELECT c.first_name
,c.last_name
,sum(p.amount) as Total
FROM payment p
JOIN customer c
ON p.customer_id = p.customer_id
GROUP BY c.first_name,c.last_name
ORDER BY c.last_name

--3.1
SELECT * 
FROM language l
JOIN (SELECT f.title,f.language_id
        FROM film f
        WHERE f.title like 'Q%'
       ) Q
    ON l.language_id = q.language_id
WHERE l.name = 'English'
--3.2
;WITH CTE_ActorPelicula (
    SELECT fa.film_id,first_name,last_name
    FROM actor a
    JOIN film_actor fa
    ON a.actor_id = fa.actor_id
)
SELECT cte.*
FROM film f
JOIN CTE_ActorPelicula cte
ON cte.film_id = f.film_id
WHERE f.title = 'ALONE TRIP' 

SELECT cte.*
FROM film f
JOIN (SELECT fa.film_id,first_name,last_name
    FROM actor a
    JOIN film_actor fa
    ON a.actor_id = fa.actor_id) cte
ON cte.film_id = f.film_id
WHERE f.title = 'ALONE TRIP' 
--3.3
SELECT cu.first_name,cu.last_name,cu.email
FROM country c
JOIN city ci
ON ci.country_id = c.country_id
JOIN address a
ON a.city_id = ci.city_id
JOIN customer cu
ON cu.address_id = a.address_id
WHERE c.country = 'Canada'
--3.4
SELECT f.title 
FROM film f
JOIN film_category fc
on fc.film_id = f.film_id
JOIN category c
ON fc.category_id = c.category_id
WHERE c.name = 'Family'
--3.5
SELECT f.title,count(1)
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY count(1) desc
--3.6
SELECT s.store_id,sum(p.amount)
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN payment p
ON p.rental_id = r.rental_id
JOIN store s
ON s.store_id = i.store_id
GROUP BY s.store_id

--3.7
SELECT s.store_id,ci.city,c.country
FROM country c
JOIN city ci
ON ci.country_id = c.country_id
JOIN address a
ON a.city_id = ci.city_id
JOIN store s 
ON s.address_id = a.address_id

--3.8
SELECT c.name,row_number() over ( ORDER BY count(1) desc)
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN payment p
ON p.rental_id = r.rental_id
JOIN store s
ON s.store_id = i.store_id
JOIN film_category fc
ON fc.film_id = f.film_id
JOIN category c
ON c.category_id = fc.category_id
GROUP BY c.category_id
ORDER by count(1) desc
LIMIT 5
