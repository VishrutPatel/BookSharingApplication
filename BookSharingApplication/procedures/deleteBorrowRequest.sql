delimiter //

CREATE PROCEDURE `deleteBorrowRequest`(
IN bookID INT(6)
 )
 
BEGIN

      DELETE FROM BorrowRequest br
      where br.book_Id = bookID;
     
END//
