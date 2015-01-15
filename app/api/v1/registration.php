<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
        
    $resultUser = createUser($r);
    
    $response = array();

    if($resultUser !=  NULL) {
        switch ($result['status']) {
            case 0:
                $resultTree = createTree($resultUser['uid']);
                if($resultTree['status'] == 0){
                    $response['status'] = 'success';
                    $response['uid'] = $resultUser['uid'];
                    $response['email'] = $resultUser['email'];
                    if (!isset($_SESSION)) {
                        session_start();
                        $_SESSION['unqid']=uniqid('ang_');
                        $_SESSION['uid'] = $resultUser['uid'];
                        $_SESSION['email'] = $resultUser['email'];
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
        $pwd = md5($r->user->password);

        $result = $db->getResult("CALL SP_DoRegistration('". $fname . "', '". $lname . "', '". $email . "', '" . $pwd . "')");
        return $result;
    };

    function createTree($uid){

        $db = new DbHandler();

        $result = $db->getResult("CALL SP_DoCreateTree('Testing','". $uid ."')");
        return $result;
    };

?>