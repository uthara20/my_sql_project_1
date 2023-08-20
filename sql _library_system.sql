
CREATE DATABASE library;
USE library;
CREATE TABLE Branch (
Branch_no INT PRIMARY KEY,
Manager_Id INT,
Branch_address VARCHAR(255),
Contact_no VARCHAR(255));
CREATE TABLE Employee (
Emp_Id INT PRIMARY KEY,
Emp_name VARCHAR(255),
Position_ VARCHAR(255),
Salary DECIMAL(10,2));
CREATE TABLE Customer (Customer_Id INT PRIMARY KEY,Customer_name VARCHAR(255),
Customer_address VARCHAR(255),Reg_date DATE);
CREATE TABLE Books (ISBN INT PRIMARY KEY,Book_title VARCHAR(255),
Category VARCHAR(255),Rental_Price DECIMAL(10,2),Status ENUM('yes', 'no'),
Author VARCHAR(255),
Publisher VARCHAR(255));
CREATE TABLE IssueStatus (
Issue_Id INT PRIMARY KEY,Issued_cust INT,
Issued_book_name VARCHAR(255),Issue_date DATE,Isbn_book INT,
FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),FOREIGN KEY (Isbn_book)
 REFERENCES Books(ISBN));
CREATE TABLE ReturnStatus (Return_Id INT PRIMARY KEY,
Return_cust INT,Return_book_name VARCHAR(255), Return_date DATE,Isbn_book2 INT,
FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN));

-- inserting values to the table
INSERT INTO Branch VALUES 
  (1, 1, '123 Main St', '555-1234'),
  (2, 2, '456 Elm St', '555-5678'),
  (3, 3, '789 Oak St', '555-9012'),
  (4, 4, '1011 Pine St', '555-3456'),
  (5, 5, '1213 Maple St', '555-7890'),
  (6, 6, '1415 Cedar St', '555-2345'),
  (7, 7, '1617 Walnut St', '555-6789'),
  (8, 8, '1819 Birch St', '555-0123'),
  (9, 9, '2021 Spruce St', '555-4567'),
  (10, 10, '2223 Fir St', '555-8901');
  
INSERT INTO Employee VALUES 
  (1, 'John Doe', 'Manager', 50000),
  (2, 'Jane Smith', 'Assistant Manager', 40000),
  (3, 'Bob Johnson', 'Clerk', 30000),
  (4, 'Mary Brown', 'Clerk', 30000),
  (5, 'Tom Davis', 'Clerk', 30000),
  (6, 'Sue Wilson', 'Clerk', 30000),
  (7, 'Mike Lee', 'Ceo', 75000),
  (8, 'Ann Jones', 'Executive', 55000),
  (9, 'Bill Green', 'Clerk', 30000),
  (10,'Karen White','Clerk',30000);
  
INSERT INTO Customer VALUES 
   (1,'John Smith','123 Main St','2019-01-01'),
   (2,'Jane Doe','456 Elm St','2020-02-02'),
   (3,'Bob Brown','789 Oak St','2021-03-03'),
   (4,'Mary Johnson','1011 Pine St','2021-04-04'),
   (5,'Tom Wilson','1213 Maple St','2021-05-05'),
   (6,'Sue Davis','1415 Cedar St','2021-06-06'),
   (7,'Mike Lee','1617 Walnut St','2021-07-07'),
   (8,'Ann Jones','1819 Birch St','2021-08-08'),
   (9,'Bill Green','2021 Spruce St','2021-09-09'),
   (10,'Karen White','2223 Fir St','2021-10-10');
   
INSERT INTO IssueStatus VALUES 
   (1,1,'Book A','2023-06-06',100001),
   (2,2,'Book B','2022-02-02',100002),
   (3,3,'Book C','2023-06-06',100003),
   (4,4,'Book D','2022-04-04',100004),
   (5,5,'Book E','2021-05-05',100005),
   (6,6,'Book F','2019-06-06',100006),
   (7,7,'Book G','2018-07-07',100007),
   (8,8,'Book H','2022-08-08',100008),
   (9,9,'Book I','2022-09-09',100009),
   (10,10,'Book J','2022-10-10',100010);
   
INSERT INTO ReturnStatus VALUES 
   (1,1,'Book A','2023-06-06',100001),
   (2,2,'Book B','2022-02-02',100002),
   (3,3,'Book C','2023-06-06',100003),
   (4,4,'Book D','2022-04-04',100004),
   (5,5,'Book E','2021-05-05',100005),
   (6,6,'Book F','2019-06-06',100006),
   (7,7,'Book G','2018-07-07',100007),
   (8,8,'Book H','2022-08-08',100008),
   (9,9,'Book I','2022-09-09',100009),
   (10,10,'Book J','2022-10-10',100010);
   
INSERT INTO Books VALUES 
   (100001,'Book A','Fiction',10.00,'yes','Author A','Publisher A'),
   (100002,'Book B','Non-Fiction',20.00,'yes','Author B','Publisher B'),
   (100003,'Book C','History',30.00,'yes','Author C','Publisher C'),
   (100004,'Book D','Science',40.00,'yes','Author D','Publisher D'),
   (100005,'Book E','Biography',50.00,'yes','Author E','Publisher E'),
   (100006,'Book F','Mystery',60.00,'yes','Author F','Publisher F'),
   (100007,'Book G','Romance',70.00,'yes','Author G','Publisher G'),
   (100008,'Book H','Thriller',80.00,'yes','Author H','Publisher H'),
   (100009,'Book I','Comedy',90.00,'yes','Author I','Publisher I'),
   (100010,'Book J','Drama',100.00,'yes','Author J','Publisher J');

-- queries for following
-- 1.Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price
FROM Books WHERE Status = 'yes';
-- 2.List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;
-- 3.Retrieve the book titles and the corresponding customers who have issued those books.
SELECT Book_title, Customer_name
FROM Books b
JOIN IssueStatus i ON b.ISBN = i.Isbn_book
JOIN Customer c ON i.Issued_cust = c.Customer_Id;
-- 4.Display the total count of books in each category.
SELECT Category, COUNT(*) AS Total_Count
FROM Books
GROUP BY Category;
-- 5.Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name, Position_
FROM Employee
WHERE Salary > 50000;
-- 6.List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name 
FROM Customer c 
WHERE Reg_date < '2022-01-01' AND NOT EXISTS 
(SELECT * FROM IssueStatus i WHERE i.Issued_cust = c.Customer_Id);
-- 7.Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, COUNT(*) AS Total_Count_Employees 
FROM Employee 
GROUP BY Branch_no;
-- 8.Display the names of customers who have issued books in the month of June 2023.
SELECT Customer_name 
FROM Customer c 
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust 
WHERE MONTH(Issue_date) = 6 AND YEAR(Issue_date) = 2023;
-- 9.Retrieve book_title from book table containing history.
SELECT Book_title 
FROM Books 
WHERE Category = 'history';
-- 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT Branch.Branch_no, COUNT(*) AS Total_Employees
FROM Branch
Join Employee ON Branch.Manager_Id=Employee.Emp_Id
GROUP BY Branch.Branch_no
HAVING COUNT(*) > 5;
