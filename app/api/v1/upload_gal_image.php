
<?php

	require_once 'dbHandler.php';

	$mID = $_POST["memberID"];
	$tID = $_POST["treeID"];

	$imageFileType = pathinfo($_FILES["image"]["name"], PATHINFO_EXTENSION);
	// Obtain safe unique name from img's binary data.
	$filename = sprintf('%s.%s',sha1_file($_FILES['image']['tmp_name']), $imageFileType);
  	$destination = 'assets/img/users/' . $mID . '/';
  	$fileDest = $destination . $filename;
  	$destinationTn = 'assets/img/users/' . $mID . '/tn/';
  	$fileDestTn = $destinationTn . $filename;

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

		// Allow certain file formats
		if($imageFileType != "jpg" && $imageFileType != "JPG"  && $imageFileType != "png" && $imageFileType != "PNG" && $imageFileType != "jpeg"
			&& $imageFileType != "JPEG" && $imageFileType != "gif" && $imageFileType != "GIF" ) {
	    	throw new RuntimeException('Sorry, only JPG, JPEG, PNG & GIF files are allowed.');
		} 

		// Check if make folder exist
		if (!file_exists('../../'.$destination)) {
			mkdir('../../'.$destination, 0777, true);
			mkdir('../../'.$destinationTn, 0777, true);
		}

		if (isset($_FILES['image'])) { 
			if (move_uploaded_file($_FILES['image']['tmp_name'],'../../'.$fileDest)){
			  	createThumb('../../'.$fileDest, '../../'.$fileDestTn);

			  	$db = new DbHandler();
			    $result = $db->getResult("CALL SP_DoUploadPGalleryPic('$mID','$tID','$filename','$destination','$destinationTn')");
			    if($result['status'] == 0) {
		            $response['status'] = "success";
		        }else{
		            throw new RuntimeException("There's a problem uploading the image");      
		        }
			} else{
		         throw new RuntimeException("There's a problem uploading the image");      
			}
		}
	} catch (RuntimeException $e) {
		$response['status'] = "error";
    	$response['message'] = $e->getMessage();
	}

	echo json_encode($response);

	function createThumb($src, $dest) {

		$image = imagecreatefromjpeg($src);
		$thumb_width = 183;
		$thumb_height = 137;
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
		imagejpeg($thumb, $dest);
	}

?>
