<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>


<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
<input type="button" value="Aggiungi Richiesta" onclick="if(${cc.dataChiusura!=null}){ 
	if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){location.href='vam.cc.esamiIstopatologici.ToAdd.us'}
	}else{attendere();location.href='vam.cc.esamiIstopatologici.ToAdd.us';}">
	

	<!-- input type="button" value="Stampa richiesta multipla" onclick="location.href='vam.cc.esamiIstopatologici.StampaIstoMultiplo.us?'" /-->

<c:if test="${not empty cc.esameIstopatologicos}">
<br>
<c:set var="tipo" scope="request" value="stampaIstoMultiplo" />
<c:import url="../../jsp/documentale/home.jsp"/>
<br>
</c:if>

<h4 class="titolopagina">
     		Richieste Esami Istopatologici
</h4>



<div class="area-contenuti-2">
	<form action="vam.cc.esamiIstopatologici.List.us" method="post">
		
		<jmesa:tableModel items="${istopatologici}" id="ei" var="ei" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>

					<jmesa:htmlColumn property="numero" 			title="Numero Esame" filterable="false" sortable="false"/>
					
					<jmesa:htmlColumn property="dataRichiesta" 		title="Data Richiesta" 	pattern="dd/MM/yyyy" filterEditor="it.us.web.util.jmesa.DateFilterEditor">
						<fmt:formatDate pattern="dd/MM/yyyy" value="${ei.dataRichiesta}"  />
					</jmesa:htmlColumn>
				    <jmesa:htmlColumn property="dataEsito" 			title="Data Esito" 		pattern="dd/MM/yyyy" filterEditor="it.us.web.util.jmesa.DateFilterEditor">
						<fmt:formatDate pattern="dd/MM/yyyy" value="${ei.dataEsito}"  />
					</jmesa:htmlColumn>
					<jmesa:htmlColumn property="sedeLesione" 		title="Sede Lesione" sortable="false"/>
					
					<jmesa:htmlColumn property="numeroRifMittente" 		title="Numero Rif.Mittente">
						${ei.numeroAccettazioneSigla}
					</jmesa:htmlColumn>
					
					<jmesa:htmlColumn property="" title="Diagnosi"  sortable="false" filterable="false">
						${ei.whoUmana } <c:if test="${ei.tipoDiagnosi.id==3}">${ei.diagnosiNonTumorale }</c:if> 
					</jmesa:htmlColumn>
														
					<jmesa:htmlColumn sortable="false" filterable="false" title="Operazioni">
							<a href="vam.cc.esamiIstopatologici.Detail.us?id=${ei.id}" onclick="attendere();" >Dettaglio</a>
							<c:choose>
								<c:when test="${utente.ruolo!='IZSM' && utente.ruolo!='Universita' && utente.ruolo!='6' && utente.ruolo!='8'}">
									<a id="mod" href="vam.cc.esamiIstopatologici.ToAdd.us?modify=on&idEsame=${ei.id}" onclick="if(${cc.dataChiusura!=null}){ 
			    				return myConfirm('Cartella Clinica chiusa. Vuoi procedere?');
	    						}else{ attendere();return true;}">Modifica</a>
								</c:when>
								<c:otherwise>
									<a id="ie" href="vam.cc.esamiIstopatologici.ToAdd.us?modify=on&idEsame=${ei.id}&editIzsm=on" onclick="if(${cc.dataChiusura!=null}){ 
			    				return myConfirm('Cartella Clinica chiusa. Vuoi procedere?');
	    						}else{attendere();return true;}">Inserisci Esito</a>
								</c:otherwise>
							</c:choose>
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
			location.href = 'vam.cc.esamiIstopatologici.List.us?' + parameterString;
		}
	</script>
</div>