<?php
     
    require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
    $response = array();

	if(!empty($r->invite->tid)){
        $inviteTreeID = $r->invite->tid;
    }

    try {

        $resultUser = createUser($r);

        if($resultUser !=  NULL) {
            switch ($resultUser['status']) {
                case 0:
                       if($inviteTreeID != NULL){
                           $resultShare = createShareTree($resultUser['uID'],$inviteTreeID);
                           if($resultShare !=  NULL){
                                $response['status'] = 'success';
                                $response['uID'] = $resultUser['uID'];
                                $response['email'] = $resultUser['email'];
                                $response['treeid'] = $resultUser['treeID'];
                                if (!isset($_SESSION)) {
                                    session_start();
                                    $_SESSION['unqid']=uniqid('ang_');
                                    $_SESSION['uID'] = $resultUser['uID'];
                                    $_SESSION['email'] = $resultUser['email'];
                                    $_SESSION['treeid'] = $resultUser['treeID'];
                                    $response['unqid'] = $_SESSION['unqid'];
                                }
                           } else {
                                throw new RuntimeException("Error creating share tree"); 
                           }
                       } else {
                            $response['status'] = 'success';
                            $response['uID'] = $resultUser['uID'];
                            $response['email'] = $resultUser['email'];
                            $response['treeid'] = $resultUser['treeID'];
                            if (!isset($_SESSION)) {
                                session_start();
                                $_SESSION['unqid']=uniqid('ang_');
                                $_SESSION['uID'] = $resultUser['uID'];
                                $_SESSION['email'] = $resultUser['email'];
                                $_SESSION['treeid'] = $resultUser['treeID'];
                                $response['unqid'] = $_SESSION['unqid'];
                            }
                        }
                    break;
                case 1:
                    throw new RuntimeException("An error has occur please contact administrator."); 
                    break;
                case 2:
                    throw new RuntimeException("This email address is already registered."); 
                    break;
            };
        };

    } catch (RuntimeException $e) {
        $response['status'] = "error";
        $response['message'] = $e->getMessage();
    }

    echo json_encode($response);

    function createUser($r){

        $db = new DbHandler();

        $fname = $r->user->fname;
        $lname = $r->user->lname;
        $email = $r->user->email;
        $gender = $r->user->gender;
        $privacy = $r->user->privacy;
        if(!empty($r->user->password)){
            $pwd = md5($r->user->password);
            $pwd = "'$pwd'";
        }else{
            $pwd = "NULL";
        }
       if(!empty($r->user->fbID)){
            $fbid = $r->user->fbID;
            $fbid = "'$fbid'";
        }else{
            $fbid = "NULL";
        };

        $result = $db->getResult("CALL SP_DoRegistration('$fname','$lname','$email','$gender','$privacy',$pwd,$fbid)");
        return $result;

    };

    function createShareTree($memberID,$treeID){

        $db = new DbHandler();
        $result = $db->getResult("CALL SP_DoCreateTreeShare('$memberID', '$treeID')");
        return $result;

    };

?>