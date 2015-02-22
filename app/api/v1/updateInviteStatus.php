<?php
     
    require_once 'dbHandler.php';

    $post = file_get_contents('php://input');
    $r = json_decode($post);
    $type = $r->type;
    $status = $r->status;
    $memberID = $r->member;

    $response = array();

    if ($type = 'invite'){
        if(updateInviteStatus($memberID,$status)){
            $response['status'] = "success";
            $response['message'] = "status updated";
        } else {
            $response['status'] = "error";
            $response['message'] = "Error updating member's invite status";
        }
    }

        echo json_encode($response);

    function updateInviteStatus($memberID,$status)
    {
        $db = new DbHandler();
        $result = $db->getResult("CALL SP_UpdateInviteStatus('$memberID','$status')");
        $response = array();
        $member = $result;
        if($result['status'] == 0) {
            return true;
        }else{
            return false;
        }
    }
?>