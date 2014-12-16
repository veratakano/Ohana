<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
    $mode = $r->mode;

    $fname = $r->user->fname;
    $lname = $r->user->lname;
    $email = $r->user->email;
    $pwd = md5($r->user->password);

    $db = new DbHandler();
        
    $result = $db->getResult("CALL SP_DoRegistration('". $fname . "', '". $lname . "', '". $email . "', '" . $pwd . "')");
    
    $response = array();

    if($result !=  NULL) {
        switch ($result['status']) {
            case 0:
                $response['status'] = 'success';
                $response['uid'] = $result['uid'];
                $response['email'] = $result['email'];
                if (!isset($_SESSION)) {
                    session_start();
                    $_SESSION['unqid']=uniqid('ang_');
                    $_SESSION['uid'] = $result['uid'];
                    $_SESSION['email'] = $result['email'];
                    $response['unqid'] = $_SESSION['unqid'];
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


?>