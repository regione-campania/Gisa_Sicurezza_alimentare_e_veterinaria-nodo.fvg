<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.us.web.constants.SpecieAnimali"%>
<%@page import="it.us.web.bean.vam.Animale"%>
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
<%@ include file="../../../js/barcode.jsp"%>

<div class="boxIdDocumento"></div>
<div class="boxOrigineDocumento"><%@ include file="../../../../hostName.jsp" %></div>
<!-- <h4 class="titolopagina">
     Cartella Clinica
</h4>  -->
<br/>

<%

EsameIstopatologico esame = (EsameIstopatologico)request.getAttribute("esame");
%>

<%
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
	
	
	
	Animale animale = (Animale)request.getAttribute("animale");
	SpecieAnimali specie				= (SpecieAnimali)request.getAttribute("specie");

	 %>






<table class="bordo"> <col width="25%">
<col width="33%"><col width="33%"><col width="33%">
<tr>
<td>
	<p style="align: center">
		<b>REGIONE CAMPANIA <br/>C.R.I.U.V. <br/>Centro di Riferimento Regionale per <br/>l'Igiene Urbana Veterinaria<b/>
	</p>
</td>
<td>
	<p style="align: center">
		<b>Richiesta Esame Istologico<br/> effettuata da Medici Veterinari Liberi <br/>Professionisti<b/>
	</p>
</td>

<td>
<p style="align: right">
	<b>MOD 3 POS 06<br/> 
	CRIUV<br/><br/>  
	Ed.1 Rev.0<b/>
</p>
</td>  		
</tr>

</table>

<br/>
Veterinario referente Dr. .......<br/><br/>

Data Prelievo  ............................. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N° Accettazione .............................<br/><br/>

Numero riferimento mittente:  ${esame.numeroAccettazioneSigla} <br/><br/><br/>

<c:if test="<%=animale.getLookupSpecie().getId()==specie.getSinantropo()%>">
		Dati relativi al detentore dell'animale:<br/> 
</c:if>
<c:if test="<%=animale.getLookupSpecie().getId()==specie.getCane() || animale.getLookupSpecie().getId()==specie.getGatto()%>">
		<c:set var="proprietarioCognome" value="<%=proprietarioCognome%>"/>
				<c:choose>
					<c:when test="<%=proprietarioCognome!=null && proprietarioCognome.startsWith(\"<b>\")%>">
						Dati relativi alla colonia dell'animale:<br/>
					</c:when>
					<c:otherwise>
						Dati relativi al proprietario <%=(proprietarioTipo==null || proprietarioTipo.equals("null"))?(""):(proprietarioTipo)%> dell'animale:<br/>
					</c:otherwise>
				</c:choose>
</c:if>
		
		
	




	
	
	
	
	
	
	<!-- Colonia -->
	<c:choose>
	
			<c:when test="<%=proprietarioCognome!=null && proprietarioCognome.startsWith(\"<b>\")%>">
				<table class="bordo"> <col width="25%">
<col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%">
<tr>
<td colspan="5">
Colonia:<br/>
<%=nomeColonia%>
</td>

<td colspan="2">
Indirizzo:<br/>
<%=proprietarioIndirizzo%>
</td>
 <td>
Tel.:<br/>
<%=proprietarioTelefono%>
</td>		
</tr>
<tr>
<td colspan="2">
Mail:<br/>

</td>
<td colspan="2">
Localita':<br/>

</td>
<td colspan="2">
Comune:<br/>
<%=proprietarioComune%>
</td>
 <td>
CAP:<br/>
 <%=proprietarioCap%>
</td>	
 <td>
Provincia:<br/>
<%=proprietarioProvincia%>
</td>	
</tr>
</table>




			</c:when>
			<c:when test="${proprietarioTipo=='Importatore' || proprietarioTipo=='Operatore Commerciale'}">
				<table class="bordo"> <col width="25%">
<col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%">
<tr>
<td colspan="5">
Ragione Sociale:<br/>
<%=proprietarioNome%>
</td>

