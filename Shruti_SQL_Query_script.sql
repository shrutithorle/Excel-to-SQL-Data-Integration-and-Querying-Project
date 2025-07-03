CREATE DATABASE OnlineBookstore 
USE OnlineBookstore

CREATE TABLE Books (
    Books_id serial PRIMARY KEY,
    Title VARCHAR(100),
	Author VARCHAR(100),
    Genre Varchar(50),
    Published_year int ,
    price Numeric(10,2),
    Stock int
);

DROP TABLE IF exists customers;
create table customer (
Customer_id serial PRIMARY KEY,
Name varchar(100),
Email varchar(100),
Phone varchar(15),
City Varchar(20),
Country varchar(20)
);

create table orders(
Order_ID serial primary key,
Customer_ID int references Customers(Customer_ID),
Book_ID INT references Books(Books_ID),
Order_date date,
Quantity int,
Total_amount numeric(10,2)
);
Select* from Books;
Select * from customers;
Select* from orders;
show tables;
rename table customer to Customers;
describe Books;

USE OnlineBookstore;
-- 1) Retrieve all books in the "Fiction" genre:
select Books_id
from books where genre='Fiction';

-- 2) Find books published after the year 1950:
select Books_id from Books where Published_year>1950;

-- 3) List all customers from the Canada:
select * from customers where country='Canada';

-- 4) Show orders placed in November 2023:
select * from orders where order_date between'2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books available:
select sum(Stock)  From Books;

-- 6) Find the details of the most expensive book:
select * from books order by price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select Customer_id from Orders where quantity>1

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from Orders where Total_amount>20;

-- 9) List all genres available in the Books table:
select distinct genre from books;

-- 10) Find the book with the lowest stock:
select Books_id from Books order by Stock asc limit 1;

-- 11) Calculate the total revenue generated from all orders:
select sum(Total_amount) from Orders;
-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
select genre , sum(Quantity) as Total_books_sold
from Orders as o join books as b on b.books_id=o.book_id 
group by b.genre;


-- 2) Find the average price of books in the "Fantasy" genre:
select avg(price) as Avg_price
from books where genre='Fantasy';


-- 3) List customers who have placed at least 2 orders:
select  o.Customer_id, count(order_id) As order_Count
from Customers as c join orders as o on c.customer_id=o.customer_id 
group by o.customer_id 
having order_count>=2;

-- 4) Find the most frequently ordered book:
select b.title, count(order_id) as Order_count
from Books as b join Orders as o on b.books_id=o.book_id
group by b.books_id,b.title
order by order_count desc limit 1; 

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select title,price
from books where genre='Fantasy'
order by price desc limit 3


-- 6) Retrieve the total quantity of books sold by each author:
select  author,sum(quantity) as total_books_sold
from books as b 
join orders as o on b.books_id=o.book_id 
group by author; 

-- 7) List the cities where customers who spent over $30 are located:
select city ,name , total_amount
from customers as c
join orders as o on c.customer_id=o.customer_id
where total_amount>30;

-- 8) Find the customer who spent the most on orders:
select customer_id , sum(total_amount) as total_spent
from orders
group by customer_id
order by total_spent desc
limit 1; 

