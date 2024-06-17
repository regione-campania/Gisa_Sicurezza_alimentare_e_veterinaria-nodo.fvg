<?php

	session_start();

	echo "session.user: " .	$_SESSION['user'];
	echo "<br> session.id_asl: " . $_SESSION['id_asl'];
	echo "<br> session.called_url: " . $_SESSION['called_url'];
		  
	if ( $_SESSION['called_url'] == 'formulematrix.gisacampania.it') {
		
		echo "<hr><a href='/formule.php'> Prosegui</a>";
	} else {
		echo "<hr><a href='/tree.php'> Prosegui</a>";
	}

?>