<td colspan="2">
Indirizzo:<br/>
<%=proprietarioIndirizzo%>
</td>
 <td>
Tel.:<br/>
<%=proprietarioTelefono%>
</td>		
</tr>
<tr>
<td colspan="2">
Mail:<br/>

</td>
<td colspan="2">
Localita':<br/>

</td>
<td colspan="2">
Comune:<br/>
<%=proprietarioComune%>
</td>
 <td>
CAP:<br/>
<%=proprietarioCap%>
</td>	
 <td>
Provincia:<br/>
<%=proprietarioProvincia%>
</td>	
</tr>
</table>
				
				
				
				
				
				
			</c:when>
			<c:otherwise>
				<c:if test="<%=proprietarioTipo!=null && proprietarioTipo.equals(\"Canile\") %>">
					<table class="bordo"> <col width="25%">
<col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%">
<tr>
<td colspan="5">
Ragione sociale:<br/>
<%=proprietarioNome%>
</td>

<td colspan="2">
Indirizzo:<br/>
<%=proprietarioIndirizzo %>
</td>
 <td>
Tel.:<br/>
<%=proprietarioTelefono %>
</td>		
</tr>
<tr>
<td colspan="2">
Rappr. Legale:<br/>
<%=proprietarioCodiceFiscale%>
</td>
<td colspan="2">
Partita Iva:<br/>
<%=proprietarioCognome%>
</td>
<td colspan="2">
Comune:<br/>
<%=proprietarioComune %>
</td>
 <td>
CAP:<br/>
<%=proprietarioCap %>
</td>	
 <td>
Provincia:<br/>
<%=proprietarioProvincia %>
</td>	
</tr>
</table>



				</c:if>
				
				<c:if test="<%=!randagio%>">
			<table class="bordo"> <col width="25%">
<col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%">
<tr>
<td colspan="2">
Cognome:<br/>
<%=proprietarioCognome%>
</td>
<td colspan="2">
Nome:<br/>
<%=proprietarioNome%>
</td>
<td colspan="3">
Indirizzo:<br/>
<%=proprietarioIndirizzo%>
</td>
 <td>
Tel.:<br/>
<%=proprietarioTelefono%>
</td>		
</tr>
<tr>
<td colspan="2">
Mail:<br/>

</td>
<td colspan="2">
Localita':<br/>

</td>
<td colspan="2">
Comune:<br/>
<%=proprietarioComune%>
</td>
 <td>
CAP:<br/>
<%=proprietarioCap%>
</td>	
 <td>
Provincia:<br/>
<%=proprietarioProvincia%>
</td>	
</tr>
</table>		
					
				</c:if>
			</c:otherwise>
		</c:choose>
    
<br/><br/>
Dati relativi all'animale: <br/>

  
<table class="bordo"> <col width="25%">
<col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%">
<tr>
<td colspan="2">
<b>Specie:</b><br/>
<c:if test="${esame.animale.lookupSpecie.id == 1}">
	Cane
</c:if>
<c:if test="${esame.animale.lookupSpecie.id == 2}">
	Gatto
</c:if>
<c:if test="${esame.animale.lookupSpecie.id == 3}">
	Sinantropo
</c:if>
</td>
<td colspan="2">
<b>Identificativo:</b><br/>
${esame.animale.identificativo}
</td>
<td colspan="2">
<b>Sesso:</b><br/>
${esame.animale.sesso}
</td>
<td colspan="2">
<b>Trattamenti ormonali:</b><br/>
${esame.trattOrm }
</td>
<td colspan="2">
<b>Taglia:</b><br/>
${anagraficaAnimale.taglia}
</td>	
</tr>
<tr>
<td colspan="2">
<c:if test="${esame.animale.lookupSpecie.id!=3}">
    			<b>Razza:</b>
    			</c:if>
    		<c:if test="${esame.animale.lookupSpecie.id==3}">
    			<b>Famiglia/Genere:</b>
    			</c:if><br/>
  	<c:if test="${(esame.animale.lookupSpecie.id == specie.cane or esame.animale.lookupSpecie.id == specie.gatto) && esame.animale.decedutoNonAnagrafe==false}">
  		${anagraficaAnimale.razza}
  	</c:if>
	<c:if test="${esame.animale.decedutoNonAnagrafe==true}">
		${anagraficaAnimale.razza}
	</c:if>
	<c:if test="${esame.animale.lookupSpecie.id == specie.sinantropo && esame.animale.decedutoNonAnagrafe==false}">
		${esame.animale.specieSinantropoString} - ${esame.animale.razzaSinantropo}
	</c:if>
    		   

