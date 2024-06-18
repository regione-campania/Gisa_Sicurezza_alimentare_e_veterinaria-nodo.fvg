<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
	
	<script type="text/javascript" src="js/sinantropi/ddtabmenu.js">
	</script>

	<!-- CSS for Tab Menu #2 -->
	<link rel="stylesheet" type="text/css" href="css/sinantropi/menuSin/glowtabs.css" />
    
    <script type="text/javascript">		ddtabmenu.definemenu("ddtabs2");
	</script>    
    
      		
	<div id="ddtabs2" class="glowingtabs">
		<ul>
			<li>
				<a href="sinantropi.Detail.us?idSinantropo=${s.id}"><span>Dettaglio Anagrafica</span></a>	
			</li>				
			<li>
				<a href="sinantropi.catture.List.us?idSinantropo=${s.id}"><span>Rinvenimenti</span></a>	
			</li>			
			<li>
				<a href="sinantropi.detenzioni.List.us?idCattura=${c.id}"><span>Detenzioni</span></a>	
			</li>	
			<li>
				<a href="sinantropi.reimmissioni.Detail.us?idCattura=${c.id}"><span>Rilasci</span></a>	
			</li>				
		</ul>
	</div>
	 