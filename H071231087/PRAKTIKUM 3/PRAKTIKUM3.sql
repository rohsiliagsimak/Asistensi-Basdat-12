USE library;

#Nomor 1

INSERT INTO authors (name, nationality)
VALUES ('Tere Liye', 'Indonesian'), 
		 ('J.K. Rowling', 'British'),
		 ('Andrea Hirata', '');

SELECT * FROM authors		 

INSERT INTO books(isbn, title, author_id, published_year, genre, copies_available)
VALUES (704028970375, 'Ayah', 12, 2015, 'Fiction', 15),
		 (9780375704025, 'Bumi', 10, 2014, 'Fantasy', 5),
		 (8310371703024, 'Bulan', 10, 2015, 'Fantasy', 3),
		 (9780747532699, 'Harrry Potter and the Philosophers Stone', 11, 1997, NULL, 10),
		 (7210301703022, 'The Running Grave', 11, 2016, 'Fiction', 11);

SELECT * FROM books


INSERT INTO members (first_name, last_name, email, phone_number, join_date, membership_type)
VALUES ('John', 'Doe', 'John.doe@example.com', NULL, '2023-04-29', ''),
		 ('Alice', 'Johnson', 'alice.johnson@example.com', '123231231', '2023-05-01', 'Standar'),
		 ('Bob','Williams', 'bob.williams@example.com', '321321321','2023-06-20', 'Premium');

SELECT * FROM members 


INSERT INTO borrowings(member_id, book_id, borrow_date, return_date)
VALUES ((SELECT id FROM members WHERE first_name = 'John'), (SELECT id FROM books WHERE title = 'Harrry Potter and the Philosophers Stone'), '2023-07-10', '2023-07-25'),
		 ((SELECT id FROM members WHERE first_name = 'Bob'), (SELECT id FROM books WHERE title = 'Ayah'), '2023-08-01', NULL),
		 ((SELECT id FROM members WHERE first_name = 'Alice'), (SELECT id FROM books WHERE title = 'The Running Grave'), '2023-09-06', '2023-09-09'),
		 ((SELECT id FROM members WHERE first_name = 'Alice'), (SELECT id FROM books WHERE title = 'Bulan'), '2023-09-08', NULL),
		 ((SELECT id FROM members WHERE first_name = 'Bob'), (SELECT id FROM books WHERE title = 'Bumi'), '2023-09-10', NULL);


SELECT * FROM borrowings

#Nomor 2

UPDATE books
SET copies_available = copies_available - 1
WHERE id = 1 OR id = 2 OR id = 3;

SELECT * FROM books

#Nomor 3
UPDATE members 
SET membership_type = 'Standar'
WHERE id = 3;

DELETE FROM borrowings 
WHERE member_id = 2;

DELETE FROM members 
WHERE id = 2;

ALTER TABLE borrowings
DROP FOREIGN KEY borrowings_ibfk_1

ALTER TABLE borrowings 
ADD CONSTRAINT borrowings_ibfk_1 FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE 

SELECT * FROM borrowings 

SELECT * FROM members