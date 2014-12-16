<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
    $mode = $r->mode;

    if($mode == login){
        funcLogin($r);
    }else if ($mode == logout){
        funcLogout();
    };

    function funcLogin($r) {

        $email = $r->user->email;
        $pwd = md5($r->user->password);
        $db = new DbHandler();
        $result = $db->getLogin("CALL SP_GetLogin('". $email . "', '" . $pwd . "')");
        $response = array();
        $user = $result->fetch_assoc();
        if($user != NULL) {
            $response['status'] = "success";
            $response['uid'] = $user['uid'];
            $response['email'] = $user['email'];
            if (!isset($_SESSION)) {
                session_start();
                $_SESSION['unqid']=uniqid('ang_');
                $response['unqid'] = $_SESSION['unqid'];
            }
        }else{
            $response['status'] = "error";
            $response['message'] = "Email or Password was not entered correctly.";      
        }

        header('application/json');
        echo json_encode($response);        
    }

    function funcLogout(){
        $ss = new Session();
        $session = $ss->destroySession();
        $response["status"] = "success";

        header('application/json');
        echo json_encode($response);   
    }


?>

