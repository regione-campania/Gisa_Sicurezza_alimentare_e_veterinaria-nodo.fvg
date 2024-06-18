<%@ taglib uri="/WEB-INF/tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage="" %>

<!DOCTYPE html>


<%@page import="it.us.web.bean.BUtente"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it" lang="it">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" type="text/css" href="css/vam/template_css.css" />
		
				<!-- inclusioni per jmesa -->
		<link rel="stylesheet" type="text/css" href="css/jmesa/jmesa.css" />
		<script type="text/javascript" src="js/jmesa/jquery-1.3.min.js"></script>
		<script type="text/javascript" src="js/jmesa/jquery.bgiframe.pack.js"></script>
		<script type="text/javascript" src="js/jmesa/jmesa.js"></script>
		<script type="text/javascript" src="js/jmesa/jmesa.min.js"></script>
		<script type="text/javascript" src="js/jmesa/jquery.jmesa.js"></script>
		
		
<!--		<script type="text/javascript" src="js/jquery/jquery-1.3.2.min.js"></script>-->
		<script type="text/javascript" src="js/jquery/jquery-ui-1.7.3.custom.min.js"></script>
		<script type="text/javascript" src="js/jquery/jquery.jqprint-0.3.js"></script>
		<script type="text/javascript" src="js/jquery/tooltip.min.js"></script>
		<script type="text/javascript" src="js/jquery/jquery-us.js"></script>

		<!-- link rel="stylesheet" type="text/css" href="css/black-tie/jquery-ui-1.7.3.custom.css" /-->
		<!-- link rel="stylesheet" type="text/css" href="css/custom-theme/jquery-ui-1.7.3.custom.css" /-->
		<!-- link rel="stylesheet" type="text/css" href="css/ui-lightness/jquery-ui-1.7.3.custom.css" /-->
		<link rel="stylesheet" type="text/css" href="css/redmond/jquery-ui-1.7.3.custom.css" />
		
		
		<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>
		<script type="text/javascript" src="js/date.js"></script>
		<script language="JavaScript" type="text/javascript" src="js/amministrazione/permessi.js"></script>
		
		<link rel="stylesheet" type="text/css" href="css/aqua/theme.css" />
		<script type="text/javascript" src="js/calendario/calendar.js"></script>
		<script type="text/javascript" src="js/calendario/calendar-setup.js"></script>
		<script type="text/javascript" src="js/calendario/calendar-it.js"></script>
		
		<title>V.A.M.</title>
		
	</head>
  
  <body class="white" >
    
    
    <div id="dialog-modal" title="Attendere" style="display: none;">
		<p>
			<br />
			<img src="images/loader.gif" />
		</p>
	</div>
	
	
    <c:if test="${errore != null || messaggio != null}">
		<jsp:include page="default/errore-messaggio-popup.jsp" />
	</c:if>
	
  			<div class="contentpaneopen">
				<div class="cpocontent">
					<us:err classe="errore" />
	 				<us:mex classe="messaggio" />
					<tiles:insertAttribute name="body" />
				</div>
			</div>
			
							
  </body>

</html>