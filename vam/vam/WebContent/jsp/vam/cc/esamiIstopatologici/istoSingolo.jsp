<link rel="stylesheet" documentale_url="" href="jsp/vam/cc/print.css" type="text/css" media="print" />

<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fn.tld" prefix="fn" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<%@page import="it.us.web.bean.vam.TerapiaDegenza"%>
<%@page import="it.us.web.bean.vam.CartellaClinica"%>
<%@page import="it.us.web.bean.vam.Diagnosi"%>
<%@page import="it.us.web.bean.vam.Trasferimento"%>
<%@page import="it.us.web.bean.vam.TipoIntervento"%>
<%@page import="it.us.web.bean.vam.Accettazione"%>
<%@page import="it.us.web.bean.vam.EsameIstopatologico"%>
<%@page import="it.us.web.bean.vam.lookup.LookupOperazioniAccettazione"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page
	import="java.util.Date"%>


<%@page import="it.us.web.constants.IdOperazioniBdr"%>
<%@page import="it.us.web.constants.IdRichiesteVarie"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.net.InetAddress"%>
<%@page import="it.us.web.util.properties.Application"%>

<script language="JavaScript" type="text/javascript" src="js/vam/cc/stampaCC/popupDetails.js"></script>

<style>

@media all {
	table.fondo {
position: absolute;
	font-size: 12px;
	margin-top: 650px;
	width:100%;
}
div.header {
	display:none;
}
.stampaSezione {
display:none;
}
.coloreIdentificativo {
	color:#000000;
}
.boxIdDocumento {  
       border: 1px solid black;
       width: 60px;
       height: 20px;
       margin-top: 30px;
       text-align: center;
       padding-top: 5px;
       font-size: 8px; 
}
.boxOrigineDocumento {
	position: absolute;
	width: 160px;
	height: 20px;
	top: 15px;
	left: 70px;
	text-align: left;
	padding-top: 10px;
	font-size: 8px;
}
table.tabella
{
	-webkit-print-color-adjust:exact;
	background-color:#E5EAE7;
	font-size:16px;
	margin:0.5%;
	width:94%;	
	border-collapse: collapse;
	
}

th
{
	background:#A8C4DC;
	color:#000044;
	font-weight:bold;
	text-align:center;
	padding: 0px;
	border: none;	
}

th.sub
{
	background:#CCCCCC;
	color:#000044;
	font-weight:bold;
	text-align:center;
	padding: 0px;
	border: none;	
}
#divTerap, #divChir {
page-break-before: always;
}


tr.odd {background-color: #FFFFFF}
tr.even {background-color: #E5EAE7;}

table.griglia  {
width:100%;
background-color:#000;
}
table.griglia td {
background-color:#FFF;

}

table.grigliaEsami  {
background-color:#000;
}
table.grigliaEsami td {
background-color:#FFF;

}

table {
line-height:1.8em;
}

.underline {
border-bottom:1px solid;
}
.esamiSangue tr td{
	font-size: 0.8em;
}
}

body{
	-webkit-print-color-adjust:exact;
    font-family: Trebuchet MS,Verdana,Helvetica,Arial,san-serif;	
}

p.intestazione{
	background: none repeat scroll 0 0 #A8C4DC;
    border: medium none;
    color: #000044;
    font-weight: bold;
    padding: 0;
    text-align: center;
    width: 50%;
    text-align:left;
    
}
.pagebreak, #divChir {
page-break-after:always;

}

#intestazione table td img {
	heigth:100px;
}
h2 {
	border:none !important;
	text-decoration: underline;
	display:inline;
}
table td h3 {
	display:inline
	}
table.griglia  {
width:100%;
background-color:#000;
}
table.griglia td {
background-color:#FFF;
text-align:center;
}

table.grigliaEsami  {
background-color:#000;
}
table.grigliaEsami td {
background-color:#FFF;
text-align:center;
}

table.bordo {
border:1px solid;
width:100%;
}
.esamiSangue {
	font-size: 10px;
	}
	table.fondo {

position: absolute;
	font-size: 12px;
	width:98%;
}

	
</style>
<%@ include file="barcode.jsp"%>
<%

EsameIstopatologico esame = (EsameIstopatologico)request.getAttribute("esame");
%>

