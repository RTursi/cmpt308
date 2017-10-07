-- Joe Tursi
-- Professor Labouseur
-- Lab5

-- #1
select a.city
from agents a, orders orders
where o.cid = 'c006'
and a.aid = o.aid

-- #2
select distinct pid
from customers c, orders o
where o.cid = c.cid
and c.city = 'Beijing'
order by pid desc;

-- #3
select name
from customers c
where not cid in(
select cid
from orders
);

-- #4
select c.name
from customers c left outer join orders o on c.cid = o.cid
where o.cid is null;

-- #5
select distinct c.name, a.name
from customers c, orders o, agents a
where a.aid =o.aid
and c.cid = o.cid
and c.city = a.city;

-- #6
select a.name, c.name, c.city
from customers c, agents a
where c.city = a.city


-- #7

select c.name, c.city
from customers c 
where city in(
select city
from products
group by city
order by count(pid) asc
);