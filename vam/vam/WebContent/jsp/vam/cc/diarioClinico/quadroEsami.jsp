<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fn.tld" prefix="fn" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<%@page import="java.net.URLEncoder"%><script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>


<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
	<h4 class="titolopagina">
     		&nbsp;Lista Esami
</h4>

<input type="button" onclick="location.href='vam.cc.diarioClinico.Detail.us'" value="Vai al Diario Clinico" />

<div class="area-contenuti-2">
	<form name="qeForm" action="vam.cc.diarioClinico.QuadroEsami.us" method="post">
		
		<jmesa:tableModel items="${cc.quadroEsami }" id="qe" var="qe">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>
					
					<jmesa:htmlColumn property="nomeEsame" title="Esame" filterable="false" sortable="false"/>
					
					<jmesa:htmlColumn property="dataRichiesta" title="Data Richiesta" pattern="dd/MM/yyyy" cellEditor="org.jmesa.view.editor.DateCellEditor" filterable="false" sortable="false"/>
					
					<jmesa:htmlColumn property="dataEsito" title="Data Esito" pattern="dd/MM/yyyy" cellEditor="org.jmesa.view.editor.DateCellEditor" filterable="false" sortable="false"/>
					
					<jmesa:htmlColumn property="enteredBy" title="Richiesto da" filterable="false" sortable="false"/>
					
				</jmesa:htmlRow>
				
			</jmesa:htmlTable>
		</jmesa:tableModel>
	</form>
	
	<script type="text/javascript">
		function onInvokeAction(id)
		{
			setExportToLimit(id, '');
			createHiddenInputFieldsForLimitAndSubmit(id);
		};
		function onInvokeExportAction(id)
		{
			var parameterString = createParameterStringForLimit(id);
			location.href = 'vam.cc.QuadroEsami.Detail.us?' + parameterString;
		};
	</script>
</div>