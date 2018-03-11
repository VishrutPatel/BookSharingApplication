<?php
//Add book for lending(6in,1out)
require (__DIR__."/Database.php");
//Connect to Database
//retrieve borrow request
$dbconn = new Database();
$conn = $dbconn->getConnection();

if($conn==false){
    //If database to connection is not established
}
else {
    //Execute a procedure call to validate signup (Check for already present users)
    //get a json file and decode it
    $json = file_get_contents("php://input");
    $data = json_decode($json,true);
    $email="pjmandle@ncsu.edu";
    $stmt=$conn->query("select * from book b where inptemail = '".$email."';");
    $stmt->execute();
    //$result=$stmt->fetch(PDO::FETCH_ASSOC);
    //echo $result;
    //The procedure returns only a bool value.
    $format=array();
    while($row1=$stmt->fetch(PDO::FETCH_ASSOC)){
        $format[]=$row1;

    }
    echo json_encode($format);
}