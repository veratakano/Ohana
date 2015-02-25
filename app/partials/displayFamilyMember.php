<html>
<body>
<?php
	session_start();
	$tree_ID = $_SESSION['treeid'];
	
	$member_ID = 2;
	
	$servername = "localhost";
	$username = "root";
	$password = "password";
	$dbname = "Ohana";

	// Create connection
	$conn = new mysqli($servername, $username, $password, $dbname);
	// Check connection
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
	
	$result = $conn->query("SELECT * FROM Member WHERE treeID = $tree_ID;");
	$member_gender = array();
	
	
	if($result != NULL) {
		while(($row = $result->fetch_assoc())) {
			extract($row);
			
			$member_gender = $member_gender + array($memberID => $gender);
		}
	}
	
	//retrieve coordinates				
	$result = $conn->query("CALL `SP_Show_Family` ($member_ID, $tree_ID);");
	
	$member_array = array();
	$member_status_array = array();
	
	
	if($result != NULL) {
		while(($row = $result->fetch_assoc())) {
			extract($row);
			
			$member_array[$memberID] = array($fatherID, $motherID, $spouseID);
		}
		
	// foreach($member_array as $key => $value) {
			// echo "$key, $value[0], $value[1], $value[2]<br>";
		// }
		
		$type = "";
		
		foreach($member_array as $key => $values) {
			// for main family members
			if(array_key_exists($member_ID, $member_array)) {
				if (array_key_exists($values[0], $member_array) or array_key_exists ($values[1], $member_array)) {
				// $member_status_array[$key] = array($values[0], $values[1], $values[2], "offsprings");
				
					if ($member_gender[$key] == 'M') {
						$type = "Son";
					} 
					else {
						$type = "Daughter";
					}
					
					$member_status_array = $member_status_array + array($key => $type);
				}
				else {
					// $member_status_array[$key] = array($values[0], $values[1], $values[2], "parent");
					
					if ($values[0] != 0 and $values[1] != 0) {
						$member_status_array = $member_status_array + array($values[0] => "Father", $values[1] => "Mother");
					}
					
					if ($values[2] !== NULL and $key == $member_ID) {
						$member_status_array = $member_status_array + array($values[2] => "Spouse");
					}
					
					$type = "";
					
					if ($key != $member_ID) {
						if ($member_gender[$key] == 'M') {
							$type = "Brother";
						} 
						else {
							$type = "Sister";
						}
						$member_status_array = $member_status_array + array($key => $type);
					}
				}
			}
			// for spouses
			else {
				if (array_key_exists($values[0], $member_array) or array_key_exists ($values[1], $member_array)) {
				// $member_status_array[$key] = array($values[0], $values[1], $values[2], "offsprings");
				
					if ($member_gender[$key] == 'M') {
						$type = "Son";
					} 
					else {
						$type = "Daughter";
					}
					
					$member_status_array = $member_status_array + array($key => $type);
				}
				else {
					// $member_status_array[$key] = array($values[0], $values[1], $values[2], "parent");
					
					if ($values[0] != 0 and $values[1] != 0) {
						$member_status_array = $member_status_array + array($values[0] => "Father in Law", $values[1] => "Mother in Law");
					}
					
					echo "$member_ID<br>";
					if ($values[2] !== NULL and $key == $member_ID) {
						$member_status_array = $member_status_array + array($values[2] => "Spouse");
					}
				}
			}
		}
		
		echo "<br><br>";
		foreach($member_status_array as $key => $value) {
			echo "$key, $value<br>";
		}
		
	}
	  
?>



</body>
</html>
