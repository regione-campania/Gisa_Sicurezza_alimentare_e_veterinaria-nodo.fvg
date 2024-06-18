<%@page import="it.us.web.bean.vam.Animale"%>
<%@page import="it.us.web.constants.SpecieAnimali"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@page import="java.util.Date"%>
<script language="JavaScript" type="text/javascript" src="js/vam/richiesteIstopatologici/add.js"></script>

<%
	Animale animale = (Animale)request.getAttribute("animale");
	String proprietarioCognome			= (String)request.getAttribute("proprietarioCognome");
	String proprietarioNome 			= (String)request.getAttribute("proprietarioNome");
	String proprietarioCodiceFiscale	= (String)request.getAttribute("proprietarioCodiceFiscale");
	String proprietarioDocumento		= (String)request.getAttribute("proprietarioDocumento");
	String proprietarioIndirizzo 		= (String)request.getAttribute("proprietarioIndirizzo");
	String proprietarioCap 				= (String)request.getAttribute("proprietarioCap");
	String proprietarioComune 			= (String)request.getAttribute("proprietarioComune");
	String proprietarioProvincia 		= (String)request.getAttribute("proprietarioProvincia");
	String proprietarioTelefono 		= (String)request.getAttribute("proprietarioTelefono");
	String proprietarioTipo 			= (String)request.getAttribute("proprietarioTipo");
	String nomeColonia 					= (String)request.getAttribute("nomeColonia");
	Boolean randagio 					= (Boolean)request.getAttribute("randagio");
	if(randagio==null)
		randagio = false;
	SpecieAnimali specie				= (SpecieAnimali)request.getAttribute("specie");
%>

<form action="vam.richiesteIstopatologici.AddLLPP.us" name="form" id="form" method="post" class="marginezero" onsubmit="javascript:return checkform(this)">    
<input type="hidden" name="idAnimale" id="idAnimale" value="${animale.id}" /> 
	
	<fmt:formatDate value="${animale.dataSmaltimentoCarogna}" pattern="dd/MM/yyyy" var="dataSmaltimento"/>
    <input type="hidden" name="dataSmaltimento" id="dataSmaltimento" value="${dataSmaltimento}" />  
    
    <h4 class="titolopagina">
			Nuova richiesta Esame Istopatologico
    </h4>	 
    
    <table class="tabella">
    <tr>
    	<th colspan="2">
    		Dati Animale
    	</th>
    </tr>
	<tr class='even'>
		<td>
			Identificativo
		</td>
		<td>
			<%=animale.getIdentificativo()%>
		</td>
	</tr>
	<tr class='even'>
		<td>
			Tatuaggio / II MC
		</td>
		<td>
<%				
			if(animale.getTatuaggio()!=null)
			{
%> 
				<%=animale.getTatuaggio()%> 
<%
			}
%>
		</td>
	</tr>
	<c:choose>
		<c:when test="<%=animale.getLookupSpecie().getId()==specie.getSinantropo()%>">
			<fmt:formatDate type="date" value="<%=animale.getDataNascita()%>" pattern="dd/MM/yyyy" var="dataNascita" />
			<tr class='odd'>
				<td>
					Et&agrave;
				</td>
				<td>
					${animale.eta.description}
					<c:if test="<%=animale.getDataNascita()!=null %>">
						(<%=animale.getDataNascita() %>)
					</c:if>
				</td>
			</tr>
		</c:when>
		<c:otherwise>
			<fmt:formatDate type="date" value="<%=animale.getDataNascita()%>" pattern="dd/MM/yyyy" var="dataNascita"/>
			<tr class='odd'>
				<td>
					Data nascita
				</td>
				<td>
<%
				if (animale.getDataNascita()!=null)
				{
%>
					<%=animale.getDataNascita()%>
<%
				} 
%>
				</td>
			</tr>
		</c:otherwise>
	</c:choose>
	
