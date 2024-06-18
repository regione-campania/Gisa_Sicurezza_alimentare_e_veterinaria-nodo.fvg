<%@page import="it.us.web.util.properties.Application"%>
<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>

<h4 class="titolopagina">
     		Registro Tumori
</h4>    
	    			 
<div class="area-contenuti-2">
	<form action="vam.registroTumori.List.us" method="post">
		
		<jmesa:tableModel items="${listEsami}" id="listEsami" var="e" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap">

		<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>
					
					<jmesa:htmlColumn width="15%" property="dataRichiesta" title="Data Richiesta" cellEditor="it.us.web.util.jmesa.DateCellEditor" filterEditor="it.us.web.util.jmesa.DateFilterEditor"/>
					
					<jmesa:htmlColumn property="identificativoAnimale" title="Identificativo" sortable="false" filterable="true" />
												
										
					<jmesa:htmlColumn width="4%"  filterEditor="org.jmesa.view.html.editor.DroplistFilterEditor" property="cartellaClinica.accettazione.animale.sesso" title="Sesso" sortable="false">
												
						<c:choose>
			    			<c:when test="${e.outsideCC == true}">					
								<c:if test="${(e.animale.lookupSpecie.id == specie.cane or e.animale.lookupSpecie.id == specie.gatto) && e.animale.decedutoNonAnagrafe==false}">${e.animale.sesso}</c:if>
							  <c:if test="${e.animale.decedutoNonAnagrafe==true}">${e.animale.sesso}</c:if>
						      <c:if test="${e.animale.lookupSpecie.id == specie.sinantropo && e.animale.decedutoNonAnagrafe==false}">${e.animale.sesso}</c:if>
							</c:when>
							<c:otherwise>
								<c:if test="${(e.cartellaClinica.accettazione.animale.lookupSpecie.id == specie.cane or e.cartellaClinica.accettazione.animale.lookupSpecie.id == specie.gatto) && e.cartellaClinica.accettazione.animale.decedutoNonAnagrafe==false}">${e.cartellaClinica.accettazione.animale.sesso}</c:if>
							  <c:if test="${e.cartellaClinica.accettazione.animale.decedutoNonAnagrafe==true}">${e.cartellaClinica.accettazione.animale.sesso}</c:if>
						      <c:if test="${e.cartellaClinica.accettazione.animale.lookupSpecie.id == specie.sinantropo}">${e.cartellaClinica.accettazione.animale.sesso}</c:if>
							</c:otherwise>	
						</c:choose>	
												
					</jmesa:htmlColumn>
					
					<jmesa:htmlColumn filterEditor="org.jmesa.view.html.editor.DroplistFilterEditor" property="cartellaClinica.accettazione.animale.lookupSpecie.description" title="Specie" sortable="false" >
												
						<c:choose>
			    			<c:when test="${e.outsideCC == true}">					
								${e.animale.lookupSpecie.description}
							</c:when>
							<c:otherwise>
								${e.cartellaClinica.accettazione.animale.lookupSpecie.description}
							</c:otherwise>	
						</c:choose>	
												 
					</jmesa:htmlColumn>	
															
					<jmesa:htmlColumn  property="whoUmana" title="Diagnosi" sortable="false">
						${e.whoUmana } 
					</jmesa:htmlColumn>
					
					<jmesa:htmlColumn sortable="false" filterable="false" title="Dettaglio">
							<a href="vam.registroTumori.Detail.us?id=${e.id}" onclick="avviaPopup(this.href); return false;" target="_blank">Dettaglio</a>							
					</jmesa:htmlColumn>
											
				</jmesa:htmlRow>
			</jmesa:htmlTable>
		</jmesa:tableModel>
		
		<%
        //Abilitazione 287
		if(Application.get("flusso_287").equals("true"))
		{
		%>
		
		
		<jmesa:tableModel items="${listEsamiCit}" id="listEsamiCit" var="e" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap">

		<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>
					
					<jmesa:htmlColumn width="15%" property="dataRichiesta" title="Data Richiesta" cellEditor="it.us.web.util.jmesa.DateCellEditor" filterEditor="it.us.web.util.jmesa.DateFilterEditor"/>
					
					<jmesa:htmlColumn property="identificativoAnimale" title="Identificativo" sortable="false" filterable="true" />
										
							
										
					<jmesa:htmlColumn width="4%"  filterEditor="org.jmesa.view.html.editor.DroplistFilterEditor" property="cartellaClinica.accettazione.animale.sesso" title="Sesso" sortable="false">
												
						<c:choose>
			    			<c:when test="${e.outsideCC == true}">					
								<c:if test="${(e.animale.lookupSpecie.id == specie.cane or e.animale.lookupSpecie.id == specie.gatto) && e.animale.decedutoNonAnagrafe==false}">${e.animale.sesso}</c:if>
							  <c:if test="${e.animale.decedutoNonAnagrafe==true}">${e.animale.sesso}</c:if>
						      <c:if test="${e.animale.lookupSpecie.id == specie.sinantropo && e.animale.decedutoNonAnagrafe==false}">${e.animale.sesso}</c:if>
							</c:when>
							<c:otherwise>
								<c:if test="${(e.cartellaClinica.accettazione.animale.lookupSpecie.id == specie.cane or e.cartellaClinica.accettazione.animale.lookupSpecie.id == specie.gatto) && e.cartellaClinica.accettazione.animale.decedutoNonAnagrafe==false}">${e.cartellaClinica.accettazione.animale.sesso}</c:if>
							  <c:if test="${e.cartellaClinica.accettazione.animale.decedutoNonAnagrafe==true}">${e.cartellaClinica.accettazione.animale.sesso}</c:if>
						      <c:if test="${e.cartellaClinica.accettazione.animale.lookupSpecie.id == specie.sinantropo}">${e.cartellaClinica.accettazione.animale.sesso}</c:if>
							</c:otherwise>	
						</c:choose>	
												
					</jmesa:htmlColumn>
					
					<jmesa:htmlColumn filterEditor="org.jmesa.view.html.editor.DroplistFilterEditor" property="cartellaClinica.accettazione.animale.lookupSpecie.description" title="Specie" sortable="false" >
												
						<c:choose>
			    			<c:when test="${e.outsideCC == true}">					
								${e.animale.lookupSpecie.description}
							</c:when>
							<c:otherwise>
								${e.cartellaClinica.accettazione.animale.lookupSpecie.description}
							</c:otherwise>	
						</c:choose>	
												 
					</jmesa:htmlColumn>	
															
					<jmesa:htmlColumn  property="diagnosi" title="Diagnosi" sortable="false">
						<c:choose>
    						<c:when test="${e.idDiagnosiPadre==1}">
    							Sospetto benigno<br/>
			    			</c:when>
			    			<c:when test="${e.idDiagnosiPadre==2}">
			    				Sospetto maligno<br/>
			    				${e.diagnosi.padre} -> ${e.diagnosi}
			    			</c:when>
			    			<c:when test="${e.idDiagnosiPadre==3}">
			    				Non diagnostico<br/>
			    			</c:when>
			    		</c:choose>
					</jmesa:htmlColumn>
					
					<jmesa:htmlColumn sortable="false" filterable="false" title="Dettaglio">
							<a href="vam.registroTumori.Detail.us?idCit=${e.id}" onclick="avviaPopup(this.href); return false;" target="_blank">Dettaglio</a>							
					</jmesa:htmlColumn>
											
				</jmesa:htmlRow>
			</jmesa:htmlTable>
		</jmesa:tableModel>
		
		
		
		<jmesa:tableModel items="${altreDiagnosi}" id="ei" var="ei" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap" columnSort="it.us.web.util.jmesa.CustomColumnSort">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>

					<jmesa:htmlColumn width="15%" property="dataDiagnosi" title="Data Diagnosi" cellEditor="it.us.web.util.jmesa.DateCellEditor" filterEditor="it.us.web.util.jmesa.DateFilterEditor"/>
					
					
					<jmesa:htmlColumn property="identificativoAnimale"     title="Identificativo" sortable="false" filterable="true" />
						
										
					<jmesa:htmlColumn width="4%"  filterEditor="org.jmesa.view.html.editor.DroplistFilterEditor" property="animale.sesso" title="Sesso" sortable="false">
								${ei.animale.sesso}
					</jmesa:htmlColumn>
					
					<jmesa:htmlColumn filterEditor="org.jmesa.view.html.editor.DroplistFilterEditor" property="animale.lookupSpecie.description" title="Specie" sortable="false" >
								${ei.animale.lookupSpecie.description}
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
					<jmesa:htmlColumn sortable="false" filterable="false" title="Dettaglio">
							<a href="vam.registroTumori.DetailBase.us?id=${ei.id}" onclick="avviaPopup(this.href); return false;" target="_blank">Dettaglio</a>
					</jmesa:htmlColumn>
					
				</jmesa:htmlRow>
			</jmesa:htmlTable>
		</jmesa:tableModel> 
		
		<%
}
%>
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
			location.href = 'vam.registroTumori.List.us?' + parameterString;
		}
	</script>
</div>