# Activate the Sakila Database
use sakila;

# 1a.)  Display first and last name of all actors on the 'Actor' table
select first_name, last_name from actor;

# 1b.) Display the first and last name of each actor in a single column in upper case letters.  Name the column `Actor Name`.
select CONCAT(first_name, ' ', last_name) as Actor_Name from actor; 

# 2a.) Find the ID number, first name, and last name of an actor with the first name "Joe."
select actor_id, first_name, last_name from actor where first_name like 'Joe%'; 

# 2b.) Find all actors whose last name contain the letters `GEN`
select * from actor 
where last_name like '%GEN%';

# 2c.) Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order
select * from actor
where last_name like '%li%'
ORDER BY last_name, first_name; 

# 2d.) Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:
Select * from country
where country in ('Afghanistan', 'Bangladesh', 'China');

# 3a.) You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table `actor` named `description` and use the data type `BLOB` (Make sure to research the type `BLOB`, as the difference between it and `VARCHAR` are significant).
ALTER TABLE actor
	ADD column description blob; 

# 3b.) Very quickly you realize that entering descriptions for each actor is too much effort. Delete the `description` column.
ALTER TABLE actor
Drop description; 

# 4a.) List the last names of actors, as well as how many actors have that last name.
select last_name, count(last_name) as "Last Name Count"
from actor
group by last_name;

# 4b.) List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name, count(last_name) as "Last Name Count"
from actor
group by last_name
having count(last_name) > 1;

# 4c.) The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.
update actor
set first_name = "HARPO"
where first_name = "GROUCHO" and last_name = "Williams";

select * from actor
where last_name = "Williams";

# 4d.) Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.
update actor
set first_name = "GROUCHO"
where first_name = "HARPO" and last_name = "Williams";

# 5a.) You cannot locate the schema of the `address` table. Which query would you use to re-create it? Hint: https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html
show create table address; 

# 6a.) Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
select t1.first_name, t1.last_name, t2.address
from staff t1
inner join address t2 on 
t1.address_id = t2.address_id;

# 6b.) Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.
select t1.staff_id as "Staff ID", t1.first_name as "First Name", t1.last_name as "Last Name", sum(t2.amount) as Sales
from staff t1
inner join payment t2 on 
t1.staff_id = t2.staff_id
where t2.payment_date between '2005-08-01 00:00:00' and '2005-08-31 23:59:59'
group by t1.staff_id;

# 6c.) List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
select t1.film_id as "Film ID", t1.title as "Film Title", count(actor_id)
from film t1
inner join film_actor t2 on
t1.film_id = t2.film_id
group by t1.film_id;

# 6d.) How many copies of the film `Hunchback Impossible` exist in the inventory system?
select t1.film_title as "Film Title", count(t2.inventory_id) as "Inventory Name Count"
from film t1
inner join inventory t2 on 
t1.film_id = t2.film_id;

select count(inventory_id) as "Inventory Count"
from inventory 
where film_id = (select film_id from film 
	             where title = "Hunchback Impossible");

# 6e.) Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name: [Total amount paid](Images/total_payment.png)
select t1.customer_id as "Customer ID",  Concat(t1.first_name, " ", t1.last_name) as "Customer Name", sum(t2.amount) as "Total Sales"
from customer t1
right join payment t2 on
t1.customer_id = t2.customer_id
group by t1.customer_id; 

# 7a.) The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.

Select t1.title as "Film Title" from film t1
where (t1.title like "K%" or t1.title like "Q%") and
	t1.language_id = (select t2.language_id from language t2 
	where t2.name = "English")
    order by t1.title;

# 7b.) Use subqueries to display all actors who appear in the film `Alone Trip`.
select t1.title, concat(t3.first_name, " ", t3.last_name) as "Actor Name" 
from film t1
inner join film_actor t2 on t1.film_id = t2.film_id
inner join actor t3 on t2.actor_id = t3.actor_id
where t1.title = "Alone Trip"
order by t3.last_name;

# 7c.) You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
select concat(t1.first_name, " ", t1.last_name) as "Customer Name" , 
              t2.address as "Street Address",
              t3.city as "City", 
              t2.district as "Province", 
              t2.postal_code as "Postal Code", 
              t4.country as "Country", 
              t1.email as "Email Address"            
from customer t1
inner join address t2 on t1.address_id = t2.address_id
inner join city t3 on t2.city_id = t3.city_id
inner join country t4 on t3.country_id = t4.country_id
where t4.country = "Canada"
order by t1.last_name;

# 7d.) Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films.
select t1.title as "Film Title",  
       t3.name as "Category Type"    
from film t1
inner join film_category t2 on t1.film_id = t2.film_id
inner join category t3 on t2.category_id = t3.category_id
where t3.name = "Family"
order by t1.title;

# 7e.) Display the most frequently rented movies in descending order.
select t3.title as "Film Title",  
       count(t1.rental_id) as "Rental Count"    
from rental t1
inner join inventory t2 on t1.inventory_id = t2.inventory_id
inner join film t3 on t2.film_id = t3.film_id
group by t3.title
order by (count(t1.rental_id)) desc;

# 7f.) Write a query to display how much business, in dollars, each store brought in.
select * from sales_by_store;

# 7g.) Write a query to display for each store its store ID, city, and country.
select t1.store_id as "Store ID",  
       t3.city as "Rental Count",    
       t4.country as "Country Name"
from store t1
inner join address t2 on t1.address_id = t2.address_id
inner join city t3 on t2.city_id = t3.city_id
inner join country t4 on t3.country_id = t4.country_id;        

# 7h.) List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
select sum(t1.amount) as "Gross Revenue",
       t5.name as "Genre" 
from payment t1
inner join rental t2 on t1.rental_id = t2.rental_id
inner join inventory t3 on t2.inventory_id = t3.inventory_id
inner join film_category t4 on t3.film_id = t4.film_id
inner join category t5 on t4.category_id = t5.category_id
group by t5.name
order by (sum(t1.amount)) desc 
limit 5;

# 8a.) In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
Create View Top_Five as
select sum(t1.amount), t5.name
from payment t1
inner join rental t2 on t1.rental_id = t2.rental_id
inner join inventory t3 on t2.inventory_id = t3.inventory_id
inner join film_category t4 on t3.film_id = t4.film_id
inner join category t5 on t4.category_id = t5.category_id
group by t5.name
order by (sum(t1.amount)) desc 
limit 5;

# 8b.) How would you display the view that you created in 8a?
select * from Top_Five;

# 8c.) You find that you no longer need the view `top_five_genres`. Write a query to delete it.
drop view if exists sakila.top_five;
