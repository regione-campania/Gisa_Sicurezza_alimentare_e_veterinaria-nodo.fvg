<%@page import="it.us.web.util.properties.Application"%>
<%@ taglib uri="/WEB-INF/tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage="" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it" lang="it">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=windows-1252" />
		
		<link rel="stylesheet" type="text/css" href="css/vam/template_css.css" />
		<link rel="stylesheet" type="text/css" href="css/aqua/theme.css" />
		
		<script type="text/javascript" src="js/jmesa/jquery-1.3.min.js"></script>
		<script type="text/javascript" src="js/azionijavascript.js"></script>
		<script type="text/javascript" src="js/amministrazione/permessi.js"></script>
		<script type="text/javascript" src="js/date.js"></script>
		<script type="text/javascript" src="js/calendario/calendar.js"></script>
		<script type="text/javascript" src="js/calendario/calendar-setup.js"></script>
		<script type="text/javascript" src="js/calendario/calendar-it.js"></script>
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
		<title>V.A.M.</title>
	</head>

	<body class="white" >
	
		<div id="dialog-modal" title="Attendere" style="display: none;">
			<p>
				<br />
				<img src="images/loader.gif" />
			</p>
		</div>
	
		<div class="header_<%=Application.get("ambiente")%>" >
			<tiles:insertAttribute name="header" />
		</div>
	
		<div id="contentBody">
			<tiles:insertAttribute name="menu" />
		</div>
	
		<div class="contentpaneopen">
			<div class="cpocontent">
				<table align="center" >
					<tr>
						<td>
							<us:err classe="errore" />
							<us:mex classe="messaggio" />
						</td>
					</tr>
				</table>
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
