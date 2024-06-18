<%@page import="it.us.web.constants.SpecieAnimali"%>
<%@page import="it.us.web.bean.vam.Animale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@page import="java.util.Date"%>

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



<script language="JavaScript" type="text/javascript" src="js/vam/cc/esamiCitologici/addEdit.js?v=3"></script>

<form action="vam.diagnosiCitologica.AddLLPP.us" name="form" method="post" class="marginezero" onsubmit="javascript:return checkform(this);">    

  <input type="hidden" name="idAnimale" id="idAnimale" value="${animale.id }"/>

    
	  <h4 class="titolopagina">
		<c:if test="${!modify }" >     
			Nuovo Esame Citologico
		</c:if>
		<c:if test="${modify }" >
			Modifica Esame Citologico 
    			
    			<input type="hidden" name="modify" value="on" />
    			<input type="hidden" name="id" value="${esame.id }" />
		</c:if>
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
    		<td >
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
        		Dati dell'esame
        	</th>
        </tr>
    	<tr class="odd">
    		<td style="text-align: left;">
    			 Data Richiesta<font color="red"> *</font>
    		</td>
    		<td style="text-align: left;">
    			 <input 
    			 	type="text" 
    			 	id="dataRichiesta" 
    			 	name="dataRichiesta" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:246px;" 
					<c:if test="${modify }"> value="<fmt:formatDate type="date" value="${esame.dataRichiesta}" pattern="dd/MM/yyyy" />" </c:if>
					<c:if test="${!modify }"> value="<fmt:formatDate type="date" value="<%=new Date() %>" pattern="dd/MM/yyyy" />" </c:if> />
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
    	<tr class="even">
    		<td style="text-align: left;">
    			 Data Esito<font color="red"> *</font>
    		</td>
			<td style="text-align: left;">
    			 <input 
    			 	type="text" 
    			 	id="dataEsito" 
    			 	name="dataEsito" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:246px;" 
					value="<fmt:formatDate type="date" value="${esame.dataEsito }" pattern="dd/MM/yyyy" />" />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_2" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataEsito",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_2",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script>   
    		</td>
        </tr>
		
		<tr class="odd">
			<td style="text-align: left;">
				Tipo Prelievo<font color="red"> *</font>
			</td>
			<td style="text-align: left;">
    			<select name="idTipoPrelievo" id="idTipoPrelievo" onchange="javascript:mostraAltro()" style="width:250px;">
    				<option value="">&lt;-- Selezionare Tipo Prelievo --&gt;</option>
					<c:forEach items="${tipiPrelievo}" var="temp" >
						<option value="${temp.id}"
							<c:if test="${esame.tipoPrelievo.id == temp.id}">selected="selected"</c:if>
						>${temp.descrizione}</option>
					</c:forEach> 
				</select>
			</td>
        </tr>
        
        <tr class="odd">
			<td style="text-align: left;" id="tipoPrelievoAltroTd1">
				<c:if test="${esame.tipoPrelievo.id==4}">
					Specificare altro<font color="red"> *</font>
				</c:if>
			</td>
			<td style="text-align: left;">
    			<input type="text" name="tipoPrelievoAltro" id="tipoPrelievoAltro" value="${esame.tipoPrelievoAltro}"
    				<c:choose>
    					<c:when test="${esame.tipoPrelievo.id!=4 || esame==null}">
    						style="width:246px;display:none";
    					</c:when>
    					<c:otherwise>
							style="width:246px;";
						</c:otherwise>
					</c:choose>
    			>
			</td>
        </tr>
        
        <tr class="odd">
			<td style="text-align: left;">
				Matrice<font color="red"> *</font>
			</td>
			<td style="text-align: left;">
    			<select  name="padreDiagnosi" id="padreDiagnosi" onchange="selezionaDivDiagnosi(document.getElementById('padreDiagnosi').value);" >
    			 	 	<option value="-1">&lt;-- Selezionare voce --&gt;</option>
	    			 	<c:forEach items="${diagnosiPadre }" var="temp">
	    			 		<option value="${temp.id }" <c:if test="${temp == esame.diagnosi.padre || temp == esame.diagnosi }">selected="selected"</c:if> >${temp.description }</option>
	    			 	</c:forEach>
	    			 </select>
			</td>
        </tr>
        
        <tr class="even">
			<td style="text-align: left;">
				Aspetto della lesione
			</td>
			<td style="text-align: left;">
    			<input type="text" name="aspettoLesione" value="${esame.aspettoLesione}" style="width:246px;">
	    	</td>
        </tr>
          
        <tr class="odd">
    		<td style="width:30%">
    			 Diagnosi <font color="red">*</font>
    		</td>
    		<td style="width:70%">  
    		
    		<select id="idDiagnosiPadre" name="idDiagnosiPadre" onchange="selezionaDivDiagnosi(document.getElementById('padreDiagnosi').value);" >
				<option value="-1"> &lt;-- Selezionare una voce --&gt;</option>
				<option value="1">Sospetto benigno</option>
				<option value="2">Sospetto maligno</option>
				<option value="3">Non diagnostico</option>
			</select>
		
    			 </td>
        </tr>
          
        <tr class="odd">
    		<td style="width:30%">
    			 Diagnosi del tumore<font color="red">*</font>
    		</td>
    		<td style="width:70%">  
    			 	<input type="hidden" name="idDiagnosi" id="idDiagnosi" value="${esame.diagnosi.id }"/>
    			 	
    			 	 <select style="display:none;" name="padreDiagnosi" id="padreDiagnosi" onchange="selezionaDivDiagnosi(this.value);updateIdDiagnosi();">
    			 	 	<option value="-1">&lt;-- Selezionare voce --&gt;</option>
	    			 	<c:forEach items="${diagnosiPadre }" var="temp">
	    			 		<option value="${temp.id }" <c:if test="${temp == esame.diagnosi.padre || temp == esame.diagnosi }">selected="selected"</c:if> >${temp.description }</option>
	    			 	</c:forEach>
	    			 </select>
	    			 <c:forEach items="${diagnosiPadre }" var="temp">
    			 	 <div <c:if test="${temp.id > 1 }"> style="display: none;" </c:if> id="div_diagnosi_${temp.id }" name="div_diagnosi_${temp.id }">
    			 		<c:if test="${empty temp.figli }">
    			 			<input type="hidden" name="idDiagnosi" id="idDiagnosi" value="${temp.id }" <c:if test="${temp.id > 0 }">disabled="disabled"</c:if> />
    			 		</c:if>
    			 		<c:if test="${not empty temp.figli }">
    			 			 <select name="idDiagnosi${temp.id }" id="idDiagnosi${temp.id }" disabled="disabled" onchange="updateIdDiagnosi();">
    			 			 <option value="-1" >&lt; Selezionare voce --&gt;</option>
			    			 		
			    			 	<c:forEach items="${temp.figli }" var="figlio">
			    			 		<c:if test="${empty figlio.figli }">
			    			 			<option value="${figlio.id }" <c:if test="${figlio == esame.diagnosi }">selected="selected"</c:if> >${figlio.description }</option>
			    			 		</c:if>
			    			 		<c:if test="${not empty figlio.figli}">
			    			 			<optgroup label="${figlio.description }">
			    			 				<c:forEach items="${figlio.figli }" var="nipote" >
			    			 					<option value="${nipote.id }" <c:if test="${nipote == esame.diagnosi }">selected="selected"</c:if> >${nipote.description }</option>
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
          
        <tr>
    		<td colspan="2">    
    			<font color="red">* </font> Campi obbligatori
				<br/>
				<c:if test="${!modify }" >
					<input type="submit" value="Salva" />
				</c:if>
				<c:if test="${modify }" >
					<input type="submit" value="Modifica" />
				</c:if>
    		</td>
        </tr>
	</table>
