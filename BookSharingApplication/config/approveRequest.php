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
    $lender_email = $data['lenderEmail'];
    $borrower_email = $data['borrowerEmail'];
    $book_id = $data['bookId'];
    $stmt=$conn->query("CALL addTransaction('" .$lender_email. "','" .$book_id. "','" .$borrower_email. "');");
    $stmt1=$conn->query("CALL updateBookStatus('" .$book_id. "');");
    $stmt2=$conn->query("CALL deleteBorrowRequest('" .$book_id. "');");
    $stmt3=$conn->query("CALL addReviewForTransaction('" .$book_id. "');");
}
