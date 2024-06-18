<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@page import="java.util.Date"%>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
         
    <h4 class="titolopagina">
     		Storico scarico mangime ${magazzinoMangimi.tipoAnimale.description } --> ${magazzinoMangimi.etaAnimale.description } --> ${magazzinoMangimi.lookupMangimi.description }
    </h4>
      
 
<div class="area-contenuti-2">
	<form action="vam.magazzino.mangimi.Storico.us" method="post">
		
		<jmesa:tableModel items="${listScaricoMangimi}" id="lsm" var="lsm" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap" >
			<jmesa:htmlTable styleClass="tabella" >
				<jmesa:htmlRow>	
					
					<jmesa:htmlColumn property="entered" title="Data Scarico" sortable="false" filterable="false">
						<fmt:formatDate value="${lsm.entered}" pattern="dd/MM/yyyy" var="data"/>
    			 		<c:out value="${data}"></c:out>		
    			 	</jmesa:htmlColumn>				
															
					<jmesa:htmlColumn property="enteredBy" 			title="Effettuato da" sortable="false" filterable="false" />
										
					<jmesa:htmlColumn property="quantita" 			title="Quantità scaricata" sortable="false" filterable="false" />
					
				</jmesa:htmlRow>
			</jmesa:htmlTable>
		</jmesa:tableModel>
	</form>
	
	<div align="center">
		<a onclick="window.close()">
			<input type="button" value="Chiudi"/>
		</a>
	</div>
	
	<script type="text/javascript">
		function onInvokeAction(id)
		{
			setExportToLimit(id, '');
			createHiddenInputFieldsForLimitAndSubmit(id);
		}
		function onInvokeExportAction(id)
		{
			var parameterString = createParameterStringForLimit(id);
			location.href = 'vam.magazzino.mangimi.Storico.us?' + parameterString;
		}
	</script>
</div>	