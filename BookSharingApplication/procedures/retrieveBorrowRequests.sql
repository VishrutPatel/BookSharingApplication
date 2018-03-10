delimiter //

CREATE PROCEDURE `retrieveBorrowRequests`(
IN inptemail varchar(50),
OUT otptborroweremail varchar(50),
OUT otptratings FLOAT(3,2),
OUT otptbookID INT,
OUT otptTitle varchar(50),
)
 
 
BEGIN
      
      SELECT br.book_Id into otptbookID,b.email into otptborroweremail,b.ratings into otptratings,bk.title into otptTitle
      FROM borrower b, borrowrequest br, book bk
      WHERE b.email = br.borroweremail AND bk.id = br.book_Id AND bk.email = inptemail
      ORDER BY br.book_Id
      
END//
