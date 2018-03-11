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
    $email=$data['email'];
    $stmt=$conn->query("select b.id, t.lender_email, b.title, b.author, b.genre, b.start_Date_Time, b.end_Date_Time from TRANSACTION t, book b where t.borrower_email = '".$email."'and t.book_Id = b.id;");
    $stmt->execute();
    $format=array();
    while($row1=$stmt->fetch(PDO::FETCH_ASSOC)){
        $format[]=$row1;
    }
    if(count($format)==0){
        echo json_encode(
            array("message"=>"false")
        );
    }
    else{
        echo json_encode(
            array("message"=>$format)
        );
    }
}