delimiter //

CREATE PROCEDURE `borrowedBookInformation`(
IN inptemail varchar(50),
OUT id int(6),
OUT email VARCHAR(50),
OUT title varchar(50),
OUT author varchar(50),
OUT genre varchar(50),
OUT start_Date_Time DATETIME,
OUT end_Date_Time DATETIME
 )
 
 
BEGIN

      select b.id, b.email, b.title, b.author, b.genre, b.start_Date_Time, b.end_Date_Time
      from TRANSACTION t, book b
      where inptemail = t.borrower_email and t.book_Id = b.id;
     
END//
