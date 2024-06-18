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


<form action="vam.altreDiagnosi.AddLLPP.us" id="myform" name="form" method="post" class="marginezero">    

  <input type="hidden" name="idAnimale" id="idAnimale" value="${animale.id }"/>

    
	  <h4 class="titolopagina">
		Nuova Diagnosi BASE 1/2/3
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
        		Diagnosi
        	</th>
        </tr>
        
        <tr class="even">
    		<td style="text-align: left;">
    			Data <font color="red">*</font>
    		</td>
			<td style="text-align: left;">
				 <input 
    			 	type="text" 
    			 	id="dataDiagnosi" 
    			 	name="dataDiagnosi" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:246px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_1" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi",     // id of the input field
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
    			Prima diagnosi <font color="red">*</font>
    		</td>
			<td style="text-align: left;">
				 <select name="primaDiagnosi" id="primaDiagnosi" onChange="attivaDataPrimaDiagnosi(this.value);">
    			 	<option value="">&lt;---Selezionare---&gt;</option>
    			 	<option value="true">SI</option>
    			 	<option value="false">NO</option>
    			 </select>
    			 
    			 &nbsp;&nbsp;
    			 
    			 <p id="dataPrimaDiagnosiLabel" style="display:none;">Data prima diagnosi  <font  id="dataPrimaDiagnosiRed" color="red">*</font> 
				 <input 
    			 	type="text" 
    			 	id="dataPrimaDiagnosi" 
    			 	name="dataPrimaDiagnosi" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:246px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_2" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataPrimaDiagnosi",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_2",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script>
    			 </p>
    			 
    			 
    		</td>
        </tr>
        
    	<tr class="even">
    		<td style="text-align: left;">
    			Tipo <font color="red">*</font>
    		</td>
			<td style="text-align: left;">
				<input type="radio" onclick="if(this.checked){disattivaNote();document.getElementById('note3').style.display='none';document.getElementById('note4').style.display='none';document.getElementById('note5').style.display='none';document.getElementById('note6').style.display='none';document.getElementById('note1').style.display='block';document.getElementById('note2').style.display='none';document.getElementById('idDiagnosiRM').checked=false;document.getElementById('idDiagnosiTac').checked=false;document.getElementById('idDiagnosiEco').checked=false;document.getElementById('idDiagnosiRx').checked=false;} else{document.getElementById('note1').style.display='none'} disattivaNote()" name="idDiagnosi" id="idDiagnosi1" value="1"><b>BASE 1</b> Clinica/anamnestica</input><br/>
					<p style="display: none;" id="note1">Inserire diagnosi <input type="text" name="idDiagnosiNoteBase1" id="idDiagnosiNoteBase1" value=""> <font color="red" > *</font></p>
				<br/><br/>
    			<input type="radio" onclick="if(this.checked){disattivaNote();document.getElementById('note3').style.display='none';document.getElementById('note4').style.display='none';document.getElementById('note5').style.display='none';document.getElementById('note6').style.display='none';document.getElementById('note2').style.display='block';document.getElementById('note1').style.display='none';document.getElementById('idDiagnosiRM').checked=false;document.getElementById('idDiagnosiTac').checked=false;document.getElementById('idDiagnosiEco').checked=false;document.getElementById('idDiagnosiRx').checked=false;} else{document.getElementById('note2').style.display='none'} disattivaNote()" name="idDiagnosi" id="idDiagnosi2" value="2"><b>BASE 2</b> Esami ematochimici</input><br/>
					<p style="display: none;" id="note2">Specificare <input type="text" name="idDiagnosiNoteBase2" id="idDiagnosiNoteBase2" value=""> <font color="red" > *</font></p>
				<br/><br/>
	    	 	<input type="radio" name="idDiagnosi" id="idDiagnosi3" value="3" onclick="disattivaNote();if(this.checked){document.getElementById('note2').style.display='none';document.getElementById('note1').style.display='none';}"><b>BASE 3</b> </input><br/>
    			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" onclick="if(this.checked){document.getElementById('note3').style.display='block';} else{document.getElementById('note3').style.display='none'}" name="idDiagnosiRx" id="idDiagnosiRx" value="1">RX</input>
    			<p style="display: none;" id="note3">Inserire referto <input type="text" name="idDiagnosiNoteRx" id="idDiagnosiNoteRx" value=""> <font color="red" > *</font></p>
				<br/>
    			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" onclick="if(this.checked){document.getElementById('note4').style.display='block';} else{document.getElementById('note4').style.display='none'}" name="idDiagnosiEco" id="idDiagnosiEco" value="2">Eco</input>
    			<p style="display: none;" id="note4">Inserire referto <input type="text" name="idDiagnosiNoteEco" id="idDiagnosiNoteEco" value=""> <font color="red" > *</font></p>
				<br/>
    			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" onclick="if(this.checked){document.getElementById('note5').style.display='block';} else{document.getElementById('note5').style.display='none'}" name="idDiagnosiTac" id="idDiagnosiTac" value="3">Tac</input>
    			<p style="display: none;" id="note5">Inserire referto <input type="text" name="idDiagnosiNoteTac" id="idDiagnosiNoteTac" value=""> <font color="red" > *</font></p>
				<br/>
    			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" onclick="if(this.checked){document.getElementById('note6').style.display='block';} else{document.getElementById('note6').style.display='none'}" name="idDiagnosiRM" id="idDiagnosiRM" value="4">RM</input>
    			<p style="display: none;" id="note6">Inserire referto <input type="text" name="idDiagnosiNoteRM" id="idDiagnosiNoteRM" value=""> <font color="red" > *</font></p>
				<br/>
    		</td>
        </tr>
        
        
        
        <tr>
    		<td colspan="2">    
    			<font color="red">* </font> Campi obbligatori
				<br/>
					<input type="button" value="Salva" onclick="checkform(document.getElementById('myform'))"/>
    		</td>
        </tr>
	</table>
