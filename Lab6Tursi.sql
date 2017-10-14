-- Joe Tursi
-- Professor Labousuer
-- Database Systems
-- Lab6


-- 1

select name, city
from customers
where city in (
	select city
	from products 
	group by city
	order by count(products.city) 
	desc
	limit 1
);

-- 2

select name
from products p
where priceUSD >(
	select avg(priceUSD)
	from products)
	order by name desc; 
-- 3

select customers.name, orders.pid, orders.totalusd
from orders 
inner join customers
on orders.cid = customers.cid
order by orders.totalusd asc;

-- 4
select customers.name, coalesce(sum(orders.quantity), 0) as TotalOrdered
from orders
right outer join customers
on orders.cid = customers.cid
group by customers.name
order by customers.name desc;

--this returns the query but the column name is coalesce?

-- 5

select customers.name as customer, products.name as product, agents.name as agent
from orders
inner join customers
on orders.cid = customers.cid
inner join products
on orders.pid = products.pid
inner join agents
on orders.aid = agents.aid
where agents.city = 'Newark';

-- 6

select *
from (select o.*, o.quantity*p.priceusd*(1-(discountpct/100)) as truedollars
      from orders o
      inner join products p on o.pid = p.pid
      inner join customers c on o.cid = c.cid) as tmptable
where totalusd != truedollars;


-- 7 
-- Ignore this just for my understanding
-- If we have two tables,Table A and Table B for example,
-- a full outer join would produce the set of all records in Table A and Table B,
-- with matching records from both sides where avaiable. If there is no match, the missing side will have null.

--Answer
-- A left outer join would produce a complete set of records from table A, with the matching records in Table B, 
-- if there is no match the right side will be null.
-- The same concept applies for a right outer join, it would produce the set of records from table B, with the matching records in table A. 
-- if there is no match, the left side will contain null.

-- EX
-- For this example agents would be table A, and orders is table B, so this 
-- returns the values for all of AGENTS with the matching records from orders which is just aid. 
--  Every other column is left null from orders.


select *
from agents
left outer join orders
on orders.totalusd = agents.commission;


select *
from agents
right outer join orders
on orders.totalusd = agents.commission;
-- same idea for the this right outer join but its flipped. So all the values from 
-- orders and any matching records from agents are returned. The rest is left null





