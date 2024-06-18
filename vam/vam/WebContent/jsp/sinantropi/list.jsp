<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>

<h4 class="titolopagina">
     		Lista Sinantropi in BDR
</h4>    
	    			 
<div class="area-contenuti-2">
	<form action="sinantropi.List.us" method="post">
				
		<jmesa:tableModel items="${sinantropi}" id="sinantropi" var="s" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>
					<jmesa:htmlColumn property="numeroAutomatico"  title="Identificativo in BDR"/>
					
					<c:if test="${s.numeroUfficiale!=''}">					
						<jmesa:htmlColumn property="numeroUfficiale"   title="Numero Ufficiale Istituto Faunistico"/>
					</c:if>
					<c:if test="${s.mc!=''}">											
						<jmesa:htmlColumn property="mc"  title="Microchip" />
					</c:if>
					<c:if test="${s.codiceIspra!=''}">					
						<jmesa:htmlColumn property="codiceIspra"   title="Codice Ispra"/>
					</c:if>
					
					<jmesa:htmlColumn property="lookupSpecieSinantropi.description" title="Genere-Famiglia"/>						
										
					<jmesa:htmlColumn property="lastOperation"	title="Ultimo stato"/>
										
					<jmesa:htmlColumn property="dataDecesso" filterable="false"	title="Data decesso">
						<fmt:formatDate value="${s.dataDecesso}" pattern="dd/MM/yyyy" var="dataDecesso"/>
    			 		<c:out value="${dataDecesso}"></c:out>					
					</jmesa:htmlColumn>
					
					
					<jmesa:htmlColumn sortable="false" filterable="false" 				title="Operazioni">
							<a href="sinantropi.Detail.us?idSinantropo=${s.id}">Dettaglio</a>										
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
			location.href = 'sinantropi.List.us?' + parameterString;
		}
	</script>
</div>