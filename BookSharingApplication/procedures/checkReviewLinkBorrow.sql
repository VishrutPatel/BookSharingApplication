delimiter //

CREATE PROCEDURE `checkReviewLink`(
IN bookId INT(6),
OUT validate int
 )
 
 
BEGIN
      
      SELECT count(*) INTO validate
      FROM reviews r, transaction tr
      WHERE r.transaction_id = tr.id and tr.book_Id = bookId
      
END//