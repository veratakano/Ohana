
<?php

	require_once 'dbHandler.php';

	$response = array();

	try {
		//check upload error
		// Check $_FILES['upfile']['error'] value.
	    switch ($_FILES['image']['error']) {
	        case UPLOAD_ERR_OK:
	            break;
	        case UPLOAD_ERR_NO_FILE:
	            throw new RuntimeException('No file sent.');
	        case UPLOAD_ERR_INI_SIZE:
	        	throw new RuntimeException('Sorry file is too large.');
	        case UPLOAD_ERR_FORM_SIZE:
	            throw new RuntimeException('Exceeded filesize limit.');
	        default:
	            throw new RuntimeException('Unknown errors.');
	    }

	    $imageFileType = pathinfo($_FILES["image"]["name"],PATHINFO_EXTENSION);

		// Allow certain file formats
		if($imageFileType != "jpg" && $imageFileType != "JPG" && $imageFileType != "jpeg" && $imageFileType != "JPEG" ) {
	    	throw new RuntimeException('Sorry, only JPG & JPEG files are allowed.');
	   	}

		if (isset($_FILES['image'])) { 

			$mID = $_POST["memberID"];
			$tID = $_POST["treeID"];

		  	$type = $_FILES['image']['type'];

		  	//$file = cropAndResize(file_get_contents($_FILES['image']['tmp_name']));
		  	$file = cropAndResize($_FILES['image']['tmp_name']);

			$image = addslashes($file);

		  	$db = new DbHandler();
		    $result = $db->getResult("CALL SP_DoUploadProfilePic('$mID','$tID','$image','$type')");
		    if($result['status'] == 0) {
	            $response['status'] = "success";
	        }else{
	            throw new RuntimeException("There's a problem uploading the image");      
	        }
		}

	} catch (RuntimeException $e) {
		$response['status'] = "error";
    	$response['message'] = $e->getMessage();
	}

	echo json_encode($response);

	function cropAndResize($src) {

		$image = imagecreatefromjpeg($src);
		$thumb_width = 200;
		$thumb_height = 200;
		$width = imagesx($image);
		$height = imagesy($image);
		$original_aspect = $width / $height;
		$thumb_aspect = $thumb_width / $thumb_height;
		if ( $original_aspect >= $thumb_aspect ) {
			// If image is wider than thumbnail (in aspect ratio sense)
			$new_height = $thumb_height;
			$new_width = $width / ($height / $thumb_height);
		} else {
			// If the thumbnail is wider than the image
			$new_width = $thumb_width;
			$new_height = $height / ($width / $thumb_width);
		}
		$thumb = imagecreatetruecolor( $thumb_width, $thumb_height );
		// Resize and crop
		imagecopyresampled($thumb,
		$image,
		0 - ($new_width - $thumb_width) / 2, // Center the image horizontally
		0 - ($new_height - $thumb_height) / 2, // Center the image vertically
		0, 0,
		$new_width, $new_height,
		$width, $height);

		ob_start();

		imagejpeg($thumb, NULL, 100);

		$final_image = ob_get_contents();

    	ob_end_clean();

    	return $final_image;
	}

?>
