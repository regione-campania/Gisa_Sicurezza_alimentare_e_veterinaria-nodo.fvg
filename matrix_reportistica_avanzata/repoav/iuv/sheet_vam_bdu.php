<?php
session_start();
ini_set('max_execution_time', '0'); // for infinite time of execution 
ini_set('memory_limit', '512M');
header('Cache-Control: max-age=0');

require_once("../../dal_include.php");
require_once("../../dal_connessione.php");
header ("Content-Type: application/vnd.ms-excel");


$di = $_REQUEST['di'];
$df = $_REQUEST['df'];
$cols = array();
$idAsl = $_SESSION['id_asl'];

date_default_timezone_set('Italy/Rome');
$now = date('m/d/Y h:i:s a', time());
$filename="IUV_Rendicontazione_BDU_VAM.xls";
header ("Content-Disposition: inline; filename=$filename");

function n2l($n)
{
    for($r = ""; $n >= 0; $n = intval($n / 26) - 1)
        $r = chr($n%26 + 0x41) . $r;
    return $r;
}


$res = pg_query("select r.* from ra.vw_rendic_iuv r 
join matrix.struttura_asl sa on sa.descrizione_breve = r.asl and sa.anno::text = to_char(r.\"data\", 'YYYY') and (sa.id_asl = $idAsl or -1 = $idAsl)
where data between '$di' and '$df'");

$i = pg_num_fields($res);
for ($j = 0; $j < $i; $j++) {
	array_push($cols, pg_field_name($res, $j));
}

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang=it><head>
<title>Titolo</title>
<style>
.num {
  mso-number-format:"\#\,\#\#0;
}

.per {
	mso-number-format:"Percent";
}
</style>
</head>
<body>
<table border="1">
<?php

echo "<tr> <td colspan = \"$n_col\"> Data di esportazione: $now </td> </tr>";

//echo "<tr> <td> $now </td> </tr>";
echo "<tr>";
foreach($cols as $c ){
		echo " <td style=\"text-align: center; background-color: #d9d9d9\"> $c </td>";		
}
echo "</tr>";


$i = 0;
while($row = pg_fetch_assoc($res)){
	echo "<tr>";
	foreach($cols as $c ){
		echo " <td style='text-align: center' > ".$row["$c"]." </td>";		
	}
	echo "</tr>";
}




?>
</table>
</body></html>


