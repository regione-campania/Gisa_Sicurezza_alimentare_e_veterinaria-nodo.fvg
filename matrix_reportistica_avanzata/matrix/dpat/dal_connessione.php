<?php
require_once("../common/config.php");


$strConnection = "host=" . $_CONFIG['db_host'] . " " .
				 "port=" . $_CONFIG['db_port'] . " " .
				 "dbname=" . $_CONFIG['db_name'] . " " .
				 "password=" . $_CONFIG['db_password'] . " " .
				 "user=" . $_CONFIG['db_user']  . " ";

			  
$connessione = pg_connect($strConnection) or die ("Errore critico di Connessione al Database");
pg_set_client_encoding($connessione, "UTF-8");


?>