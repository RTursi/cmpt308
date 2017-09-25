
#Joe Tursi

#1. works!!!!!!!!!
		
Select distinct city
from agents
Where aid in  (Select aid
	      From orders
	      Where cid = 'c006');



 # 2. cant figure out the ordr
 
 select distinct pid 
 from Orders 
where aid in (
      
      select aid from Orders
      where cid in
      	    (
		select cid from Customers
		where city = 'Beijing'
           order by pid desc ));

#3. works!!!!

Select distinct cid, name 
from Customers
where cid not in (
      select distinct cid from orders
      where aid = 'a03');

#4.  works!!
select distinct cid 
from Customers
where cid in (
      select cid from Orders
      where pid = 'p01' or pid = 'p07');

#5. 

select distinct pid 
from Orders
where cid not in (
      select cid from Orders
      where  aid = 'a03' or aid = 'a02'
	  ORDER by pid desc
);
     

#6. works!!! 	

select name, discountPct 
from Customers
where cid in (
      select cid from Orders
      where aid in (
      	    select aid from Agents
	    where city = 'Tokyo' or city = 'New York'));

# 7. eh 

select * 
from Customers
where discountPct in(
	select distinct discountPct
	from customers
	where city in ('Duluth', 'London')
)
	and city not in('Duluth', 'London');

#8. 
/*
A check constraint is a rule that enforces rules in certain column values for data in a row. 
Check constraints help enforce domain integrity. The advantages of check constraints is the ability to enforce a rule. 
By limiting data to specific values which ensures reliability of the data in the table. 
By using check constraints you can control what your database contains and what passes the constraints. 
You can use a check constraint on a “create table” statement, in a payroll table you could make a constraint to make it so your table only has monthly and annual values in wage column. 
In another table you could put a check constraint on the minimal salary that is allowed in your column or table.
 A bad example of a check constraint could be putting a constraint on a table that doesn’t consist of a specific data type. 
 If you have a constraint on the alphabet from a-d, and a number is implemented then there is no constraint or bound.







