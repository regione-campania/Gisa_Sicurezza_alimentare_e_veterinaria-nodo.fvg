<?php
require_once("dal_include.php");
require_once("dal_connessione.php");
error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED & ~E_WARNING);
header('Content-Type: application/json; charset=UTF-8');
mb_internal_encoding("UTF-8");


$array = $_POST['values'];
//var_dump($array);

$idStruttura = $array[0];
$f1 = $array[1];
$f2 = $array[2];
$sottr = $array[3];
$ups = $array[4];
$uba = $array[5];


$q = "insert into matrix.mod4_strutture(id_struttura, sottr,
			fattore1, fattore2, ups, uba) values ($idStruttura, $sottr, $f1, $f2, $ups, $uba)
		ON CONFLICT (id_struttura) 
		DO
			UPDATE
			SET sottr = $sottr, fattore1 = $f1, fattore2 = $f2, ups = $ups, uba = $uba";
		
if(!pg_query($q)){
	echo "KO ";
	echo $q;
	exit;
}

$q = "update matrix.struttura_asl set ups = $ups, uba= $uba where id_gisa = $idStruttura";
	if(!pg_query($q)){
		echo "KO ";
		echo $q;
		exit;
	}

$q = "select * from matrix.update_valori_somme()";
if(!pg_query($q)){
	echo "KO ";
	echo $q;
	exit;
}

echo "OK";
?>
