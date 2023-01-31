use sakila;

-- 1 Select the first name, last name, and email address of all the customers who have rented a movie.
select first_name, last_name, email from customer;


-- 2 What is the average payment made by each customer (display the customer id, customer name (concatenated), 
-- and the average payment made).
-- Step 1: find average payment made
select round(avg(amount), 2)
from payment;

-- Step 2: 
select * from customer;
select c.customer_id, c.first_name, c.last_name, round(avg(amount), 2) as average_payment
from customer c
join payment p using (customer_id)
group by c.customer_id
order by average_payment desc;


-- 3 Select the name and email address of all the customers who have rented the "Action" movies.
-- 3.1 write the query using multiple join statements
-- 3.2 write the query using subqueries with multiple WHERE clauses and IN conditions
-- 3.3 Verify if the above two queries produce the same results or not

-- Multiple join statements
select c.first_name, c.last_name, c.email
from category ca 
join film_category fm using (category_id)
join film f using (film_id)
join inventory i using (film_id)
join rental r using (inventory_id) 
join customer c using(customer_id) 
where name = 'Action';

-- Write query using subqueries with multiple where clauses
select first_name, last_name, email from customer
where customer_id in (
	select customer_id from rental
	where inventory_id in (
		select inventory_id from inventory
		where film_id in (
			select film_id from film
			where film_id in (
				select film_id from film_category
				where category_id in (
					select category_id 
					from category
					where name = 'Action'
				)
			)
		)
	)
);
-- It looks like the 2 queries give the same results


-- 4 Use the case statement to create a new column classifying existing columns as either or high value 
-- transactions based on the amount of payment. If the amount is between 0 and 2, 
-- label should be low and if the amount is between 2 and 4, the label should be medium, 
-- and if it is more than 4, then it should be high.
select payment_id, rental_id,
case
	when amount <= 2 then 'low'
    when amount > 2 and amount <= 4 then 'medium'
    when amount > 4 then 'high'
end as TransactionValue
from payment;