<div class="boxIdDocumento"></div>
<div class="boxOrigineDocumento"><%@ include file="../../../../hostName.jsp" %></div>
<!-- <h4 class="titolopagina">
     Cartella Clinica
</h4>  -->
<br/>
<c:set var="tipo" scope="request" value="stampaAcc" />
<c:import url="../../jsp/documentale/home.jsp"/>
      
<div id="print_div" >

	<div id="intestazioneCC" style="display: block;" >
	<table class="griglia" style="margin:0 auto;" >
		<tr>
			
		<td>
			<c:choose>
				<c:when test="${esame.tipoAccettazione=='Criuv'}">
					<img documentale_url="" src="images/criuv.jpg" style="height:100px"/>
				</c:when>
				<c:otherwise>
					<img documentale_url="" src="images/asl/${utente.clinica.lookupAsl}.jpg" style="height:100px"/>
				</c:otherwise>
			</c:choose>
		</td>
		
		<td>
			<c:choose>
				<c:when test="${esame.tipoAccettazione=='Criuv'}">
					<h3>CRIUV</h3><br/>
					Via M.R. di Torrepadula - P.O. Frullone - Plesso Ulisse<br/>
					80143 Napoli<br/>
					Tel.  0812549555/52/56/58 - Fax 0812548740<br/>
					email: criuv@regione.campania.it
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${utente.clinica.lookupAsl.id==204}">
							<h3>ASL NAPOLI 1 CENTRO - SSD EPIDEMIOLOGIA VETERINARIA</h3><br/>
							Via M.R. di Torrepadula - P.O. Frullone - Plesso Ulisse<br/>
							80143 Napoli<br/>
							Tel.  081-2549555 - Fax 081- 2548740<br/>
							email: epidevet@aslnapoli1centro.it                       
						</c:when>
						<c:otherwise>
							<h3>${utente.clinica.nome }</h3><br/>
							${utente.clinica.indirizzo }<br/>
							${utente.clinica.lookupComuni.description }
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</td>
		<td>
			<c:choose>
				<c:when test="${esame.tipoAccettazione=='Criuv'}">
					<b><i>Cod. SIGLA 282961</i></b>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${utente.clinica.lookupAsl.id==204}">
							<b><i>Cod. SIGLA 283779</i></b>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</td>			
		</tr>
	
	</table></div>
	
			<table width="100%" style="border-collapse: collapse">
		  <col width="40%">  <col width="30%"> <col width="30%">
		  
		  
		  
		  
		  <tr>
<td><i></td>
</tr>
<tr>
	<td style="padding:10px" align="right">
		<i>Numero rif. mittente Asl:  </i> ${esame.numeroAccettazioneSigla}
	</td>
	<td style="padding:10px" align="right">
		<img src="<%=createBarcodeImage(esame.getAnimale().getIdentificativo())%>" />
	</td>
	<td style="padding:10px" align="center">
		<img src="<%=createBarcodeImage(esame.getNumero())%>" />
	</td>  
</tr>
</table>
	
	
	
	
	
    			<fmt:setLocale value="en_US" /> <!-- ALTRIMENTI LA STAMPA NON FUNZIONA -->
    			<fmt:formatDate type="date" value="${esame.getCartellaClinica().getAccettazione().data}" pattern="dd/MM/yyyy" var="dataApertura"/>
	<center><h2>Richiesta Esame Istopatologico</h2></center>
	
		<br/>
		
		<center><h2>Dati del ${esame.animale.lookupSpecie.description}</h2></center>
	<table class="bordo"> <col width="25%"><col width="25%"><col width="25%"><col width="25%">
<tr>
<td><i>Identificativo</i></td>
<td>${esame.animale.identificativo}</td>

<td><i>
    		<c:if test="${esame.animale.lookupSpecie.id!=3}">
    			Razza
    			</c:if>
    		<c:if test="${esame.animale.lookupSpecie.id==3}">
    			Famiglia/Genere
    			</c:if>
    			
    			</i></td><td><c:if test="${(esame.animale.lookupSpecie.id == specie.cane or esame.animale.lookupSpecie.id == specie.gatto) && esame.animale.decedutoNonAnagrafe==false}">${anagraficaAnimale.razza}</c:if>
				<c:if test="${esame.animale.decedutoNonAnagrafe==true}">${anagraficaAnimale.razza}</c:if>
				<c:if test="${esame.animale.lookupSpecie.id == specie.sinantropo && esame.animale.decedutoNonAnagrafe==false}">${esame.animale.specieSinantropoString} - ${esame.animale.razzaSinantropo}</c:if>
    		   </td>  		
