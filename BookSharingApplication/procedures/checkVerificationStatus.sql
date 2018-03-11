delimiter //

CREATE PROCEDURE `checkVerificationStatus`(
IN inptemail varchar(50),
IN inptpass varchar(30),
OUT validate int
 )
 
 
BEGIN
      
      SELECT count(*) INTO validate
      FROM user u
      WHERE u.email = inptemail
      AND
      u.verification_status = TRUE;
      
END//