delimiter //

CREATE PROCEDURE `retrieveBorrowRequests`(
IN inptemail varchar(50),
OUT otptborroweremail varchar(50),
OUT otptratings FLOAT(3,2),
OUT otptbookID INT,
OUT otptTitle varchar(50),
)
 
 
BEGIN
      
      SELECT br.book_Id,b.email,b.ratings,bk.title
      FROM borrower b, borrowrequest br, book bk
      WHERE b.email = br.borroweremail AND bk.id = br.book_Id AND bk.email = inptemail
      
END//
