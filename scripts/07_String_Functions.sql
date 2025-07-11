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
