<?php
require_once("../dal_include.php");
require_once("../dal_connessione.php");
error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED & ~E_WARNING);
mb_internal_encoding("UTF-8");

$anno = $_REQUEST['anno'];
$id = $_REQUEST['id'];

if($id == 8)
	$query = "select id from matrix.vw_tree_nodes_asl_descr where p_id = (select id_root from matrix.tree_anno where anno = $anno and id_tree in (select id from matrix.trees where name = 'Struttura ASL'))";
else
	$query = "select id from matrix.vw_tree_nodes_asl_descr where n_livello = 1 and anno = $anno and id_asl = $id + 200";

$results = pg_query($query);
$arResults = CaricaArray($results);

$i = 0;
foreach($arResults as $row) {
	echo $row['id'];
}

?>
