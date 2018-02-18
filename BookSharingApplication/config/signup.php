<?php

//Connect to Database
$dbconn = new Database();
$conn = $dbconn->getConnection();

if($conn==false){
    //If database to connection is not established
}
else {
    //Execute a procedure call to validate signup (Check for already present users)
    $stmt = $conn->prepare("CALL ValidateSignUp(?)");
    //get a json file and decode it
    $json = file_get_contents("php://input");
    $data = json_decode($json);
    $stmt->bindParam(1, $data, PDO::PARAM_STR);
    $stmt->execute();
    //The procedure returns only a bool value.
    $result = $stmt->fetchAll();

    if ($result == true) {
        //return a true value to the front-end for a go ahead to signup
    } else {
        //return false in case an email-id already exists in the database

    }
}


