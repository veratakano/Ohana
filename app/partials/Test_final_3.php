
<html>
	<!-- get only the spouses of second generation
	--everything is displayed correctly according to y_axis except from the alignment
	-->
	
	<body>
		<?php
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
			
			// load the data from database
			// relation table
			
			$sql = "SELECT * FROM relation ORDER BY memberID;";
			$result = $conn->query($sql);
			
			// key:array_value pairs
			// key is member ID and array values are firstName, lastName, etc.
			$relation_array = array();
			$spouses = array();
			$father_id = 0;
			
			while($row = $result->fetch_assoc()) {
				extract($row);
				
				if (sizeof($relation_array) == 0)
					$father_id = $fatherID;
				
				$relation_array [$memberID] = array($fatherID, $motherID, $spouseID, $spouseTreeID);
				
				if ($spouseID != 0) 
					$spouses [] = $spouseID;
			}
			
			foreach($spouses as $sp) {
				
				//echo "a$sp : sp <br>";
			}
			
			//echo "<br><br>";
			
			// load the data from database
			// member table

			$sql = "SELECT * FROM Member;";
			$result = $conn->query($sql);
			$member_array = array();
			
			while($row = $result->fetch_assoc()) {
				extract($row);
				$member_array [$memberID] = array($firstName, $lastName, $gender);
				
			}
			
			arrangeTree($relation_array, $member_array, $spouses, $father_id, 1);
		
		foreach($spouses as  $val) {
			// 0 status means for spouses
			
			echo "spouse $val<br>";
			arrangeTree($relation_array, $member_array, $spouses, $val, 0);
			
		}

		
				
		
				
		$get_coordinate_values = array();
		
		// $user_id can be any IDs 
		// in this case, it's used only for spouses who still needs to be in the tree
		 function arrangeTree (&$relation_array, &$member_array, &$spouses, $user_id, $status) {
				$set_vh = false;
				$vertical_hierarchy = 0;
		
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
				
				
				$sql = "SELECT * FROM Coordinates;";
				$result = $conn->query($sql);
				$coordinate_array = array();
				
				while($row = $result->fetch_assoc()) {
					extract($row);
					$coordinate_array [$memberID] = array($x, $y, $verticalHierarchy);
					
				}
				
				$sql = "select memberID, fatherID, motherID, @sID:=spouseID 'spID' from Relation 
					join
					(select @sID:= $user_id)tmp
					where fatherID=@sID or motherID = @sID;";
					
				$result = $conn->query($sql);
				$abc = array();
				
				
				while($row = $result->fetch_assoc()) {
					extract($row);
					$abc [$memberID] = array($memberID, $fatherID, $motherID, $spID);
				}
				
				
					$x_coordinate = 30;
					$y_coordinate = 30;
					$outerCount = 0;
					$innerCount = 0;	
					
					
				
				foreach($abc as $key=>$values) {
					
					
					if (sizeof($coordinate_array) > 0 ) {
					if(!array_key_exists($key, $coordinate_array)) {
						
					
						$get_coordinate_values = $coordinate_array[$user_id];
						$x_coordinate = $get_coordinate_values[0];
						$y_coordinate = $get_coordinate_values[1] + 20;
						
						$sql = "select * from relation where fatherID = $user_id or motherID = $user_id;";
						$result = $conn->query($sql);
						
						//$y_coordinate = $get_coordinate_values[1] + ($outerCount * 10);
						
						while($row = $result->fetch_assoc()) {
							extract($row);
							
								$x_coordinate = $get_coordinate_values[0] + ($innerCount * 20);
							
								$innerCount = $innerCount + 1;
											
								$insertSql = "insert into coordinates values ($memberID, $x_coordinate, $y_coordinate, 0);";
								$insertResult = $conn->query($insertSql);
								
								if($spouseID != 0) {
									
									$x_spouse_temp = $x_coordinate + 20;
									
									// check gender
									// swap x, y positions of male and female
									// male in front
									if (array_key_exists($spouseID, $member_array)) {
										$member_values = $member_array[$spouseID];
										
										if($member_values[2] == 'M') {
											// assign the x, y coordinate of female 
											$insertSql = "insert into coordinates values ($spouseID, $x_coordinate, $y_coordinate, 0);";
											$conn->query($insertSql);
											
											// update the x, y coordinate of female to male's x,y
											$updateSQL = "update coordinates set x = $x_spouse_temp where memberID = $memberID;";
											$conn->query($updateSQL);
										}
										else { 
											
											$insertSql = "insert into values ($spouseID, $x_spouse_temp, $y_coordinate, 0);";
											$insertResult = $conn->query($insertSql);
										}
									}
								
								unset($relation_array[$memberID]);
								
								// remove spouses who are already in the hierarchy
								// to get the spouses who aren't in the list
								$spouse_to_delete = array_search($user_id, $spouses);
									unset ($spouses[$spouse_to_delete]);
								}
							}
						}
					}
					
				if ($status == 1) {
						
					$sql = "select * from relation where fatherID = $values[1] and motherID = $values[2];";
					$result = $conn->query($sql);
					
					$y_temp = $y_coordinate + ($outerCount * 20);
					
					while($row = $result->fetch_assoc()) {
						extract($row);
						
						$innerCount = $innerCount + 1;
						
						$arr = array();
						
						if($set_vh == false) {
							$vertical_hierarchy = $vertical_hierarchy + 1;
						}
						else {
							$vertical_hierarchy = 0;
						}
						
						if ($innerCount == 0) {
							$x_temp = $x_coordinate;
						}
						else {
							$x_temp = $x_coordinate + ($innerCount * 20);
						}
											
	
						$insertSql = "insert into coordinates values ($memberID, $x_temp, $y_temp, $vertical_hierarchy);";
						
						$insertResult = $conn->query($insertSql);
						
						if($spouseID != 0) {
							$innerCount = $innerCount + 1;
							$x_spouse_temp = $x_coordinate + ($innerCount * 20);
							
							
							//check gender
							if (array_key_exists($spouseID, $member_array)) {
								$member_values = $member_array[$spouseID];
								
								if($member_values[2] == 'M') {
									// assign the x, y coordinate of female 
									$insertSql = "insert into coordinates values ($spouseID, $x_temp, $y_temp, $vertical_hierarchy);";
									$conn->query($insertSql);
									
									// update the x, y coordinate of female to male's x,y
									$updateSQL = "update coordinates set x = $x_spouse_temp where memberID = $memberID;";
									$conn->query($updateSQL);
								}
								else {
									
									$insertSql = "insert into coordinates values ($spouseID, $x_spouse_temp, $y_temp, $vertical_hierarchy);";
									$insertResult = $conn->query($insertSql);
								}
								
								
							}
							
						}
						
						unset($relation_array[$memberID]);
						
					}
					
					$set_vh = true;
				}
				
				$innerCount = 0;
				$outerCount = $outerCount + 1;
			}
				
				// with second loop
			
		 }
		 
		// alignTree();
		 
		 function alignTree () {
			 
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
			
			 
			$sql = "SELECT * FROM Relation;";
			$result = $conn->query($sql);
			$relation_array = array();
				
			while($row = $result->fetch_assoc()) {
				extract($row);
				$relation_array [$memberID] = array($fatherID, $motherID, $spouseID);
				
			}
			 
			 $sql = "SELECT * FROM Coordinates;";
				$result = $conn->query($sql);
				$coordinate_array = array();
				
				while($row = $result->fetch_assoc()) {
					extract($row);
					$coordinate_array [$memberID] = array($x, $y, $verticalHierarchy);
					
				}
				
				foreach($coordinate_array as $key => $values) {
					echo "$key : ";
					
		
					
					echo " <br>";
					
					
					
					$father_id = 0;
					$vertical_hierarchy = 0;
					
					$coordinate_child = $coordinate_array[$key];
					
					if ($coordinate_child[2] == 0) {
	
						if(array_key_exists($key, $relation_array)) {
							
							$relation_child = $relation_array[$key];
							$father_id = $relation_child[0];
							
							$coordinate_father = $coordinate_array[$father_id];
							$vertical_hierarchy = $coordinate_father[2];
							
							echo "father_vh $vertical_hierarchy, fID: $father_id , memID: $key spouse: $relation_child[2]<br> <br>";
							
							$sql = "update coordinates set verticalHierarchy = $vertical_hierarchy where memberID = $key;";
							$conn->query($sql);
							
							
							// update spouse
							if ($relation_child[2] != 0) {
								$sql = "update coordinates set verticalHierarchy = $vertical_hierarchy where memberID = $relation_child[2];";
								$conn->query($sql);
							}
						}
					}
				}
		 }
			
			
			// display
				$sql = "select * from coordinates;";
					
				$result = $conn->query($sql);
				
				
				while($row = $result->fetch_assoc()) {
					extract($row);
					
					
					echo'<div style="top: '. $y .'%; left:' . $x . '%; position: absolute;">
							<div>' . $memberID . '</div>
						</div>';
				}
		?>
		
	</body>
</html>