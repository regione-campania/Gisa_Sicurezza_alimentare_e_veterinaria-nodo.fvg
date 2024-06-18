<%@ taglib uri="/WEB-INF/tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage="" %>

<!DOCTYPE html>

<LINK REL="SHORTCUT ICON" HREF="images/animated_favicon1.gif">


<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it" lang="it">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=windows-1252" />
		<link rel="stylesheet" type="text/css" href="css/vam/template_css.css" />
		<link rel="stylesheet" type="text/css" href="css/vam/homePage/homePage.css" />
		<script type="text/javascript" src="js/jmesa/jquery-1.3.min.js"></script>		
		<script type="text/javascript" src="js/azionijavascript.js"></script>
		<script type="text/javascript" src="js/amministrazione/permessi.js"></script>
		<script type="text/javascript" src="js/jmesa/jquery-1.3.min.js"></script>
		<script type="text/javascript" src="js/jmesa/jquery.bgiframe.pack.js"></script>
		<script type="text/javascript" src="js/jmesa/jmesa.js"></script>
		<script type="text/javascript" src="js/jmesa/jmesa.min.js"></script>
		<script type="text/javascript" src="js/jmesa/jquery.jmesa.js"></script>
		<script type="text/javascript" src="js/jquery/jquery-ui-1.7.3.custom.min.js"></script>
		<script type="text/javascript" src="js/jquery/jquery.jqprint-0.3.js"></script>
		<script type="text/javascript" src="js/jquery/tooltip.min.js"></script>
		<script type="text/javascript" src="js/jquery/jquery-us.js"></script>
		<script type="text/javascript" src="js/amministrazione/permessi.js"></script>
		<script type="text/javascript" src="js/azionijavascript.js"></script>
		<script type="text/javascript" src="js/date.js"></script>
		<script type="text/javascript" src="js/calendario/calendar.js"></script>
		<script type="text/javascript" src="js/calendario/calendar-setup.js"></script>
		<script type="text/javascript" src="js/calendario/calendar-it.js"></script>
		<link rel="stylesheet" type="text/css" href="css/jmesa/jmesa.css" />
		<link rel="stylesheet" type="text/css" href="css/redmond/jquery-ui-1.7.3.custom.css" />
		<title>VAM</title>
	</head>
	
	<div class="contentpaneopen">
	
		<div id="dialog-modal" title="Attendere" style="display: none;">
			<p>
				<br />
				<img src="images/loader.gif" />
			</p>
		</div>
		
		<div class="cpocontent">
			<tiles:insertAttribute name="body" />
		</div>
	</div>
</html>
