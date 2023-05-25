USE Sakila;

## Exercise 1
SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id;

## Exercise 2
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, AVG(p.amount) AS average_payment
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, customer_name;

## Exercise 3

# Using Multiple Join Statements:

SELECT distinct c.first_name, c.last_name, c.email
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name = 'Action';

# Using Subqueries with Multiple WHERE Clauses and IN Condition:

SELECT first_name, last_name, email
FROM customer
WHERE customer_id IN (
    SELECT r.customer_id
    FROM rental r
    WHERE r.inventory_id IN (
        SELECT i.inventory_id
        FROM inventory i
        WHERE i.film_id IN (
            SELECT f.film_id
            FROM film f
            WHERE f.film_id IN (
                SELECT fc.film_id
                FROM film_category fc
                JOIN category cat ON fc.category_id = cat.category_id
                WHERE cat.name = 'Action'
            )
        )
    )
);

# Both queries are producing the same output of 498 rows.

## Exercise 4

SELECT payment_id, customer_id, amount,
  CASE
    WHEN amount BETWEEN 0 AND 2 THEN 'low'
    WHEN amount BETWEEN 2 AND 4 THEN 'medium'
    WHEN amount > 4 THEN 'high'
    ELSE 'unknown'
  END AS transaction_label
FROM payment;
