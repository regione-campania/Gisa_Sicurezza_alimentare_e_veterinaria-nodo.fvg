<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>


<h4 class="titolopagina">
     		Richieste Esami Istopatologici
</h4>

<div class="area-contenuti-2">

 
	<form action="vam.richiesteIstopatologici.ListLLPP.us" method="post">		
		<jmesa:tableModel items="${esamiIstopatologici}" id="ei" var="ei" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap" columnSort="it.us.web.util.jmesa.CustomColumnSort">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>

					<jmesa:htmlColumn property="numero" 			title="Numero Esame" filterable="false" sortable="false"/>
					<jmesa:htmlColumn property="identificativoAnimale"     title="Microchip">
						${ei.getIdentificativoAnimale() }
					</jmesa:htmlColumn>					
					<jmesa:htmlColumn property="dataRichiesta" 		title="Data Richiesta" 	pattern="dd/MM/yyyy" filterEditor="it.us.web.util.jmesa.DateFilterEditor">
						<fmt:formatDate pattern="dd/MM/yyyy" value="${ei.dataRichiesta}"  />
					</jmesa:htmlColumn>
				    <jmesa:htmlColumn property="dataEsito" 			title="Data Esito" 		pattern="dd/MM/yyyy" filterEditor="it.us.web.util.jmesa.DateFilterEditor">
						<fmt:formatDate pattern="dd/MM/yyyy" value="${ei.dataEsito}"  />
					</jmesa:htmlColumn>
					<jmesa:htmlColumn property="sedeLesione" 		title="Sede Lesione" sortable="false"/>
					<jmesa:htmlColumn property="" title="Diagnosi" filterable="false" sortable="false">
						<c:choose>
						<c:when test="${ei.tipoDiagnosi!=null && ei.tipoDiagnosi.id>0}">
							${ei.tipoDiagnosi.description }
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${ei.whoUmana!=null && ei.whoUmana.id>0}">
							${ei.whoUmana }
						</c:when>
					</c:choose>
					</jmesa:htmlColumn>
														
					<jmesa:htmlColumn sortable="false" filterable="false" title="Operazioni">
							<a href="vam.richiesteIstopatologici.DetailLLPP.us?id=${ei.id}" onclick="attendere()">Dettaglio</a>
							<c:if test="${ei.lass.id==19 && ei.dataEsito==null}">
								<a href="vam.richiesteIstopatologici.ToAdd.us?modify=on&idEsame=${ei.id}&editIzsm=on" onclick="attendere()">Inserisci Esito</a>
    						</c:if>
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
			location.href = 'vam.richiesteIstopatologici.ListLLPP.us?' + parameterString;
		}
	</script>
</div>