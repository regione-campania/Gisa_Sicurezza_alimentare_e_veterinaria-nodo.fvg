<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>


<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
<h4 class="titolopagina">
     		Anamnesi remota
</h4>


	    			 
<div class="area-contenuti-2">
	<form action="vam.cc.anamnesiRemota.List.us" method="post">
		
		<input type="hidden" name="identificativoAnimale" value="<c:out value="${identificativoAnimale}"/>"/>
		
		<jmesa:tableModel items="${cartelleCliniche}" id="cartelleCliniche" var="cc" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap" >
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>
					<jmesa:htmlColumn property="numero" 	title="Numero Cartella Clinica"/>
										
					<jmesa:htmlColumn property="dataApertura" 			title="Data di apertura" filterEditor="it.us.web.util.jmesa.DateFilterEditor">
						<fmt:formatDate value="${cc.dataApertura}" pattern="dd/MM/yyyy" var="dataApertura"/>
    			 		<c:out value="${dataApertura}"></c:out>					
					</jmesa:htmlColumn>
					
					<jmesa:htmlColumn property="lastDiagnosi.diagnosiEffettuate" title="Diagnosi" sortable="false">
						${cc.lastDiagnosi.diagnosiEffettuate}	
					</jmesa:htmlColumn>
					
					<jmesa:htmlColumn filterable="false" sortable="false" property="terapiaPrescritta" 	 title="Terapia prescritta"/>
					
					<jmesa:htmlColumn filterable="false" sortable="false"				title="Operazioni">
							<a href="vam.cc.Detail.us?idCartellaClinica=${cc.id}">Dettaglio</a>										
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
			location.href = 'vam.cc.anamnesiRemota.List.us?' + parameterString;
		}
	</script>
</div>