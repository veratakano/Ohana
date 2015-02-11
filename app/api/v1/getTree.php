<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    //$post = file_get_contents('php://input');
    //$r = json_decode($post);


        //$memberID = $r->member;

        $db = new DbHandler();
        $response = array();

        /*retrieve member
        $sql = "select * from member;";
        $result = $db->getResultSet($sql);
        $member_array = array();
        foreach ($result as &$row) {
            $member_array[$row[memberID]] = array($row[firstName], $row[lastName], $row[gender]);
        }*/

        //retrieve coords

        $sql = "select * from coordinates;";
        $result = $db->getResultSet($sql);     
        $response = $result;
        //$response = array();
        //$member = $result;
        //if($user['member'] != 1) {
        //    $response = $member;
        //}else{
        //    $response['status'] = "error";
        //    $response['message'] = "Email or Password was not entered correctly.";      
        //}
        echo json_encode($response);
?>