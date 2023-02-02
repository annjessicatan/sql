-- MySQL DATABASE ADMINISTRATION BASICS: FINAL COURSE PROJECT

/*
THE SITUATION: A new client, Bubs Glover, the owner of Bubs’ Bigtime Baby Booties, has reached out to you for help building his business a database from the ground up.

THE OBJECTIVE: Use Your MySQL Database Administration skills to:
Design a database from scratch, which will capture information about Bubs’ customers, the purchases they make, his products, and his employees.
*/



/*
1. Bubs wants you to track information on his customers (first name, last name, email), 
his employees (first name, last name, start date, position held), his products, 
and the purchases customers make (which customer, when it was purchased, for how much money). 
Think about how many tables you should create. 
Which data goes in which tables? How should the tables relate to one another?
*/

-- table: customers
	-- customer_id
    -- first_name
    -- last_name
    -- email

-- table: employees
	-- employee_id
    -- first_name
    -- last_name
    -- start_date
    -- position

-- table: products
	-- product_id
    -- product_name
    -- launched_date
    
-- table: customer_purchases
	-- customer_purchase_id
    -- product_id
    -- customer_id
    -- employee_id
    -- purchased_at
    -- amount_usd
    


/*
2. Given the database design you came up with, use Workbench to create an EER diagram of the database. 
Include things like primary keys and foreign keys, and anything else you think you should have in the tables. 
Make sure to use reasonable data types for each column.
*/

-- check this link: https://github.com/annjessicatan/SQL/blob/main/Final%20Course%20Project%20EEP%20Diagram.mwb



/*
3. Create a schema called bubsbooties. Within that schema, create the tables that you have diagramed out. 
Make sure they relate to each other, and that they have the same reasonable data types you selected previously.
*/

CREATE SCHEMA bubsbooties;

USE bubsbooties;

/*
CREATING TABLES USING UI TOOL:

CREATE TABLE `bubsbooties`.`customers` (
  `customer_id` BIGINT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`));
  
  CREATE TABLE `bubsbooties`.`employees` (
  `employee_id` BIGINT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `start_date` DATE NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employee_id`));

CREATE TABLE `bubsbooties`.`products` (
  `product_id` BIGINT NOT NULL,
  `product_name` VARCHAR(45) NOT NULL,
  `launched_date` DATE NOT NULL,
  PRIMARY KEY (`product_id`));
  
  CREATE TABLE `bubsbooties`.`customer_purchases` (
  `customer_purchase_id` BIGINT NOT NULL,
  `customer_id` BIGINT NOT NULL,
  `employee_id` BIGINT NOT NULL,
  `product_id` BIGINT NOT NULL,
  `purchased_at` TIMESTAMP NOT NULL,
  `amount_usd` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`customer_purchase_id`))
COMMENT = '		';
*/




/*
4. Add any constraints you think your tables’ columns should have. 
Think through which columns need to be unique, which ones are allowed to have NULL values, etc.
*/

/*
ALTER TABLE `bubsbooties`.`customers` 
ADD UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE;
;

ALTER TABLE `bubsbooties`.`products` 
ADD UNIQUE INDEX `product_name_UNIQUE` (`product_name` ASC) VISIBLE;
;
*/




/*
5. Insert at least 3 records of data into each table. 
The exact values do not matter, so feel free to make them up. 
Just make sure that the data you insert makes sense, and that the tables tie together.
*/

SELECT * FROM customers;

INSERT INTO customers VALUES
('1', 'Gintoki', 'Sakata', 'gintokisakata@gmail.com'),
('2', 'Kagura', 'Chan', 'kagurachan@gmail.com'),
('3', 'shinpachi', 'Shimura', 'patsusan@gmail.com')
;

SELECT * FROM employees;

INSERT INTO employees VALUES
('1', 'Zhan', 'Xiao', '2018-10-05', 'manager'),
('2', 'Yibo', 'Wang', '2019-08-05', 'supervisor'),
('3', 'Suo', 'Wang', '2022-09-05', 'staff_member')
;


SELECT * FROM products;

INSERT INTO products VALUES
('1', 'Skateboard', '2018-12-28'),
('2', 'Ice Berry', '2018-03-28'),
('3', '3 + 1 Biscuit', '2018-03-28')
;


SELECT * FROM customer_purchases;

INSERT INTO customer_purchases VALUES
('1', '3', '1', '3', '2021-05-19', '3.49'),
('2', '2', '2', '2', '2020-12-09', '1.50'),
('3', '1', '1', '1', '2023-01-01', '182.30')
;



/*
6. Create two users and give them access to the database. 
The first user, TuckerReilly, will be the DBA, and should get full database administrator privileges. 
The second user, EllaBrody, is an Analyst, and only needs read access.
*/

-- Click Admin tab
-- Click Users and Privileges then add accounts with passwords for TuckerReilly and EllaBrody
-- Cick Administrative Roles (DBA for TuckerReilly, Custom role: Select and Create Temporary tables for EllaBrody)
