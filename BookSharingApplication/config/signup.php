<?php

//Connect to Database
$dbconn = new Database();
$conn = $dbconn->getConnection();

if($conn==false){
    //If database to connection is not established
}
else {
    //Execute a procedure call to validate signup (Check for already present users)
    //get a json file and decode it
    $json = file_get_contents("php://input");
    $data = json_decode($json);
    $user="";
    $stmt=$conn->query("CALL ValidateSignUp('".$user."',@p1);");
    $stmt2=$conn->query("SELECT @p1 FROM VALIDATE");
    //The procedure returns only a bool value.
    $result = $stmt2->fetch();
    if ($result == true) {
        //return a true value to the front-end for a go ahead to signup
    } else {
        //return false in case an email-id already exists in the database

    }
}


