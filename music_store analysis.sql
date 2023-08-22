-- Q1 who was senior most employee based on job title?

select * from employee
order by levels desc limit 1;

-- Q2 which countries have the most invoices?

select count(*) as c ,billing_country from invoice
group by billing_country
order by c desc;

-- Q3 What are top 3 values of total invoices? 

select total from invoice
order by total desc limit 3;



-- Q4 which cities has the best customers? we would like to throw a promotional  Music Festival 
-- in a city we made the most money. write a query that returns one city that has higgest sum of 
-- invoices total. return both the city name and sum of all invoices total

select * from invoice;
select billing_city  , sum(total) as total   from invoice
group by billing_city
order by total desc limit 1;


-- Q5 who was the best customer? the customer who has spent the most money will declared as best customer
-- write a query that return the person who has spent the most money

select c.customer_id ,c.first_name , c.last_name, sum(total) as total from invoice  i
join customer c on c.customer_id = i.customer_id
group by c.customer_id
order by total desc limit 3;


-- Q6  Write query to return the email,first name,last name and genre of all reck music listeners. Return your list orders alphabatically
-- by email starting from A 

select distinct c.email,c.first_name,c.last_name,g.name from customer c 
join invoice i on c.customer_id= i.customer_id
join invoice_line inv on inv.invoice_id = i.invoice_id
join track t on t.track_id = inv.track_id
join genre g on g.genre_id = t.genre_id 
 where g.name = "rock" 
 order by c.email;
 

 -- Q7 lets invite the artist who have written the most rock music . write a query 
 -- that return the artist name and total track count of the top 10 rock bands  
 
 select ar.name ,ar.artist_id, count(ar.artist_id) as songs_played
 from track t join album2  a 
 on a.album_id = t.album_id
 join artist ar on ar.artist_id = a.artist_id
 join genre g on g.genre_id = t.genre_id
 where g.name = "rock"
 group by ar.artist_id
 order by songs_played desc limit 10;
 
 
-- Q8 Return all the track names that have a song length longer than the avg song length.
-- return the name and millisec for each track .order by the song length with the longest songs 
-- listed first 

select name , milliseconds from track
where milliseconds > (select avg(milliseconds) as avg_track from track)
order by milliseconds desc ;

-- Q9 Find how much amount spent by each customer on artist write a query to return
-- customer name,artist name, total spent 

select c.customer_id, c.first_name,c.last_name,a.name as artist_name,sum(inl.unit_price*inl.quantity) as total
from artist a 
join album2 al
on a.artist_id = al.artist_id
join track t
on t.album_id = al.album_id
join invoice_line inl
on inl.track_id = t.track_id
join invoice i 
on i.invoice_id = inl.invoice_id
join customer c 
on c.customer_id = i.customer_id
group by c.customer_id 
order by total desc ;





-- Q10 write a query that return each country along with the top genre. for countries where the maximum
-- number of purchase is shared all genre


select i.billing_country as country ,count(quantity) as purchase, g.genre_id,g.name
from genre g
join track t on g.genre_id = t.genre_id
join invoice_line inv on t.track_id = inv.track_id
join invoice i on inv.invoice_id = i.invoice_id
group by country
order by purchase desc ;

-- Q11 write a query that determines the customer that has spent the most on music for each country
-- write a query that return the country along with the top customer and how they spent. 
-- for countries where the amount spent is shared provide all customers who spent this amount

select c.customer_id  ,max(billing_country) as country, first_name,last_name, sum(total) as amount_spend
from invoice i
join customer c on c.customer_id = i.customer_id
group by country
order by amount_spend desc;












