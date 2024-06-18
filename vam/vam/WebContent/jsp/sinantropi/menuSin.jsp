<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
	
	<script type="text/javascript" src="js/sinantropi/ddtabmenu.js">
	</script>

	<!-- CSS for Tab Menu #2 -->
	<link rel="stylesheet" type="text/css" href="css/sinantropi/menuSin/glowtabs.css" />
    
    <script type="text/javascript">
		ddtabmenu.definemenu("ddtabs2")
	</script>    
    
<c:set var="action" value=""/>    
<c:if test="${s.zoo}">
	<c:set var="action" value="Zoo"/>    
</c:if>
<c:if test="${s.marini}">
	<c:set var="action" value="Marini"/>    
</c:if>

	<div id="ddtabs2" class="glowingtabs">
		<ul>
			<li>
				<a href="sinantropi.Detail${action}.us?idSinantropo=${s.id}"><span>Dettaglio Anagrafica</span></a>	
			</li>				
			<li>
				<a href="sinantropi.catture.List.us?idSinantropo=${s.id}"><span>Rinvenimenti, Detenzioni e Rilasci</span></a>	
			</li>			
<!--			<li>-->
<!--				<a href="sinantropi.detenzioni.List.us?idSinantropo=${s.id}"><span>Detenzioni</span></a>	-->
<!--			</li>	-->
<!--			<li>-->
<!--				<a href="sinantropi.reimmissioni.List.us?idSinantropo=${s.id}"><span>Rilasci</span></a>	-->
<!--			</li>			-->
			<li>
				<a href="sinantropi.decessi.Detail.us?idSinantropo=${s.id}""><span>Decesso</span></a>
			</li>			
			
			
			
		</ul>
	</div>
	 
	

	