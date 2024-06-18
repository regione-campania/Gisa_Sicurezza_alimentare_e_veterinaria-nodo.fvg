<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<h4 class="titolopagina">
     		Lista delle detenzioni
</h4>
<jsp:include page="/jsp/sinantropi/menuCatture.jsp"/>
<script type="text/javascript">
		ddtabmenu.definemenu("ddtabs2",2);	
</script> 
<br>
<br>
<br>

<c:if test="${(c.reimmissioni == null) && (s.dataDecesso == null)}">	
		<input type="button" value="Aggiungi un detentore" onclick="location.href='sinantropi.detenzioni.ToAdd.us?idCattura=${c.id}'">
</c:if>
<div class="area-contenuti-2">
	<form action="sinantropi.detenzioni.List.us" method="post">
		
		<input type="hidden" name="idCattura" 		value="<c:out value="${c.id}"/>"/>
		<input type="hidden" name="idSinantropo" 	value="<c:out value="${s.id}"/>"/>
						
		<jmesa:tableModel items="${c.detenzionis}" id="detenzioni" var="d" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>
										
					<jmesa:htmlColumn filterable="false" property="dataDetenzioneDa" title="Data Detenzione Da">
						<fmt:formatDate value="${d.dataDetenzioneDa}" pattern="dd/MM/yyyy" var="dataDetenzioneDa"/>
    			 		<c:out value="${dataDetenzioneDa}"></c:out>					
					</jmesa:htmlColumn>	
					
					<jmesa:htmlColumn filterable="false" property="dataDetenzioneA"  title="Data Detenzione A">
						<fmt:formatDate value="${d.dataDetenzioneA}" pattern="dd/MM/yyyy" var="dataDetenzioneA"/>
    			 		<c:out value="${dataDetenzioneA}"></c:out>					
					</jmesa:htmlColumn>			
					
					<jmesa:htmlColumn filterable="false"  property="lookupDetentori.description"  title="Detentore"/>					
						
					
					<jmesa:htmlColumn sortable="false" filterable="false" title="Operazioni">
							<a href="sinantropi.detenzioni.Detail.us?idDetenzione=${d.id}">Dettaglio</a>
							<a href="sinantropi.detenzioni.ToEdit.us?idDetenzione=${d.id}">Modifica</a>
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
			location.href = 'sinantropi.detenzioni.List.us?' + parameterString;
		}
	</script>
</div>