<?php
require_once("../dal_include.php");
require_once("../dal_connessione.php");
error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED & ~E_WARNING);
mb_internal_encoding("UTF-8");

$anno = $_REQUEST['anno'];
$query = "select id_root from matrix.tree_anno where anno = $anno and id_tree in (select id from matrix.trees where name = 'Struttura Piani')";

$results = pg_query($query);
$arResults = CaricaArray($results);

$i = 0;
foreach($arResults as $row) {
	echo $row['id_root'];
}

?>
