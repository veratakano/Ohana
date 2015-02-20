<?php

			session_start();
			$treeID = $_SESSION['treeid'];
			echo $treeID;

			//********* edit
			
			$treeID = 1;
			
			
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
			
			//retrieve coordinates
			$sql = "select * from coordinates where TreeID = $treeID;";
					
			$result = $conn->query($sql);
				
			$coor_array = array();
			while($row = $result->fetch_assoc()) {
				extract($row);
					
				$coor_array[$memberID] = array($fatherID, $motherID, $spouseID, $x, $y);
			}
			
			//retrieve relation
			$sql = "select * from Relation where TreeID = $treeID;";
					
			$result = $conn->query($sql);
				
			$relation_array = array();
			while($row = $result->fetch_assoc()) {
				extract($row);
					
				$relation_array[$memberID] = array($fatherID, $motherID, $spouseID);
			}
			
			//retrieve member
			$sql = "select * from member where TreeID = $treeID;";
					
			$result = $conn->query($sql);
				
			$member_array = array();
			while($row = $result->fetch_assoc()) {
				extract($row);
					
				$member_array[$memberID] = array($firstName, $lastName, $gender, $vitalStatus);
			}
				
				
			// display
			$sql = "select * from coordinates where TreeID = $treeID order by fatherID, y, x;";	
			$result = $conn->query($sql);
			
			$coor_values = array();
			$member_values = array();
			
			// array used for display
			$display_array = array();
			
			$count = 0;
			$father_id = 0;
			$mother_id = 0;
			
			// initial and last x
			$x0 = 0;
			$x1 = 0;
			
			while($row = $result->fetch_assoc()) {
				extract($row);
					
				$member_values = $member_array[$memberID];
				
				IF (is_null($member_values[0])) 
					$name = "$memberID Undefined";
				else
					$name = "$memberID $member_values[0] $member_values[1]";
				
				/** colour **/
				if($member_values[3] != 0) {
					if($member_values[2] == 'M') 
						// change colour of males
						echo '<div class="windowMale" style="top: '. ($y*7) .'px; left: '. ($x*7) .'px" id="container0" ng-click="openDialog('. $memberID . ')">  
							<div>'. $name . '</div>
						</div> ';
					else 
						// change colours of females
						echo '<div class="windowFemale" style="top: '. ($y*7) .'px; left: '. ($x*7) .'px" id="container0" ng-click="openDialog('. $memberID . ')">  
							<div>'. $name . '</div>
						</div> ';					
				}
				else {
					// change colour of passed-away
					echo '<div class="window" style="top: '. ($y*7) .'px; left: '. ($x*7) .'px" id="container0" ng-click="openDialog('. $memberID . ')">  
						<div>'. $name . '</div>
					</div> ';
				}
					//$member_values[0]
				/** colour **/

				/** lines **/	
				
				if ($fatherID != 0 and $motherID != 0) {
					
					if($father_id != $fatherID or $mother_id != $motherID) {

						$x0 = $x;
						
						$father_id = $fatherID;
						$mother_id = $motherID;
						$count = $count + 1;						
					}					
					$x1 = $x;
										
					$display_array[$count] = array($x0, $x1, $y);
				}
				
				// echo "$count + > $fatherID: (x0,x1) ($x0 , $x1 & $y)<br>";
				
				if (array_key_exists($memberID, $relation_array)) {
					if ($fatherID != 0 and $motherID != 0)
						// kid's vertical line
						echo '<div style="top:'. (($y-3) *7) .'px; left:'. (($x+2) *7) .'px; position: absolute;">  
							<div style="width: 2px; height: 20px; background-color: grey;"></div>
						</div> ';
				}
				
				if ($spouseID <> 0) {
					
					// spouse downword vertical line
					echo '<div style="top:'. (($y+9) *7) .'px; left:'. (($x+2) *7) .'px; position: absolute;">  
						<div style="width: 2px; height: 20px; background-color: grey;"></div>
					</div> ';
						
					if(array_key_exists($memberID, $relation_array)) {
						$coor_values = $coor_array[$spouseID];
						$spouse_x = $coor_values[3];
							
						if($x < $spouse_x) {
							// spouse horizontal line
							echo '<div style="top:'. ( ($y+12)*7) .'px; left:'. (($x+2) *7) .'px; position: absolute;">  
								<div style="width: 143px; height: 2px; background-color: grey;"></div>
							</div> ';	
						}
						else {
							// spouse horizontal line
							echo '<div style="top:'. ( ($y+12)*7) .'px; left:'. (($spouse_x+2) *7) .'px; position: absolute;">  
								<div style="width: 143px; height: 2px; background-color: grey;"></div>
							</div> ';
						}
					}
				}
			}
			
			// get the x,y value out from the loop
			$display_array[$count+1] = array($x0, $x1, $y);
			$display_values = array();
			
			
			foreach ($display_array as $key=>$value) {
				$display_values = $value;
				
				$generation_count = ($display_values[1] - $display_values[0])/20;
				if ($generation_count > 0) {
							
					// echo "Display: $display_values[0], $display_values[1], $display_values[2] <br> gc: $generation_count<br>";
					// horizontal line for kids
					echo '<div style="top:'. (($display_values[2]-3)*7) .'px; left:'. (($display_values[0]+2) *7) .'px; position: absolute;">  
						<div style="width:'. ( ($display_values[1] - $display_values[0])*7) .'px; height: 1.5px; background-color: grey;"></div>
					</div> ';
				
					// vertical connection between kids and parents
					echo '<div style="top:'. (($display_values[2]-8) *7) .'px; left:'. (($display_values[0]+9) *7) .'px; position: absolute;">  
						<div style="width: 2px; height: 30px; background-color: grey;"></div>
					</div> ';					
				}
				else {
					// vertical connection between kids and parents
					echo '<div style="top:'. (($display_values[2]-8) *7) .'px; left:'. (($display_values[0]+2) *7) .'px; position: absolute;">  
						<div style="width: 2px; height: 30px; background-color: grey;"></div>
					</div> ';	
				}
			}
		
?>
