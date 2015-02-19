	<!-- dashboard -->
  
	<head>  
  
    <style>  
  
        .window {   
  
            background-color: #EEEEEF; 
			border: 1px solid #346789;    
            border-radius: 0.5em;    
            box-shadow: 1px 1px 2px #AAAAAA;    
            color: black;   
            height: 4em;   
            position: absolute;    
            width: 4em;  			
			margin: 0 auto; 
        }  
		
		.windowMale {   
  
            background-color: #38ACEC; 
			border: 1px solid #346789;    
            border-radius: 0.5em;    
            box-shadow: 1px 1px 2px #AAAAAA;    
            color: black;   
            height: 4em;   
            position: absolute;    
            width: 4em;  			
			margin: 0 auto; 
        }  
		
		.windowFemale {   
  
            background-color: #FAAFBE; 
			border: 1px solid #346789;    
            border-radius: 0.5em;    
            box-shadow: 1px 1px 2px #AAAAAA;    
            color: black;   
            height: 4em;   
            position: absolute;    
            width: 4em;  			
			margin: 0 auto; 
        }  
  
    </style>  
  
	</head>  	  
	<body >  
	 
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
			
			//retrieve coordinates
			$sql = "select * from coordinates;";
					
			$result = $conn->query($sql);
				
			$coor_array = array();
			while($row = $result->fetch_assoc()) {
				extract($row);
					
				$coor_array[$memberID] = array($fatherID, $motherID, $spouseID, $x, $y);
			}
			
			//retrieve relation
			$sql = "select * from Relation;";
					
			$result = $conn->query($sql);
				
			$relation_array = array();
			while($row = $result->fetch_assoc()) {
				extract($row);
					
				$relation_array[$memberID] = array($fatherID, $motherID, $spouseID);
			}
			
			//retrieve member
			$sql = "select * from member;";
					
			$result = $conn->query($sql);
				
			$member_array = array();
			while($row = $result->fetch_assoc()) {
				extract($row);
					
				$member_array[$memberID] = array($firstName, $lastName, $gender, $vitalStatus);
			}
				
				
			// display
			$sql = "select * from coordinates order by fatherID, y, x;";	
			$result = $conn->query($sql);
			
			$coor_values = array();
			$member_values = array();
			
			
			$display_array = array();
			
			$count = 0;
			$father_id = 0;
			$mother_id = 0;
			$father_x = 0;
		
			$x0 = 0;
			$x1 = 0;
			
			while($row = $result->fetch_assoc()) {
				extract($row);
					
				$member_values = $member_array[$memberID];
				
				/** colour **/
				if($member_values[3] != 0) {
					if($member_values[2] == 'M') 
						// change colour of males
						echo '<div class="windowMale" style="top: '. $y .'%; left: '. $x .'%" id="container0" ng-click="openDialog('. $memberID . ')">  
							<div>'. $memberID . '</div>
						</div> ';
					else 
						// change colours of females
						echo '<div class="windowFemale" style="top: '. $y .'%; left: '. $x .'%" id="container0" ng-click="openDialog('. $memberID . ')">  
							<div>'. $memberID . '</div>
						</div> ';					
				}
				else
					// change colour of passed-away
					echo '<div class="window" style="top: '. $y .'%; left: '. $x .'%" id="container0" ng-click="openDialog('. $memberID . ')">  
						<div>'. $memberID . '</div>
					</div> ';
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
					else {
						$x1 = $x;
					}
					
					$display_array[$count] = array($x0, $x1, $y);
				}
				
				echo "$count + > $fatherID: (x0,x1) ($x0 , $x1 & $y)<br>";
				
				if (array_key_exists($memberID, $relation_array)) {
					if ($fatherID != 0 and $motherID != 0)
						// kid's vertical line
						echo '<div style="top:'. ($y-3) .'%; left:'. ($x+2) .'%; position: absolute;">  
							<div style="width: 1px; height: 20px; background-color: grey;"></div>
						</div> ';
				}
				
				if ($spouseID <> 0) {
					
					// spouse downword vertical line
					echo '<div style="top:'. ($y+9) .'%; left:'. ($x+2) .'%; position: absolute;">  
						<div style="width: 1px; height: 20px; background-color: grey;"></div>
					</div> ';
						
					$coor_values = $coor_array[$spouseID];
					$spouse_x = $coor_values[3];
						
					if($x < $spouse_x) {
						// spouse horizontal line
						echo '<div style="top:'. ($y+12) .'%; left:'. ($x+2) .'%; position: absolute;">  
							<div style="width: 256px; height: 1px; background-color: grey;"></div>
						</div> ';
							
					}	
				}
			}
			
			$display_array[$count+1] = array($x0, $x1, $y);
			
			
			$display_values = array();
			
			
			foreach ($display_array as $key=>$value) {
				$display_values = $value;
				
				
				$generation_count = ($display_values[1] - $display_values[0])/20;
				if ($generation_count > 0) {
							
							
				
				echo "Display: $display_values[0], $display_values[1], $display_values[2] <br> gc: $generation_count<br>";
					// spouse horizontal line
					echo '<div style="top:'. ($display_values[2]-3) .'%; left:'. ($display_values[0]+2) .'%; position: absolute;">  
						<div style="width:'. (256*$generation_count) .'px; height: 1px; background-color: grey;"></div>
					</div> ';		
							
					
				}
			}
		
		?>

	</body>  	  
	</head>  
