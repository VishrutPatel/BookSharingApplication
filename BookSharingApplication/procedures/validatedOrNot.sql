delimiter //

CREATE PROCEDURE `validatedOrNot`(
IN inptemail VARCHAR(50),
OUT trueorFalse BOOLEAN
 )
 
 
BEGIN

      select verification_status into trueorFalse
      from User
      where inptemail = email;
     
END//
