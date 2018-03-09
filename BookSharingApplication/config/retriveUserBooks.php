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
    $user=$data['userName'];
    $stmt=$conn->query("CALL getUserName('".$user."',@p1);");
    $stmt2=$conn->query("SELECT @p1 AS userFirstName;");
    $row=$stmt2->fetch();
    echo json_encode(
        array("message"=>$row['userFirstName'])
    );
    //The procedure returns only a bool value.
    //$result=$stmt->fetchAll();
    //echo "".$result['validate'];
}