</tr>
<c:if test="${esame.animale.lookupSpecie.id!=3}">
	<tr>
		<td>
			Mantello
		</td>
		<td colspan="3">
			${anagraficaAnimale.mantello}
		</td>
	</tr>
</c:if>
<tr>
<td><i>Sesso</i></td>
<td>${esame.animale.sesso}</td>

<c:choose>
<c:when test="${esame.animale.lookupSpecie.id==3}">
<td><i>Età</i></td>
<td><fmt:formatDate type="date" value="${esame.animale.dataNascita }" pattern="dd/MM/yyyy" var="dataNascita"/>
${esame.animale.eta} <c:if test="${dataNascita}">(${dataNascita})</c:if>
</td>
</c:when>
<c:otherwise>
<td><i>Data nascita</i></td>
<td><fmt:formatDate type="date" value="${esame.animale.dataNascita }" pattern="dd/MM/yyyy" var="dataNascita"/>
${dataNascita}</td>
</c:otherwise></c:choose> 

</tr>
<tr>
<td><i>Peso (in Kg)</i></td>
<td> ${esame.cartellaClinica.peso} </td>
<td><i> Habitat </i></td>
<td>
<c:choose>
	<c:when test="${esame.cartellaClinica!=null}">
		${esame.cartellaClinica.lookupHabitats}
	</c:when>
	<c:otherwise>
		${esame.lookupHabitats}
	</c:otherwise>
</c:choose>
</td>
</tr>
<tr>
<td><i>Alimentazione</i></td>
<td>${esame.cartellaClinica.lookupAlimentazionis} - ${esame.cartellaClinica.lookupAlimentazioniQualitas}</td>
</tr>

</table>	
	
</br></br>

<c:if test="${esame.cartellaClinica.accettazione.animale.decedutoNonAnagrafe==true && esame.cartellaClinica.accettazione.randagio==true}">	
	<center><h2>Ritrovamento carcassa</h2></center>
	<table width="100%" class="bordo">
		<col width="25%"><col width="25%">
	<tr>
	<td><i>Comune</i></td>
	<td>${esame.cartellaClinica.accettazione.animale.comuneRitrovamento.description}</td>
	<td><i>Provincia</i></td>
	<td>${esame.cartellaClinica.accettazione.animale.provinciaRitrovamento}</td>
	</tr>
	<tr>
	<td><i>Indirizzo</i></td>
	<td>${esame.cartellaClinica.accettazione.animale.indirizzoRitrovamento}</td>
	<td><i>Note</i></td>
	<td>${esame.cartellaClinica.accettazione.animale.noteRitrovamento}</td>
	</tr>
</table>
<br/><br/>
</c:if>
<c:choose>
	<c:when test="${esame.cartellaClinica!=null}">
	
	
<center><h2>Dati del proprietario</h2></center>
<table class="bordo"> <col width="25%"><col width="25%"><col width="25%"><col width="25%">
	<c:if test="${esame.cartellaClinica.accettazione.proprietarioTipo=='Privato' || esame.cartellaClinica.accettazione.proprietarioTipo=='Sindaco'}">
	<tr>
<td><i>Cognome</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioCognome}</td>
<td><i>Nome</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioNome}</td>
</tr>
<tr>
<td><i>Codice fiscale</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioCodiceFiscale}</td>
<td><i>Documento</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioDocumento}</td>
</tr>
<tr>
<td><i>Indirizzo</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioIndirizzo}</td>
<td><i>CAP</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioCap}</td>
</tr>
<tr>
<td><i>Comune</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioComune}</td>
<td><i>Provincia</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioProvincia}</td>
</tr>
</c:if>
	<c:if test="${esame.cartellaClinica.accettazione.proprietarioTipo=='Canile'}">
