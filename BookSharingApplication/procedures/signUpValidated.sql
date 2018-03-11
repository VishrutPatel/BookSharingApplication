delimiter //

CREATE PROCEDURE `signUpValidated`(
IN inptemail VARCHAR(50)
 )
 
 
BEGIN

      UPDATE user SET verification_status = 1 WHERE email = inptemail;
     
END//