</td>
<td colspan="2">
<c:choose>
	<c:when test="${esame.animale.lookupSpecie.id==3}">
		<b>Età:</b><br/>
		<fmt:formatDate type="date" value="${esame.animale.dataNascita }" pattern="dd/MM/yyyy" var="dataNascita"/>
		${esame.animale.eta} <c:if test="${dataNascita}">(${dataNascita})</c:if>
	</c:when>
	<c:otherwise>
		<b>Data nascita:</b><br/>
		<fmt:formatDate type="date" value="${esame.animale.dataNascita }" pattern="dd/MM/yyyy" var="dataNascita"/>
		${dataNascita}
	</c:otherwise>
</c:choose> 
</td>
<td colspan="2">
<b>Sterilizzazione:</b><br/>
${anagraficaAnimale.sterilizzato }
</td>
<td colspan="2">
<b>Mantello:</b><br/>
${anagraficaAnimale.mantello}
</td>
<td colspan="2">
<b>Peso:</b><br/>
${esame.peso}
</td>	
</tr>
<tr>
<td colspan="2">
<b>Habitat:</b><br/>
<c:forEach items="${lh}" var="h">
	${h.description} - 							
</c:forEach>		
</td>
<td colspan="2">
<b>Alimentazione:</b><br/>
<c:forEach items="${la}" var="a">
						${a.description}						
				</c:forEach>
				
				<c:forEach items="${listAlimentazioniQualita}" var="aq" >									
							${aq.description} 	
				</c:forEach> 
</td>
<td colspan="2">
<b>Stato generale:</b><br/>
${esame.statoGenerale } ${esame.statoGeneraleLookup }
</td>
<td colspan="4">
<b>Osservazioni del veterinario:</b><br/>

</td>
</tr>
</table>  

