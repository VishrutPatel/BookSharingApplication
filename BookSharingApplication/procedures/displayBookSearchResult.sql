delimiter //

CREATE PROCEDURE `displayBookSearchResult`(
IN inptstartdate DATETIME,
IN inptenddate DATETIME,
OUT email VARCHAR(50),
OUT title VARCHAR(50),
OUT author VARCHAR(50),
OUT genre VARCHAR(50),
OUT start_Date_Time DATETIME,
OUT end_Date_Time DATETIME 
 )
 
 
BEGIN

      select *
      from book
      where inptbookname = title AND inptstartdate >= start_Date_Time AND inptenddate <= end_Date_Time;
     
END//
