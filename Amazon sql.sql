use amazon;
Select* from customers;
Select* from order_details; 
Select* from products; 
# Task 1 and 2 -Create er diagram and describe the relationship 

#Task 3
Select*from customers
where city="Johnfurt";

Select*from products 
where Category="Fruits";


#Task 4--Recreate table with customer id as primary key , name with unique constraint, age not null and must be above 18 
CREATE TABLE Customers2 (
    CustomerID CHAR(36) PRIMARY KEY,
    Name VARCHAR(100) UNIQUE,
    Age INT NOT NULL CHECK (Age > 18),
    Gender VARCHAR(10),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    SignupDate DATE,
    PrimeMember VARCHAR(3)
);
Select*from customers2; 

#Task 5---Insert 3 new rows into the Products table using INSERT statements.
Select*from products where productname= "Golden apple";
Insert into products values 
('5bb1f482-2fd4-4c87-9ac4-122345abc789', 'Golden Apple', 'Fruits', 'Sub-Fruits-2', 150, 120, '1234abcd-56ef-78gh-90ij-klmnopqrstuv'),
('8cc2a593-3fe5-4d98-ab56-234567def890', 'Organic Mango', 'Fruits', 'Sub-Fruits-3', 95, 200, '2345bcde-67fg-89hi-01jk-lmnopqrstuvw'),
('9dd3b6a4-4gf6-5e09-bc67-345678fgh901', 'Fresh Grapes', 'Fruits', 'Sub-Fruits-4', 300, 180, '3456cdef-78gh-90ij-12kl-mnopqrstuvwx');

#Task6-Update the stock quantity of a product where ProductID matches a specific ID.
Select* from products;

update products
Set stockquantity=300
where productid= '2aa28375-c563-41b5-aa33-8e2c2e0f4db9'; 

#Task 7-Delete a supplier from the Suppliers table where their city matches a specific value.
Delete from suppliers
where city= 'Schneidermouth'; 
 
#Task 8.1--Add a CHECK constraint to ensure that ratings in the Reviews table are between 1 and 5.
Select*from reviews;
Alter table reviews 
Add constraint check_rating_range
Check (Rating between 1 and 5); 

#Task 8.2--Add a DEFAULT constraint for the PrimeMember column in the Customers table (default value: "No").
Select*from customers;
Alter table customers
alter column primemember set default 'No'; 

#Task 9.1--WHERE clause to find orders placed after 2024-01-01.
Select*from orders
Where orderdate>'2024-01-01';

#Task 9.2-HAVING clause to list products with average ratings greater than 4.
Select productid,
avg(Rating) as averagerating
from reviews 
group by ProductID
having avg(Rating)>4; 

#Task 9.3--GROUP BY and ORDER BY clauses to rank products by total sales.
SELECT 
    p.ProductName,
    SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM order_details od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales DESC;


#Task 10.1--Calculate each customer's total spending.
SELECT 
    customerid,
    SUM(OrderAmount + DeliveryFee - DiscountApplied) AS TotalSales
FROM Orders
GROUP BY CustomerID
ORDER BY TotalSales DESC;

#10.2--Rank customers based on their spending.
SELECT 
    CustomerID,
    SUM(OrderAmount + DeliveryFee - DiscountApplied) AS TotalSpending,
    RANK() OVER (ORDER BY SUM(OrderAmount + DeliveryFee - DiscountApplied) DESC) AS SpendingRank
FROM Orders
GROUP BY CustomerID
ORDER BY SpendingRank;

#10.3--Identify customers who have spent more than ₹5,000.
SELECT 
    CustomerID,
    SUM(OrderAmount + DeliveryFee - DiscountApplied) AS TotalSpending
FROM Orders
GROUP BY CustomerID
HAVING SUM(OrderAmount + DeliveryFee - DiscountApplied) > 5000
ORDER BY TotalSpending DESC;

#11.1-Join the Orders and OrderDetails tables to calculate total revenue per order.
SELECT
    o.OrderID,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM
    Orders AS o
JOIN
    Order_Details AS od ON o.OrderID = od.OrderID
GROUP BY
    o.OrderID
ORDER BY
    TotalRevenue DESC;
    
#11.2--Identify customers who placed the most orders in a specific time period.
Select customerid, count(OrderID) as total from orders
where orderdate >='2025-01-01'
group by customerid
order by total;

#11.3-Find the supplier with the most products in stock.(Supplier and product id have different number of id)
Select supplierid,StockQuantity from products order by StockQuantity desc limit 10; 



#12.1--Identify the top 3 products based on sales revenue.
Select p.productID,p.productName,od.Totalrevenue from products p join (
select ProductID,sum(quantity*unitprice) as Totalrevenue from order_details group by productID) od on p.productID = od.productID
order by od.Totalrevenue desc limit 3; 


#12.2--Find customers who haven’t placed any orders yet.
Select c.customerID, c.name from customers c
left join orders o on c.customerID = o.customerID where orderID is null; 

select c.customerID,c.name from customers c where c.customerID not in (select o.customerID from orders o);

#13--Which cities have the highest concentration of Prime members?
SELECT 
    City, 
    COUNT(*) AS PrimeMemberCount
FROM Customers
WHERE PrimeMember = 'Yes'
GROUP BY City
ORDER BY PrimeMemberCount DESC;

#13.2--What are the top 3 most frequently ordered categories?
SELECT 
    p.Category,
    SUM(od.Quantity) AS TotalOrdered
FROM order_details od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY TotalOrdered DESC
Limit 3;







