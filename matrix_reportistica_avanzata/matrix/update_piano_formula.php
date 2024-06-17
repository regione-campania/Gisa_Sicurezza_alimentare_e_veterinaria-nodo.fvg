<?php
require_once("dal_include.php");
//require_once("dal_connessione.php");
require_once("common/config.php");
error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED & ~E_WARNING);
header('Content-Type: application/json; charset=UTF-8');
mb_internal_encoding("UTF-8");

$id_piano = $_REQUEST['id_piano'];
$id_formula = $_REQUEST['id_formula'];
$is_uba = $_REQUEST['is_uba'];
$force = $_REQUEST['force'];



$strConnection = "host=" . $_CONFIG['db_host'] . " " .
				 "port=" . $_CONFIG['db_port'] . " " .
				 "dbname=" . $_CONFIG['db_name'] . " " .
				 "user=" . $_CONFIG['db_user']  . " ";

			  
$conn = pg_connect($strConnection) or die ("Errore critico di Connessione al Database");


$query = "select * from MATRIX.updatepianoformula($id_piano, $id_formula, $is_uba, $force)";


pg_query($conn, $query);


echo $query;

?>
