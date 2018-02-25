<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
 
// include database and object files
include_once '../config/database.php';
include_once '../config/Book.php';
 
// instantiate database and product object
$database = new Database();
$db = $database->getConnection();
 
// initialize object
$book = new Book($db);
 
// query products
$stmt = $book->read();
$num = $stmt->rowCount();
// check if more than 0 record found
if($num>0){
 
    // products array
    $products_arr=array();
    $products_arr["records"]=array();
 
    // retrieve our table contents
    // fetch() is faster than fetchAll()
    // http://stackoverflow.com/questions/2770630/pdofetchall-vs-pdofetch-in-a-loop
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        // extract row
        // this will make $row['name'] to
        // just $name only
        extract($row);
 
        $product_item=array(
            "id" => $id,
            "email" => $email,
            "title" => $title,
            "genre" => $genre,
            "author" => $author,
            "start_Date_Time" => $start_Date_Time,
            "end_Date_time" => $end_Date_Time
        );
 
        array_push($products_arr["records"], $product_item);
    }
 
    echo json_encode($products_arr["records"],JSON_PRETTY_PRINT);
}
 
else{
    echo json_encode(
        array("message" => "No Books found.")
    );
}
?>