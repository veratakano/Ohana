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
		// add siblings
		elseif ($r->type == 2 or $r->type == 3 or $r->type == 4 or $r->type == 5) {
			
			
			$father_id = 2;
			$mother_id = 3;
			$member_fname = $r->user->fName;
			$member_lname = $r->user->lName;
			$member_dob = $r->user->DOB;
			$member_cob = $r->user->COB;
			
			// no need to change this hardcode
			if ($r->type == 2 or $r->type == 4)
				$member_gender = 'M'; 
			else
				$member_gender = 'F'; 
			
			// hard coded ***
			$member_vs = 1;
			$member_treeID = 1;
			
			$db->getResult("CALL `SP_Add_Family` ($father_id, $mother_id, '$member_fname', '$member_lname', '$member_dob', '$member_cob', '$member_gender', $member_vs, $member_treeID)");
			
		}
		// add spouse
		else {
			$member_id = 7;
			
			//id of member's father
			$father_id = 2;
			$spouse_fname = $r->user->fName;
			$spouse_lname = $r->user->lName;
			$spouse_dob = $r->user->DOB;
			$spouse_cob = $r->user->COB;
			
			// need to find gender
			$spouse_gender = $r->user->gender;
			$spouse_vs = 1;
			$member_treeID = 1;
			
			$db->getResult("CALL `SP_Add_Spouse`  ($member_id, $father_id, '$spouse_fname', '$spouse_lname', '$spouse_dob','$spouse_cob','$spouse_gender', $spouse_vs, $member_treeID);");
		}
		
	
    };

    function createTree($uid){

        $db = new DbHandler();

        $result = $db->getResult("CALL SP_DoCreateTree('Testing','$uid')");
        return $result;
    };

?>