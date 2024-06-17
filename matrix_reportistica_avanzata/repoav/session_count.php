<?php
require_once("../dal_include.php");
require_once("../dal_connessione.php");
error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED & ~E_WARNING);
header('Content-Type: application/json; charset=UTF-8');
mb_internal_encoding("UTF-8");


//$results = pg_query("select count(*) from \"Analisi_dev\".session_log where extract(epoch from(clock_timestamp()- last_timestamp ))/60 < 5");
$results = pg_query("SELECT count(*) FROM pg_stat_activity where state = 'active' and datname = 'mdgm'and query ilike '%allinea(%)%'");
$arResults = CaricaArray($results);
foreach($arResults as $row) {
    echo $row['count'];
}

?>