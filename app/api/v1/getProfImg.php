<?php

  require_once 'dbHandler.php';

  $id = $_GET['id'];
  // do some validation here to ensure id is safe

  $db = new DbHandler();
  $result = $db->getResult("SELECT * FROM Member_Image WHERE memberID = '$id'");

  if($result != NULL) {
      header("Content-type:" . $result['type']);
      echo $result['image'];
  } else {
      $file = '../../images/default_profile.png';
      header('Content-Type: image/png');
      echo file_get_contents($file);
  }

?>