</form>

<script type="text/javascript">
var padreDiagnosiPrecedente = 1;

function selezionaDivDiagnosi( idPadreSelezionato )
{
	//Variabili
	//idPadreSelezionato 
	var sospettoMaligno = document.getElementById('idDiagnosiPadre').value == 2; //sospetto maligno = 2
	//padreDiagnosiPrecedente diagnosi precedente selezionata
	
	//Cose da fare
	//nascondere vecchio div aperto
	if(padreDiagnosiPrecedente>1)
	{
		document.getElementById("div_diagnosi_" + padreDiagnosiPrecedente).style.display="none";
		protect( document.getElementById("div_diagnosi_" + padreDiagnosiPrecedente), true );
		document.getElementById('idDiagnosi').value="";
	}
	//nascondere nuovo div aperto
	if(!sospettoMaligno || idPadreSelezionato <=1)
	{
		document.getElementById("div_diagnosi_" + idPadreSelezionato).style.display="none";
		protect( document.getElementById("div_diagnosi_" + idPadreSelezionato), true );
		document.getElementById('idDiagnosi').value="";
	}
	//attivare nuovo div
	if(sospettoMaligno && idPadreSelezionato >1)
	{
		document.getElementById("div_diagnosi_" + idPadreSelezionato).style.display="block";
		protect( document.getElementById("div_diagnosi_" + idPadreSelezionato), false );
	}
	padreDiagnosiPrecedente = idPadreSelezionato;
	
	//toggleDiv( "div_diagnosi_" + padreDiagnosiPrecedente );
	//toggleDiv( "div_diagnosi_" + idPadreSelezionato );

	
}


	toggleDiv( "diagnosiDiv" );

	function updateIdDiagnosi()
	{
		var indiceDiv = document.getElementById( 'padreDiagnosi' ).value;
		document.getElementById( 'idDiagnosi' ).value = document.getElementById( 'idDiagnosi' + indiceDiv ).value;
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
	
	
	
</script>
