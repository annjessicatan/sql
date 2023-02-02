/*
THE SITUATION: You have just been hired by a small database consulting shop. You will be working on projects 
for various clients to help them get their databases built and optimized for business.

THE BRIEF: As a member of the consulting team, you will be asked to perform database services for
various clients. Sometimes you will work with existing databases and tables to make small improvements, and 
other times you will need to set up a database for clients from the ground up. 

THE OBJECTIVE: THE Use MySQL Workbench to:
• Create databases and tables your clients will need to run their businesses
• Use your knowledge of database best practices to implement and optimize database design principles
• Update records, create indexes, triggers, and stored procedures, and manage users and permissions
*/



-- ASSIGNMENT: CREATE NEW SCHEMA AND TABLES
/*
1. Create a new schema, called ‘toms_marketing_stuff’
2. Add a table called ‘publishers’, with two columns: 
‘publisher_id’ (integer) and ‘publisher_name’ (up to 65 chars)
3. Add another table called ‘publisher_spend’ with 
‘publisher_id’ (integer), ‘month’ (date), and spend (decimal)
*/

CREATE SCHEMA toms_marketing_stuff DEFAULT CHARSET utf8mb4;

USE toms_marketing_stuff;

CREATE TABLE publishers(
	publisher_id INT,
    publisher_name VARCHAR(65),
	PRIMARY KEY (publisher_id)
);

SELECT * FROM publishers;

SELECT * FROM publisher_spend; -- created using UI tool
/*
CREATE TABLE `publishers` (
  `publisher_id` int NOT NULL,
  `publisher_name` varchar(65) DEFAULT NULL,
  PRIMARY KEY (`publisher_id`)
  */
  
  
  
/*
ASSIGNMENT: ADDING AND REMOVING COLUMNS
I have some basic tables set up in my ‘candystore’ schema, but I need some help updating some of the tables before my 
employees can get access and start using this more widely. 

1. Can you remove the hourly_wage column from the employees table? (I need it hidden before I can share out)
2. Can you add a column to the employees table called ‘avg_customer_rating’? (decimal to one digit)
*/

USE candystore;

SELECT * FROM employees;

ALTER TABLE employees
DROP COLUMN hourly_wage;

ALTER TABLE employees
ADD COLUMN avg_customer_rating DECIMAL(10,1) AFTER position; 



/* 
ASSIGNMENT: DROPPING SCHEMAS AND TABLES
We’re almost ready to share our ‘candystore’ schema for all employees to use. Can you please help me with the following?
1. Drop the table ‘candy_products’. I don’t want my employees knowing my margins.
2. Drop the schema ‘candystore_old’. This is an old copy that is now out of date, so we don’t need to maintain it.
*/

DROP TABLE candy_products;

DROP SCHEMA candystore_old;



/*
ASSIGMENT: INSERTING AND UPDATING RECORDS

From: Amy Baker (owns the candy store)
Subject: Help Updating Some Data Records

Exciting news! I have hired two new employees, who both started on March 15th, 2020. They are both clerks. Their
names are Charles Munger and William Gates. Could you add them to the employees table for me?
Could you also update the avg_customer_rating column? The average ratings for employees 1-6 are 4.8, 4.6, 4.75, 4.9, 4.75,
and 4.2, respectively. The two new clerks are both at 5.0. 
*/

SELECT * FROM employees;

INSERT INTO employees VALUES
(7, 'Munger', 'Charles', '2020-03-15', 'Clerk', 5.0),
(8, 'Gates', 'William', '2020-03-15', 'Clerk', 5.0);

UPDATE employees
SET avg_customer_rating = 4.8
WHERE employee_id = 1;

UPDATE employees
SET avg_customer_rating = 4.6
WHERE employee_id = 2;

UPDATE employees
SET avg_customer_rating = 4.75
WHERE employee_id;

UPDATE employees
SET avg_customer_rating = 4.9
WHERE employee_id = 4;

UPDATE employees
SET avg_customer_rating = 4.2
WHERE employee_id = 6;



/*
ASSIGNMENT: DELETING RECORDS
I have a situation I need your help with. One of my employees, Margaret Simpson, was recently caught generating fake
customer reviews to boost her score. I would like you to…

1. Delete her record from the employees table
2. Remove all data from the customer reviews table but
preserve the table structure (we want to start fresh)
*/

SELECT * FROM employees;

SELECT @@autocommit;

SET autocommit = OFF;
-- ON, OFF
-- 0, 1

DELETE FROM employees
WHERE employee_id = 4;

-- ROLLBACK; 

COMMIT; 

SELECT * FROM customer_reviews;

DELETE FROM customer_reviews
WHERE customer_review_id BETWEEN 1 AND 33; -- using safemode, set a primary key

/*
ALTER TABLE `candystore`.`customer_reviews` 
ADD PRIMARY KEY (`customer_review_id`);
*/

rollback;

TRUNCATE TABLE customer_reviews; -- no rollback coz it's Data Definition Language (TRUNCATE/TRUNCATE TABLE)



/*
ASSIGNMENT: TABLE RELATIONSHIPS

From: Emily Trapp (Owner, Online School)
Subject: Help Understanding My Tables

Would you be able to help me out? I have 3 tables in my
‘onlinelearningschool’ schema and would like to understand
how they are related. For each table, could you please:

1) Tell me what the primary key is, and whether there are
any foreign keys
2) Explain how the tables relate to each other and what
type of relationship exists (one-to-one, one-to-many, etc.)
*/

USE onlinelearningschool;

SELECT * FROM course_ratings;
-- Primary key: rating_id
SELECT * FROM course_ratings_summaries;
-- foreign_key: course_id
SELECT * FROM courses;
-- type of relationship: one-to-many