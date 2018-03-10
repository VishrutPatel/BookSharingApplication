<?php
//Add book for lending(6in,1out)

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
    $bookId="";

    $stmt=$conn->query("CALL RetriveBookLendingInformation('".$bookID."',@p1,@p7,@p8,@p9,@p2,@p3,@p4,@p5,@p6);");
    $stmt2=$conn->query("SELECT @p1 AS EMAIL");
    $stmt8=$conn->query("SELECT @p7 AS TITLE");
    $stmt9=$conn->query("SELECT @p8 AS AUTHOR");
    $stmt10=$conn->query("SELECT @p9 AS GENRE");
    $stmt3=$conn->query("SELECT @p2 AS STARTDATE");
    $stmt4=$conn->query("SELECT @p3 AS ENDDATE");
    $stmt5=$conn->query("SELECT @p4 AS RATINGS");
    $stmt6=$conn->query("SELECT @p5 AS FIRSTNAME");
    $stmt7=$conn->query("SELECT @p6 AS LASTNAME");
    //The procedure returns only a bool value.

    $format=array();
    $format['Email']=$stmt2;
    $format['StartDate']=$stmt3;
    $format['EndDate']=$stmt4;
    $format['Ratings']=$stmt5;
    $format['FirstName']=$stmt6;
    $format['LastName']=$stmt7;
    $format['Title']=$stmt8;
    $format['Author']=$stmt9;
    $format['Genre']=$stmt10;
    echo json_encode($format);
}