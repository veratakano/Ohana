<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
    $response = array();

    try {
        $email = $r->user->email;
        $pwd = $r->user->password;
        if(!empty($pwd)){
            $pwd = md5($pwd);
            $pwd = "'$pwd'";
        }else{
            $pwd = "NULL";
        }
        $fbid = $r->user->fbID;
        $fbid = !empty($fbid) ? "'$fbid'" : "NULL";
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

