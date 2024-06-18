<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>


<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
<h4 class="titolopagina">
     		Lista Esami Citologici
</h4>

<input type="button" value="Aggiungi Esame Citologico" onclick="if(${cc.dataChiusura!=null}){ 
	if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){location.href='vam.cc.esamiCitologici.ToAdd.us'}
	}else{location.href='vam.cc.esamiCitologici.ToAdd.us'}">

<div class="area-contenuti-2">
	<form action="vam.cc.esamiCitologici.List.us" method="post">
		
		<jmesa:tableModel items="${cc.esameCitologicos }" id="cit" var="cit" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>
				
				    <jmesa:htmlColumn property="numero" 			title="Numero Esame" filterable="false" sortable="false"/>
					

					<jmesa:htmlColumn property="dataRichiesta" title="Data Richiesta" pattern="dd/MM/yyyy" cellEditor="it.us.web.util.jmesa.DateCellEditor" filterEditor="it.us.web.util.jmesa.DateFilterEditor"/>
					<jmesa:htmlColumn property="dataEsito" title="Data Esito" pattern="dd/MM/yyyy" cellEditor="it.us.web.util.jmesa.DateCellEditor" filterEditor="it.us.web.util.jmesa.DateFilterEditor" />
					<jmesa:htmlColumn property="diagnosi" 	title="Diagnosi" sortable="false" filterEditor="it.us.web.util.jmesa.vam.DiagnosiEsameCitologicoDroplistFilterEditor"/>
														
					<jmesa:htmlColumn sortable="false" filterable="false" title="Operazioni">
							<a href="vam.cc.esamiCitologici.Detail.us?id=${cit.id}">Dettaglio</a>
							<a href="vam.cc.esamiCitologici.ToEdit.us?modify=on&idEsame=${cit.id}" onclick="if(${cc.dataChiusura!=null}){ 
			    				return myConfirm('Cartella Clinica chiusa. Vuoi procedere?');
	    						}else{return true;}">Modifica</a>
					</jmesa:htmlColumn>
					
				</jmesa:htmlRow>
			</jmesa:htmlTable>
		</jmesa:tableModel>
	</form>
	
	<script type="text/javascript">
		function onInvokeAction(id)
		{
			setExportToLimit(id, '');
			createHiddenInputFieldsForLimitAndSubmit(id);
		}
		function onInvokeExportAction(id)
		{
			var parameterString = createParameterStringForLimit(id);
			location.href = 'vam.cc.esamiCitologici.List.us?' + parameterString;
		}
	</script>
</div>