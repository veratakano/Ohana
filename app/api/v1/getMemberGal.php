<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);


        $memberID = $r->member;

        $db = new DbHandler();
        $result = $db->getResultSet("SELECT * FROM Rememberance WHERE MemberID = '$memberID'");
        $response = array();
        if($result != NULL) {
            $response = $result;
        }else{
        }

        echo json_encode($response);
?>