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
					
					
					//$member_values = $member_array[$memberID];
					
					//echo "gender: $member_values[2] <br>";
						
					echo '<div class="window" style="top: '. $y .'%; left: '. $x .'%" id="container0">  
				
							
							
							<div>'. $memberID . '</div>
					</div> ';
					
					
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