<?php

function getConnection($db){

    require("common/config.php");

    if($db != "gesdasic"){
        $_CONFIG['db_psw'] = "";
    }

    $strConnection = "host=" . $_CONFIG["db_".$db] . " " .
				 "port=" . $_CONFIG['db_port'] . " " .
				 "dbname=" . $db . " " .
				 "user=" . $_CONFIG['db_user']  . " ".
                 "password=" . $_CONFIG['db_psw'];

    $conn = pg_connect($strConnection);// or die ("Errore critico di Connessione al Database $db");
    return $conn;

}


function isAdministrator($usr, $psw){
    getConnection("guc");
    $res = pg_query("select * from is_administrator('$usr', '$psw')");
    while($row = pg_fetch_assoc($res)){
        $isAdministrator = $row['is_administrator'];
    }
    return $isAdministrator;
}
			  			   
?>