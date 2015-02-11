<?php

class DbHandler {

    private $conn;

    function __construct() {
        require_once 'dbConnect.php';
        // opening db connection
        $db = new dbConnect();
        $this->conn = $db->connect();
    }
    /**
     * Fetching single record
     */
    public function getResult($query) {
        $r = $this->conn->query($query) or die($this->conn->error.__LINE__);
        return $result = $r->fetch_assoc();    
    }
     /**
     * Fetching records
     */
    public function getResultSet($query) {
        $result_array = array();
        $r = $this->conn->query($query) or die($this->conn->error.__LINE__);
        while($row = $r->fetch_assoc()) {
            array_push($result_array,$row);
        };
        return $result_array;
    }
}

?>