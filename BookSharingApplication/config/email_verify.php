<?php
//PHP_Mailer Dependencies
require (__DIR__."/PHPMailer_5.2.0/class.phpmailer.php");

// This PHP script is used to send a security code to verify the email-address of the registering user
$mail=new PHPMailer();
$mail->IsSMTP();
//$mail->IsHTML(true);
$mail->SMTPDebug=2;
$mail->SMTPAuth=true;
$mail->SMTPSecure="ssl";
$mail->Host="smtp.gmail.com";
$mail->Port=465;
$mail->Username="wolfsharenc@gmail.com";
$mail->Password="9197375362";
$mail->From="wolfsharenc@gmail.com";
$mail->FromName="The WolfShare Team";
$mail->AddAddress("vnpatel@ncsu.edu","Vishrut Patel");
$mail->Subject="Security Code for Wolfware";
$code=rand(10001,99999);
//AddSignUpInformation
$mail->Body="Security Code: ".$code. "\nPlease Enter this code on the signup window.\nRegards,\nThe Wolfshare Team";

if(!$mail->Send()){
    echo "Message could not be sent";
    echo $mail->ErrorInfo;
    exit;
}
echo "Message sent";



