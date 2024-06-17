<?php
require_once("dal_include.php");
require_once("dal_connessione.php");
error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED & ~E_WARNING);
mb_internal_encoding("UTF-8");


$id = $_REQUEST['id'];
$unlock = $_REQUEST['unlock'];

$is_locked = "false";

if($unlock == 1)
	$is_locked = "true";


//$query = "select * from matrix.vw_cf_uos vcu join matrix.struttura_asl a on a.id = vcu.id_s where vcu.id_s = $id;";

//$query = "select * from \"Analisi_dev\".vw_dpat_get_nominativi_validi n join matrix.struttura_asl a on a.id = n.id_struttura_semplice where n.id_struttura_semplice = $id;"; 

$query = "update matrix.lock_asl_mod4 set is_locked = $is_locked where asl = $id";

echo $query;
$results = pg_query($query);
//$arResults = CaricaArray($results);



?>
