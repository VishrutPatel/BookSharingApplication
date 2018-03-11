delimiter //

CREATE PROCEDURE `deleteBorrowRequest`(
IN bookID INT(6)
 )
 
BEGIN

      DELETE FROM BorrowRequest br
      where bookID = br.book_Id;
     
END//