<!--  	<c:set scope="request" var="anagraficaAnimale" value="${anagraficaAnimale}"/> -->
    <c:import url="../vam/richiesteIstopatologici/anagraficaAnimaleDetail.jsp"/>
	
		<c:if test="<%=animale.getClinicaChippatura()!=null%>">
			<tr class='even'>
				<td>
					Microchippato nella clinica 
				</td>
				<td>
					<%=animale.getClinicaChippatura().getNome()%>
				</td>
			</tr>
		</c:if>
		<c:if test="${animale.dataMorte!=null || res.dataEvento!=null}">
        	<tr class='even'>
   				<td>
   					Data del decesso
   				</td>
   				<td> 
					${dataMorte} - 
					<c:choose>
						<c:when test="<%=animale.getDecedutoNonAnagrafe()==true %>">
							<%=animale.getDataMorteCertezza()%>
						</c:when>
						<c:otherwise>
							${res.dataMorteCertezza}
						</c:otherwise>	
					</c:choose>	 
        		</td>
   			</tr>
    	
   			<tr class='odd'>
      	  		<td>
    				Probabile causa del decesso
   				</td>
   				<td>    
   					<c:choose>
    				<c:when test="<%=animale.getDecedutoNonAnagrafe()%>">
<% 
					if (animale.getCausaMorte().getDescription()!=null)
					{ 
%>
						<%=animale.getCausaMorte().getDescription()%>
<%
					} 
					else 
					{
%>
    					<%=""%>
<%
					}
