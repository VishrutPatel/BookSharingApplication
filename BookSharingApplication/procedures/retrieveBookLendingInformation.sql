delimiter //

CREATE PROCEDURE `retrieveBookLendingInformation`(
IN inid INT(6),
OUT email VARCHAR(50),
OUT title varchar(50),
OUT author varchar(50),
OUT genre varchar(50),
OUT start_Date_Time DATETIME,
OUT end_Date_Time DATETIME,
OUT ratings float(3,2),
OUT firstname varchar(30),
OUT lastname varchar(30)
 )
 
 
BEGIN

      select b.email, b.title, b.author, b.genre, b.start_Date_Time, b.end_Date_Time, l.ratings, u.firstname, u.lastname
      from book b, lender l, user u
      where inid = b.id AND b.email = l.email AND l.email = u.email;
     
END//
