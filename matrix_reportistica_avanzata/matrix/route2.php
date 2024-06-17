<?php

	session_start();

	echo "session.user: " .	$_SESSION['user'];
	echo "<br> session.id_asl: " . $_SESSION['id_asl'];
	echo "<br> session.called_url: " . $_SESSION['called_url'];
	echo "<br> session.id_user: " . $_SESSION['id_user'];
	echo "<br> session.role: " . $_SESSION['role'];
	echo "<br> session.strut: " . $_SESSION['strut'];
	echo "<br> session.readonly: " . $_SESSION['readonly'];
		  
	if ( $_SESSION['called_url'] == 'formulematrix.gisacampania.it') {
		
		$dest = '/formule.php';
	} else {
		$dest = '/tree.php';
	}
	echo "<hr><a href='$dest'> Prosegui</a>";

?>
 
<script>
	setTimeout(function() { location='<?php echo $dest;?>'} , 500);
</script>
