<?php
require_once("dal_include.php");
require_once("dal_connessione.php");
error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED & ~E_WARNING);
header('Content-Type: application/json; charset=UTF-8');
mb_internal_encoding("UTF-8");


$id = $_REQUEST['id'];


//$query = "select * from matrix.vw_cf_uos vcu join matrix.struttura_asl a on a.id = vcu.id_s where vcu.id_s = $id;";

//$query = "select * from \"Analisi_dev\".vw_dpat_get_nominativi_validi n join matrix.struttura_asl a on a.id = n.id_struttura_semplice where n.id_struttura_semplice = $id;"; 

$query = "select * from matrix.mod4_strutture where id_struttura = $id";

//echo $query;
$results = pg_query($query);
$arResults = CaricaArray($results);

//echo " ".(round(microtime(true) * 1000))-$millis;

$j = 0;
foreach($arResults as $row) {
	$resp->data[$j]["sottr"] = $row['sottr'];
	$resp->data[$j]["fattore1"] = $row['fattore1'];
	$resp->data[$j]["fattore2"] = $row['fattore2'];	
	$resp->data[$j]["ups"] = $row['ups'];	

   	$j++;
}

$sss = json_encode($resp); 

//echo " ".(round(microtime(true) * 1000))-$millis;

//echo $json;
echo $sss;

?>