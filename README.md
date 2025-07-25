
# Library Management System

![ER Diagram](project%20library%20management.png)

A SQL-based Library Management System designed to manage books, authors, members, and loan records efficiently. This project includes database schema design, sample data, triggers, and views to automate library operations.

## Features

- **Book Management**: Track book details like title, genre, publication year, and available copies.
- **Author Management**: Store author information and link them to books (many-to-many relationship).
- **Member Management**: Record member details, including email and join date.
- **Loan Tracking**: Manage book loans with issue, due, and return dates.
- **Automation**: Trigger to decrease available copies when a book is loaned.
- **Overdue Tracking**: View to identify overdue books.

## Database Schema

### Tables

1. **books**: Stores book information.
   - `book_id`, `title`, `genre`, `publish_year`, `copies_available`

2. **authors**: Stores author information.
   - `author_id`, `name`

3. **members**: Stores member information.
   - `member_id`, `name`, `email`, `join_date`

4. **book_authors**: Bridge table for many-to-many relationship between books and authors.
   - `book_id`, `author_id`

5. **loans**: Tracks book loans.
   - `loan_id`, `book_id`, `member_id`, `issue_date`, `due_date`, `return_date`

### Views

- **overdue_books**: Lists all overdue books with member and book details.

### Triggers

- **trg_decrease_copies**: Automatically decreases `copies_available` when a book is loaned.

## Setup

1. **Database Creation**: Run the SQL script `library_management_system.sql` in your MySQL server to create the database and tables.
   ```sql
   mysql -u [username] -p < library_management_system.sql
   ```

2. **Sample Data**: The script includes sample data for books, authors, and members to get started.

## Usage

### Example Queries

1. **List all books with their authors**:
   ```sql
   SELECT b.title, a.name AS author 
   FROM books b 
   JOIN book_authors ba ON b.book_id = ba.book_id 
   JOIN authors a ON ba.author_id = a.author_id;
   ```

2. **Check overdue books**:
   ```sql
   SELECT * FROM overdue_books;
   ```

3. **Borrow a book**:
   ```sql
   INSERT INTO loans (book_id, member_id, issue_date, due_date) 
   VALUES (1, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 15 DAY));
   ```

## Project Report

For detailed insights into the project, refer to the [Library Management System Project Report](Library%20Management%20System%20Project%20Report.pdf).

## Tools Used

- MySQL Server
- MySQL Workbench
- SQL

## Author

**Nagula Lahari**  
Internship Project Phase (Jul 2025)

## License

This project is open-source and available under the MIT License.
``` 

This `README.md` provides a comprehensive overview of the project, including setup instructions, usage examples, and links to relevant files. It is ready to be posted on GitHub.
