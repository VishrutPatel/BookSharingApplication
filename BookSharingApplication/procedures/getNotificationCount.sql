delimiter //

CREATE PROCEDURE `getNotificationCount`(
IN inptemail varchar(50),
OUT count INT
 )
 
 
BEGIN
      
      SELECT count(*) into count
      FROM borrower b, borrowrequest br, book bk
      WHERE b.email = br.borroweremail AND bk.id = br.book_Id AND bk.email = inptemail
      
END//
