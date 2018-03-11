delimiter //

CREATE PROCEDURE `updateBookStatus`(
IN inptbookid INT(6),
OUT check INT
 )
 
 
BEGIN
      
      UPDATE book 
      set book_status = 0
      where id = inptbookid;

END//