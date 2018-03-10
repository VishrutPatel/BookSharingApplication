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
    $email="";
    $stmt=$conn->query("CALL RetrieveBorrowRequest('".$email."',@p1,@p2);");
    $stmt2=$conn->query("SELECT @p1 AS EMAIL");
    $stmt3=$conn->query("SELECT @p2 AS RATINGS");
    //The procedure returns only a bool value.

    $format=array();
    while($row1=$stmt2->fetch(PDO::FETCH_ASSOC) && $row2=$stmt3->fetch(PDO::FETCH_ASSOC)){
        $format['Email'][]=$row1;
        $format['Ratings'][]=$row2;
    }
    echo json_encode($format);
}

