-- Concatenate first name and country into one column
SELECT
  first_name,
  country,
  CONCAT(first_name, ' ', country) AS name_country
FROM customers;

-- Convert the first name to lowercase
SELECT
  first_name,
  country,
  CONCAT(first_name, ' ', country) AS name_country
  LOWER(first_name) AS low_name
FROM customers;

-- Convert the first name to uppercase
SELECT
  first_name,
  country,
  CONCAT(first_name, ' ', country) AS name_country,
  LOWER(first_name) AS low_name,
  UPPER(first_name) AS up_name
FROM customers;

-- Find customers whose first name contains leading or trailing spaces
SELECT
  first_name
FROM customers
WHERE first_name != TRIM(first_name);

SELECT
  first_name,
  LEN(first_name) len_name,
  LEN(TRIM(first_name)) len_trim_name,
  LEN(first_name) - LEN(TRIM(first_name)) flag
FROM customers
WHERE LEN(first_name) != LEN(TRIM(first_name));

-- Remove dashes (-) from a phone number
SELECT
'123-456-7890' AS phone,
REPLACE('123-456-7890', '-', '') AS clean_phone

-- Replace File Extence from txt to csv
SELECT
'report.txt' AS old_filename,
REPLACE('report.txt', '.txt', '.csv') AS new_filename

-- Calculate the length of each customer's first name
SELECT
  first_name,
  LEN(first_name) AS len_name
FROM customers;

-- Retrieve the first two characters of each first name
SELECT
  first_name,
  LEFT(TRIM(first_name), 2) AS first_2_char
FROM customers;

-- Retrieve the last two characters of each first name
SELECT
  first_name,
  RIGHT(first_name, 2) AS last_2_char
FROM customers;

-- Retrieve a list of customer's first names removing the first character
SELECT
  first_name,
  SUBSTRING(TRIM(first_name), 2, LEN(first_name)) AS sub_name
FROM customers;