</form>

<script type="text/javascript">
function checkform(form) 
{
	
	
	if(document.getElementById("dataDiagnosi").value == '')
			{
				alert("Inserire Data Diagnosi");
				document.getElementById('dataDiagnosi').focus();
				return false;
			}
	
	
	if(document.getElementById("primaDiagnosi").value == '')
	{
		alert("Selezionare se si tratta della prima diagnosi");
		document.getElementById('primaDiagnosi').focus();
		return false;
	}
	
	if(document.getElementById("primaDiagnosi").value == 'false' && document.getElementById("dataPrimaDiagnosi").value == '')
	{
		alert("Inserire Data Prima Diagnosi");
		document.getElementById('dataPrimaDiagnosi').focus();
		return false;
	}
	
	
	
	if(document.getElementById("idDiagnosi1").checked == false && document.getElementById("idDiagnosi2").checked == false && 
			   document.getElementById("idDiagnosi3").checked == false )
			{
				alert("Inserire Diagnosi");
				document.getElementById('idDiagnosi').focus();
				return false;
			}
	
	
	
	if(document.getElementById("idDiagnosi1").checked == true && document.getElementById("idDiagnosiNoteBase1").value == '')
			{
				alert("Inserire note per BASE 1");
				document.getElementById('idDiagnosiNoteBase1').focus();
				return false;
			}
	
	if(document.getElementById("idDiagnosi2").checked == true && document.getElementById("idDiagnosiNoteBase2").value == '')
	{
		alert("Inserire note per BASE 2");
		document.getElementById('idDiagnosiNoteBase2').focus();
		return false;
	}
	
	if(document.getElementById("idDiagnosiRx").checked == true && document.getElementById("idDiagnosiNoteRx").value == '')
	{
		alert("Inserire note per BASE 3");
		document.getElementById('idDiagnosiNoteRx').focus();
		return false;
	}
	
	if(document.getElementById("idDiagnosiEco").checked == true && document.getElementById("idDiagnosiNoteEco").value == '')
	{
		alert("Inserire note per BASE 3");
		document.getElementById('idDiagnosiNoteEco').focus();
		return false;
	}
	
	if(document.getElementById("idDiagnosiTac").checked == true && document.getElementById("idDiagnosiNoteTac").value == '')
	{
		alert("Inserire note per BASE 3");
		document.getElementById('idDiagnosiNoteTac').focus();
		return false;
	}
	
	if(document.getElementById("idDiagnosiRM").checked == true && document.getElementById("idDiagnosiNoteRM").value == '')
	{
		alert("Inserire note per BASE 3");
		document.getElementById('idDiagnosiNoteRM').focus();
		return false;
	}
			
	
	form.submit();
	
	return true;

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

function attivaDataPrimaDiagnosi(primaDiagnosi)
{
	if(primaDiagnosi=='false')
	{
		document.getElementById('dataPrimaDiagnosiLabel').style.display='block';
		//document.getElementById('dataPrimaDiagnosiRed').style.display='block';
		//document.getElementById('dataPrimaDiagnosi').style.display='block';
		//document.getElementById('id_img_2').style.display='block';
	}
	else
	{
		document.getElementById('dataPrimaDiagnosiLabel').style.display='none';
		//document.getElementById('dataPrimaDiagnosiRed').style.display='none';
		//document.getElementById('dataPrimaDiagnosi').style.display='none';
		//document.getElementById('id_img_2').style.display='none';
	}
	document.getElementById('dataPrimaDiagnosi').value='';
}

function disattivaNote()
{
	document.getElementById('idDiagnosiNoteTac').value="";
	document.getElementById('idDiagnosiNoteRM').value="";
	document.getElementById('idDiagnosiNoteRx').value="";
	document.getElementById('idDiagnosiNoteEco').value="";
	document.getElementById('idDiagnosiNoteBase1').value="";
	document.getElementById('idDiagnosiNoteBase2').value="";
}

</script>
