<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);


    $treeID = $r->treeID;

    try{
        $db = new DbHandler();
        $result = $db->getResult("CALL SP_GetTreeOwner('$treeID')");
        $response = array();
        $member = $result;
        if($user['member'] != 1) {
            $response = $member;
        }else{
            $response['status'] = "error";
            $response['message'] = "Email or Password was not entered correctly.";      
        }
    } catch (Exception $e) {
        $response['status'] = "error";
        $response['message'] = 'Caught exception: ' . $e->getMessage();
    }

    echo json_encode($response);
?>