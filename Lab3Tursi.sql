1. 
select  
ordno,totalUSD from orders;

2. 
select name,city
From Agents
Where name = 'Smith' AND city = 'New York';

3. 
select name, pid, priceUSD 
from Products
Where qty >= 200010 OR qty > 200010;

4.
select name, city
from Customers
Where city = 'Duluth'

5.
select name
from agents
Where city NOT IN ('New York', 'Duluth');

6.
select *
from products
Where city NOT IN ('Dallas', 'Duluth')
AND priceUSD >= 1;

7. select *
from Orders
Where month = 'March' AND month = 'May'; 

8.
select *
from Orders
Where month = ('February')
AND totalUSD >= 500;

9.
select OrdNo
from Orders
Where cid = ('C005');



