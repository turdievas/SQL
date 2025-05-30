--1. Combine Two Tables
select p.firstName, p.lastName, ad.city, ad.state from person as p 
left join 
address as ad on p.personId=ad.personId
--2.Employees Earning More Than Their Managers
select emp.name from Employee as emp
inner join employee as m on m.id=emp.managerId 
where emp.salary>m.salary
--3.Duplicate Emails
select email
, Count(email)
from person
group by email
having  count(email)=2
--4.Delete Duplicate Emails
delete from person where id not in 
(select min(id) from person group by email)
--5.Find those parents who has only girls.
select distinct g.ParentName from  boys as b
 right join girls as g on b.ParentName=g.ParentName
where b.id is null
--6.Total over 50 and least
select custid,
sum(case when freight>50 then unitprice*qty 
else 0 end) as TotalSale
 from sales.orders as sale
join sales.OrderDetails as ordd on sale.orderid=ordd.orderid
group by custid
order by custid
--7. Carts
select isnull(c1.item, ' ') as c1, isnull(c2.item, ' ') as c2 from cart1 as c1
full join cart2 as c2 on c1.item=c2.item
--8. Customers Who Never Order
select cust.name from customers as cust
 left join  orders as ord on cust.id=ord.customerId
 where ord.customerId is null
 --9.Students and Examinations
 select st.student_id, st.student_name, sub.subject_name, COUNT(ex.subject_name) 
 from students as st 
 cross join subjects as sub
 left join Examinations as ex on st.student_id=ex.student_id and sub.subject_name=ex.subject_name
 group by st.student_id, st.student_name, sub.subject_name
 order by st.student_id
