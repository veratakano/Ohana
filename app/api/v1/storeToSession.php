<?php
    session_start();

    $post = file_get_contents('php://input');
    $r = json_decode($post);

    $key = $r->key;
    $value = $r->value;
    $_SESSION[$key] = $value;
    
    echo "Session Changed"
?>