<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
    $response = array();

    try {
        $userID = $r->userID;

        $db = new DbHandler();
        $result = $db->getResultSet("SELECT t.treeID, u.firstName, u.lastName FROM Tree_Share t INNER JOIN Users u ON t.uID = u.uID WHERE t.uID = '$userID'");
        $response = $result;
    } catch (Exception $e) {
        $response['status'] = "error";
        $response['message'] = $e->getMessage();
    }

        echo json_encode($response);
?>