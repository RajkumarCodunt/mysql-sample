CREATE TABLE orders (
    order_id      VARCHAR(20)   PRIMARY KEY,
    order_date    DATE,
    customer_name VARCHAR(100),
    state         VARCHAR(100),
    city          VARCHAR(100)
);

CREATE TABLE order_details (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    order_id     VARCHAR(20),
    amount       DECIMAL(10, 2),
    profit       DECIMAL(10, 2),
    quantity     INT,
    category     VARCHAR(100),
    sub_category VARCHAR(100),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE sales_targets (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    order_month VARCHAR(10),
    category    VARCHAR(100),
    target      DECIMAL(12, 2)
);

CREATE INDEX idx_order_details_order    ON order_details(order_id);
CREATE INDEX idx_order_details_category ON order_details(category);
CREATE INDEX idx_sales_targets_category ON sales_targets(category);
