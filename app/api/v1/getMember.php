<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);


        $memberID = $r->member;

        $db = new DbHandler();
        $result = $db->getResult("CALL SP_GetMember('$memberID')");
        $response = array();
        $member = $result;
        if($member != null) {
            $response = $member;
        }else{
            $response['status'] = "error";
            $response['message'] = "Member does not exsit.";      
        }

        echo json_encode($response);
?>