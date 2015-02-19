<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
    $response = array();

    try {
        $memberID = $r->member;
        $treeID = $r->tree;
        
        $db = new DbHandler();
        $result = $db->getResult("CALL SP_DoCreateTreeShare('$memberID', '$treeID')");

        if($result[status] == 0) {
            $response['status'] = "sucess";
            $response['message'] = "Share Tree Created";      
        }elseif($result[status] == 1){
            $response['status'] = "error";
            $response['message'] = "Error creating share tree";      
        }else{
            $response['status'] = "error";
            $response['message'] = "The tree has been shared with you. Login to view the tree!";      
        }
    } catch (Exception $e) {
        $response['status'] = "error";
        $response['message'] = $e->getMessage();
    }
    
    echo json_encode($response);        

?>