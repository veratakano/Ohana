<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
    var_dump($r);    
    addFamily($r);
    
    function addFamily($r){

        $db = new DbHandler();
		
		if ($r->type == "1") {
			echo "hiiiiiiiiiiiiiiiiiiii";
			// hard coded ***
			$member_ID = 1;
			$father_fname = $r->user->fFirstName;
			$father_lname = $r->user->fLastName;
			$father_dob = $r->user->fDOB;
			$father_cob = $r->user->fCOB;
			
			// hard coded ***
			$father_vs = 0;
			
			$mother_fname = $r->user->mFirstName;
			$mother_lname = $r->user->mLastName;
			$mother_dob = $r->user->mDOB;
			$mother_cob = $r->user->mCOB;
			$mother_vs = 1;
			
			// hard coded ***
			$tree_id = 1;

			$result = $db->getResult("CALL `SP_Add_Parent` ($member_ID, '$father_fname', '$father_lname', '$father_dob', '$father_cob', $father_vs, '$mother_fname', '$mother_lname', '$mother_dob', '$mother_cob', $mother_vs,$tree_id)");
		
		}
		// // add siblings
		// elseif ($r->user->type == 2) {
			
		// }
		// // add spouse
		// else {
			
		// }
		
	
    };

    function createTree($uid){

        $db = new DbHandler();

        $result = $db->getResult("CALL SP_DoCreateTree('Testing','$uid')");
        return $result;
    };

?>