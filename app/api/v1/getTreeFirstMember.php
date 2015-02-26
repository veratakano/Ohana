<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);

    $treeID = $r->treeID;

    try{
        $db = new DbHandler();
        $result = $db->getResult("CALL SP_GetTreeFirstMember('$treeID')");
        $response = array();
        $member = $result;
        if($result['status'] == 0) {
            $response = $result;
        }else{
            throw new RuntimeException("There are no members."); 
        }
    } catch (RuntimeException $e) {
        $response['status'] = "error";
        $response['message'] = $e->getMessage();
    }

    echo json_encode($response);
?>