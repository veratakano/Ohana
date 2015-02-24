<?php

	session_start();
     
    require_once 'dbHandler.php';
    date_default_timezone_set('Asia/Singapore');

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
    $response = array();
	
	// get tree ID from session 
	$tree_id = $_SESSION['treeid'];
		
	//echo "$tree_id<br>";
		
	// link of the current page to get member ID
	$link = $r->link;
	//echo "$link<br>";
	$str ="/"; 
	$char_found_at = strripos($link, $str, -1);
	$member_ID = substr($link, $char_found_at+1) ;

    $type = $r->type;
		
	if ($type == "1") {
		$response = doAddParents($r,$tree_id,$member_ID);
	}
	// add siblings
	elseif ($type == "2") {
		$response = doAddSibling($r,$tree_id,$member_ID);
	}		
	// add offspring
	elseif ($type == "3") {
		$response = doAddOffspring($r,$tree_id,$member_ID);
	}
	// add spouse
	elseif ($type == "4"){
		$response = doAddOffspring($r,$tree_id,$member_ID);
	}

    function doAddParents($r,$tree_id,$member_ID){
    		$db = new DbHandler();

    		$father_fname = $r->user->fFirstName;
			$father_lname = $r->user->fLastName;
			$date = str_replace('/', '-', $r->user->fDOB);
        	$father_dob = date('Y-m-d', strtotime($date));
			$father_email = $r->user->fEmail;
			$father_email = !empty($father_email) ? "'$father_email'" : "NULL";
			$father_pob = $r->user->fPOB;
			$father_vs = $r->user->fvStatus;
			
			$mother_fname = $r->user->mFirstName;
			$mother_lname = $r->user->mLastName;
			$date = str_replace('/', '-', $r->user->mDOB);
        	$mother_dob = date('Y-m-d', strtotime($date));
			$mother_email = $r->user->mEmail;
			$mother_email = !empty($mother_email) ? "'$mother_email'" : "NULL";
			$mother_pob = $r->user->mPOB;
			$mother_vs = $r->user->mvStatus;
			//echo "CALL `SP_Add_Parent` ($member_ID, '$father_fname', '$father_lname', '$father_dob', $father_email, '$father_pob', $father_vs, '$mother_fname', '$mother_lname', '$mother_dob', $mother_email, '$mother_pob', $mother_vs,$tree_id)";

			$result = $db->getResult("CALL `SP_Add_Parent` ($member_ID, '$father_fname', '$father_lname', '$father_dob', $father_email, '$father_pob', $father_vs, '$mother_fname', '$mother_lname', '$mother_dob', $mother_email, '$mother_pob', $mother_vs, $tree_id)");
			return $result; 
    }

    function doAddSibling($r,$tree_id,$member_ID){
    		$db = new DbHandler();

    		$member_fname = $r->user->fName;
			$member_lname = $r->user->lName;
			$date = str_replace('/', '-', $r->user->DOB);
        	$member_dob = date('Y-m-d', strtotime($date));
			$member_email = $r->user->email;
			$member_email = !empty($member_email) ? "'$member_email'" : "NULL";
			$member_pob = $r->user->POB;
			$member_vs = $r->user->vStatus;
			
			if (strcmp($r->user->type, "Brother"))
				$member_gender = 'F'; 
			else
				$member_gender = 'M'; 
		
			$result = $db->getResult("CALL `SP_Add_Sibling` ($member_ID, '$member_fname', '$member_lname', '$member_dob', $member_email, '$member_pob', '$member_gender', $member_vs, $tree_id)");
    		return $result;
    }

    function doAddOffspring($r,$tree_id,$member_ID){
    		$db = new DbHandler();

    		$offspring_fname = $r->user->fName;
			$offspring_lname = $r->user->lName;
			$date = str_replace('/', '-', $r->user->DOB);
        	$offspring_dob = date('Y-m-d', strtotime($date));
			$offspring_email = $r->user->email;
			$offspring_email = !empty($offspring_email) ? "'$offspring_email'" : "NULL";
			$offspring_pob = $r->user->POB;
			$offspring_vs = $r->user->vStatus;
			$offspring_gender;
			
			if (strcmp($r->user->type, "Son"))
				$offspring_gender = 'F'; 
			else
				$offspring_gender = 'M'; 
			
			$result = $db->getResult("CALL `SP_Add_Offspring` ($member_ID, '$offspring_fname', '$offspring_lname', '$offspring_dob', $offspring_email, '$offspring_pob', '$offspring_gender', $offspring_vs, $tree_id)");
    		return $result;
    }

    function doAddSpouse($r,$tree_id,$member_ID){
    		$db = new DbHandler();

    		$spouse_fname = $r->user->fName;
			$spouse_lname = $r->user->lName;
			$date = str_replace('/', '-', $r->user->DOB);
        	$spouse_dob = date('Y-m-d', strtotime($date));
			$spouse_email = $r->user->email;
			$spouse_email = !empty($spouse_email) ? "'$spouse_email'" : "NULL";
			$spouse_pob = $r->user->POB;
			$spouse_vs = $r->user->vStatus;
			$spouse_gender = $r->user->gender;
			
			$result = $db->getResult("CALL `SP_Add_Spouse` ($member_ID, '$spouse_fname', '$spouse_lname', '$spouse_dob', $spouse_email, '$spouse_pob','$spouse_gender', $spouse_vs, $tree_id)");
			return $result;
    }

    echo json_encode($response);


?>