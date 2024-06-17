<?php
require_once("dal_include.php");
require_once("dal_connessione.php");
error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED & ~E_WARNING);
header('Content-Type: application/json; charset=UTF-8');
mb_internal_encoding("UTF-8");


$array = $_POST['values'];
//var_dump($array);
$once = true;

//check flusso 319
foreach($array as $values) {
	$id_fattore = $values[0];
	$id_nominativo = $values[1];
	$valore = $values[2];
	$univoco_asl = $values[4];
	$limite_asl = $values[5];
	$limite_uoc = $values[6];

	if($univoco_asl == 'true'){
		$query = "select  n.nominativo ||' ('||nv.desc_strutt_complessa || ' -> ' ||sa.descrizione_breve ||')' as gia_esistente,
		 mf.descr as fattore
		from matrix.mod4_fattori mf 
		join matrix.mod4_nominativi_fattori nf on nf.id_fattore = mf.id
		join matrix.nominativi_struttura ns on ns.id = nf.id_nominativo_struttura 
		join matrix.nominativi n on n.id = ns.id_nominativo 
		join \"Analisi_dev\".vw_dpat_get_nominativi_validi nv on nv.id_nominativo = n.id_nominativo_gisa 
		join matrix.struttura_asl sa on sa.id_gisa = ns.id_struttura and sa.id_asl = nv.id_asl and sa.anno = nv.anno 
		where mf.id = $id_fattore and ns.id != $id_nominativo and (nv.anno, nv.id_asl) = (SELECT anno, id_asl
			from 
			matrix.nominativi_struttura ns
			join matrix.nominativi n on n.id = ns.id_nominativo 
			join \"Analisi_dev\".vw_dpat_get_nominativi_validi nv on nv.id_nominativo = n.id_nominativo_gisa 
			where ns.id = $id_nominativo
			)";
		$res = pg_query($query);
		if(!$res){
			echo "KO ";
			echo $query;
			exit;
		}
		while($row = pg_fetch_assoc($res)){
				echo "KO ";
				echo "Gìà è selezionato/a ".$row['gia_esistente']." per la causale ".$row['fattore']." univoca per asl";
				exit;
		}
	}

	if($limite_asl == 'true'){
		$query = "
			select  (sum(nf.valore) + $valore) > mf.limite_asl as superato , string_agg(n.nominativo ||' ('||nv.desc_strutt_complessa || ' -> ' ||sa.descrizione_breve ||')' ||'['||nf.valore||'%]', ';   ') as gia_esistente,
				 mf.descr as fattore  , mf.limite_asl
				from matrix.mod4_fattori mf 
				join matrix.mod4_nominativi_fattori nf on nf.id_fattore = mf.id
				join matrix.nominativi_struttura ns on ns.id = nf.id_nominativo_struttura 
				join matrix.nominativi n on n.id = ns.id_nominativo 
				join \"Analisi_dev\".vw_dpat_get_nominativi_validi nv on nv.id_nominativo = n.id_nominativo_gisa 
				join matrix.struttura_asl sa on sa.id_gisa = ns.id_struttura and sa.id_asl = nv.id_asl and sa.anno = nv.anno 
				where mf.id = $id_fattore and ns.id != $id_nominativo and (nv.anno, nv.id_asl) = (SELECT anno, id_asl
					from 
					matrix.nominativi_struttura ns
					join matrix.nominativi n on n.id = ns.id_nominativo 
					join \"Analisi_dev\".vw_dpat_get_nominativi_validi nv on nv.id_nominativo = n.id_nominativo_gisa 
					where ns.id = $id_nominativo
					)
				group by 3, mf.limite_asl ";

			$res = pg_query($query);
			if(!$res){
				echo "KO ";
				echo $query;
				exit;
			}
			while($row = pg_fetch_assoc($res)){
				if($row['superato'] == 't'){
					echo "KO ";
					echo "La causale ".$row['fattore']." sfora il limite del ".$row['limite_asl']."% consentito all'interno della stessa asl: ".$row['gia_esistente'];
					exit;
				}
			}
	}

	if($limite_uoc == 'true'){
		$query = "
			select  (sum(nf.valore) + $valore) > mf.limite_uoc as superato , string_agg(n.nominativo ||' ('||nv.desc_strutt_complessa || ' -> ' ||sa.descrizione_breve ||')' ||'['||nf.valore||'%]', ';   ') as gia_esistente,
				mf.descr as fattore  , mf.limite_uoc
			from matrix.mod4_fattori mf 
			join matrix.mod4_nominativi_fattori nf on nf.id_fattore = mf.id
			join matrix.nominativi_struttura ns on ns.id = nf.id_nominativo_struttura 
			join matrix.nominativi n on n.id = ns.id_nominativo 
			join \"Analisi_dev\".vw_dpat_get_nominativi_validi nv on nv.id_nominativo = n.id_nominativo_gisa 
			join matrix.struttura_asl sa on sa.id_gisa = ns.id_struttura and sa.id_asl = nv.id_asl and sa.anno = nv.anno 
			where mf.id = $id_fattore and ns.id != $id_nominativo and (nv.anno, nv.id_strutt_complessa) = (SELECT anno, id_strutt_complessa
				from 
				matrix.nominativi_struttura ns
				join matrix.nominativi n on n.id = ns.id_nominativo 
				join \"Analisi_dev\".vw_dpat_get_nominativi_validi nv on nv.id_nominativo = n.id_nominativo_gisa 
				where ns.id = $id_nominativo
				)
			group by 3, mf.limite_uoc  ";

			$res = pg_query($query);
			if(!$res){
				echo "KO ";
				echo $query;
				exit;
			}
			while($row = pg_fetch_assoc($res)){
				if($row['superato'] == 't'){
					echo "KO ";
					echo "La causale ".$row['fattore']." sfora il limite del ".$row['limite_uoc']."% consentito all'interno della stessa UOC: ".$row['gia_esistente'];
					exit;
				}
			}
	}

}

