<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<h4 class="titolopagina">
     		Lista Rilasci
</h4>
<jsp:include page="/jsp/sinantropi/menuSin.jsp"/>
<script type="text/javascript">
		ddtabmenu.definemenu("ddtabs2",3);		
</script> 
<br>
<br>
<br>
<input type="button" value="Aggiungi Rilascio" onclick="location.href='sinantropi.reimmissioni.ToAdd.us?idSinantropo=${s.id}'">

<div class="area-contenuti-2">
	<form action="sinantropi.reimmissioni.List.us" method="post">
		
		<input type="hidden" name="idCattura" 		value="<c:out value="${c.id}"/>"/>
		<input type="hidden" name="idSinantropo" 	value="<c:out value="${s.id}"/>"/>
		
					
		<jmesa:tableModel items="${c.reimmissioni}" id="reimmissioni" var="r" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>
										
					<jmesa:htmlColumn property="dataReimmissione" 	title="Data Reimmissione">
						<fmt:formatDate value="${r.dataReimmissione}" pattern="dd/MM/yyyy" var="dataReimmissione"/>
    			 		<c:out value="${dataReimmissione}"></c:out>					
					</jmesa:htmlColumn>			
					
					<jmesa:htmlColumn sortable="false" filterable="false"  property="" title="Provincia Reimmissione">
						<c:choose>			
							<c:when test="${r.comuneReimmissione.bn == true}">
								<c:out value="Benevento"></c:out>	
							</c:when>
							<c:when test="${r.comuneReimmissione.na == true}">
								<c:out value="Napoli"></c:out>	
							</c:when>
							<c:when test="${r.comuneReimmissione.sa == true}">
								<c:out value="Salerno"></c:out>	
							</c:when>
							<c:when test="${r.comuneReimmissione.av == true}">
								<c:out value="Avellino"></c:out>	
							</c:when>
							<c:when test="${r.comuneReimmissione.ce == true}">
								<c:out value="Caserta"></c:out>	
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</jmesa:htmlColumn>					
										
					<jmesa:htmlColumn sortable="false" filterable="false"  property="comuneReimmissione.description"  title="Comune Rilascio"/>					
					
					<jmesa:htmlColumn sortable="false" filterable="false"  property="luogoReimmissione"  title="Luogo Rilascio"/>
					
					<jmesa:htmlColumn sortable="false" filterable="false" title="Operazioni">							
							<a href="sinantropi.reimmissioni.ToEdit.us?idReimmissione=${r.id}">Modifica</a>
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
			location.href = 'sinantropi.reimmissioni.List.us?' + parameterString;
		}
	</script>
</div>