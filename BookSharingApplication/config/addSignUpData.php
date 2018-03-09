<?php

//Connect to Database
require (__DIR__."/Database.php");
require (__DIR__."\PHPMailer_5.2.0\class.phpmailer.php");
$dbconn = new Database();
$conn = $dbconn->getConnection();

if($conn==false){
    //If database to connection is not established
}
else {
    //Execute a procedure call to validate signup (Check for already present users)
    //get a json file and decode it
    $json = file_get_contents("php://input");
    $data = json_decode($json, true);
    $email = $data["email"];
    $firstName = $data["firstName"];
    $lastName = $data["lastName"];
    $addr1 = $data["addr1"];
    $addr2 = $data["addr2"];
    $city = $data["city"];
    $state = $data["state"];
    $zipCode = $data["zipCode"];
    $password = $data["password"];
    $Date = new DateTime();
    $regDate = $Date->format('Y-m-d H:i:s');
    $verStatus = 0;
    $secCode = rand(10001, 99999);
    $stmt1 = $conn->query("CALL validateSignUp('" . $email . "',@p1);");
    $stmt5 = $conn->query("SELECT @p1 AS VALIDATE");
    $result1 = $stmt5->fetch();
    $stmt = $conn->query("CALL addSignUpInformation('" . $firstName . "','" . $lastName . "','" . $addr1 . "','" . $addr2 . "','" . $city . "','" . $state . "','" . $zipCode . "','" . $email . "','" . $regDate . "','" . $secCode . "','" . $verStatus . "','" . $password . "');");
    $stmt3 = $conn->query("CALL validateSignUp('" . $email . "',@p1);");
    $stmt4 = $conn->query("SELECT @p1 AS VALIDATE");
    $result2 = $stmt4->fetch();
}


