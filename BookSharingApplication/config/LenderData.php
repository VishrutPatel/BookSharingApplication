<?php
/**
 * Created by PhpStorm.
 * User: nilay
 * Date: 20/02/18
 * Time: 13:48
 */
//Add book for lending(6in,1out)
require (__DIR__."/Database.php");
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
    $data = json_decode($json,true);
    $email=$data["emailBook"];
    $title=$data["titleBook"];
    $author=$data['authorBook'];
    $genre=$data['genreBook'];
    $userstartdate=$data['startDateBook'];
    $userenddate=$data['endDateBook'];
    $starttime=strtotime($userstartdate);
    $startdate=date('Y-m-d H:i:s',$starttime);
    $endtime=strtotime($userenddate);
    $enddate=date('Y-m-d H:i:s',$endtime);
    $mod=$data['deliveryModeBook'];
    $stmt3=$conn->query("CALL GetCountOfBooks(@p1);");
    $stmt2=$conn->query("SELECT @p1 AS COUNT;");
    $result1=$stmt2->fetch();
    $stmt=$conn->query("CALL addBookForLending('" .$email. "','" .$title. "','" .$author. "','" .$genre. "','" .$startdate. "','" .$enddate. "','" .$mod. "');");
    $stmt4=$conn->query("CALL GetCountOfBooks(@p1);");
    $stmt5=$conn->query("SELECT @p1 AS COUNT;");
    $result2=$stmt5->fetch();
    //The procedure returns only a bool value.
    if ($result2['COUNT']-$result1['COUNT'] == 1 ) {
        //return a true value to the front-end for a go ahead to signup
        echo json_encode(
            array("message"=>"True")
        );
    } else {
        //return false in case an email-id already exists in the database
        echo json_encode(
            array("message"=>"false")
        );
    }
}

