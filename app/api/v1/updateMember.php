<?php
     
    require_once 'dbHandler.php';

    date_default_timezone_set('Asia/Singapore');

    $post = file_get_contents('php://input');
    $r = json_decode($post);
    $response = array();

     try {
        $member_id = $r->member->memberID;
        $member_fname = $r->member->firstName;
        $member_lname = $r->member->lastName;
        $date = str_replace('/', '-', $r->member->dateOfBirth);
        $member_dob = date('Y-m-d', strtotime($date));
        $member_gender = $r->member->gender;
        $member_email = $r->member->email;
        $member_pob = $r->member->placeOfBirth;
        $member_vs = $r->member->vitalStatus;
        
        $db = new DbHandler();
//        $result = $db->getResult("CALL SP_DoUpdateMember('$member_id','$member_fname','$member_lname','$member_dob','$member_gender','$member_email','$member_pob','$member_vs')");
 //       $result = $db->getResult("CALL SP_DoUpdateMember('$member_id','$member_fname','$member_lname', '$member_dob', '$member_gender','$member_email','$member_pob',$member_vs)");
					
					
		$result = $db->getResult("CALL `SP_DoUpdateMember` ($member_id, '$member_fname', '$member_lname', '$member_dob', '$member_gender', '$member_email', '$member_pob', $member_vs);");
        if($result !=  NULL) {
            $response['status'] = "sucess";
            $response['message'] = "Member Updated";       
        }else{
            throw new RuntimeException("There's an error updaating the memberm plase try again.");      
        }
    } catch (RuntimeException $e) {
        $response['status'] = "error";
        $response['message'] = $e->getMessage();
    }
    
    echo json_encode($response);       
?>