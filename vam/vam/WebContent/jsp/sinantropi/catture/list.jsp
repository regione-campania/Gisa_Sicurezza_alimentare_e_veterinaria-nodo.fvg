<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<h4 class="titolopagina">
     		Lista dei rinvenimenti
</h4>
<jsp:include page="/jsp/sinantropi/menuSin.jsp"/>
<script type="text/javascript">
		ddtabmenu.definemenu("ddtabs2",1);		
</script> 
<br>
<br>
<br>


<c:if test="${s.lastOperation == 'RILASCIO'}">
	<input type="button" value="Registra Rinvenimento" onclick="location.href='sinantropi.catture.ToAdd.us?idSinantropo=${s.id}'">
</c:if>



<div class="area-contenuti-2">
	<form action="sinantropi.catture.List.us" method="post">
		
		<input type="hidden" name="idSinantropo" value="<c:out value="${s.id}"/>"/>
		
				
		<jmesa:tableModel items="${s.cattureis}" id="catture" var="c" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>
										
					<jmesa:htmlColumn filterable="false" property="dataCattura" 	title="Data Rinvenimento">
						<fmt:formatDate value="${c.dataCattura}" pattern="dd/MM/yyyy" var="dataCattura"/>
    			 		<c:out value="${dataCattura}"></c:out>					
					</jmesa:htmlColumn>			
					
					<jmesa:htmlColumn sortable="false" filterable="false"  property="" title="Provincia Rinvenimento">
						<c:choose>			
							<c:when test="${c.comuneCattura.bn == true}">
								<c:out value="Benevento"></c:out>	
							</c:when>
							<c:when test="${c.comuneCattura.na == true}">
								<c:out value="Napoli"></c:out>	
							</c:when>
							<c:when test="${c.comuneCattura.sa == true}">
								<c:out value="Salerno"></c:out>	
							</c:when>
							<c:when test="${c.comuneCattura.av == true}">
								<c:out value="Avellino"></c:out>	
							</c:when>
							<c:when test="${c.comuneCattura.ce == true}">
								<c:out value="Caserta"></c:out>	
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</jmesa:htmlColumn>					
										
					<jmesa:htmlColumn sortable="false" filterable="false"  property="comuneCattura.description"  title="Comune Rinvenimento"/>					
					
					<jmesa:htmlColumn sortable="false" filterable="false" property="luogoCattura"  title="Luogo Rinvenimento"/>
					
					<jmesa:htmlColumn sortable="false" filterable="false" title="Operazioni">							
							<a href="sinantropi.catture.Detail.us?idCattura=${c.id}">Gestione Rinvenimenti, Detenzioni e Rilasci</a>
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
			location.href = 'sinantropi.catture.List.us?' + parameterString;
		}
	</script>
</div>