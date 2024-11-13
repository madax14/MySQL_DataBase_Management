CREATE SCHEMA mavenbearbulders;
USE mavenbearbulders;

# Creating frist table schema to import orders table
CREATE TABLE orders_items(
order_item_id bigint,
created_at datetime,
order_id bigint,
price_usd decimal(6,2),
congs_usd decimal(6,2),
website_session_id bigint,
PRIMARY KEY(order_item_id)
);

# Alter data type in the schema
ALTER TABLE orders_items
MODIFY created_at datetime;

SELECT * FROM orders_items;

# Checking data imported
SELECT 
min(created_at),
max(created_at)
FROM orders_items;	

# Creating new table schema to import antoher table
CREATE TABLE order_item_refund (
order_item_refund_id bigint,
created_at datetime,
order_item_id bigint,
order_id bigint,
refund_amount_usd decimal(6,2),
PRIMARY KEY(order_item_id)
);

# Alering the primary key
ALTER TABLE order_item_refund DROP PRIMARY KEY;
ALTER TABLE order_item_refund ADD PRIMARY KEY(order_item_refund_id);
# adding a foreign key that I forgot to add in the schema table
ALTER TABLE order_item_refund ADD foreign key(order_item_id) references orders_items(order_item_id);

SELECT * FROM order_item_refund;

# Removing wrong data from the dataset
DELETE FROM order_item_refund 
WHERE order_item_refund_id BETWEEN 6 AND 10;

#Creating a new table for products
CREATE TABLE products (
product_id BIGINT,
created_at DATETIME,
product_name VARCHAR(150),
PRIMARY KEY (product_id)
);

#Insert 2 new data to the products table
INSERT INTO products VALUES
(1, "2012-03-19 09:00:00", "The Original Mr. Fuzzy"), 
(2, "2013-01-06 13:00:00", "The Forever Love Bear");

SELECT * FROM products;

#Need to add a new column in the orders_items table to identify the product
ALTER TABLE orders_items ADD product_id BIGINT;

# Populating the data with the product_id
UPDATE orders_items SET product_id = 1 WHERE order_item_id > 0;

# Setting relationship between tables
# Setting the product_id from the product table AS FOREIGN KEY FOR THE ORDER_ITEMS TABLE 
ALTER TABLE orders_items ADD FOREIGN KEY(product_id) REFERENCES products(product_id);

# Deleting data that has been imported incorrectly.
DELETE FROM orders_items
WHERE order_item_id BETWEEN 2587 AND 3859;

#Imported data through UI Wizard
# Checking the amount records
SELECT count(*) FROM order_item_refund;
SELECT count(*) FROM orders_itemsd;