%>
    				</c:when>
    				<c:otherwise>
    					${res.decessoValue}
    				</c:otherwise>
    				</c:choose>	        	        
        		</td>
       		</tr>
       	</c:if>

	<!--  c:if test="${!animale.decedutoNonAnagrafe }" -->
		<c:choose>
			<c:when test="<%=animale.getLookupSpecie().getId()==specie.getSinantropo()%>">
				<tr>
					<th colspan="2">
						Detentore
					</th>
				</tr>
			</c:when>
			<c:otherwise>
				<c:set var="proprietarioCognome" value="<%=proprietarioCognome%>"/>
				<c:choose>
					<c:when test="<%=proprietarioCognome!=null && proprietarioCognome.startsWith(\"<b>\")%>">
						<th colspan="2">Colonia</th>
					</c:when>
					<c:otherwise>
						<th colspan="2">Proprietario <%=(proprietarioTipo==null || proprietarioTipo.equals("null"))?(""):(proprietarioTipo)%></th>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when test="<%=proprietarioCognome!=null && proprietarioCognome.startsWith(\"<b>\")%>">
				<tr class='even'>
					<td>
						Colonia
					</td>
					<td colspan="2">
						<%=nomeColonia%>
					</td>
				</tr>
				<tr class='odd'>
					<td>
						Indirizzo
					</td>
					<td>
						<%=proprietarioIndirizzo%>, <%=proprietarioComune%>
						<c:if test="<%=!proprietarioProvincia.equals(\"\") %>">
							(<%=proprietarioProvincia%>)						
						</c:if>
						<c:if test="<%=!proprietarioCap.equals(\"\")%>">
							- <%=proprietarioCap%>						
						</c:if>
					</td>
				</tr>
				<tr class='even'>
					<td>
						Nominativo Referente
					</td>
					<td>
						<%=proprietarioNome%>
					</td>
				</tr>
				<tr class='odd'>
					<td>
						Codice fiscale Referente
					</td>
					<td>
						<%=proprietarioCodiceFiscale%>
					</td>
				</tr>
				<tr class='even'>
					<td>
						Documento Identità Referente
					</td>
					<td>
						<%=proprietarioDocumento%>
					</td>
				</tr>
				<tr class='odd'>
					<td>
						Telefono Referente
					</td>
					<td>
						<%=proprietarioTelefono%>
					</td>
				</tr>
			</c:when>
			<c:when test="${proprietarioTipo=='Importatore' || proprietarioTipo=='Operatore Commerciale'}">
				<tr class='even'><td>Ragione Sociale:</td><td><%=proprietarioNome%></td></tr>
				<tr class='odd'><td>Partita Iva:</td><td><%=proprietarioCognome%></td></tr>
				<tr class='even'><td>Rappr. Legale:</td><td><%=proprietarioCodiceFiscale%></td></tr>
				<tr class='odd'><td>Telefono struttura(principale):</td><td><%=proprietarioTelefono%></td></tr>
				<tr class='even'><td>Telefono struttura(secondario):</td><td><%=proprietarioDocumento%></td></tr>
				<tr class='odd'><td>Indirizzo sede operativa:</td><td><%=proprietarioIndirizzo%></td></tr>
				<tr class='even'><td>CAP sede operativa:</td><td><%=proprietarioCap%></td></tr>
				<tr class='odd'><td>Comune sede operativa:</td><td><%=proprietarioComune%></td></tr>
				<tr class='even'><td>Provincia sede operativa:</td><td><%=proprietarioProvincia%></td></tr>
			</c:when>
			<c:otherwise>
				<c:if test="<%=proprietarioTipo!=null && proprietarioTipo.equals(\"Canile\") %>">
					<tr class='even'><td>Ragione Sociale:</td><td><%if (proprietarioNome!=null){%><%=proprietarioNome %><%} %></td></tr>
					<tr class='odd'><td>Partita Iva:</td><td><%=proprietarioCognome%></td></tr>
					<tr class='even'><td>Rappr. Legale:</td><td><%=proprietarioCodiceFiscale%></td></tr>
				</c:if>
				<c:if test="<%=proprietarioTipo!=null && !proprietarioTipo.equals(\"Canile\") %>">
					<c:if test="<%=!randagio%>">
						<tr class='even'><td>Cognome:</td><td><%if (proprietarioCognome!=null){%><%=proprietarioCognome%><%} %></td></tr>
					</c:if>
					<tr class='odd'><td>Nome:</td><td><%if (proprietarioNome!=null){%><%=proprietarioNome %><%} %></td></tr>
				</c:if>	
				<c:if test="<%=!randagio%>">
				<c:if test="<%=proprietarioTipo!=null && !proprietarioTipo.equals(\"Canile\") %>">
					<tr class='even'><td>Codice Fiscale:</td><td><% if (proprietarioCodiceFiscale!=null){%><%=proprietarioCodiceFiscale%><%} %></td></tr>
				</c:if>
					<tr class='odd'><td>Documento:</td><td><% if (proprietarioDocumento!=null){%><%=proprietarioDocumento%><%} %></td></tr>
					<tr class='even'><td>Indirizzo:</td><td><% if (proprietarioIndirizzo!=null){%><%=proprietarioIndirizzo%><%} %></td></tr>
					<tr class='odd'><td>CAP:</td><td><% if (proprietarioCap!=null){%><%=proprietarioCap%><%} %></td></tr>
					<tr class='even'><td>Comune:</td><td><% if (proprietarioComune!=null){%><%=proprietarioComune%><%} %></td></tr>
					<tr class='odd'><td>Provincia:</td><td><% if (proprietarioProvincia!=null){%><%=proprietarioProvincia%><%} %></td></tr>
					<tr class='even'><td>Telefono:</td><td><% if (proprietarioTelefono!=null){%><%=proprietarioTelefono%><%} %></td></tr>
				</c:if>
			</c:otherwise>
		</c:choose>
    </table>
    
    <table class="tabella">
    	<tr>
        	<th colspan="3">
        		Dati generici dell'animale
        	</th>
        </tr>
    
    	<tr class='even'>
    		<td>
    			Peso dell'animale (in Kg)
    		</td>
    		<td>
    			 <input type="text" name="peso" maxlength="6" size="6"/>
    		</td>
    		<td>
    		</td>
        </tr>
        
        <tr class="odd">
    		<td style="width:30%">
    			 Stato generale
    		</td>
    		<td style="width:70%">  
    			  <select name="idStatoGeneraleLookup" id="idStatoGeneraleLookup">
    			 	<option value="">&lt;---Selezionare---&gt;</option>
    			 	<c:forEach items="${statoGeneraleLookups }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.statoGeneraleLookup }">selected="selected"</c:if>>${temp.description }</option>
    			 	</c:forEach>
    			 </select>
    		</td>
        </tr>
        
        <tr class='odd'>
    		<td>
    			Habitat 
    		</td>
    		<td>
    		
    			<c:forEach items="${listHabitat}" var="h" >									
							<input type="checkbox" name="oph_${h.id }" id="oph_${h.id }" onclick="mutuamenteEsclusiviHabitatAlimentazioni(this.id);" /> ${h.description} 	
							<br>				
				</c:forEach>
    		
    		</td>
    		<td>
    		</td>
        </tr>
        
        <tr class='even'>
    		<td>
    			Alimentazione
    		</td>
    		<td>
    			<c:forEach items="${listAlimentazioni}" var="a" >									
							<input onclick="mutuamenteEsclusiviHabitatAlimentazioni(this.id);" type="checkbox" name="opa_${a.id }" id="opa_${a.id }" /> ${a.description} 	
							<br>				
				</c:forEach> 
				<c:forEach items="${listAlimentazioniQualita}" var="aq" >									
							<input onclick="mutuamenteEsclusiviHabitatAlimentazioni(this.id);" type="checkbox" name="opaq_${aq.id }" id="opaq_${aq.id }" /> ${aq.description} 	
							<br>				
				</c:forEach> 
    		</td>
    		<td>
    		</td>
        </tr>
        
        <tr>
        	<th colspan="2">
        		Richiesta
        	</th>
        </tr>
    	<tr class="even">
    		<td>
    			Data Richiesta<font color="red"> *</font>
    		</td>
    		<td style="width:50%">    			 
    			 <input 
    			 	type="text" 
    			 	id="dataRichiesta" 
    			 	name="dataRichiesta" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:246px;" 
					value="<fmt:formatDate type="date" value="<%=new Date() %>" pattern="dd/MM/yyyy" />" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_1" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataRichiesta",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_1",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> 
  					 
    				
    		</td>    		
        </tr>
        
        <tr class='odd'>
    		<td>
    			 Laboratorio di destinazione<font color="red"> *</font>
    		</td>
    		<td>
    			 <select name="lookupAutopsiaSalaSettoria" onchange="attivaLaboratorioPrivato(this.value)"  >
    			 	<option value="">&lt;---Selezionare---&gt;</option>
				 	<c:forEach items="${listAutopsiaSalaSettoria}" var="t" >
				 		<c:if test="${q.esterna && viewOptEsterna=='true'}">
				 			<optgroup label="<------- Esterna ------->" style="font-style: italic">
							<c:set value="false" var="viewOptEsterna"/>
				 		</c:if>
				 		<c:if test="${!q.esterna && viewOptInterna=='true'}">
				 			<optgroup label="<------- Interna ------->" style="font-style: italic">
				 			<c:set value="false" var="viewOptInterna"/>
				 		</c:if>
				 		<c:if test="${t.id==7}">
				 		<optgroup label="Universit&agrave;">
				 	</c:if>
				 	<c:if test="${t.id==6}">
				 		</optgroup>
				 		<optgroup label="IZSM">
				 	</c:if>	
				 	<c:if test="${t.id==19}">
				 		</optgroup>
				 		<optgroup label="Laboratorio Privato">
				 	</c:if>	
				    	<option value="${t.id }" <c:if test="${t.id==esame.lass.id}">selected="selected"</c:if> >${t.description }</option>
					</c:forEach>
					</optgroup>
		      	</select>
		      	
		      	
		      	<input style="display:none;" type="text" value="" id="laboratorioPrivato" name="laboratorioPrivato"/>
    		</td>
        </tr>  
        
              
		<tr class="odd">
    		<td style="width:30%">
    			 Tipo Prelievo
    		</td>
    		<td style="width:70%">  
    			 <select name="idTipoPrelievo" id="idTipoPrelievo">
    			 	<c:forEach items="${tipoPrelievos }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.tipoPrelievo }">selected="selected"</c:if>>${temp.description }</option>
    			 	</c:forEach>
    			 </select>
    		</td>
        </tr> 
        
         <tr class="odd">
    		<td style="width:30%">
    			 Sede Lesione e Sottospecifica<font color="red"> *</font> 
    		</td>
    		<td style="width:70%">  
    			 <select name="padreSedeLesione" id="padreSedeLesione" onchange="selezionaDivSedeLesione(this.value)">
    			 	<c:forEach items="${sediLesioniPadre }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp.id == esame.sedeLesione.padre.padre.id || temp.id == esame.sedeLesione.padre.id || temp.id == esame.sedeLesione.id }">selected="selected"</c:if> >${temp.codice } - ${temp.description }</option>
    			 	</c:forEach>
    			 </select>
    			 <br/>
    			 <c:forEach items="${sediLesioniPadre }" var="temp">
    			 	<div <c:if test="${temp.id > 0 }"> style="display: none;" </c:if> id="div_sedi_${temp.id }" name="div_sedi_${temp.id }">
    			 		<c:if test="${empty temp.figli }">
    			 			<input type="hidden" name="idSedeLesione" id="idSedeLesione" value="${temp.id }" <c:if test="${temp.id > 0 }">disabled="disabled"</c:if> />
    			 		</c:if>
    			 		<c:if test="${not empty temp.figli }">
    			 			 <select name="idSedeLesione" id="idSedeLesione" disabled="disabled">
			    			 	<c:forEach items="${temp.figli }" var="figlio">
			    			 		<c:if test="${empty figlio.figli }">
			    			 			<option value="${figlio.id }" <c:if test="${figlio == esame.sedeLesione }">selected="selected"</c:if> >${figlio.codice } - ${figlio.description }</option>
			    			 		</c:if>
			    			 		<c:if test="${not empty figlio.figli}">
			    			 			<optgroup label="${figlio.description }">
			    			 				<c:forEach items="${figlio.figli }" var="nipote" >
			    			 					<option value="${nipote.id }" <c:if test="${nipote == esame.sedeLesione }">selected="selected"</c:if> >${nipote.codice } - ${nipote.description }</option>
			    			 				</c:forEach>
			    			 			</optgroup>
			    			 		</c:if>
			    			 	</c:forEach>
			    			 </select>
    			 		</c:if>
    			 	</div>
    			 </c:forEach>
    		</td>
        </tr> 
        
        <tr class="odd">
    		<td style="width:30%">
    			 Tumore
    		</td>
    		<td style="width:70%">  
    			  <select name="idTumore" id="idTumore">
    			 	<option value="">&lt;---Selezionare---&gt;</option>
    			 		<c:forEach items="${tumores }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.tumore }">selected="selected"</c:if>>${temp.description }</option>
    			 	</c:forEach>
    			 </select>
    		</td>
        </tr> 
        
        <tr class="odd">
    		<td style="width:30%">
    			 Trattamenti ormonali
    		</td>
    		<td style="width:70%">  
    			 <input type="text" name="trattOrm" id="trattOrm" size="50" value="${esame.trattOrm }"/>
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 Tumori Precedenti
    		</td>
    		<td style="width:70%">  
    			<select name="idTumoriPrecedenti" id="idTumoriPrecedenti" onchange="updateTNM(this.value);">
    			 	<c:forEach items="${tumoriPrecedentis }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.tumoriPrecedenti }">selected="selected"</c:if> >${temp.description }</option>
    			 	</c:forEach>
    			 </select>
    			 
    			 
    			 
    			 
    			 <div id="tnm" name="tnm" style="display: none">
    			 
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnosi" 
    			 	name="dataDiagnosi" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_2" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_2",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente" id="diagnosiPrecedente"   value="${esame.diagnosiPrecedente }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t" id="t"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n" id="n"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m" id="m"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	<input type="button" value="+" onclick="aggiungiRigaTNM();">
    			 </div>
    			 <div id="tnm1" name="tnm1" style="display: none">
    			 <br/>
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnosi1" 
    			 	name="dataDiagnosi1" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_3" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi1",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_3",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente1" id="diagnosiPrecedente1"   value="${esame.diagnosiPrecedente1 }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t1" id="t1"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n1" id="n1"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m1" id="m1"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	
    			 </div>
    			 <div id="tnm2" name="tnm2" style="display: none">
    			 <br/>
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnosi2" 
    			 	name="dataDiagnosi2" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_4" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi2",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_4",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente2" id="diagnosiPrecedente2"   value="${esame.diagnosiPrecedente2 }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t2" id="t2"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n2" id="n2"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m2" id="m2"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	
    			 </div>
    			 <div id="tnm3" name="tnm3" style="display: none">
    			 <br/>
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnosi3" 
    			 	name="dataDiagnosi3" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_5" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi3",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_5",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente3" id="diagnosiPrecedente3"   value="${esame.diagnosiPrecedente3 }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t3" id="t3"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n3" id="n3"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m3" id="m3"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	
    			 </div>
    			 <div id="tnm4" name="tnm4" style="display: none">
    			 <br/>
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnosi4" 
    			 	name="dataDiagnosi4" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_6" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_4",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente4" id="diagnosiPrecedente4"   value="${esame.diagnosiPrecedente4 }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t4" id="t4"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n4" id="n4"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m4" id="m4"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	
    			 </div>
    			 <div id="tnm5" name="tnm5" style="display: none">
    			 <br/>
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnos5" 
    			 	name="dataDiagnosi5" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_7" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi5",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_7",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente5" id="diagnosiPrecedente5"   value="${esame.diagnosiPrecedente5 }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t5" id="t5"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n5" id="n5"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m5" id="m5"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	
    			 </div>
    			 
    		</td>
        </tr>    
        
        <tr class="odd">
    		<td style="width:30%">
    			 Dimensione (centimetri)
    		</td>
    		<td style="width:70%"> 
    			<input maxlength="3" type="text" name="dimensione" id="dimensione" size="5" value="${esame.dimensione }"/>
    		</td>
        </tr> 
        
        <tr>
    		<td style="width:30%">
    			 Interessamento Linfonodale
    		</td>
    		<td style="width:70%">  
    			<select name="idInteressamentoLinfonodale" id="idInteressamentoLinfonodale">
    			 	<c:forEach items="${interessamentoLinfonodales }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.interessamentoLinfonodale }">selected="selected"</c:if> >${temp.description }</option>
    			 	</c:forEach>
    			 </select>
       		</td>
        </tr> 
        
        <tr>
    		<td colspan="2">    
    			<font color="red">* </font> Campi obbligatori
				<br/>
					<input type="submit" value="Salva" />
    			<!--  input
				type="button" value="Immagini"
				onclick="javascript:avviaPopup( 'vam.cc.esamiIstopatologici.GestioneImmagini.us?id=${esame.id }&cc=${cc.id}' );" /-->
    			<input type="button" value="Annulla" onclick="attendere();location.href='vam.richiesteIstopatologici.ToFindAnimaleLLPP.us'">
    		</td>
        </tr>
	</table>
