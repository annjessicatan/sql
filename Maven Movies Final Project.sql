/*
THE SITUATION: You and your business partner were recently approached by another local business owner who is interested in 
purchasing Maven Movies. He primarily owns restaurants and bars, so he has lots of questions for you about your business 
and the rental business in general. His offer seems very generous, so you are going to entertain his questions. 


THE OBJECTIVE: Use MySQL to leverage your SQL skills to extract and analyze data from various tables in the Maven Movies 
database to answer your potential Acquirer’s questions. Each question will require you to write a multi-table SQL query, 
joining at least two tables. 
*/

USE mavenmovies;

/*
1. My partner and I want to come by each of the stores in person and meet the managers. Please send over the managers’ names at each 
store, with the full address of each property (street address, district, city, and country please).
*/


SELECT 
    staff.first_name AS manager_first_name,
    staff.last_name AS manager_last_name,
    address.address AS street_address,
    address.district AS district,
    city.city AS city,
    country.country AS country
FROM store
	LEFT JOIN staff
		ON staff.staff_id = store.manager_staff_id
    LEFT JOIN address
		ON address.address_id = store.address_id
	LEFT JOIN city 
		ON city.city_id = address.city_id
	LEFT JOIN country
		ON country.country_id = city.country_id;


/*
2. I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, the 
inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost.
*/
SELECT
	inventory.store_id,
    inventory.inventory_id,
    film.title,
    film.rating,
    film.rental_rate,
    film.replacement_cost
FROM inventory
	LEFT JOIN film
		ON film.film_id = inventory.film_id;


/*
3. From the same list of films you just pulled, please roll that data up and provide a summary level overview of 
your inventory. We would like to know how many inventory items you have with each rating at each store.
*/
SELECT
    inventory.store_id,
    -- inventory.film_id,
    film.rating,
    COUNT(inventory_id) AS number_of_inventory_items
FROM inventory
	LEFT JOIN film
		ON film.film_id = inventory.film_id
GROUP BY 
	inventory.store_id,
    film.rating;
    

/*
4. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to 
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement 
cost, sliced by store and film category. 
*/

SELECT 
	store_id,
    category.name AS category,
    COUNT(inventory.inventory_id) AS films,
    AVG(film.replacement_cost) AS avg_replacement_cost,
    SUM(film.replacement_cost) AS total_replacement_cost
FROM inventory
	LEFT JOIN film
		ON inventory.film_id = film.film_id
	LEFT JOIN film_category
		ON film_category.film_id = inventory.film_id
	LEFT JOIN category
		ON film_category.category_id = category.category_id
GROUP BY
	store_id,
    category.name
ORDER BY 
	SUM(film.replacement_cost) DESC;

/*
5. We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, and their full 
addresses – street address, city, and country.
*/

SELECT 
	customer.store_id AS store_id,
    customer.first_name,
    customer.last_name,
	customer.active,
    address.address AS street_address,
    city.city AS city,
    country.country AS country
FROM customer
	LEFT JOIN address
		ON customer.address_id = address.address_id
	LEFT JOIN city
		ON address.city_id = city.city_id
	LEFT JOIN country
		ON country.country_id = city.country_id;

/*
6. We would like to understand how much your customers are spending with you, and also to know who your 
most valuable customers are. Please pull together a list of customer names, their total lifetime rentals, and the 
sum of all payments you have collected from them. It would be great to see this ordered on total lifetime value, 
with the most valuable customers at the top of the list.
*/

SELECT 
	customer.first_name,
    customer.last_name, 
    COUNT(payment.rental_id) AS total_lifetime_rentals,
		-- same result if you use table rental
    SUM(payment.amount) AS sum_of_all_payments
FROM customer
	LEFT JOIN payment
		ON payment.customer_id = customer.customer_id
GROUP BY
	customer.first_name,
    customer.last_name
ORDER BY
	SUM(payment.amount) DESC;
        

/*
7. My partner and I would like to get to know your board of advisors and any current investors. Could you 
please provide a list of advisor and investor names in one table? Could you please note whether they are an 
investor or an advisor, and for the investors, it would be good to include which company they work with. 
*/

SELECT
	'advisor' AS type,
    advisor.first_name,
    advisor.last_name,
    'null' AS company_name
FROM advisor

UNION

SELECT
	'investor' AS type,
    investor.first_name,
    investor.last_name,
    company_name
FROM investor;


/*
8. We're interested in how well you have covered the most-awarded actors. Of all the actors with three types of 
awards, for what % of them do we carry a film? And how about for actors with two types of awards? Same 
questions. Finally, how about actors with just one award?
*/

SELECT * FROM actor_award;

SELECT 
	CASE
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN actor_award.awards IN ('Emmy, Oscar', 'Emmy, Tony', 'Oscar, Tony') THEN ' 2 awards'
		ELSE '1 award'
	END AS number_of_awards,
    AVG(CASE WHEN actor_award.actor_id IS NULL THEN 0 ELSE 1 END) AS percent_with_one_film
FROM actor_award

GROUP BY
	CASE
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN actor_award.awards IN ('Emmy, Oscar', 'Emmy, Tony', 'Oscar, Tony') THEN ' 2 awards'
		ELSE '1 award'
	END;

