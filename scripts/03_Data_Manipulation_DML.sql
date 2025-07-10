USE MyDatabase

INSERT INTO customers (id, first_name, country, score)
VALUES
  (6, 'Anna', 'USA', NULL),
  (7, 'Sam', NULL, 100);

INSERT INTO customers(id, first_name, country, score)
VALUES
  (8, 'USA', 'Max', NULL);

INSERT INTO customers
VALUES
  (9, 'Andreas', 'Germany', NULL);

INSERT INTO customers (id, first_name)
VALUES
  (10, 'Sarah');

-- Copy data from 'customers table into 'persons'
INSERT INTO persons (id, person_name, birth_date, phone)
SELECT 
id,
first_name,
NULL,
'Unknown'
FROM customers;

-- Change the sscore of customer with ID 6 to 0
UPDATE customers
SET score = 0
WHERE id = 6;

-- Change the score of customer with ID 10 to 0 and update the country to 'UK'
UPDATE cutomers
SET score = 0,
    country = 'UK'
WHERE id = 10;

-- Update all customers with a NULL score by setting their score to 0
UPDATE customers
SET score = 0
WHERE score IS NULL;

-- Delete all customers with an ID greater than 5
DELETE FROM customers 
WHERE id > 5;

-- Delete all data from the persons table
TRUNCATE TABLE persons;
