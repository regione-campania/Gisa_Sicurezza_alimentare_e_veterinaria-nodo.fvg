<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>


<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
<h4 class="titolopagina">
     		Lista Esami Coprologici precedenti
</h4>

<input type="button" value="Aggiungi Esame Coprologico" onclick="if(${cc.dataChiusura!=null}){ 
	if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){location.href='vam.cc.esamiCoprologici.ToAdd.us'}
	}else{location.href='vam.cc.esamiCoprologici.ToAdd.us'}">

<div class="area-contenuti-2">
	<form action="vam.cc.esamiCoprologici.List.us" method="post">
		
		<jmesa:tableModel items="${cc.esameCoprologicos }" id="ei" var="ei">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>

					<jmesa:htmlColumn property="dataRichiesta" title="Data Richiesta" pattern="dd/MM/yyyy" cellEditor="org.jmesa.view.editor.DateCellEditor" filterable="false"/>
					<jmesa:htmlColumn property="dataEsito" title="Data Esito" pattern="dd/MM/yyyy" cellEditor="org.jmesa.view.editor.DateCellEditor" filterable="false"/>
					<jmesa:htmlColumn property="elminti" 	title="Elminti" sortable="false" />
					<jmesa:htmlColumn property="protozoi" 	title="Protozoi" sortable="false" />
														
					<jmesa:htmlColumn sortable="false" filterable="false" title="Operazioni">
							<a href="vam.cc.esamiCoprologici.Detail.us?id=${ei.id}">Dettaglio</a>
							<a id="mod" href="vam.cc.esamiCoprologici.ToEdit.us?modify=on&idEsame=${ei.id}" onclick="if(${cc.dataChiusura!=null}){ 
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
			location.href = 'vam.cc.esamiCoprologici.List.us?' + parameterString;
		}
	</script>
</div>