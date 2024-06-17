<?php
$id_asl = $_REQUEST["id_asl"];
session_start();
$_SESSION["id_asl"] = $id_asl;
sleep(3);
header("location: ra.php");

?>
