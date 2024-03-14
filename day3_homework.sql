-- 1. List all customer who live in Texas (tip use JOIN)
-- JOIN CUSTOMER_list with customer
select CONCAT(first_name, ' ', last_name) as Name, district
from customer 
join address 
on customer.address_id = address.address_id
where district = 'Texas';

                -- this was my query to find out how they had Texas stored. 
select * from address
where district = 'Texas'

-- 2. Get all payments above $6.99 with the Customer's Full Name
-- customer, customer_id goes to rental, goes to payment, amount >= 6.99
select CONCAT (first_name, ' ', last_name) AS Name, amount
from customer
join payment
on customer.customer_id = payment.customer_id
where amount > 6.99;


-- 3 Show all customers names who have made payments over $175 (tip use subqueries)
select CONCAT (first_name, ' ', last_name) AS Name
from customer
where customer_id in(
			select customer_id 
			from payment
			group by customer_id 
			having SUM(amount) > 175
			order by SUM(amount) DESC
);


-- 4. List all customers that live in Nepal (use the city table)
-- city_id is Nepal into address_id into customer(customer_id)
-- the answer is: Theres 1 based on what i could find and figure out. Kevin Schuler is his name
select CONCAT(first_name, ' ', last_name) as full_name, country
from customer  
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id 
join country on city.country_id = country.country_id
where country = 'Nepal';

select country -- i had to find out if Nepal was a city or a country silly me.
from country


-- 5. Which staff member had the most transactions? (staff_id > amount transactions)
-- staff(staff_id) goes to payment(staff_id) amount ascending/descending
select CONCAT(first_name, ' ', last_name) as full_name, count(amount) as total_transactions
from staff
join payment
on staff.staff_id = payment.payment_id
group by full_name
order by COUNT(amount) desc;


-- 6. How many movies of each rating are there?
-- select rating from film and count()
select rating, count(rating) as total_film_rating
from film
group by rating;


-- 7. Show all customers who have made a single payment above $6.99 (tip use subqueries)
-- select payment for amount >= 6.99 subqueue(customer_list, for name)
select CONCAT(first_name, ' ', last_name) as full_name
from customer
where customer_id IN( 
			select customer_id 
			from payment 
			group by customer_id
			having sum(amount) > 6.99
			order by sum(amount) DESC
);



-- 8. How many free rentals did our stores give away?
-- rental id from payment, where amount = 0 
select count(rental_id) as free_rental
from rental
where rental_id IN(
			select rental_id 
			from payment
			group by rental_id 
			having sum(amount) = 0
);

