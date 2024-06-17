<?php
session_start();
require_once("../../dal_include.php");
require_once("../../dal_connessione.php");
header('Cache-Control: max-age=0');
header ("Content-Type: application/vnd.ms-excel; charset=utf-8");

$di = $_REQUEST['di'];
$df = $_REQUEST['df'];
$id_asl = $_SESSION['id_asl'];

//$query = 'select cu.id_controllo_ufficiale, cu.data_inizio_controllo, cu.unita_operativa,  cu.asl, cu.tipo_ispezione_o_audit, cu.codice_macroarea, cu.codice_aggregazione, cu.codice_attivita					from   matrix.struttura_piani p 					 join  matrix.struttura_asl a  on  p.parent = -1 and  a.id_padre = 8					left join ( SELECT g.*,						 p.id_ref as p_id_ref,						 a.id_ref as a_id_ref,						 mr.id_ref as m_id_ref						 FROM "Analisi".gisa_controlli_ufficiali g						 left join "Analisi".mvw_stabilimenti_codici_rel s on s.id_record_anagrafica = g.id_record_anagrafica						  left  join matrix.vw_macroarea_ref mr on mr.id = s.id and mr.id_ref   = -1						  join matrix.vw_struttura_piani_ref p on p.id = g.id_indicatore and p.id_ref  in (select id from matrix.struttura_piani where parent = -1)						   left  join matrix.struttura_asl_ref a on  g.id_struttura_uo = a.id and a.id_ref  in (select id from matrix.struttura_asl where id_padre = 8)						  where 1=1					 ) cu on  p.id = cu.p_id_ref  and  a.id = cu.a_id_ref 					 left join matrix.vw_target t on t.id_piano = cu.p_id_ref and cu.a_id_ref = t.id_struttura 					  where  1=1 order by id_controllo_ufficiale;';

date_default_timezone_set('Italy/Rome');
$now = date('m/d/Y h:i:s a', time());
$filename="Dettaglio_IUV.xls";
header ("Content-Disposition: inline; filename=$filename");

function n2l($n)
{
    for($r = ""; $n >= 0; $n = intval($n / 26) - 1)
        $r = chr($n%26 + 0x41) . $r;
    return $r;
}


echo "<script> console.log($query); </script>";

pg_query('set lc_time to \'it_IT.utf8\';');

$query = "select * from (
	select null as id_controllo, mi.data::date as data, asl.descrizione_breve as asl, null as uo, sp.alias||' '||sp.descrizione_breve as piano_attivita, null as codice_linea, null as ragione_sociale, MI.eseguiti 
	from RA.mvw_iuv mi 
	join RA.config_iuv ci on CI.id = MI.fonte 
	join matrix.struttura_asl asl on asl.id_asl = mi.id_asl and asl.n_livello = 1 and asl.anno = extract(year from mi.data)
	join matrix.struttura_piani sp on sp.cod_raggruppamento = mi.cod_raggruppamento and sp.anno =  extract(year from mi.data)
	where CI.enabled and CI.motivo is false and asl.id_asl between 201 and 207 and (asl.id_asl = $id_asl or $id_asl = -1) 
	
	union ALL
	
	select
	distinct  cu.id_controllo, cu.data_inizio_controllo::date as DATA, asl.descrizione_breve as asl, uo.descrizione_breve as uo, sp.alias||' '||sp.descrizione_breve as piano_attivita, cu.codice_linea, ss.ragione_sociale, cu.eseguiti  
	from 
	RA.vw_gisa_controlli_ufficiali cu
	left join matrix.struttura_asl uo on uo.id_gisa = cu.id_unita_operativa 
	left join matrix.struttura_piani sp on sp.id_gisa = cu.id_motivo 
	left join matrix.struttura_asl asl on asl.id_asl = uo.id_asl and asl.n_livello = 1 and asl.anno = uo.anno
	left join \"Analisi_dev\".vw_dbi_get_all_stabilimenti__validi ss on ss.riferimento_id = cu.riferimento_id and ss.riferimento_id_nome_tab = cu.riferimento_nome_tab  
	where cu.data_inizio_controllo::date  >= '2022-01-01' and cu.fonte = 'isp semp'  and (asl.id_asl = $id_asl or $id_asl = -1)  
	--and sp.id_gisa in (
	--	select id_gisa from \"Analisi_dev\".vw_struttura_piani_ref where id_ref  in (select pd.id from matrix.vw_tree_nodes_piani_descr pd where pd.p_id = $id_p)
	--)
	and sp.cod_raggruppamento in (
		select ci.cod_raggruppamento 
		from ra.mvw_iuv mi 
		join ra.config_iuv ci on mi.fonte = ci.id and ci.enabled and ci.motivo
	)
) foo 
where data between '$di' and '$df'
order by 2,1,3,4,5,6,7,8";

$results = pg_query($query);
$arResults = CaricaArray($results);

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

.text {
	white-space: nowrap;
	mso-number-format:"\@";/*force text*/
}

</style>
</head>
<body>
<table border="1">
<?php

$n_col = 8;

echo "<tr> <td style=\"background-color: #fff0b3\" colspan = \"$n_col\" class=\"text\"> Data di esportazione: $now </td> </tr>";
echo "<tr> <td style=\"background-color: #fff0b3\" colspan = \"$n_col\" class=\"text\"> $di/$df </td> </tr>";

echo "<tr> <td style=\"background-color: #d9d9d9\"> ID CONTROLLO </td> 
		<td style=\"background-color: #d9d9d9\"> DATA </td> 
		<td style=\"background-color: #d9d9d9\"> ASL </td> 
		<td style=\"background-color: #d9d9d9\"> UO </td> 
		<td style=\"background-color: #d9d9d9\"> PIANO/ATTIVITA' </td> 
		<td style=\"background-color: #d9d9d9\"> CODICE LINEA </td>
		<td style=\"background-color: #d9d9d9\"> RAGIONE SOCIALE </td>
		<td style=\"background-color: #d9d9d9\"> ESEGUITI </td>
		</tr>";


$i = 0;
foreach($arResults as $row){
	$id = $row['id_controllo'];
	$data = $row['data'];
	$uo = $row['uo'];
	$asl = $row['asl'];
	$piano = strtoupper($row["piano_attivita"]);
	$codice_linea = $row['codice_linea'];
	$ragione_sociale = $row['ragione_sociale'];
	$eseguiti = $row['eseguiti'];
	if($codice_linea == 'tot')
		$codice_linea = '';
	echo "<tr class=\"text\"> <td> $id </td>  <td> $data </td> <td> $asl </td>  <td> $uo </td> <td> $piano </td>  <td class=\"text\"> $codice_linea </td> <td class=\"text\"> $ragione_sociale </td> <td> $eseguiti </td> </tr>";
	$i++;
}




?>
</table>
</body></html>


