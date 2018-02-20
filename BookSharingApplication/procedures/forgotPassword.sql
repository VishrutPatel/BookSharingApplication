delimiter //

CREATE PROCEDURE `forgotPassword`(
IN inptemail varchar(50),
IN inptnewpass varchar(30)
)
 
 
BEGIN
      
	UPDATE user SET password = inptnewpass WHERE email = inptemail;	
      
END//