<tr>
<td><i>Ragione sociale</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioNome}</td>
<td></td>
<td></td>
</tr>
<tr>
<td><i>Partita IVA</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioCognome}</td>
<td><i>Rappr. Legale</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioCodiceFiscale}</td>
</tr>
<tr>
<td><i>Indirizzo</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioIndirizzo}</td>
<td><i>CAP</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioCap}</td>
</tr>
<tr>
<td><i>Comune</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioComune}</td>
<td><i>Provincia</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioProvincia}</td>
</tr>
</c:if>

<c:if test="${esame.cartellaClinica.accettazione.proprietarioTipo=='Colonia'}">
<tr>
<td><i>Nome colonia</i></td>
<td>${esame.cartellaClinica.accettazione.nomeColonia}</td>
<td></td>
<td></td>
</tr>
<tr>
<td><i>Nominativo referente</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioNome}</td>
<td><i>Codice fiscale referente</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioCodiceFiscale}</td>
</tr>
<tr>
<td><i>Indirizzo</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioIndirizzo}</td>
<td><i>CAP</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioCap}</td>
</tr>
<tr>
<td><i>Comune</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioComune}</td>
<td><i>Provincia</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioProvincia}</td>
</tr>
</c:if>


<c:if test="${esame.cartellaClinica.accettazione.proprietarioTipo=='Importatore' || esame.cartellaClinica.accettazione.proprietarioTipo=='Operatore Commerciale'}">
<tr>
<td><i>Ragione sociale</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioNome}</td>
<td><i>Partita IVA</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioCognome}</td>
</tr>
<tr>
<td><i>Indirizzo sede operativa</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioIndirizzo}</td>
<td><i>CAP sede operativa</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioCap}</td>
</tr>
<tr>
<td><i>Comune sede operativa</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioComune}</td>
<td><i>Provincia sede operativa</i></td>
<td>${esame.cartellaClinica.accettazione.proprietarioProvincia}</td>
</tr>
</c:if>

</table>	
		</br></br>
</c:when>

</c:choose>	
		
	<center><h2>Dati dell'esame</h2></center>
	<table class="bordo"> <col width="25%">
<tr>
<td><i>Data della richiesta</i></td>
<td><fmt:formatDate type="date" value="${esame.dataRichiesta }" pattern="dd/MM/yyyy" var="dataRichiesta"/>
${dataRichiesta}</td>
</tr>
<tr>
<td><i>Laboratorio destinazione</i></td>
<td>${esame.lass.description}</td>
</tr>
<tr>
<td><i>Tipo prelievo</i></td>
<td>${esame.tipoPrelievo.description }</td>
</tr>

