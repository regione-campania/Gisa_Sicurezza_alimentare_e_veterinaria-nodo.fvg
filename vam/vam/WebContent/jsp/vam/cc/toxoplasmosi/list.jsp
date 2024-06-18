<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>


<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
<h4 class="titolopagina">
     		Lista Esami Toxoplasmosi
</h4>

<input type="button" value="Aggiungi Esame Toxoplasmosi" onclick="location.href='vam.cc.toxoplasmosi.ToAddEdit.us'">

<div class="area-contenuti-2">
	<form action="vam.cc.toxoplasmosi.List.us" method="post">
		
		<jmesa:tableModel items="${cc.toxoplasmosis }" id="tx" var="tx">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>

					<jmesa:htmlColumn property="dataRichiesta" title="Data Richiesta" pattern="dd/MM/yyyy" cellEditor="org.jmesa.view.editor.DateCellEditor" filterable="false"/>
					<jmesa:htmlColumn property="dataEsito" title="Data Esito" pattern="dd/MM/yyyy" cellEditor="org.jmesa.view.editor.DateCellEditor" filterable="false"/>
					<jmesa:htmlColumn property="tipoPrelievo" 	title="Tipo Prelievo" sortable="false" />
					<jmesa:htmlColumn property="esito" 	title="Esito" sortable="false" />
														
					<jmesa:htmlColumn sortable="false" filterable="false" title="Operazioni">
						<a id="mod" href="vam.cc.toxoplasmosi.ToAddEdit.us?modify=on&idEsame=${tx.id}" onclick="if(${cc.dataChiusura!=null}){ 
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
			location.href = 'vam.cc.toxoplasmosi.List.us?' + parameterString;
		}
	</script>
</div>