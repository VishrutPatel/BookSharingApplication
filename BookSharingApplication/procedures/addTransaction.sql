delimiter //

CREATE PROCEDURE `addTransaction`(
IN lenderemail VARCHAR(50),
IN inptbookid INT(6),
IN borroweremail VARCHAR(50),
OUT check INT
 )
 
 
BEGIN
      
      insert into transaction 
      (lender_email,book_Id,borrower_email)
      values 
      (lenderemail,inptbookid,borroweremail);
      insert into reviews
      (transaction_id)
      values
      (select id from transaction where book_Id = inptbookid);

END//