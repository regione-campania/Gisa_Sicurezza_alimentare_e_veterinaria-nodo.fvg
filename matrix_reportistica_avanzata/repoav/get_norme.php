<?php
require_once("../dal_include.php");
require_once("../dal_connessione.php");
error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED & ~E_WARNING);
header('Content-Type: application/json; charset=UTF-8');
mb_internal_encoding("UTF-8");

$results = pg_query('select * from ra.lookup_norme order by norma');
$arResults = CaricaArray($results);

$i = 0;
$responce = new stdClass();
foreach($arResults as $row) {
	$responce->norma[$i]['norma'] = $row['norma'];
	$responce->norma[$i]['id_norma'] = $row['id_norma'];

	$i++;
}

$json = json_encode($responce); 

echo $json;

pg_close($connessione);

?>
