	<!-- dashboard -->
	<html>  
  
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
			
				
				//retrieve member
				$sql = "select * from member;";
					
				$result = $conn->query($sql);
				
				$member_array = array();
				while($row = $result->fetch_assoc()) {
					extract($row);
					
					$member_array[$memberID] = array($firstName, $lastName, $gender);
				}
				
				
			// display
				$sql = "select * from coordinates;";
					
				$result = $conn->query($sql);
				
				$member_values = array();
				while($row = $result->fetch_assoc()) {
					extract($row);
					
					
					$member_values = $member_array[$memberID];
					
					//echo "gender: $member_values[2] <br>";
						
					echo '<div class="window" style="top: '. $y .'%; left: '. $x .'%" id="container0">  
							<div>'. $member_values[0] . '</div>
					</div> ';
					
					// <hr noshade size=3 width=300>
					if ($fatherID <> 0 or $motherID <> 0) {
						// echo '<div style="top:'. $y+2 .'%; left:'.$x+3 .'%; position: absolute;" >
							
							// <hr noshade width=1 size=500/>
						// </div>';
						
						
						// vertical line
						//<hr noshade width=1 size=50 />
						
						echo '<div style="top:'. ($y+2) .'%; left:'. ($x+6) .'%; position: absolute;">  
							<div style="width: 1px; height: 50px; background-color: grey;"></div>
						</div> ';

					}
					
					
				}
		
		?>
	  
	  
	  <!--
		 <div class="window" style="top: 20%; left: 50%" id="container0">  
			<div> hello </div>
		</div>
	  
		<div class="window" style="left: 300px" id="container1">  
			<div> world </div>
		 </div>  
	  
		-->
	  
	</body>  
	  
	</head>  
	  
	 
  
</html>  