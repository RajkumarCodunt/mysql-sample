-- Load orders (date format DD-MM-YYYY)
LOAD DATA INFILE '/csv-data/List of Orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@order_id, @order_date, @customer_name, @state, @city)
SET
    order_id      = @order_id,
    order_date    = STR_TO_DATE(@order_date, '%d-%m-%Y'),
    customer_name = @customer_name,
    state         = @state,
    city          = @city;

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