<%
        //Abilitazione 287
		if(Application.get("flusso_287").equals("true"))
		{
		%>


<tr>
<td><i>Tumore</i></td>
<td>${esame.tumore.description }</td>
</tr>
<tr>



<td><i>Trattamenti ormonali</i></td>
<td>${esame.trattOrm}</td>
</tr>
<tr>
<td><i>Stato generale</i></td>
<td>${esame.statoGenerale} ${esame.statoGeneraleLookup}</td>
</tr>
<tr>
<%
}
%>
<td><i>Tumori precedenti</i></td>
<td>	${esame.tumoriPrecedenti.description }  </td>
</tr>

 <c:if test="<%=esame.getTumoriPrecedenti()!=null && esame.getTumoriPrecedenti().getId()==2 && (esame.getT()!=null || esame.getN()!=null || esame.getM()!=null || esame.getDiagnosiPrecedente()!=null || esame.getDataDiagnosi()!=null)%>">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="<%=esame.getDataDiagnosi()%>" pattern="dd/MM/yyyy" var="dataDiagnosi"/>
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getDiagnosiPrecedente()%>
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getT()%>
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getN()%> 
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			<%=esame.getM()%>
    		</td>
        </tr> 
    </c:if>
    
    <c:if test="<%=esame.getTumoriPrecedenti()!=null && esame.getTumoriPrecedenti().getId()==2 && (esame.getT1()!=null || esame.getN1()!=null || esame.getM1()!=null || esame.getDiagnosiPrecedente1()!=null || esame.getDataDiagnosi1()!=null)%>">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="<%=esame.getDataDiagnosi1()%>" pattern="dd/MM/yyyy" var="dataDiagnosi1"/>
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getDiagnosiPrecedente1()%>
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getT1()%>
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getN1()%> 
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			<%=esame.getM1()%>
    		</td>
        </tr> 
    </c:if>
    
    <c:if test="<%=esame.getTumoriPrecedenti()!=null && esame.getTumoriPrecedenti().getId()==2 && (esame.getT2()!=null || esame.getN2()!=null || esame.getM2()!=null || esame.getDiagnosiPrecedente2()!=null || esame.getDataDiagnosi2()!=null)%>">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="<%=esame.getDataDiagnosi2()%>" pattern="dd/MM/yyyy" var="dataDiagnosi2"/>
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getDiagnosiPrecedente2()%>
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getT2()%>
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getN2()%> 
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			<%=esame.getM2()%>
    		</td>
        </tr> 
    </c:if>
    
    <c:if test="<%=esame.getTumoriPrecedenti()!=null && esame.getTumoriPrecedenti().getId()==2 && (esame.getT3()!=null || esame.getN3()!=null || esame.getM3()!=null ||  esame.getDiagnosiPrecedente3()!=null || esame.getDataDiagnosi3()!=null)%>">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="<%=esame.getDataDiagnosi3()%>" pattern="dd/MM/yyyy" var="dataDiagnosi3"/>
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getDiagnosiPrecedente3()%>
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getT3()%>
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getN3()%> 
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			<%=esame.getM3()%>
    		</td>
        </tr> 
    </c:if>
    
    <c:if test="<%=esame.getTumoriPrecedenti()!=null && esame.getTumoriPrecedenti().getId()==2 && (esame.getT4()!=null || esame.getN4()!=null || esame.getM4()!=null ||   esame.getDiagnosiPrecedente4()!=null || esame.getDataDiagnosi4()!=null)%>">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="<%=esame.getDataDiagnosi4()%>" pattern="dd/MM/yyyy" var="dataDiagnosi4"/>
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getDiagnosiPrecedente4()%>
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getT4()%>
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getN4()%> 
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			<%=esame.getM4()%>
    		</td>
        </tr> 
    </c:if>
    
    <c:if test="<%=esame.getTumoriPrecedenti()!=null && esame.getTumoriPrecedenti().getId()==2 && (esame.getT5()!=null || esame.getN5()!=null || esame.getM5()!=null ||  esame.getDiagnosiPrecedente5()!=null || esame.getDataDiagnosi5()!=null)%>">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="<%=esame.getDataDiagnosi5()%>" pattern="dd/MM/yyyy" var="dataDiagnosi5"/>
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getDiagnosiPrecedente5()%>
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getT5()%>
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			<%=esame.getN5()%> 
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			<%=esame.getM5()%>
    		</td>
        </tr> 
    </c:if>
    
<tr>
<td><i>Dimensione (in cm)</i></td>
<td>${esame.dimensione }</td>
</tr>
<tr>
<td><i>Interessamento linfondale</i></td>
<td>${esame.interessamentoLinfonodale.description }  </td>
</tr>
<tr>
<td><i>Sede lesione e sottospecifica</i></td>
<td>${esame.sedeLesione }  </td>
</tr>
<tr>
<td><i>Numero riferimento mittente</i></td>
<td>${esame.enteredBy.superutente.siglaProvincia } ${esame.enteredBy.superutente.numIscrizioneAlbo }  </td>
</tr>
<tr>
<td colspan="2"><b>Risultato</b></td>
</tr>
<tr>
<tr>
<td><i>Descrizione Morfologica</i></td>
<td>${esame.descrizioneMorfologica }    </td>
</tr>
<tr>
<td><i>Diagnosi</i></td>
<td colspan="3">${esame.tipoDiagnosi.description }: ${esame.whoUmana } ${esame.diagnosiNonTumorale }  </td>
</tr>

</table>	
	
</br></br>

<P style="line-height:30px; text-align: left;">
Ai sensi del GDPR UE 2016/679 si da' il consenso al trattamento dei dati contenuti nel presente documento.
<br>
<fmt:formatDate type="date" value="<%=new Date() %>" pattern="dd/MM/yyyy" var="dataEntered"/>
&nbsp;&nbsp;&nbsp;&nbsp;${esame.enteredBy.cognome } ${esame.enteredBy.nome },  ${dataEntered}<br>
_____________________
</P>
	
		
	</div>
<br/>
	
  	