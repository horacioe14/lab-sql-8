# 1. Rank films by length (filter out the rows that have nulls or 0s in length column). 
# In your output, only select the columns title, length, and the rank.

use sakila; 
select film.title, film.length, rank() over (order by film.length desc) as 'Rank'
from sakila.film
where film.length <> 0 or film.length <> null;

#2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
# In your output, only select the columns title, length, rating and the rank.
select film.title, film.length, film.rating, dense_rank() over (partition by film.rating order by film.length desc) as 'Rank'
from sakila.film
where film.length <> 0 or film.length <> null;


#3 How many films are there for each of the categories in the category table. Use appropriate join to write this query
select c.name, c.category_id, count(ci.film_id) as films_per_category
from sakila.category as c
join sakila.film_category as ci
on c.category_id = ci.category_id
group by c.category_id;


#4 Which actor has appeared in the most films?
select a.first_name, a.last_name, count(fa.film_id) as films_per_actor
from sakila.actor as a
join sakila.film_actor as fa
on a.actor_id = fa.actor_id
group by fa.actor_id
order by count(fa.film_id) desc
limit 1;


#5 Most active customer (the customer that has rented the most number of films)
select c.first_name, c.last_name, count(r.customer_id) as rents_per_customer
from sakila.customer as c
join sakila.rental as r
on c.customer_id = r.customer_id
group by r.customer_id
order by count(r.customer_id) desc
limit 1;

# Bonus: Which is the most rented film? The answer is Bucket Brotherhood
select f.title, count(i.film_id) as most_rented_film
from sakila.rental as r
join sakila.inventory as i
on r.inventory_id = i.inventory_id
join sakila.film as f
on i.film_id = f.film_id
group by i.film_id
order by count(i.film_id) desc
limit 1;

