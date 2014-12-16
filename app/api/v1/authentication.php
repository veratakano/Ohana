<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);


        $email = $r->user->email;
        $pwd = md5($r->user->password);
        $db = new DbHandler();
        $result = $db->getResult("CALL SP_GetLogin('". $email . "', '" . $pwd . "')");
        $response = array();
        $user = $result;
        if($user != NULL) {
            $response['status'] = "success";
            $response['uid'] = $user['uid'];
            $response['email'] = $user['email'];
            if (!isset($_SESSION)) {
                session_start();
                $_SESSION['unqid']=uniqid('ang_');
                $_SESSION['uid'] = $result['uid'];
                $_SESSION['email'] = $result['email'];
                $response['unqid'] = $_SESSION['unqid'];
            }
        }else{
            $response['status'] = "error";
            $response['message'] = "Email or Password was not entered correctly.";      
        }

        echo json_encode($response);        
    

?>

