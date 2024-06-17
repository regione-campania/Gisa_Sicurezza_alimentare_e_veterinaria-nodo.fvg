<?php
ini_set('max_execution_time', '0'); // for infinite time of execution 
ini_set('memory_limit', '512M');
header('Cache-Control: max-age=0');

require_once("../../dal_include.php");
require_once("../../dal_connessione.php");

$ANNO = $_REQUEST['anno'];

$query = "select RIGA, ID_R, COLONNA, ID_C, VALORE, TARGET, COLONNA_PADRE, ORDINAMENTO, count(*) over (partition by COLONNA_PADRE) as count_padre 
	from (

	select replace(a.descrizione_breve, '.', '') riga, a.id as id_r,  replace(upper(p.alias||' '||p.descrizione), '.', '') colonna, p.id as id_c, 
		sum(coalesce(eseguiti,0)) valore, (coalesce(t.sum, 0)) as target 
		,replace(upper(p.p_alias||' '||p.p_descrizione), '.', '') as colonna_padre,  P.path_ord as ordinamento 
	 from matrix.vw_tree_nodes_piani_descr p	
	 join matrix.struttura_asl a on a.n_livello = 1 and a.anno = $ANNO and p.p_id in (select id from matrix.vw_tree_nodes_piani_descr where p_id = ID_PIANO) and a.id_asl > 200 
	 join matrix.struttura_piani sp2 on sp2.cod_raggruppamento = p.cod_raggruppamento and sp2.id_gisa in  (	
		 select id_gisa from \\\"Analisi_dev\\\".vw_struttura_piani_ref_iuv where id_ref  in (select pd.id from matrix.vw_tree_nodes_piani_descr pd where pd.p_id = ID_PIANO)	
	)	
	 left join matrix.vw_struttura_piano_target_tree_iuv t 	
		on  t.id_node_ref = p.id and a.id = t.id_struttura and p.anno = t.anno 	
	 left join(	
		 select pr.id_ref, mi.* from 	
		 ra.mvw_iuv mi 	
		 join matrix.struttura_piani i on i.cod_raggruppamento = mi.cod_raggruppamento and i.anno = $ANNO	
				 join \\\"Analisi_dev\\\".vw_struttura_piani_ref pr on pr.id_gisa = i.id_gisa and id_ref  in (select id from matrix.vw_tree_nodes_piani_descr pd where pd.p_id in (select id from matrix.vw_tree_nodes_piani_descr where p_id = ID_PIANO))
				 where mi.cod_raggruppamento in (	
					 select cod_raggruppamento from	
					 matrix.struttura_piani sp where id_gisa in (	
						 select id_gisa from \\\"Analisi_dev\\\".vw_struttura_piani_ref where id_ref  in (select id from matrix.vw_tree_nodes_piani_descr pd where pd.p_id in (select id from matrix.vw_tree_nodes_piani_descr where p_id = ID_PIANO))	
					)	
				)	
		and 1=1 and extract(year from data) = $ANNO	
	)c on c.id_ref = p.id and c.id_asl = a.id_asl 	
	 where not ((p.livello = 3 and p.cod_raggruppamento not in (select p_cod_raggruppamento from matrix.vw_tree_nodes_piani_descr pd2 where pd2.cod_raggruppamento in (	
		 select cf.cod_raggruppamento from ra.config_iuv cf)))	
			 or (p.cod_raggruppamento not in (select cf.cod_raggruppamento from ra.config_iuv cf) and p.livello = 4)	
			 or (p.livello in (2) and eseguiti = 0) ) 	
	 group by 1,2,3,4, 6,  P.path_ord, p.p_alias, p.p_descrizione 
 ) a
 order by 1,coalesce(ordinamento, colonna)";


$json = new stdClass();
$json->anno = $ANNO;

$res = pg_query("select * from matrix.struttura_asl sa where anno = $ANNO and n_livello = 0;");
while($row = pg_fetch_assoc($res)){
	$query = str_replace("ID_ASL", $row["id"], $query);
	$json->id_asl = $row['id'];
	$json->descr_asl = $row['descrizione'];

}

$piani = array();
$res = pg_query("select * from matrix.vw_tree_nodes_up_piani where livello = 2 and anno = $ANNO order by path_ord");
while($row = pg_fetch_assoc($res)){
	$obj = new stdClass();
	$obj->id = $row["id"];
	$obj->descr = $row["path_descr"];
	$obj->query = str_replace("ID_PIANO", $row["id"], $query);
	array_push($piani, $obj);
}

$json->piani = $piani;

echo json_encode($json);


