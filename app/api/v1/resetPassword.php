<?php
     
    require_once 'dbHandler.php';
    require '../PHPMailer/PHPMailerAutoload.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
    $response = array();

    try {

        $db = new DbHandler();

        $email = $r->email;
        $password = randomPassword();
        $md5Password = md5($password);

        $result = $db->getResult("CALL SP_DoResetPassword('$email','$md5Password')");

        if($result !=  NULL) {
            switch ($result['status']) {
                case 0:
                    if(sendemail($email,$password,$result['firstName'],$result['lastName'])){
                        $response['status'] = 'success';
                        $response['message'] = 'A email with the a new password has been sent to ' . $email . '. Please change your password after the first login.';
                    }else{
                        throw new RuntimeException("An error has sending email."); 
                        break;
                    }
                    break;
                case 1:
                    throw new RuntimeException("An error has occur please contact administrator."); 
                    break;
                case 2:
                    throw new RuntimeException("This is not a registed email address."); 
                    break;
            };
        };

    } catch (RuntimeException $e) {
        $response['status'] = "error";
        $response['message'] = $e->getMessage();
    }

    echo json_encode($response);

    function randomPassword() {
        $alphabet = "abcdefghijklmnopqrstuwxyzABCDEFGHIJKLMNOPQRSTUWXYZ0123456789";
        $pass = array(); //remember to declare $pass as an array
        $alphaLength = strlen($alphabet) - 1; //put the length -1 in cache
        for ($i = 0; $i < 8; $i++) {
            $n = rand(0, $alphaLength);
            $pass[] = $alphabet[$n];
        }
        return implode($pass); //turn the array into a string
    }

    function sendemail($email,$password,$firstName,$lastName) {

        $FullName = $firstName . ' ' . $lastName;

        //Create a new PHPMailer instance
        $mail = new PHPMailer;

        //Tell PHPMailer to use SMTP
        $mail->isSMTP();

        //Enable SMTP debugging
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
        $mail->addAddress($email, $FullName);

        //Set the subject line
        $mail->Subject = 'Password Reset';

        //Read an HTML message body from an external file, convert referenced images to embedded,
        //convert HTML into a basic plain-text alternative body

        $message = file_get_contents('../mail_templates/reset.html');
        $message = str_replace('%userfullname%', $FullName, $message);
        $message = str_replace('%userpassword%', $password, $message);

        $mail->msgHTML($message);

        //Replace the plain text body with one created manually
        $mail->AltBody = 'This is a plain-text message body';

        //send the message, check for errors
        if (!$mail->send()) {
            return false;
        } else {
            return true;
        }   
    }

?>