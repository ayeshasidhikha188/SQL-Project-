CREATE database Library;

USE Library;

CREATE TABLE tbl_publisher (
    publisher_PublisherName VARCHAR(255) PRIMARY KEY,
    publisher_PublisherAddress VARCHAR(255),
    publisher_PublisherPhone VARCHAR(15)
);

CREATE TABLE tbl_borrower (
    borrower_CardNo INT PRIMARY KEY,
    borrower_BorrowerName VARCHAR(255),
    borrower_BorrowerAddress VARCHAR(255),
    borrower_BorrowerPhone VARCHAR(15)
);

CREATE TABLE tbl_library_branch (
    library_branch_BranchID INT PRIMARY KEY AUTO_INCREMENT,
    library_branch_BranchName VARCHAR(255),
    library_branch_BranchAddress VARCHAR(255)
);

CREATE TABLE tbl_book (
    book_BookID INT PRIMARY KEY,
    book_Title VARCHAR(255),
    book_PublisherName VARCHAR(255),
    FOREIGN KEY (book_PublisherName)
        REFERENCES tbl_publisher (publisher_PublisherName)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_book_authors (
    book_authors_AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    book_authors_BookID INT,
    book_authors_AuthorName VARCHAR(255),
    FOREIGN KEY (book_authors_BookID)
        REFERENCES tbl_book (book_BookID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_book_copies (
    book_copies_CopiesID INT PRIMARY KEY AUTO_INCREMENT,
    book_copies_BookID INT,
    book_copies_BranchID INT,
    book_copies_No_Of_Copies INT,
    FOREIGN KEY (book_copies_BookID)
        REFERENCES tbl_book (book_BookID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (book_copies_BranchID)
        REFERENCES tbl_library_branch (library_branch_BranchID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_book_loans (
    book_loans_LoansID INT PRIMARY KEY AUTO_INCREMENT,
    book_loans_BookID INT,
    book_loans_BranchID INT,
    book_loans_CardNo INT,
    book_loans_DateOut VARCHAR(20),
    book_loans_DueDate VARCHAR(20),
    FOREIGN KEY (book_loans_BookID)
        REFERENCES tbl_book (book_BookID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (book_loans_BranchID)
        REFERENCES tbl_library_branch (library_branch_BranchID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (book_loans_CardNo)
        REFERENCES tbl_borrower (borrower_CardNo)
        ON UPDATE CASCADE ON DELETE CASCADE
);

SET sql_safe_updates = 0;
 
UPDATE library.tbl_book_loans
SET book_loans_DateOut = STR_TO_DATE(book_loans_DateOut, '%m/%d/%y'),
    book_loans_DueDate = STR_TO_DATE(book_loans_DueDate, '%m/%d/%y');
    
    
-- 1 . How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?

SELECT SUM(book_copies_No_Of_Copies) AS Total_Copies
FROM tbl_book_copies bc
JOIN tbl_library_branch lb ON bc.book_copies_BranchID = lb.library_branch_BranchID
JOIN tbl_book b ON bc.book_copies_BookID = b.book_BookID
WHERE b.book_Title = 'The Lost Tribe' AND lb.library_branch_BranchName = 'Sharpstown';

-- 2. How many copies of the book titled "The Lost Tribe" are owned by each library branch?

SELECT lb.library_branch_BranchName, SUM(bc.book_copies_No_Of_Copies) AS Total_Copies
FROM tbl_book_copies bc
JOIN tbl_library_branch lb ON bc.book_copies_BranchID = lb.library_branch_BranchID
JOIN tbl_book b ON bc.book_copies_BookID = b.book_BookID
WHERE b.book_Title = 'The Lost Tribe'
GROUP BY lb.library_branch_BranchName;

-- 3. Retrieve the names of all borrowers who do not have any books checked out.

SELECT borrower_BorrowerName
FROM tbl_borrower
WHERE borrower_CardNo NOT IN (SELECT DISTINCT book_loans_CardNo FROM tbl_book_loans);

-- 4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address. 

SELECT b.book_Title, br.borrower_BorrowerName, br.borrower_BorrowerAddress
FROM tbl_book_loans bl
JOIN tbl_book b ON bl.book_loans_BookID = b.book_BookID
JOIN tbl_library_branch lb ON bl.book_loans_BranchID = lb.library_branch_BranchID
JOIN tbl_borrower br ON bl.book_loans_CardNo = br.borrower_CardNo
WHERE lb.library_branch_BranchName = 'Sharpstown' AND bl.book_loans_DueDate = '2018-02-03';

-- 5. For each library branch, retrieve the branch name and the total number of books loaned out from that branch.

SELECT lb.library_branch_BranchName, COUNT(*) AS Total_Books_Loaned
FROM tbl_book_loans bl
JOIN tbl_library_branch lb ON bl.book_loans_BranchID = lb.library_branch_BranchID
GROUP BY lb.library_branch_BranchName;

-- 6. Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.

SELECT br.borrower_BorrowerName, br.borrower_BorrowerAddress, COUNT(bl.book_loans_LoansID) AS Total_Books_Checked_Out
FROM tbl_book_loans bl
JOIN tbl_borrower br ON bl.book_loans_CardNo = br.borrower_CardNo
GROUP BY br.borrower_BorrowerName, br.borrower_BorrowerAddress
HAVING Total_Books_Checked_Out > 5;


-- 7. For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".

SELECT b.book_Title, bc.book_copies_No_Of_Copies
FROM tbl_book b
JOIN tbl_book_authors ba ON b.book_BookID = ba.book_authors_BookID
JOIN tbl_book_copies bc ON b.book_BookID = bc.book_copies_BookID
JOIN tbl_library_branch lb ON bc.book_copies_BranchID = lb.library_branch_BranchID
WHERE ba.book_authors_AuthorName = 'Stephen King' AND lb.library_branch_BranchName = 'Central';