<br/><br/>
Dati relativi al prelievo: <br/>

  
<table class="bordo"> <col width="25%">
<col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%">
<tr>
<td colspan="2">
Prelievo:<br/>
${esame.tipoPrelievo.description }
</td>
<td colspan="2">
Tumore:<br/>
${esame.tumore.description }
</td>
<td colspan="2">
Tumori precedenti:<br/>
${esame.tumoriPrecedenti.description } 
</td>
<td colspan="4">
Date e diagnosi precedenti:<br/>
<c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t || esame.n || esame.m || esame.dataDiagnosi!=null || esame.diagnosiPrecedente)}">
        Data diagnosi: <fmt:formatDate type="date" value="${esame.dataDiagnosi}" pattern="dd/MM/yyyy" /> - Diagnosi precedente: ${esame.diagnosiPrecedente}
    	<br/> T: ${esame.t }, N: ${esame.n }, M: ${esame.m }  
    </c:if>
 
 <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t1 || esame.n1 || esame.m1 || esame.dataDiagnosi1!=null || esame.diagnosiPrecedente1)}">
        Data diagnosi: <fmt:formatDate type="date" value="${esame.dataDiagnosi1}" pattern="dd/MM/yyyy" /> - Diagnosi precedente: ${esame.diagnosiPrecedente1}
    	<br/> T: ${esame.t1 }, N: ${esame.n1 }, M: ${esame.m1 }  
    </c:if>
    
    <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t2 || esame.n2 || esame.m2 || esame.dataDiagnosi2!=null || esame.diagnosiPrecedente2)}">
        Data diagnosi: <fmt:formatDate type="date" value="${esame.dataDiagnosi2}" pattern="dd/MM/yyyy" /> - Diagnosi precedente: ${esame.diagnosiPrecedente2}
    	<br/> T: ${esame.t2 }, N: ${esame.n2 }, M: ${esame.m2 }  
    </c:if>
    
    <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t3 || esame.n3 || esame.m3 || esame.dataDiagnosi3!=null || esame.diagnosiPrecedente3)}">
        Data diagnosi: <fmt:formatDate type="date" value="${esame.dataDiagnosi3}" pattern="dd/MM/yyyy" /> - Diagnosi precedente: ${esame.diagnosiPrecedente3}
    	<br/> T: ${esame.t3 }, N: ${esame.n3 }, M: ${esame.m3 }  
    </c:if>
    
    <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t4 || esame.n4 || esame.m4 || esame.dataDiagnosi4!=null || esame.diagnosiPrecedente4)}">
        Data diagnosi: <fmt:formatDate type="date" value="${esame.dataDiagnosi4}" pattern="dd/MM/yyyy" /> - Diagnosi precedente: ${esame.diagnosiPrecedente4}
    	<br/> T: ${esame.t4 }, N: ${esame.n4 }, M: ${esame.m4 }  
    </c:if>
    
    <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t5 || esame.n5 || esame.m5 || esame.dataDiagnosi5!=null || esame.diagnosiPrecedente5)}">
        Data diagnosi: <fmt:formatDate type="date" value="${esame.dataDiagnosi5}" pattern="dd/MM/yyyy" /> - Diagnosi precedente: ${esame.diagnosiPrecedente5}
    	<br/> T: ${esame.t5 }, N: ${esame.n5 }, M: ${esame.m5 }  
    </c:if>   
    
    
</td>
	
</tr>
</table> 

<br/>
Esito esami citologici pregressi _________________________________________________________________________
<br/>



<table class="bordo"> <col width="25%">
<col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%">
<tr>
<td colspan="2">
Organo
</td>
<td colspan="2">
Topografia
</td>
<td colspan="2">
Data prelievo
</td>
<td colspan="2">
Dimensioni (in cm)  
    
    
</td>

<td colspan="2">
Interessamento linfonodale
    
    
</td>
	
</tr>

<tr>
<td colspan="2">
</td>
<td colspan="2">
</td>
<td colspan="2">
</td>
<td colspan="2">
    
    
</td>

<td colspan="2">
    
    
</td>
	
</tr>

<tr>
<td colspan="2">
</td>
<td colspan="2">
</td>
<td colspan="2">
</td>
<td colspan="2">
    
    
</td>

<td colspan="2">
    
    
</td>
	
</tr>

<tr>
<td colspan="2">
</td>
<td colspan="2">
</td>
<td colspan="2">
</td>
<td colspan="2">
    
    
</td>

<td colspan="2">
    
    
</td>
	
</tr>
</table>

<br/>
OSSERVAZIONI DEL VETERINARIO<br/>
 ________________________________________________________________________________________<br/>
 ________________________________________________________________________________________<br/>
 
 Importante
<br/>
<ul>
	<li>Fissare il campione in formalina al 10% </li>
	<li>Rispettare rapporto volumetrico campione/formalina 1:10</li>
	<li>Nel caso di prelievo di più pezzi  identificarli chiaramente o meglio porli in contenitori diversi</li>
	<li>Non usare contenitori in vetro o con bocca stretta o comunque inadeguata all'estrazione del campione</li>
	<li>Compilare attentamente la richiesta pena l'esclusione della processazione del campione</li>
</ul>





	
				
	
</br></br>	

<%
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>
&nbsp;&nbsp;&nbsp;&nbsp;${esame.enteredBy.cognome } ${esame.enteredBy.nome },  <%=sdf.format(new Date())%>
<br>
_____________________

	
  	