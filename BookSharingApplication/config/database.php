<?php
class Database{
 
    // specify your own database credentials
    private $host = "localhost";
    private $db_name = "BookSharingApplication";
    private $username = "root";
    private $password = "";
    public $conn;
 
    // get the database connection
    public function getConnection(){
 
        $this->conn = null;
 
        try{
            $this->conn = new PDO("mysql:host=" . $this->host . ";dbname=" . $this->db_name, $this->username, $this->password);
            //echo "<h2>connection successful</h2>";
        }catch(PDOException $exception){
            return false;
        }
 
        return $this->conn;
    }
}
?>