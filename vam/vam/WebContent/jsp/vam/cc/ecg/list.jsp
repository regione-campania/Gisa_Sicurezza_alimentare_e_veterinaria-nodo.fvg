<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>


<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
<h4 class="titolopagina">
     		Lista ECG precedenti
</h4>

<input type="button" value="Aggiungi ECG" onclick="if(${cc.dataChiusura!=null}){ 
	if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){location.href='vam.cc.ecg.ToAdd.us'}
	}else{location.href='vam.cc.ecg.ToAdd.us'}">

<div class="area-contenuti-2">
	<form action="vam.cc.ecg.List.us" method="post">
		
		<jmesa:tableModel items="${ecg}" id="ecg" var="ecg" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap" columnSort="it.us.web.util.jmesa.CustomColumnSort">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>

					<jmesa:htmlColumn property="dataRichiesta" title="Data Richiesta" cellEditor="it.us.web.util.jmesa.DateCellEditor" filterEditor="it.us.web.util.jmesa.DateFilterEditor"/>
					<jmesa:htmlColumn property="dataEsito" title="Data Esito" cellEditor="it.us.web.util.jmesa.DateCellEditor" filterEditor="it.us.web.util.jmesa.DateFilterEditor"/>
					
					<jmesa:htmlColumn property="ritmo" 	title="Ritmo" cellEditor="it.us.web.util.jmesa.vam.RitmoCellEditor" filterEditor="it.us.web.util.jmesa.vam.RitmoDroplistFilterEditor"/>	
														
					<jmesa:htmlColumn sortable="false" filterable="false" title="Operazioni">
							<a href="vam.cc.ecg.Detail.us?idEcg=${ecg.id}">Dettaglio</a>
							<a id="mod" href="vam.cc.ecg.ToEdit.us?idEcg=${ecg.id}" onclick="if(${cc.dataChiusura!=null}){ 
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
			location.href = 'vam.cc.ecg.List.us?' + parameterString;
		}
	</script>
</div>