 <?php


	require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
    $response = array();

    $keyword = $r->keyword;
    $keyword = "*" . $keyword . "*";

    if(!empty($r->gender)){
 		$gender = $r->gender;
 		$gender = "'$gender'";
    }else{
         $gender = "NULL";
    }

    if(!empty($r->vs)){
 		$vs = $r->vs;
 		$vs = "'$vs'";
    }else{
         $vs = "NULL";
    }


    if(!empty($keyword)){

        $db = new DbHandler();

        $result = $db->getResultSet("CALL SP_Search_Profile('$keyword',$gender,$vs)");
        $response = $result;

        echo json_encode($response);

    }


	/*require_once 'dbHandler.php';

    //get posted json object
    $post = file_get_contents('php://input');
    $r = json_decode($post);
	
    searchProfile($r);
    
	// ************ check by session if the user is public or member
    function searchProfile($r){

        $db = new DbHandler();

		// Create connection
		$conn = new mysqli($servername, $username, $password, $dbname);
		// Check connection
		if ($conn->connect_error) {
			die("Connection failed: " . $conn->connect_error);
		} 
		
		// search by name
		if ($r->type == "1")  {
			
			$first_name = $r->value->firstName;
			$last_name = $r->value->lastName;
			
			$sql = "call SP_Search_Profile_By_Name ('$first_name','$last_name');";
					
			$result = $conn->query($sql);
				
			$search_array = array();
			
			while($row = $result->fetch_assoc()) {
				extract($row);
				
				echo "$memberID, $firstName, $lastName <br>";
			}
		}

    };*/

?>