use sakila;

-- 1.
-- Write a query to display for each store its store ID, city, and country.
select s.store_id, ci.city, co.country from sakila.store as s -- s: store, ci: city, co: country
join sakila.address as a on s.address_id=a.address_id
join sakila.city as ci on ci.city_id=a.city_id
join sakila.country as co on co.country_id=ci.country_id;

-- 2.
-- Write a query to display how much business, in dollars, each store brought in.
select * from sakila.payment;
select * from sakila.store;

select s.store_id, sum(p.amount) as total_amount_in_dollars from sakila.store as s -- s: store, p: payment
join sakila.payment as p on s.manager_staff_id=p.staff_id
group by store_id;

-- 3. 
-- What is the average running time of films by category?
-- if the question means that running time is the length of the film then:
select c.category_id, c.name, avg(f.length) as average_time_per_category from sakila.category as c -- c: category, f: film, fc: film_category
join sakila.film_category as fc on c.category_id=fc.category_id
join sakila.film as f on f.film_id=fc.film_id
group by c.category_id, c.name;

-- 4. 
-- Which film categories are longest?
select c.category_id, c.name, avg(f.length) as average_time_per_category from sakila.category as c -- c: category, f: film, fc: film_category
join sakila.film_category as fc on c.category_id=fc.category_id
join sakila.film as f on f.film_id=fc.film_id
group by c.category_id, c.name
order by average_time_per_category desc;
-- limit 10 -- if we would like to select the top 10 longest film categories
-- we selected the film categories by their average length

-- 5.
-- Display the most frequently rented movies in descending order.
select f.film_id, f.title, count(r.inventory_id) as frequency_of_rented_movies from sakila.film as f -- c: f: film, r: rental, i: inventory  
join sakila.inventory as i on f.film_id=i.film_id
join sakila.rental as r on i.inventory_id=r.inventory_id
group by f.film_id, f.title
order by frequency_of_rented_movies desc;
-- limit 10

-- 6. 
-- List the top five genres in gross revenue in descending order.
-- if the question means as genres the categories then :
select * from category;
select * from payment;
select * from film;
select * from film_category;
select c.category_id, c.name, sum(p.amount) as gross_revenue from sakila.category as c -- c: category, p: payment, f: film, fc: film_category, i:inventory
join sakila.film_category as fc on c.category_id=fc.category_id
join sakila.film as f on f.film_id=fc.film_id
join sakila.inventory i on i.film_id = f.film_id
join sakila.rental as r on r.inventory_id = i.inventory_id
join sakila.payment as p on p.rental_id = r.rental_id
group by c.category_id, c.name
order by gross_revenue desc
limit 5;

-- 7.
-- Is "Academy Dinosaur" available for rent from Store 1?
select f.title, r.return_date from sakila.film as f -- c: f: film, r: rental, i: inventory 
join sakila.inventory as i on f.film_id=i.film_id
join sakila.rental as r on i.inventory_id=r.inventory_id
where r.return_date is null and r.staff_id = 1 and f.title = 'Academy Dinosaur';
-- the film 'Academy Dinosaur' is available in store 1 because we do not have any result
-- if in the last statement instead of r.staff_id = 1 making it r.staff_id = 2 , we have as result null, that means the film is unavailable in Store 2