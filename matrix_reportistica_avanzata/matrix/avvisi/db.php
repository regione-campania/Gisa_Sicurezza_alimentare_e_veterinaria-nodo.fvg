<?php
require_once("../dal_include.php");
require_once("../dal_connessione.php");
error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED & ~E_WARNING);
mb_internal_encoding("UTF-8");

$avvisi = $_POST['avvisi'];
$sistema = $_REQUEST['sistema'];
$operation = $_REQUEST['operation'];

if($operation == 'save'){
    $result = "OK";

    pg_query("delete from matrix.avvisi where sistema = '$sistema'");
    foreach($avvisi as $value) {
        $value = str_replace("'", "''", $value);
        pg_query("insert into matrix.avvisi values ('$value', '$sistema')");
    }
    
    echo $result;
}else{
    $result =  pg_query("select * from matrix.avvisi where sistema = '$sistema'");
    $i = 0;
    while($row = pg_fetch_assoc($result)){
        $resp[$i] = $row["testo"];
        $i++;
    }
    echo json_encode($resp);
}


?>