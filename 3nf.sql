--Check: is this table in 1NF? Explain why.
---the table has fk author id, each book has an author

--Check: is this table in 2NF? Explain why (single-column PK).
--- every author has a couple of books

--Identify all transitive dependencies in the table.
---author name depends on author id, publisher name and publisher city depends on publisher id

--Design a 3NF schema with tables: books, authors, publishers.
--Write CREATE TABLE statements for all three tables with proper PKs and FKs.
CREATE TABLE authors(
id TEXT PRIMARY KEY,
name TEXT NOT NULL
);
CREATE TABLE publishers(
id TEXT PRIMARY KEY,
name TEXT NOT NULL,
publisher_city TEXT not NULL
);

CREATE TABLE book(
isbn TEXT PRIMARY KEY,
title TEXT NOT NULL,
author_id TEXT NOT NULL,
publisher_id TEXT NOT NULL,
FOREIGN KEY (author_id) REFERENCES authors (id)
FOREIGN KEY (publisher_id) REFERENCES publishers (id)
);


--Insert the original data into the normalized tables.
INSERT INTO authors
VALUES
('A1', 'Jane Doe'),
('A2', 'John Smith');

INSERT INTO publishers
VALUES
('P1', 'TechPress', 'New York'),
('P2', 'DataBooks','Paris' );


INSERT INTO book
VALUES
('978-1', 'SQL Mastery', 'A1','P1'),
('978-2', 'Python Pro','A2','P1' ),
('978-3', 'Data Viz','A1', 'P2');

--Write a query to reproduce all original columns using JOINs.
SELECT isbn, title, author_id, a.name as author_name, publisher_id, 
p.name as publisher_name, publisher_city
FROM book b
JOIN authors a on a.id = b.author_id
JOIN publishers p on p.id = b.publisher_id;


--Bonus: Change Jane Doe's name to "Jane Doe-Smith" — how many rows change in the 3NF vs original schema?

UPDATE  authors
SET name = 'Jane Doe-Smith'
where id = 'A1'
--in 3nf one row changed, in original schema two rows changed
