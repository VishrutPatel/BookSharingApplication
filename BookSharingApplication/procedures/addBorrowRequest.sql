delimiter //

CREATE PROCEDURE `addBorrowRequest`(
IN inptborroweremail VARCHAR(50),
IN inptbookid INT(6),
IN inptstartdatetime DATETIME,
IN inptenddatetime DATETIME,
OUT check INT
 )
 
 
BEGIN
      
      insert into borrowrequest 
      (book_Id,borrower_email,start_Date_Time,end_Date_Time)
      values 
      (inptborroweremail,inptbookid,inptstartdatetime,inptenddatetime);

END//
