<?php
     
    include_once '../config.php';

    $post = file_get_contents('php://input');
    $r = json_decode($post);
    $response = array();

    $servername = DB_HOST;
    $username = DB_USERNAME;
    $password = DB_PASSWORD;
    $dbname = DB_NAME;

     try {

        $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
        // set the PDO error mode to exception
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);


        // prepare sql and bind parameters
        $stmt = $conn->prepare("CALL `SP_DoUpdateUser` (:userID, :fname, :lname, :email, :privacy, :pwd)");
        $stmt->bindParam(':userID', $userID);
        $stmt->bindParam(':fname', $fname);
        $stmt->bindParam(':lname', $lname);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':privacy', $privacy);
        $stmt->bindParam(':pwd', $pwd);

        $userID = $r->userid;
        $fname = $r->user->firstName;
        $lname = $r->user->lastName;
        $email = $r->user->email;
        $privacy = $r->privacy;
        if(!empty($r->user->password)){
            $pwd = md5($r->user->password);
        }else{
            $pwd = NULL;
        }

         $stmt->execute();

        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if($result['status'] ==  '0') {
            $response['status'] = "success";
            $response['message'] = "User Updated";       
        }else{
            throw new RuntimeException("There's an error updating the user please try again.");      
        }
    } catch (RuntimeException $e) {
        $response['status'] = "error";
        $response['message'] = $e->getMessage();
    }

    $conn = null;
    
    echo json_encode($response);       
?>


