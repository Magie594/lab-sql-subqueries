USE SAKILA;
-- Write SQL queries to perform the following tasks using the Sakila database:
-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT Count(*)
From inventory
WHERE film_id = (SELECT film_id from film
WHERE title = 'Hunchback Impossible');

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT description, length AS longer_avg
From film
WHERE length > (SELECT AVG(length) FROM film
WHERE description = description);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name, last_name, actor_id
FROM actor
WHERE actor_id in (SELECT actor_id from film_actor 
WHERE film_id = (SELECT film_id From film
WHERE title = 'Alone Trip'));

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT film_id, title from film
WHERE film_id in (SELECT film_id from film_category
WHERE category_id in (SELECT category_id from category
WHERE name = 'family'));

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT cu.first_name, cu.email, co.country
FROM customer AS cu 
JOIN address AS a ON cu.address_id = a.address_id
JOIN city AS c ON c.city_id = a.city_id
JOIN country AS co ON c.country_id = co.country_id
WHERE country = 'Canada';

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
SELECT * FROM (
 SELECT film_id, title, 
       (SELECT COUNT(*) FROM film_actor Where film_id=f.film_id) most_actors
 FROM film f ) f2
WHERE most_actors>9 ORDER BY most_actors;

-- 7. Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

SELECT title FROM film 
WHERE film_id In (SELECT film_id From inventory
WHERE inventory_id in (SELECT inventory_id From rental
WHERE customer_id = (SELECT customer_id From payment 
Group by customer_id
Order by SUM(amount) DESC 
LIMIT 1 )));

-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.
  
SELECT customer_id, AVG(amount) as total_amount
FROM payment
WHERE customer_id IN (SELECT customer_id from customer 
WHERE customer.active = 1)
GROUP BY customer_id;








