<?php
require (__DIR__."/Database.php");
//Connect to Database
$dbconn = new Database();
$conn = $dbconn->getConnection();

if($conn==false){
    //If database to connection is not established
}
else{
    //Execute a procedure call to validate login (Check for already present users
    $json = file_get_contents("php://input");
    $data = json_decode($json,true);
    $user=$data['loginEmail'];
    $pass=$data['loginPassword'];
    $stmt=$conn->query("CALL ValidateLogin('".$user."','".$pass."',@p1);");
    $stmt2=$conn->query("SELECT @p1 AS VALIDATE;");
    $row=$stmt2->fetch();
    if ($row['VALIDATE'] == 1) {
        //return a true value to the front-end for a go ahead to signup
        echo json_encode(
            array("message"=>"Found")
        );
    } else {
        //return false in case an email-id already exists in the database
        echo json_encode(
            array("message" => "Not Found")
        );
    }
    //The procedure returns only a bool value.
    //$result=$stmt->fetchAll();
    //echo "".$result['validate'];
}

