<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
    $response = array();

    try {
        $email = $r->user->email;
        if(!empty($r->user->password;)){
            $pwd = md5($r->user->password;);
            $pwd = "'$pwd'";
        }else{
            $pwd = "NULL";
        }

        $fbid = !empty($r->user->fbID) ? "'$fbid'" : "NULL";
        $db = new DbHandler();
        $result = $db->getResult("CALL SP_GetLogin('$email', $pwd, $fbid)");
        $user = $result;
        if($user != NULL) {
            $response['status'] = "success";
            $response['uid'] = $user['uID'];
            $response['email'] = $user['email'];
            $response['treeid'] = $user['treeID'];
            if (!isset($_SESSION)) {
                session_start();
                $_SESSION['unqid']=uniqid('ang_');
                $_SESSION['uid'] = $user['uID'];
                $_SESSION['email'] = $user['email'];
                $_SESSION['treeid'] = $user['treeID'];
                $response['unqid'] = $_SESSION['unqid'];        
            }
        }else{
            $response['status'] = "error";
            $response['message'] = "Email or Password was not entered correctly.";      
        }
    } catch (Exception $e) {
        $response['status'] = "error";
        $response['message'] = $e->getMessage();
    }
        echo json_encode($response);        

?>

