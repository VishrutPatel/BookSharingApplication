<?php
/**
 * Created by PhpStorm.
 * User: nilay
 * Date: 20/02/18
 * Time: 14:12
 */
require (__DIR__."/Database.php");
//borroweremail
//bookid
//starttime
//endtime

//Connect to Database
$dbconn = new Database();
$conn = $dbconn->getConnection();

if($conn==false){
    //If database to connection is not established
}
else {
    $json = file_get_contents("php://input");
    $data = json_decode($json,true);
    $email=$data['borrowerEmail'];
    $bookid=$data['bookIdentity'];
    $stmt3=$conn->query("CALL getCountOfBorrowRequests(@p1);");
    $stmt4=$conn->query("SELECT @p1 AS COUNT;");
    $result1=$stmt4->fetch();
    $stmt=$conn->query("CALL addBorrowRequest('" .$email. "','" .$bookid. "');");
    $stmt5=$conn->query("CALL getCountOfBorrowRequests(@p1);");
    $stmt6=$conn->query("SELECT @p1 AS COUNT;");
    $result2=$stmt6->fetch();
    if($result2['COUNT']-$result1['COUNT']==1) {
        echo json_encode(
            array("message"=>"True")
        );
    }else{
        echo json_encode(
            array("message"=>"True")
        );
    }
}
