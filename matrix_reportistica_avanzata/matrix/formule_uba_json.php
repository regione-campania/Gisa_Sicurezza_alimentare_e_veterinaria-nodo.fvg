<?php
require_once("dal_include.php");
require_once("dal_connessione.php");
error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED & ~E_WARNING);
header('Content-Type: application/json; charset=UTF-8');
mb_internal_encoding("UTF-8");

$query = "select * from matrix.formule where valida_uba is true;";

  
	$results = pg_query($query);
	$arResults = CaricaArray($results);

$i = 0;
foreach($arResults as $row) {
	$responce->json[$i]['id'] = $row[id];
	$responce->json[$i]['descr'] = $row[descrizione];
	$responce->json[$i]['testo'] = $row[testo];
	$responce->json[$i]['fattore_fin'] = $row[fattore_fin];
	$i++;
}
$sss = json_encode($responce); 
//echo $json;
echo $sss;

?>