<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
        
    $resultUser = createUser($r);
    
    $response = array();

    if($resultUser !=  NULL) {
        switch ($resultUser['status']) {
            case 0:
                $resultTree = createTree($resultUser['uID']);
                if($resultTree['status'] == 0){
                    $response['status'] = 'success';
                    $response['uID'] = $resultUser['uID'];
                    $response['email'] = $resultUser['email'];
                    $response['treeid'] = $resultTree['treeID'];
                    if (!isset($_SESSION)) {
                        session_start();
                        $_SESSION['unqid']=uniqid('ang_');
                        $_SESSION['uID'] = $resultUser['uID'];
                        $_SESSION['email'] = $resultUser['email'];
                        $_SESSION['treeid'] = $resultTree['treeID'];
                        $response['unqid'] = $_SESSION['unqid'];
                    }
                } else{
                    $response['status'] = "error";
                    $response['message'] = "An error has occur please contact administrator."; 
                }
                break;
            case 1:
                $response['status'] = "error";
                $response['message'] = "An error has occur please contact administrator."; 
                break;
            case 2:
                $response['status'] = "error";
                $response['message'] = "This email address is already registered."; 
                break;
        };
    };

    echo json_encode($response);

    function createUser($r){

        $db = new DbHandler();

        $fname = $r->user->fname;
        $lname = $r->user->lname;
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

        $result = $db->getResult("CALL SP_DoRegistration('$fname', '$lname', '$email', $pwd, $fbid)");
        return $result;
    };

    function createTree($uid){

        $db = new DbHandler();

        $result = $db->getResult("CALL SP_DoCreateTree('Testing','$uid')");
        return $result;
    };

?>