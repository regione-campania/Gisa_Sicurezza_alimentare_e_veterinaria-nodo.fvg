<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>


<h4 class="titolopagina">
     		Richieste Diagnosi BASE1,2 e 3
</h4>

<div class="area-contenuti-2">

 
	<form action="vam.altreDiagnosi.ListLLPP.us" method="post">		
		<jmesa:tableModel items="${altreDiagnosi}" id="ei" var="ei" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap" columnSort="it.us.web.util.jmesa.CustomColumnSort">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>

					<jmesa:htmlColumn property="identificativoAnimale"     title="Microchip">
						${ei.identificativoAnimale}
					</jmesa:htmlColumn>	
					<jmesa:htmlColumn property="note"     title="Note">
						${ei.noteBase1}${ei.noteBase2}${ei.noteBase3Rx}${ei.noteBase3Tac}${ei.noteBase3Rm}${ei.noteBase3Eco}
					</jmesa:htmlColumn>	
					<jmesa:htmlColumn property="altraDiagnosi"     title="Diagnosi">
						<c:choose>
					<c:when test="${ei.altraDiagnosi==1}">
						BASE 1 Clinica/anamnestica
					</c:when>
					<c:when test="${ei.altraDiagnosi==2}">
						BASE 2 Esami ematochimici
					</c:when>
					<c:when test="${ei.altraDiagnosi==3}">
						BASE 3 RX
					</c:when>
					<c:when test="${ei.altraDiagnosi==4}">
						BASE 3 Ecg
					</c:when>
					<c:when test="${ei.altraDiagnosi==5}">
						BASE 3 Tac
					</c:when>
					<c:when test="${ei.altraDiagnosi==6}">
						BASE 3 RM
					</c:when>
				</c:choose>
					</jmesa:htmlColumn>	
					<jmesa:htmlColumn sortable="false" filterable="false" title="Operazioni">
							<a href="vam.altreDiagnosi.DetailLLPP.us?id=${ei.id}" onclick="attendere()">Dettaglio</a>
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
			location.href = 'vam.altreDiagnosi.ListLLPP.us?' + parameterString;
		}
	</script>
</div>