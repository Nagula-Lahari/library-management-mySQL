
-- Create database
CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

-- Books Table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    genre VARCHAR(100),
    publish_year INT,
    copies_available INT CHECK (copies_available >= 0)
);

-- Authors Table
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

-- Members Table
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    join_date DATE
);

-- Book-Authors Bridge Table (Many-to-Many)
CREATE TABLE book_authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

-- Loans Table
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    issue_date DATE,
    due_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Sample Authors
INSERT INTO authors (name) VALUES 
('J.K. Rowling'),
('George R.R. Martin'),
('J.R.R. Tolkien');

-- Sample Books
INSERT INTO books (title, genre, publish_year, copies_available) VALUES
('Harry Potter', 'Fantasy', 1997, 5),
('Game of Thrones', 'Fantasy', 1996, 3),
('The Hobbit', 'Adventure', 1937, 4);

-- Sample Members
INSERT INTO members (name, email, join_date) VALUES
('Alice', 'alice@gmail.com', CURDATE()),
('Bob', 'bob@gmail.com', CURDATE());

-- Link Books to Authors
INSERT INTO book_authors VALUES
(1, 1), (2, 2), (3, 3);

-- Insert Loan (borrowing)
INSERT INTO loans (book_id, member_id, issue_date, due_date)
VALUES (1, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 15 DAY));

-- Trigger to decrease available copies on loan
DELIMITER //

CREATE TRIGGER trg_decrease_copies
AFTER INSERT ON loans
FOR EACH ROW
BEGIN
    UPDATE books
    SET copies_available = copies_available - 1
    WHERE book_id = NEW.book_id;
END;
//

DELIMITER ;

-- View: Overdue Books
CREATE VIEW overdue_books AS
SELECT 
    l.loan_id,
    m.name AS member_name,
    b.title AS book_title,
    l.due_date
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b ON l.book_id = b.book_id
WHERE l.return_date IS NULL AND l.due_date < CURDATE();
