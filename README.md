# SQL-Project 
## Library Management System**
This project is a simple Library Management System database implemented in MySQL. It provides a relational database schema to manage various aspects of a library system, including publishers, borrowers, library branches, books, book authors, book copies, and book loans.

## Table of Contents**
  Introduction
  Schema Overview
  Queries
  Usage
 Contributing
 License
 
### Introduction**
The Library Management System is designed to efficiently manage the operations of a library, including tracking books, borrowers, and loans. This project aims to provide a robust database schema and a set of SQL queries for common library management tasks.

### Schema Overview**
The database schema consists of the following tables:

**tbl_publisher**: Stores information about book publishers.
**tbl_borrower**: Stores information about library borrowers.
**tbl_library_branch**: Contains details about library branches.
**tbl_book**: Stores information about books, including their titles and publishers.
**tbl_book_authors**: Maps authors to books.
**tbl_book_copies**: Tracks the number of copies of each book available at each library branch.
**tbl_book_loans**: Records details of book loans, including loan dates, due dates, and borrowers.

### Queries
Several SQL queries are provided to perform common library management tasks, including:

1. Retrieving the total number of copies of a specific book owned by a particular library branch.
2. Finding the total number of copies of a book owned by each library branch.
3. Retrieving the names of borrowers who do not have any books checked out.
4. Finding details of books loaned out from a specific library branch on a given due date.
5. Retrieving the total number of books loaned out from each library branch.
6. Finding details of borrowers who have more than five books checked out.
7. Retrieving details of books authored by a specific author and owned by a particular library branch.
Usage

To use this project, you can simply import the provided SQL script (library_database.sql) into your MySQL database. Once imported, you can execute the provided queries to perform various library management tasks.

### Entity-Relationship (ER) Diagram
The Entity-Relationship (ER) diagram provides a visual representation of the database schema used in this project. It illustrates the entities (such as tables) in the database, their attributes, and the relationships between them. Viewing the ER diagram can help users understand the structure of the database and how different entities are connected.

For a visual representation of the database schema, please refer to the [ER Diagram](link-to-your-er-diagram-page) page.

### Contributing
Contributions to this project are welcome. If you have any suggestions for improvements or new features, feel free to open an issue or submit a pull request.

### License
This project is licensed under the MIT License.
