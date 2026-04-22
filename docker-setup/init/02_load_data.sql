-- Load orders via staging table to skip blank rows
CREATE TEMPORARY TABLE orders_tmp (
    order_id      VARCHAR(20),
    order_date    VARCHAR(20),
    customer_name VARCHAR(100),
    state         VARCHAR(100),
    city          VARCHAR(100)
);

LOAD DATA INFILE '/csv-data/List of Orders.csv'
INTO TABLE orders_tmp
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

INSERT INTO orders (order_id, order_date, customer_name, state, city)
SELECT
    order_id,
    CASE WHEN order_date = '' THEN NULL ELSE STR_TO_DATE(order_date, '%d-%m-%Y') END,
    customer_name,
    state,
    city
FROM orders_tmp
WHERE order_id IS NOT NULL AND order_id != '';

DROP TEMPORARY TABLE orders_tmp;

-- Load order details
LOAD DATA INFILE '/csv-data/Order Details.csv'
INTO TABLE order_details
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, amount, profit, quantity, category, sub_category);

-- Load sales targets
LOAD DATA INFILE '/csv-data/Sales target.csv'
INTO TABLE sales_targets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_month, category, target);
