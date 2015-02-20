<?php

	require_once 'dbHandler.php';

	session_start();
	$treeID = $_SESSION['treeid'];

	try {
		$db = new DbHandler();
		$result = $db->getResultSet("SELECT * FROM Member WHERE treeID = '$treeID'");
		$response = array();
	    if($result != NULL) {
			$response = $result;
		}else{
			throw new RuntimeException("There are no member in the tree."); 
		}
	} catch (RuntimeException $e) {
		$response['status'] = "error";
    	$response['message'] = $e->getMessage();
	}

	echo json_encode($response);

?>