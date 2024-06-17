<?php
require_once("dal_include.php");
require_once("dal_connessione.php");
error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED & ~E_WARNING);
header('Content-Type: application/json; charset=UTF-8');
mb_internal_encoding("UTF-8");


$id = $_REQUEST['id'];

/*$query = "select mn.id as id_nominativo, mn.fattori_text, nf.id as id_relazione, nf.valore, mf.id as id_fattore, unaccent(mf.descr) descr, coalesce(max_perc, 100) max_perc 
, unaccent(mf.note) note,
mf.numero,
mf.ricalcolo_cf,
mf.mostra_altre_uos,
mf.univoco_asl,
mf.solo_tpal,
mf.limite_uoc,
mf.limite_asl,
numero_incompatibile,
n.qualifica = 'T.P.A.L' as is_tpal
from matrix.mod4_nominativi mn 
right join matrix.mod4_fattori mf on  mn.id_nominativo_struttura = $id
left join matrix.mod4_nominativi_fattori nf on mn.id_nominativo_struttura = nf.id_nominativo_struttura and mf.id = nf.id_fattore
left join matrix.nominativi_struttura ns on ns.id = mn.id_nominativo_struttura
left join matrix.nominativi n on n.id = ns.id_nominativo
where enabled order by mf.numero";*/

$query = "select mn.id as id_nominativo, 
mn.fattori_text, 
nf.id as id_relazione, 
nf.valore, 
mf.id as id_fattore, 
unaccent(mf.descr) descr, 
coalesce(max_perc, 100) max_perc,
unaccent(mf.note) note,
mf.numero,
mf.ricalcolo_cf,
mf.mostra_altre_uos,
mf.univoco_asl,
mf.solo_tpal,
mf.limite_uoc,
mf.limite_asl,
numero_incompatibile,
n.qualifica = 'T.P.A.L' as is_tpal,
string_agg(sn.uos, ', ') as altre_strutture
from matrix.mod4_nominativi mn 
right join matrix.mod4_fattori mf on  mn.id_nominativo_struttura = $id
left join matrix.mod4_nominativi_fattori nf on mn.id_nominativo_struttura = nf.id_nominativo_struttura and mf.id = nf.id_fattore
left join matrix.nominativi_struttura ns on ns.id = $id
left join matrix.nominativi n on n.id = ns.id_nominativo
left join matrix.vw_strutture_appartenenza_by_nominativo sn on sn.id_origin = mn.id_nominativo_struttura and sn.id != $id
where enabled 
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
order by mf.numero";

//echo $query;
$results = pg_query($query);
$arResults = CaricaArray($results);

//echo " ".(round(microtime(true) * 1000))-$millis;

$j = 0;
foreach($arResults as $row) {
	$resp->data[$j] = $row;

   	$j++;
}

$sss = json_encode($resp); 

//echo " ".(round(microtime(true) * 1000))-$millis;

//echo $json;
echo $sss;

?>
