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
    $user="";
    $pass="";

    $stmt=$conn->query("CALL ValidateLogin('".$user."','".$pass."',@p1);");
    $stmt2=$conn->query("SELECT @p1 AS VALIDATE;");
    $row=$stmt2->fetch();
    echo $row['VALIDATE'];
    //The procedure returns only a bool value.
    //$result=$stmt->fetchAll();
    //echo "".$result['validate'];
}

