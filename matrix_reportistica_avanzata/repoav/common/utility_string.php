<?php
	function customHtmlEntities($str){
		return htmlentities($str, ENT_COMPAT,'utf-8');
	}
?>