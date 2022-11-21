USE mavenmovies;

-- SELECT & FROM: Pull a list of first name, last name, email of each customer

SELECT
	first_name,
	last_name,
    email
FROM customer;


-- SELECT DISTINCT: Pull the records of films with rental durations including 3, 5, and 7 days

SELECT * FROM film;

SELECT DISTINCT 
	rental_duration
FROM film;


-- WHERE CLAUSE: Pull all payments from first 100 customers (based on customer ID)

SELECT * FROM payment;

SELECT DISTINCT
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment
WHERE customer_id BETWEEN 1 AND 100; -- can also use < 101 or <= 100



-- WHERE & AND: Pull records wherein just payments over $5 for the same customers since January 1, 2006

SELECT * FROM payment;

SELECT 
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment
WHERE customer_id BETWEEN 1 AND 100
	AND amount >= 5.00
	AND payment_date > '2006-01-01';
    

-- WHERE & OR: Pull all payments over $5 from all customers including 42, 53, 60,73

SELECT 
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment
WHERE amount > 5
	OR customer_id = 42
    OR customer_id = 53
    OR customer_id = 60
    OR customer_id = 73;
		-- WHERE & IN: WHERE customer_id IN (42,53,60,73)
        

-- LIKE OPERATOR: Pull a list of films which include Behind the Scenes special features

SELECT * FROM film;

SELECT 
	title,
    special_features
FROM film
WHERE special_features LIKE '%Behind the Scenes%';



-- GROUP BY: Pull a count of titles sliced by rental duration

SELECT 
	rental_duration,
    COUNT(film_id) -- works with COUNT(title) too 
FROM film
GROUP BY
	rental_duration;
    
    
    
  -- AGGREGATE FUNCTIONS: Pull a count of films along with avg, min, max rental rate, grouped by replacement cost
  
  SELECT * FROM film;
  
  SELECT 
	replacement_cost,
    COUNT(film_id) AS count_of_films,
    AVG(rental_rate) AS avg_rental_rate,
    MIN(rental_rate) AS min_rental_rate,
    MAX(rental_rate) AS max_rental_rate
FROM film
GROUP BY
	replacement_cost;
    
    

-- HAVING CLAUSE: Pull a list of customer_ids with less than 15 rentals all-time

SELECT * FROM rental;

SELECT 
	customer_id,
    COUNT(rental_id) AS total_rentals
FROM rental
GROUP BY
	customer_id
HAVING COUNT(rental_id) < 15; 



-- ORDER BY CLAUSE: Pull a list of all film titles along with their lengths & rental rates & sort from longest to shortest

SELECT * FROM film;

SELECT 
	title,
    length,
    rental_rate
FROM film
ORDER BY length DESC;



-- CASE STATEMENT: Pull a list of first & last names of all customers, label as 'store 1 in/active' or 'store 2 in/active'

SELECT * FROM customer;

SELECT
	first_name,
    last_name,
    CASE 
		WHEN store_id = 1 AND active = 1 THEN 'store 1 active'
        WHEN store_id = 1 AND active = 0 THEN 'store 1 inactive'
        WHEN store_id = 2 AND active = 1 THEN 'store 2 active'
        WHEN store_id = 2 AND active = 0 THEN 'store 2 inactive'
		ELSE 'uh oh... check logic!'
	END AS preferred_store_status
FROM customer;



-- COUNT & CASE: Create a table to count the number of customers broken down by store_id(rows), active status(columns)

SELECT
	store_id, -- rows created by group by function
    COUNT(CASE WHEN active = 1 THEN customer_id ELSE NULL END) AS active_customers, -- column
    COUNT(CASE WHEN active = 0 THEN customer_id ELSE NULL END) AS inactive_customers
FROM customer
GROUP BY store_id;



-- INNER JOIN: Pull a list of film's title, description & store id value associated with each item & its inventory id

SELECT 
	inventory.store_id,
    inventory.inventory_id,
    film.title AS film_title,
    film.description AS film_description
FROM inventory
	INNER JOIN film
		ON inventory.film_id = film.film_id;
        

-- LEFT JOIN: Pull a list of all titles & how many actors are associated with each title

SELECT * FROM film;
SELECT * FROM film_actor;

SELECT 
	film.title,
    COUNT(film_actor.actor_id) AS count_of_actors
FROM film
	LEFT JOIN film_actor
		ON film_actor.film_id = film.film_id
GROUP BY 
	film.title;
    


-- BRIDGING TABLES: Pull a list of all actors with each title they appeared in. 

SELECT 
	actor.first_name AS actors_first_name,
    actor.last_name AS actors_last_name,
    film.title AS film_title
FROM actor
	INNER JOIN film_actor
		ON film_actor.actor_id = actor.actor_id
	INNER JOIN film
		ON film.film_id = film_actor.film_id;
	
    

-- MULTI-CONDITION JOINS: Pull a list of distinct titles & descriptions currently available at store 2

SELECT DISTINCT
	film.title,
	film.description
FROM film
	INNER JOIN inventory
		ON inventory.film_id = film.film_id
		AND inventory.store_id = 2; 
			-- can also use WHERE inventory.store_id = 2
            
            
-- UNION OPERATOR: Pull a list of all staff & advisor names, include a column noting whether they're a staff member or advisor

SELECT 
	'advisor' AS position, 
    first_name,
    last_name
FROM advisor

UNION

SELECT 
	'staff member' AS position,
    first_name,
    last_name
FROM staff;