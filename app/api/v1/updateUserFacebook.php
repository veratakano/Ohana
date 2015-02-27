<?php
     
    require_once 'dbHandler.php';

    $post = file_get_contents('php://input');
    $r = json_decode($post);
    $response = array();

     try {

        $userID = $r->userid;
        $fbid = $r->fbID;
        
        $db = new DbHandler();					
					
		$result = $db->getResult("CALL `SP_DoUpdateUserFacebook` ('$userID', '$fbid')");
        if($result['status'] ==  '0') {
            $response['status'] = "success";
            $response['message'] = "User Updated";       
        }else{
            throw new RuntimeException("There's an error updating facebook.");      
        }
    } catch (RuntimeException $e) {
        $response['status'] = "error";
        $response['message'] = $e->getMessage();
    }
    
    echo json_encode($response);       
?>
