<?php

if(md5($_REQUEST['username']) != 'e0cbf0e62d03796f31da47099682b72b' ||  md5($_REQUEST['password']) != 'e0cbf0e62d03796f31da47099682b72b'){
  die("Username o password errati");
}

session_start();
$_SESSION['id_asl'] = $_REQUEST['id_asl'];
$_SESSION['readonly'] = false;
$_SESSION['id_user'] = 999;

header("location: tree.php");

?>