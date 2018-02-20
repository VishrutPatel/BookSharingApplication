delimiter //

CREATE PROCEDURE `addBookForLending`(
IN inptborroweremail VARCHAR(50),
IN inptbookid VARCHAR(30),
IN inptstartdatetime DATETIME,
IN inptenddatetime DATETIME,
OUT check INT
 )
 
 
BEGIN
      
      insert into borrowrequest 
      (book_Id,borrower_email,start_Date_Time,end_Date_Time)
      values 
      (inptborroweremail,inptbookid,inptstartdatetime,inptenddatetime);
      return 1;
END//