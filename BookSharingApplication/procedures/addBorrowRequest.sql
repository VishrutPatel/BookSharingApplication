delimiter //

CREATE PROCEDURE `addBorrowRequest`(
IN inptborroweremail VARCHAR(50),
IN inptbookid INT(6),
IN inptstartdatetime DATETIME,
IN inptenddatetime DATETIME,
OUT check INT
 )
 
 
BEGIN
      select max(br.id) as val
      from borrowrequest as br;
      insert into borrowrequest 
      (book_Id,borrower_email)
      values 
      (inptborroweremail,inptbookid);
      select val as "1"
      from borrowrequest
      where id = val+1;

END//