</form>

<script type="text/javascript">

var padreSedeLesionePrecedente = -1;

function selezionaDivSedeLesione( idPadre )
{
	toggleDiv( "div_sedi_" + padreSedeLesionePrecedente );
	toggleDiv( "div_sedi_" + idPadre );

	padreSedeLesionePrecedente = idPadre;
}

function updateTNM( idTumPrec )
{
	var div = document.getElementById( "tnm" );

	if( idTumPrec == 2 )
	{
		div.style.display = "block";
		protect( div, false );
	}
	else
	{
		div.style.display = "none";
		protect( div, true );
	}
}

var padreWhoUmanaPrecedente = 1;

function selezionaDivWhoUmana( idPadre )
{
	toggleDiv( "div_who_umana_" + padreWhoUmanaPrecedente );
	toggleDiv( "div_who_umana_" + idPadre );

	padreWhoUmanaPrecedente = idPadre;
}


function updateIdWhoUmana()
{
	var indiceDiv = document.getElementById( 'padreWhoUmana' ).value;
	document.getElementById( 'idWhoUmana' ).value = document.getElementById( 'idWhoUmana' + indiceDiv ).value;
}

var padreTipoDiagnosiPrecedente = "tipoDiagnosi-1";

function selezionaDivTipoDiagnosi( idDiagnosi )
{
	var divx = "tipoDiagnosi-1";
	
	switch ( idDiagnosi )
	{
	case "1":
		divx = "whoUmanaDiv";
		break;
	case "2":
		divx = "whoAnimaleDiv";
		break;
	case "3":
		divx = "nonTumoraleDiv";
		break;
	}

	//document.getElementById( padreTipoDiagnosiPrecedente ).style.display = "none";
	//document.getElementById( divx ).style.display = "block";
	toggleDiv( padreTipoDiagnosiPrecedente );
	toggleDiv( divx );

	switch ( idDiagnosi )
	{
	case "1":
		updateIdWhoUmana();
		break;
	case "2":
		
		break;
	case "3":
		
		break;
	}

	padreTipoDiagnosiPrecedente = divx;
}


