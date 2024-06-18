<%@ taglib uri="/WEB-INF/tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage="" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it" lang="it">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=windows-1252" />
		<link rel="stylesheet" type="text/css" href="css/sinantropi/template_css.css" />
		<script type="text/javascript" src="js/azionijavascript.js"></script>
		<script type="text/javascript" src="js/amministrazione/permessi.js"></script>
		<title>Anagrafe Sinantropi/Marini/Zoo</title>
	</head>

	<body class="white" >
	
		<div class="header" >
			<tiles:insertAttribute name="header" />
		</div>
	
		<div id="contentBody">
			<tiles:insertAttribute name="menu" />
		</div>
	
		<div class="contentpaneopen">
			<div class="cpocontent">
				<us:err classe="errore" />
				<us:mex classe="messaggio" />
				<tiles:insertAttribute name="body" />
			</div>
		</div>
	
		<div id="footer">
			<div class="padding">
				<div class="moduletable">
					<tiles:insertAttribute name="footer" />
				</div>
			</div>
		</div>
	
	</body>

</html>