//flusso 319, cerco tutti gli id_nominativo_struttura della persona nello stesso anno per le causali legate al cf
$id_nominativo_cf = array();
$res = pg_query("select * from matrix.vw_strutture_appartenenza_by_nominativo where id_origin = ".$array[0][1]);
if(!$res){
	echo "KO ";
	echo $query;
	exit;
}
while($row = pg_fetch_assoc($res)){
	array_push($id_nominativo_cf, $row['id']);
}


pg_query("BEGIN");
foreach($array as $values) {
	$id_fattore = $values[0];
	$id_nominativo = $values[1];
	$valore = $values[2];
	$note = $values[3];
	$ricalcolo_cf = $values[7];

	if($id_fattore == null && $valore == null){ //prima volta

		$q = "delete from matrix.mod4_nominativi_fattori where id_nominativo_struttura = $id_nominativo";		
		if(!pg_query($q)){
			echo "KO ";
			echo $q;
			pg_query("ROLLBACK");
			exit;
		}

		foreach($id_nominativo_cf as $id_nominativo_da_elim){
			$q = "delete from matrix.mod4_nominativi_fattori 
				where id_nominativo_struttura = $id_nominativo_da_elim and id_fattore in (Select id from matrix.mod4_fattori where ricalcolo_cf)";		
			if(!pg_query($q)){
				echo "KO ";
				echo $q;
				pg_query("ROLLBACK");
				exit;
			}
		}

		$note = str_replace("'", "", $note);

		$q = "insert into matrix.mod4_nominativi(id_nominativo_struttura, fattori_text) values ($id_nominativo, unaccent('$note'))
				ON CONFLICT (id_nominativo_struttura) 
				DO
					UPDATE
					SET fattori_text = unaccent('$note')";
					//echo $q;
				
		if(!pg_query($q)){
			echo "KO ";
			echo $q;
			pg_query("ROLLBACK");
			exit;
		}

	}else{

		if($ricalcolo_cf == 'true'){
			foreach($id_nominativo_cf as $id_nominativo){
				$q = "insert into matrix.mod4_nominativi_fattori(id_nominativo_struttura, id_fattore, valore) values ($id_nominativo, $id_fattore, $valore)";
				if(!pg_query($q)){
					echo "KO ";
					echo $q;
					pg_query("ROLLBACK");
					exit;
				}
			}
		}else{
			$q = "insert into matrix.mod4_nominativi_fattori(id_nominativo_struttura, id_fattore, valore) values ($id_nominativo, $id_fattore, $valore)
			ON CONFLICT (id_nominativo_struttura, id_fattore) 
			DO
				UPDATE
				SET valore = $valore";
				//echo $q;
			if(!pg_query($q)){
				echo "KO ";
				echo $q;
				pg_query("ROLLBACK");
				exit;
			}
		}
		
	}
}
pg_query("COMMIT");
echo "OK";
?>
