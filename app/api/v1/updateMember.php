<?php

    include_once '../config.php';
    date_default_timezone_set('Asia/Singapore');

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
        $stmt = $conn->prepare("CALL SP_DoUpdateMember(:member_id,:member_fname,:member_lname,:member_dob,:member_gender,:member_email,:member_pob,:member_vs)");
        $stmt->bindParam(':member_id', $member_id);
        $stmt->bindParam(':member_fname', $member_fname);
        $stmt->bindParam(':member_lname', $member_lname);
        $stmt->bindParam(':member_dob', $member_dob);
        $stmt->bindParam(':member_gender', $member_gender);
        $stmt->bindParam(':member_email', $member_email);
        $stmt->bindParam(':member_pob', $member_pob);
        $stmt->bindParam(':member_vs', $member_vs);

        $member_id = $r->member->memberID;
        $member_fname = $r->member->firstName;
        $member_lname = $r->member->lastName;
        if(!empty($r->member->dateOfBirth)){
                $date = str_replace('/', '-', $r->member->dateOfBirth);
                $member_dob = date('Y-m-d', strtotime($date));
        }else{
                $member_dob = NULL;
        }
        $member_gender = $r->member->gender;
        $member_email = $r->member->email;
        $member_pob = $r->member->placeOfBirth;
        $member_vs = $r->member->vitalStatus;


        $stmt->execute();

        $result = $stmt->fetch(PDO::FETCH_ASSOC);

         if($result !=  NULL) {
            $response['status'] = "sucess";
            $response['message'] = "Member Updated";       
        }else{
            throw new RuntimeException("There's an error updaating the memberm plase try again.");      
        }

    }
    catch(RuntimeException $e)
    {
        $response['status'] = "error";
        $response['message'] = $e->getMessage();
    }

    $conn = null;

    echo json_encode($response);
     
?>