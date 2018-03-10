delimiter //

CREATE PROCEDURE `retrieveBorrowRequests`(
IN inptemail varchar(50),
OUT otptborroweremail varchar(50),
OUT otptratings FLOAT(3,2)
 )
 
 
BEGIN
      
      SELECT b.email,b.ratings,count(*)
      FROM borrower b, borrowrequest br, book bk
      WHERE b.email = br.borroweremail AND bk.id = br.book_Id AND bk.email = inptemail
      
END//
