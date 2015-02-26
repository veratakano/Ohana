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

    try {
		
		if ($type == "1") {
			$result = doAddParents($r,$tree_id,$member_ID);
		}
		// add siblings
		elseif ($type == "2") {
			$result = doAddSibling($r,$tree_id,$member_ID);
		}		
		// add offspring
		elseif ($type == "3") {
			$result = doAddOffspring($r,$tree_id,$member_ID);
		}
		// add spouse
		elseif ($type == "4"){
			$result = doAddSpouse($r,$tree_id,$member_ID);
		}

		if($result['status'] == 0){
			$response['status'] = "success";
			$response['ids'] = $result; 
			$response['message'] = "Member has been created!";
		} else {
			throw new RuntimeException("Error creating member"); 
		}

	 } catch (RuntimeException $e) {
        $response['status'] = "error";
        $response['message'] = $e->getMessage();
    }

    echo json_encode($response);

    function doAddParents($r,$tree_id,$member_ID){
    		$db = new DbHandler();

    		$father_fname = $r->user->fFirstName;
			$father_lname = $r->user->fLastName;
			if(!empty($r->user->fDOB)){
            	$date = str_replace('/', '-', $r->user->fDOB);
        		$father_dob = date('Y-m-d', strtotime($date));
        		$father_dob = "'$father_dob'";
        	}else{
             	$father_dob = "NULL";
       		}
			$father_email = $r->user->fEmail;
			$father_email = !empty($father_email) ? "'$father_email'" : "NULL";
			$father_pob = $r->user->fPOB;
			$father_pob = !empty($father_pob) ? "'$father_pob'" : "NULL";
			$father_vs = $r->user->fvStatus;
			
			$mother_fname = $r->user->mFirstName;
			$mother_lname = $r->user->mLastName;
			if(!empty($r->user->mDOB)){
            	$date = str_replace('/', '-', $r->user->mDOB);
        		$mother_dob = date('Y-m-d', strtotime($date));
        		$mother_dob = "'$mother_dob'";
        	}else{
             	$mother_dob = "NULL";
       		}
			$mother_email = $r->user->mEmail;
			$mother_email = !empty($mother_email) ? "'$mother_email'" : "NULL";
			$mother_pob = $r->user->mPOB;
			$mother_pob = !empty($mother_pob) ? "'$mother_pob'" : "NULL";
			$mother_vs = $r->user->mvStatus;
			//echo "CALL `SP_Add_Parent` ($member_ID, '$father_fname', '$father_lname', '$father_dob', $father_email, '$father_pob', $father_vs, '$mother_fname', '$mother_lname', '$mother_dob', $mother_email, '$mother_pob', $mother_vs,$tree_id)";

			$result = $db->getResultMultiQuery("CALL `SP_Add_Parent` ($member_ID, '$father_fname', '$father_lname', $father_dob, $father_email, $father_pob, $father_vs, '$mother_fname', '$mother_lname', $mother_dob, $mother_email, $mother_pob, $mother_vs, $tree_id,@father_id_new,@mother_id_new);SELECT @father_id_new AS father_id,  @mother_id_new AS mother_id");

			return $result; 
    }

    function doAddSibling($r,$tree_id,$member_ID){
    		$db = new DbHandler();

    		$member_fname = $r->user->fName;
			$member_lname = $r->user->lName;
			if(!empty($r->user->DOB)){
            	$date = str_replace('/', '-', $r->user->DOB);
        		$member_dob = date('Y-m-d', strtotime($date));
        		$member_dob = "'$member_dob'";
        	}else{
             	$member_dob = "NULL";
       		}
			$member_email = $r->user->email;
			$member_email = !empty($member_email) ? "'$member_email'" : "NULL";
			$member_pob = $r->user->POB;
			$member_vs = $r->user->vStatus;
			
			if (strcmp($r->user->type, "Brother"))
				$member_gender = 'F'; 
			else
				$member_gender = 'M'; 
		
			$result = $db->getResult("CALL `SP_Add_Sibling` ($member_ID, '$member_fname', '$member_lname', $member_dob, $member_email, '$member_pob', '$member_gender', $member_vs, $tree_id)");
    		return $result;
    }

    function doAddOffspring($r,$tree_id,$member_ID){
    		$db = new DbHandler();

    		$offspring_fname = $r->user->fName;
			$offspring_lname = $r->user->lName;
			if(!empty($r->user->DOB)){
            	$date = str_replace('/', '-', $r->user->DOB);
        		$offspring_dob = date('Y-m-d', strtotime($date));
        		$offspring_dob = "'$offspring_dob'";
        	}else{
             	$offspring_dob = "NULL";
       		}
			$offspring_email = $r->user->email;
			$offspring_email = !empty($offspring_email) ? "'$offspring_email'" : "NULL";
			$offspring_pob = $r->user->POB;
			$offspring_vs = $r->user->vStatus;
			$offspring_gender;
			
			if (strcmp($r->user->type, "Son"))
				$offspring_gender = 'F'; 
			else
				$offspring_gender = 'M'; 
			
			$result = $db->getResult("CALL `SP_Add_Offspring` ($member_ID, '$offspring_fname', '$offspring_lname', $offspring_dob, $offspring_email, '$offspring_pob', '$offspring_gender', $offspring_vs, $tree_id)");
    		return $result;
    }

    function doAddSpouse($r,$tree_id,$member_ID){
    		$db = new DbHandler();

    		$spouse_fname = $r->user->fName;
			$spouse_lname = $r->user->lName;
			if(!empty($r->user->DOB)){
            	$date = str_replace('/', '-', $r->user->DOB);
        		$spouse_dob = date('Y-m-d', strtotime($date));
        		$spouse_dob = "'$spouse_dob'";
        	}else{
             	$spouse_dob = "NULL";
       		}
			$spouse_email = $r->user->email;
			$spouse_email = !empty($spouse_email) ? "'$spouse_email'" : "NULL";
			$spouse_pob = $r->user->POB;
			$spouse_vs = $r->user->vStatus;
			$spouse_gender = $r->user->gender;
			
			$result = $db->getResultMultiQuery("CALL `SP_Add_Spouse` ($member_ID, '$spouse_fname', '$spouse_lname', $spouse_dob, $spouse_email, '$spouse_pob','$spouse_gender', $spouse_vs, $tree_id, @spouse_id_new);SELECT @spouse_id_new AS spouse_id");
			return $result;
    }


?>