function aggiungiRigaTNM()
{
	if(document.getElementById('tnm1').style.display=='none')
	{
		document.getElementById('tnm1').style.display='block';
	}
	else if(document.getElementById('tnm2').style.display=='none')
	{
		document.getElementById('tnm2').style.display='block';
	}
	else if(document.getElementById('tnm3').style.display=='none')
	{
		document.getElementById('tnm3').style.display='block';
	}
	else if(document.getElementById('tnm4').style.display=='none')
	{
		document.getElementById('tnm4').style.display='block';
	}
	else if(document.getElementById('tnm5').style.display=='none')
	{
		document.getElementById('tnm5').style.display='block';
	}
}



function mutuamenteEsclusiviHabitatAlimentazioni(id)
{
	
	if(id=='oph_1')
			document.getElementById('oph_2').checked=false;
	else if(id=='oph_2')
		document.getElementById('oph_1').checked=false;
	else if(id=='oph_3')
	{
		document.getElementById('oph_4').checked=false;
		document.getElementById('oph_5').checked=false;
		document.getElementById('oph_6').checked=false;
		
	}
	else if(id=='oph_4')
	{
		document.getElementById('oph_3').checked=false;
		document.getElementById('oph_5').checked=false;
		document.getElementById('oph_6').checked=false;
		
	}
	else if(id=='oph_5')
	{
		document.getElementById('oph_4').checked=false;
		document.getElementById('oph_3').checked=false;
		document.getElementById('oph_6').checked=false;
		
	}
	else if(id=='oph_6')
	{
		document.getElementById('oph_4').checked=false;
		document.getElementById('oph_5').checked=false;
		document.getElementById('oph_3').checked=false;
		
	}
	else if(id=='opa_1')
	{
		document.getElementById('opa_2').checked=false;
		document.getElementById('opa_3').checked=false;
		
	}
	else if(id=='opa_2')
	{
		document.getElementById('opa_1').checked=false;
		document.getElementById('opa_3').checked=false;
		
	}
	else if(id=='opa_3')
	{
		document.getElementById('opa_1').checked=false;
		document.getElementById('opa_2').checked=false;
		
	}
	else if(id=='opaq_1')
	{
		document.getElementById('opaq_2').checked=false;
		document.getElementById('opaq_3').checked=false;
		
	}
	else if(id=='opaq_2')
	{
		document.getElementById('opaq_1').checked=false;
		document.getElementById('opaq_3').checked=false;
		
	}
	else if(id=='opaq_3')
	{
		document.getElementById('opaq_1').checked=false;
		document.getElementById('opaq_2').checked=false;
		
	}
}

function attivaLaboratorioPrivato(id)
{
	if(id==19)
		document.getElementById('laboratorioPrivato').style.display='block';
	else
		document.getElementById('laboratorioPrivato').style.display='none';
}


</script>
