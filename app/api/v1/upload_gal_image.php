
<?php

	require_once 'dbHandler.php';

	$mID = $_POST["memberID"];
	$tID = $_POST["treeID"];

	$filename = $_FILES['image']['name'];
  	$destination = '../../assets/img/users/' . $mID . '/';
  	$fileDest = $destination . $filename;

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

		//if (!mkdir($destination, 0777, true)) {
		//	$response['status'] = "error";
        //    $response['message'] = "Failed to create folders.";
		//}
		move_uploaded_file($_FILES['image']['tmp_name'] , $fileDest );

	  	$destinationDB = 'assets/img/users/' . $mID . '/';
	  	$fileDestDB = $destinationDB . $filename;

	  	$db = new DbHandler();
	    $result = $db->getResult("CALL SP_DoUploadPGalleryPic('$mID','$tID','$filename','$fileDestDB','null')");
	    if($result['status'] == 0) {
            $response['status'] = "success";
        }else{
            $response['status'] = "error";
            $response['message'] = "There's a problem uploading the image";      
        }
	}

	echo json_encode($response);

?>
