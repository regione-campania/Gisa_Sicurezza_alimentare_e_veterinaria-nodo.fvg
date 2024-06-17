<?php
require_once("common/config.php");


$strConnection = "host=" . $_CONFIG['db_host'] . " " .
				 "port=" . $_CONFIG['db_port'] . " " .
				 "dbname=" . $_CONFIG['db_name'] . " " .
				 "user=" . $_CONFIG['db_user']  . " ";

			  
$connessione = pg_connect($strConnection) or die ("Errore critico di Connessione al Database");

			   
?>