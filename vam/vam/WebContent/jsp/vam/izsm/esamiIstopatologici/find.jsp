<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>

<!--  
<h4 class="titolopagina">
     		Ricerca Esame Istopatologico
</h4>  

<table class="tabella">
	    
    <tr>
	    <td> 
	    	Numero Esame
	    </td>
	    <td>
		    <form action="vam.izsm.esamiIstopatologici.Find.us" method="post">			
				<input type="text" name="numeroEsame" maxlength="64" /> 
				<input type="submit" value="Cerca" />
			</form>
		</td>
    </tr>
</table>
-->
 
<h4 class="titolopagina">
     		Lista Richieste Istopatologici
</h4>

<div class="area-contenuti-2">
	<form action="vam.izsm.esamiIstopatologici.ToFind.us" method="post">
		
		<jmesa:tableModel items="${esamiIstopatologici}" id="ei" var="ei" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>

					<jmesa:htmlColumn property="numero" 			title="Numero Esame"/>
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
					<jmesa:htmlColumn property="numeroRifMittente" 		title="Numero Rif.Mittente">
						${ei.numeroAccettazioneSigla}
					</jmesa:htmlColumn>
					<jmesa:htmlColumn property="enteredBy" 		title="Richiesto Da">
						${ei.enteredBy.ruoloByTalos}
					</jmesa:htmlColumn>
					<jmesa:htmlColumn property="" title="Diagnosi"  sortable="false" filterable="false">
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
							
							<c:choose>
								<c:when test="${ei.dataEsito!=null}">
									<a href="vam.izsm.esamiIstopatologici.Find.us?numeroEsame=${ei.numero}" onclick="attendere();">
										Dettaglio
									</a>
								</c:when>
			    				<c:otherwise>
			    					<a href="vam.izsm.esamiIstopatologici.ToEdit.us?numeroEsame=${ei.numero}" onclick="attendere();">
										Dettaglio
									</a>
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