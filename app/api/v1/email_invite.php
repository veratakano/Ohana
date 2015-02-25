<?php

//SMTP needs accurate times, and the PHP time zone MUST be set
//This should be done in your php.ini, but this is how to do it if you don't have access to that
date_default_timezone_set('Etc/UTC');

require_once 'dbHandler.php';

require '../PHPMailer/PHPMailerAutoload.php';

//Create a new PHPMailer instance
$mail = new PHPMailer;

$post = file_get_contents('php://input');
$r = json_decode($post);
$rEmail = $r->member->email;
$rFullName = $r->member->firstName . ' ' . $r->member->lastName;
$rID = $r->member->memberID;
$rTreeID = $r->member->treeID;

$response = array();

//Tell PHPMailer to use SMTP
$mail->isSMTP();

//Enable SMTP debugging
// 0 = off (for production use)
// 1 = client messages
// 2 = client and server messages
$mail->SMTPDebug = 0;

//Ask for HTML-friendly debug output
$mail->Debugoutput = 'html';

//Set the hostname of the mail server
$mail->Host = 'smtp.gmail.com';

//Set the SMTP port number - 587 for authenticated TLS, a.k.a. RFC4409 SMTP submission
$mail->Port = 587;

//Set the encryption system to use - ssl (deprecated) or tls
$mail->SMTPSecure = 'tls';

//Whether to use SMTP authentication
$mail->SMTPAuth = true;

//Username to use for SMTP authentication - use full email address for gmail
$mail->Username = "no.reply.ohana@gmail.com";

//Password to use for SMTP authentication
$mail->Password = "ohanaPw1";

//Set who the message is to be sent from
$mail->setFrom('no.reply.ohana@gmail.com', 'Ohana');

//Set who the message is to be sent to
$mail->addAddress($rEmail, $rFullName);

//Set the subject line
$mail->Subject = 'Invitation to join Ohana!';

//Read an HTML message body from an external file, convert referenced images to embedded,
//convert HTML into a basic plain-text alternative body
$url = "http://$_SERVER[HTTP_HOST]/app/#/invite?mid=" . $rID . "&tid=" . $rTreeID;

$message = file_get_contents('../mail_templates/contents.html');
$message = str_replace('%memberfullname%', $rFullName, $message);
$message = str_replace('%inviteURL%', $url, $message);

$mail->msgHTML($message);

//Replace the plain text body with one created manually
$mail->AltBody = 'This is a plain-text message body';

//Attach an image file
$mail->addAttachment('images/phpmailer_mini.png');

//send the message, check for errors
if (!$mail->send()) {
	$response['status'] = "error";
    $response['message'] = "Mailer Error: " . $mail->ErrorInfo;
} else {
	if(updateInviteStatus($rID,'pending')){
		$response['status'] = "success";
    	$response['message'] = "Message sent!";
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
