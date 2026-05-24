--Identify which columns have partial dependencies and what they depend on.
-----product_name and unit_price depends on product_id

--Design a 2NF-compliant schema: customers, products, orders, order_items.
--Write CREATE TABLE statements for all four tables.
CREATE TABLE customers (
  id   INTEGER  PRIMARY KEY AUTOINCREMENT,
  name TEXT     NOT NULL
);

CREATE TABLE products (
  id   INTEGER  PRIMARY KEY ,
  name TEXT     NOT NULL,
  unit_price REAL NOT NULL
);

CREATE TABLE orders(
  id   INTEGER PRIMARY KEY ,
  customer_id INTEGER NOT NULL,
  FOREIGN KEY (customer_id)REFERENCES customers (id)
);

CREATE TABLE order_items(
   order_id INTEGER NOT NULL,
   product_id   INTEGER,
   qty INTEGER DEFAULT 1 CHECK (qty > 0),
   PRIMARY KEY (order_id, product_id)
   FOREIGN KEY (order_id) REFERENCES orders(id),
   FOREIGN KEY (product_id) REFERENCES products(id)
  );
--Insert the data from the original table into your 2NF schema.
INSERT into customers (name)
VALUES
('Alice'), 
('Bob');

INSERT INTO products
VALUES
(42, 'Keyboard',49.99),
(77, 'Mouse', 29.99);

INSERT INTO orders
VALUES
(1001, 1),
(1002, 2);

INSERT INTO order_items
VALUES
(1001, 42, 2),
(1001, 77, 1),
(1002, 42, 1);
--Write a query to reproduce the original table's data using JOINs.
SELECT o.id as order_id, product_id, qty, c.name as customer_name, 
p.name as product_name,unit_price 
from order_items oi
JOIN orders o on o.id = oi.order_id
JOIN customers c on c.id = o.customer_id
JOIN products p on p.id = oi.product_id;

--Bonus: rename "Keyboard" to "Mechanical Keyboard" — in the bad table vs the 2NF table. How many rows changed in each?
UPDATE  products
SET name = 'Mechanical Keyboard'
where id = 42
--- in 2nf table changed one ROW
--- in bad table changes 2 rows
