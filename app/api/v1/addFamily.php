<?php

	session_start();
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
    var_dump($r); 
	
    addFamily($r);
    
    function addFamily($r){
		
		// get tree ID from session 
		$tree_id = $_SESSION['treeid'];
		
		echo "$tree_id<br>";
		
		// link of the current page to get member ID
		$link = $r->link;
		echo "$link<br>";
		$str ="/"; 
		$char_found_at = strripos($link, $str, -1);
		$member_ID = substr($link, $char_found_at+1) ;

        $db = new DbHandler();
		
		if ($r->type == "1") {
		
			$father_fname = $r->user->fFirstName;
			$father_lname = $r->user->fLastName;
			$father_dob = $r->user->fDOB;
			$father_email = $r->user->fEmail;
			$father_email = !empty($father_email) ? "'$father_email'" : "NULL";
			$father_pob = $r->user->fPOB;
			$father_vs = $r->user->fvStatus;
			
			$mother_fname = $r->user->mFirstName;
			$mother_lname = $r->user->mLastName;
			$mother_dob = $r->user->mDOB;
			$mother_email = $r->user->mEmail;
			$mother_email = !empty($mother_email) ? "'$mother_email'" : "NULL";
			$mother_pob = $r->user->mPOB;
			$mother_vs = $r->user->mvStatus;
			echo "CALL `SP_Add_Parent` ($member_ID, '$father_fname', '$father_lname', '$father_dob', $father_email, '$father_pob', $father_vs, '$mother_fname', '$mother_lname', '$mother_dob', $mother_email, '$mother_pob', $mother_vs,$tree_id)";

			$result = $db->getResult("CALL `SP_Add_Parent` ($member_ID, '$father_fname', '$father_lname', '$father_dob', $father_email, '$father_pob', $father_vs, '$mother_fname', '$mother_lname', '$mother_dob', $mother_email, '$mother_pob', $mother_vs, $tree_id)");

		}

		// add siblings
		elseif ($r->type == "2") {
			
			$member_fname = $r->user->fName;
			$member_lname = $r->user->lName;
			$member_dob = $r->user->DOB;
			$member_email = $r->user->email;
			$member_email = !empty($member_email) ? "'$member_email'" : "NULL";
			$member_pob = $r->user->POB;
			$member_vs = $r->user->vStatus;
			
			if (strcmp($r->user->type, "Brother"))
				$member_gender = 'F'; 
			else
				$member_gender = 'M'; 
		
			$db->getResult("CALL `SP_Add_Sibling` ($member_ID, '$member_fname', '$member_lname', '$member_dob', $member_email, '$member_pob', '$member_gender', $member_vs, $tree_id)");
			
		}
		
		// add offspring
		elseif ($r->type == "3") {
			
			$offspring_fname = $r->user->fName;
			$offspring_lname = $r->user->lName;
			$offspring_dob = $r->user->DOB;
			$offspring_email = $r->user->email;
			$offspring_email = !empty($offspring_email) ? "'$offspring_email'" : "NULL";
			$offspring_pob = $r->user->POB;
			$offspring_vs = $r->user->vStatus;
			$offspring_gender;
			
			if (strcmp($r->user->type, "Son"))
				$offspring_gender = 'F'; 
			else
				$offspring_gender = 'M'; 
			
			$db->getResult("CALL `SP_Add_Offspring` ($member_ID, '$offspring_fname', '$offspring_lname', '$offspring_dob', $offspring_email, '$offspring_pob', '$offspring_gender', $offspring_vs, $tree_id)");
		
		}
		// add spouse
		elseif ($r->type == "4"){
			
			$spouse_fname = $r->user->fName;
			$spouse_lname = $r->user->lName;
			$spouse_dob = $r->user->DOB;
			$spouse_email = $r->user->email;
			$spouse_email = !empty($spouse_email) ? "'$spouse_email'" : "NULL";
			$spouse_pob = $r->user->POB;
			$spouse_vs = $r->user->vStatus;
			$spouse_gender = $r->user->gender;
			
			$db->getResult("CALL `SP_Add_Spouse` ($member_ID, '$spouse_fname', '$spouse_lname', '$spouse_dob', $spouse_email, '$spouse_pob','$spouse_gender', $spouse_vs, $tree_id)");
		
		}

    };

    function createTree($uid){

        $db = new DbHandler();

        $result = $db->getResult("CALL SP_DoCreateTree('Testing','$uid')");
        return $result;
    };

?>