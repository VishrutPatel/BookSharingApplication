delimiter //


CREATE PROCEDURE `validateSignUp`(
IN inptemail varchar(50),
      OUT validate int 
 )
 
 
BEGIN
      
      SELECT count(*) INTO validate
      FROM user u
      WHERE u.email = inptemail;
      
END//
