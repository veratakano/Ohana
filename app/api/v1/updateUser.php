<?php
     
    require_once 'dbHandler.php';

    $post = file_get_contents('php://input');
    $r = json_decode($post);
    $response = array();

     try {

        $userID = $r->userid;
        $fname = $r->user->firstName;
        $lname = $r->user->lastName;
        $email = $r->user->email;
        $privacy = $r->privacy;
        if(!empty($r->user->password)){
            $pwd = md5($r->user->password);
            $pwd = "'$pwd'";
        }else{
            $pwd = "NULL";
        }
        
        $db = new DbHandler();					
					
		$result = $db->getResult("CALL `SP_DoUpdateUser` ('$userID', '$fname', '$lname', '$email', '$privacy', $pwd)");
        if($result['status'] ==  '0') {
            $response['status'] = "success";
            $response['message'] = "User Updated";       
        }else{
            throw new RuntimeException("There's an error updating the user please try again.");      
        }
    } catch (RuntimeException $e) {
        $response['status'] = "error";
        $response['message'] = $e->getMessage();
    }
    
    echo json_encode($response);       
?>


