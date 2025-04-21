CREATE TABLE Books (
    Books_ID serial PRIMARY KEY,
    Title varchar(100),
    Author varchar(100),
    Genre varchar(50),
    Published_Year int,
    Price numeric(10,2),
    Stock int
);


CREATE TABLE Customers (
	Customer_ID SERIAL PRIMARY KEY,
	Name varchar(100),
	Email varchar(100),
	Phone varchar(15),
	City varchar(50),
	Country varchar(150)
	
);

CREATE TABLE Orders (
	Order_ID SERIAL PRIMARY KEY,
	Customer_ID int REFERENCES Customers(Customer_ID),
	Books_ID int REFERENCES Books(Books_ID),
	Order_Date DATE,
	Quantity int,
	Total_Amount numeric(10,2)	
	
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


--1) Retrieve all books in the "Fiction" genre:

SELECT * FROM Books 
WHERE Genre = 'Fiction';

--2) Find the books published after the year 1950:

SELECT * FROM books
where Published_Year >1950;

--3) List all customers from canada:

select * from customers 
where Country = 'Canada';

--4) Show orders placed in November 2023:

select * from orders 
where Order_Date Between '2023-11-01' and '2023-11-30';

--5) Retrieve the total stock of books available:

select SUM(Stock) as Total_Stock
from Books;

--6) Find the details of the most expensive book:

select * from books
order by Price desc 
limit 1;

--7) Show all customer who ordered more than 1 quantity of a book:

select * from orders 
where Quantity > 1;

--8) Retrieve all orders where the total amount exceeds $20:

select * from orders 
where Total_Amount > 20;

--9) List all genres available in the books table:

select Distinct genre from Books;

--10) Find the book with the lowest stock:

select * from books 
order by stock
limit 1;

--11) Calculate the total revenue generated from all orders:

select SUM(Total_Amount) as Revenue from Orders;

-- Advance Questions :

--1) Retrieve the total number of books sold for each genre:

select b.Genre, SUM(o.Quantity) 
from orders o 
join books b on o.books_id = b.books_id
group by b.Genre;

--2) Find the average price of books in the "Fantasy" genre:

select avg(Price) as Average_Price
from books
where Genre = 'Fantasy';

--3) List of customers who having placed at least 2 orders:

select o.customer_id, c.name,count(o.order_id) as order_count
from orders o
join customers c on o.customer_id = c.customer_id
group by o.customer_id, c.name
having count(order_id) >=2;

--4) find the most frequently ordered book :

select o.Books_id, b.Title, count(o.order_id) as ORDER_COUNT
from orders o
join books b on o.books_id = b.books_id
group by o.books_id,b.Title
order by ORDER_COUNT desc;

--5) show the top 3 most expensive books of 'Fantasy' Genre :

select * from books 
where genre = 'Fantasy'
order by price desc limit 3;

--6) retieve the total quantity of books sold by each author :


select b.author, sum(o.quantity) as Total_Books_sold 
from books b
join orders o on b.books_id = o.books_id
group by b.author;

--7) list the cities where customers who spent over $30 are located :

select distinct c.city, o.total_amount
from orders o 
join customers c on c.customer_id = o.customer_id
where o.total_amount > 30;

--8) find the customer who spent the most on orders :

select c.name, count(o.order_id), sum(o.total_amount) 
from customers c 
join orders o on c.customer_id = o.customer_id
group by c.name
order by sum(o.total_amount) desc;

--9) calculate the stock remaining after fulfilling all orders :

select b.books_id, b.title, b.stock, coalesce(sum(o.quantity),0) as Order_quantity,
	b.stock- coalesce(sum(o.quantity),0) as Remaining_Quantity
from books b
left join orders o on b.books_id = o.books_id
group by b.books_id 
order by b.books_id;

























