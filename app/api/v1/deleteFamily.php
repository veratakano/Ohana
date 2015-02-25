<?php

	session_start();
     
    require_once 'dbHandler.php';
    date_default_timezone_set('Asia/Singapore');

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
	
	$member_ID = $r->member->memberID;
	// echo "$member_ID <br>";
	
	doDeleteParent($member_ID);
	
	// get tree ID from session 
	// $tree_id = $_SESSION['treeid'];	

    function doDeleteParent($member_ID){
    		$db = new DbHandler();

			// echo "CALL `SP_Delete_Member` ($member_ID);";

			$db->getResult("CALL `SP_Delete_Member` ($member_ID);");
			// return $result; 
    }



?>