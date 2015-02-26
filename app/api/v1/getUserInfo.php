 <?php

 	require_once 'dbHandler.php';

  	$post = file_get_contents('php://input');
    $r = json_decode($post);

    $user = $r->user;

  	$response = array();

    try{
        $db = new DbHandler();
        $result = $db->getResult("SELECT email, firstName, lastName, fbID, created, lastlogin FROM Users WHERE uID = '$user'");
        if($result != null) {
            $response = $result;
        }else{
            throw new RuntimeException("Wrong User."); 
        }
    } catch (RuntimeException $e) {
        $response['status'] = "error";
        $response['message'] = $e->getMessage();
    }

 	echo json_encode($response);
?>