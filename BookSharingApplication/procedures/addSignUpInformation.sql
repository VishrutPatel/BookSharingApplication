delimiter //

CREATE PROCEDURE `addSignUpInformation`(
IN inptfirstname VARCHAR(30),
IN inptlastname VARCHAR(30),
IN inptaddr1 VARCHAR(100),
IN inptaddr2 VARCHAR(100),
IN inptcity VARCHAR(100),
IN inptstate VARCHAR(2),
IN inptzipcode VARCHAR(5),
IN inptemail VARCHAR(50),
IN inptreg_date TIMESTAMP,
IN inptsec_code INT(5),
IN inptverification_status BOOLEAN,
IN inptpassword VARCHAR(30)
 )
 
 
BEGIN
      
      insert into user 
      (firstname, lastname, addr1, addr2, city, state, zipcode, email, reg_date, sec_code, verification_status,password)
      values 
      (inptfirstname, inptlastname, inptaddr1, inptaddr2, inptcity, inptstate, inptzipcode, inptemail, inptreg_date, inptsec_code, inptverification_status, inptpassword);
      insert into borrower
      (email,ratings,no_of_reviews)
      values
      (inptemail,5.00,0);
      insert into lender
      (email,ratings,no_of_reviews)
      values
      (inptemail,5.00,0);
END//
