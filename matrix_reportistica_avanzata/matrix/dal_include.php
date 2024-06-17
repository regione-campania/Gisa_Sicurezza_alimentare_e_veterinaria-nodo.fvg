<?php
	$charsetDB = "SET character_set_results = 'utf8', character_set_client = 'utf8', character_set_connection = 'utf8', character_set_database = 'utf8', character_set_server = 'utf8'";
	
	function CaricaArray($results){
		$arResults = array();

		if($results){
			if (pg_num_rows($results) != 0) {
				while ($row_results = pg_fetch_assoc($results)) {
					//$arResults[] = $row_results;
					$arResults[] = array_map('utf8_encode', $row_results);
				}
			}
		}
		pg_free_result($results);
		return $arResults;
	}

?>