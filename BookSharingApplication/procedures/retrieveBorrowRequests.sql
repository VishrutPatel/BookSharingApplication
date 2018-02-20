delimiter //

CREATE PROCEDURE `validateLogin`(
IN inptemail varchar(50),
OUT otptborroweremail varchar(),
OUT otptratings FLOAT(3,2)
 )
 
 
BEGIN
      
      SELECT b.email,b.ratings
      FROM borrower b, borrowrequest br, book bk
      WHERE b.email = br.borroweremail AND bk.id = br.book_Id AND bk.email = inptemail
      
END//
