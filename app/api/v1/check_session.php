<?php
    session_start();
    if( isset($_SESSION['unqid']) ) print 'authenticated';
?>
