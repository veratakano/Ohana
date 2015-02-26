<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
    $response = array();

    try {
        $userID = $r->userID;

        $db = new DbHandler();
        $result = $db->getResultSet("CALL SP_GetShareTree('$userID')");
        $response = $result;
    } catch (Exception $e) {
        $response['status'] = "error";
        $response['message'] = $e->getMessage();
    }

        echo json_encode($response);
?>