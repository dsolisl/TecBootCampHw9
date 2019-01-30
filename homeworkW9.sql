USE sakila;

DESCRIBE actor;

#1a
SELECT first_name, last_name FROM actor;

#1b
ALTER TABLE actor ADD Actor_Name VARCHAR(25);

SELECT * FROM actor;


SELECT CONCAT (first_name, ' ', last_name) AS Actor_name FROM actor;

UPDATE actor
	SET Actor_Name = CONCAT (first_name, ' ', last_name);
    
SELECT * FROM actor;

#2a
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Joe';

#2b
SELECT Actor_Name FROM actor WHERE last_name LIKE '%GEN%';

#2c
SELECT last_name, first_name FROM actor
	WHERE last_name LIKE '%LI%'
    ORDER BY last_name, first_name ASC;
    
SELECT* FROM country;

#2d
SELECT country_id, country FROM country
	WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3a    
ALTER TABLE actor ADD Description BLOB(255);

SELECT * FROM actor;

#3b
ALTER TABLE actor	
	DROP COLUMN Description;
    
SELECT * FROM actor;

SELECT DISTINCT (last_name) FROM actor;

#4a
SELECT last_name, COUNT(*) as count FROM actor GROUP BY last_name ORDER BY count DESC;

#4b
SELECT last_name, COUNT(*) count FROM actor GROUP BY last_name HAVING count > 1;

#4c
UPDATE actor
	SET first_name = 'HARPO'
    WHERE first_name = 'GROUCHO' AND  last_name = 'WILLIAMS';
    
SELECT * FROM actor
	WHERE last_name = 'WILLIAMS';
    
UPDATE actor
	SET Actor_name = 'HARPO WILLLIAMS'
    WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';

#4d    
UPDATE actor
	SET first_name = 'GROUCHO'
    WHERE first_name = 'HARPO';
    
SELECT * FROM actor WHERE  first_name = 'GROUCHO';

UPDATE actor
	SET Actor_Name = 'GROUCHO WILLIAMS'
    WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

#5a    
SHOW CREATE TABLE address;

DESCRIBE staff;

DESCRIBE address;

SELECT * FROM STAFF;

#6a
SELECT first_name, last_name, address FROM staff
	INNER JOIN address ON  staff.address_id = address.address_id;
    
DESCRIBE payment;

SELECT* FROM payment;

#6b aqui si no tengo nada claro si puedo usar ese like y que funcione bien
SELECT first_name, last_name, SUM(amount) FROM staff
	INNER JOIN payment on staff.staff_id = payment.staff_id
    WHERE payment_date LIKE '2005-08%';

DESCRIBE film;

DESCRIBE film_actor;

#6C
SELECT 
	film.title, 
    COUNT(film_actor.actor_id)
FROM film INNER JOIN film_actor
	ON film.film_id = film_actor.film_id
    GROUP BY title;
    
DESCRIBE film;

DESCRIBE inventory;


SELECT * FROM inventory;

#6d
SELECT 
	film.title, 
	COUNT(inventory.film_id)
FROM film INNER JOIN inventory
	ON 	film.film_id = inventory.film_id
WHERE title = 'Hunchback Impossible';

DESCRIBE customer;
DESCRIBE payment;

#6e
SELECT 
	customer.first_name,
    customer.last_name,
    SUM(payment.amount)
FROM customer INNER JOIN payment
	ON customer.customer_id = payment. customer_id
GROUP BY customer.customer_id ORDER BY last_name ASC;

DESCRIBE film;
DESCRIBE language;

SELECT * FROM language;

SELECT language_id FROM language 
	WHERE name = 'English';  
    
SELECT title FROM film
	WHERE title LIKE 'K%' OR  title LIKE'Q%';
 
 #7a
SELECT title
FROM film
WHERE title LIKE 'K%' OR title LIKe 'Q%' AND 
language_id IN ( SELECT language_id
	FROM language
    WHERE name = 'English');

DESCRIBE actor;
DESCRIBE film;
DESCRIBE film_actor;

SELECT film_id FROM film
WHERE title = 'Alone Trip';

SELECT actor_id FROM film_actor
WHERE film_id = 17;
   
SELECT first_name, last_name FROM actor
WHERE actor_id IN (SELECT actor_id
	FROM film_actor
    WHERE film_id =17);
 
 #7b
SELECT first_name, last_name FROM actor
WHERE actor_id IN (SELECT actor_id
	FROM film_actor
	WHERE film_id IN (SELECT film_id
		FROM film
		WHERE title = 'Alone Trip')
	);
    
    
DESCRIBE customer;
DESCRIBE country;
DESCRIBE address;
DESCRIBE city;

SELECT country_id
FROM country
WHERE country = 'Canada';

SELECT city_id
FROM city
WHERE country_id = 20;

SELECT address_id
FROM address
WHERE city_id IN (SELECT city_id
	FROM city
    WHERE country_id IN (SELECT country_id
		FROM country
		WHERE country = 'Canada')
);

#7c
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (SELECT address_id
	FROM address
    WHERE city_id IN (SELECT city_id
		FROM city
        WHERE country_id IN (SELECT country_id
			FROM country
            WHERE country = 'Canada')
));

DESCRIBE category;
SELECT name FROM category;
DESCRIBE film;
DESCRIBE film_category;


SELECT category_id FROM category
WHERE name = 'Family';

SELECT film_id FROM film_category
WHERE category_id = 8;

#7d
SELECT title FROM film
WHERE film_id IN (SELECT film_id
	FROM film_category
    WHERE category_id IN (SELECT category_id FROM category
		WHERE name = 'Family'));
        
DESCRIBE rental;
DESCRIBE film;
DESCRIBE customer;
DESCRIBE store;
DESCRIBE payment;
DESCRIBE inventory;
DESCRIBE rental;
DESCRIBE staff;

#7e
SELECT title, COUNT(rental_id)
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY title ORDER BY  COUNT(rental_id) DESC LIMIT 10;


SELECT * FROM store;
SELECT * FROM rental;

#7f
SELECT SUM(amount), store_id FROM payment
INNER JOIN staff ON payment.staff_id = staff.staff_id
GROUP BY store_id ORDER BY amount DESC;


DESCRIBE country;
DESCRIBE city;
DESCRIBE store;
DESCRIBE address;

#7g 
SELECT store_id, city, country FROM store
INNER JOIN address ON store.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id;

SELECT * FROM film_category;

DESCRIBE payment;
DESCRIBE rental;
DESCRIBE inventory;

#7h


SELECT name, SUM(amount) AS 'Gross Revenue' FROM payment
INNER JOIN rental ON payment.rental_id = rental.rental_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film_category ON inventory.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY name ORDER BY amount DESC LIMIT 5;

#8a 
CREATE VIEW Top_Five_Genres AS
SELECT category.name as Genres, SUM(amount) AS 'Gross Revenue' FROM payment
INNER JOIN rental ON payment.rental_id = rental.rental_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film_category ON inventory.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name ORDER BY amount DESC LIMIT 5;

#8b
SELECT * FROM Top_Five_Genres;

#8c

DROP VIEW Top_Five_Genres















    













