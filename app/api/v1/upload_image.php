
<?php

	require_once 'dbHandler.php';

	$uploadOk = 1;
	$imageFileType = pathinfo($_FILES["image"]["name"],PATHINFO_EXTENSION);

	$response = array();

	// Check file size
	if ($_FILES["image"]["size"] > 8000000) {
    	$response['status'] = "error";
    	$response['message'] = "Sorry, your file is too large.";
    	$uploadOk = 0;
	}

	// Allow certain file formats
	if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
		&& $imageFileType != "gif" ) {
		$response['status'] = "error";
    	$response['message'] = "Sorry, only JPG, JPEG, PNG & GIF files are allowed.";
    	$uploadOk = 0;
	} 

	if (isset($_FILES['image']) && $uploadOk = 1) { 

		$mID = $_POST["memberID"];
		$tID = $_POST["treeID"];

	  	$type = $_FILES['image']['type'];
		$image = addslashes(file_get_contents($_FILES['image']['tmp_name']));

	  	$db = new DbHandler();
	    $result = $db->getResult("CALL SP_DoUploadProfilePic('$mID','$tID','$image','$type')");
	    if($result['status'] == 0) {
            $response['status'] = "success";
        }else{
            $response['status'] = "error";
            $response['message'] = "There's a problem uploading the image";      
        }
	}

	echo json_encode($response);

?>
