<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html40/strict.dtd">
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page
	import="org.aspcfs.modules.base.Constants,org.aspcfs.utils.web.*,org.aspcfs.modules.anagrafe_animali.base.*,org.aspcfs.modules.opu.base.*,java.util.Date"%>
	<%@ page
	import="org.aspcfs.modules.registrazioniAnimali.base.*"%>
	
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>
<%@ include file="../../initPage.jsp"%>

<link rel="stylesheet" type="text/css" media="screen"
	href="anagrafe_animali/documenti/screen.css">
<link rel="stylesheet" documentale_url="" href="anagrafe_animali/documenti/print.css"
	type="text/css" media="print" />
	
<jsp:useBean id="animale" class="org.aspcfs.modules.anagrafe_animali.base.Animale" scope="request" />
<jsp:useBean id="evento" class="org.aspcfs.modules.registrazioniAnimali.base.Evento" scope="request" />
<jsp:useBean id="dati_registrazione_adozione" class="org.aspcfs.modules.registrazioniAnimali.base.EventoAdozioneAffido" scope="request" />	
<!-- LOOKUPS DECODIFICA -->
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean"
	scope="session" />
<jsp:useBean id="specieList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="razzaList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="tagliaList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="mantelloList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
	<jsp:useBean id="provinceList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="proprietario" class="org.aspcfs.modules.opu.base.Operatore"
	scope="request" />
<jsp:useBean id="vecchioProprietario" class="org.aspcfs.modules.opu.base.Operatore"
	scope="request" />
<jsp:useBean id="vecchioDetentore" class="org.aspcfs.modules.opu.base.Operatore"
	scope="request" />
<jsp:useBean id="aslList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="caneDettaglio" class="org.aspcfs.modules.anagrafe_animali.base.Cane" scope="request" />

<%
//CATTURO INFO MICROCHIP PER SOSTITUIRLO COL TATUAGGIO NEL CASO SIA ASSENTE
String value_microchip="";
if (animale.getMicrochip()!=null && !animale.getMicrochip().equals(""))
value_microchip = animale.getMicrochip();
else if (animale.getTatuaggio()!=null && !animale.getTatuaggio().equals(""))
	value_microchip=animale.getTatuaggio();

%>


<%-- <body onload="javascript:closeAndRefresh('<%= request.getAttribute("chiudi")%>','<%= request.getAttribute("redirect")%>')">--%>
<body>
<input type="submit" name="stampa" class="buttonClass"
	onclick="window.print();" value="Stampa" />

	  <jsp:include page="../../gestione_documenti/boxDocumentale.jsp">
    <jsp:param name="idAnimale" value="<%=animale.getIdAnimale() %>" />
     <jsp:param name="idSpecie" value="<%=animale.getIdSpecie() %>" />
      <jsp:param name="idTipo" value="PrintRichiestaAdozione" />
       <jsp:param name="idMicrochip" value="<%=value_microchip %>" />
        <jsp:param name="idEvento" value="<%=request.getParameter("idEvento")%>" />
</jsp:include>



<div class="imgRegione">
<img style="text-decoration: none;" width="80" height="80" documentale_url="" src="anagrafe_animali/documenti/images/regionecampania.jpg" />
</div>
<div class="boxIdDocumento"></div>
<div class="boxOrigineDocumento"><%@ include file="../../hostName.jsp" %></div>
<dhv:evaluate if="<%=(evento.getIdAslRiferimento()>0) %>"> 
<div class="imgAsl">
<img style="text-decoration: none;" width="80" height="80" documentale_url="" src="anagrafe_animali/documenti/images/<%=aslList.getSelectedValue(evento.getIdAslRiferimento()) %>.jpg" />
</div>
</dhv:evaluate>
<div class="Section1">
 </br>
 <div class="title1" style="text-align:center;font-size: 15px"><u><b>Modulo affido temporaneo cane randagio</b></u></div>
 
<div style="margin-top:10px; text-align:center;font-size: 12px"><b>DICHIARAZIONE SOSTITUTIVA DI CERTIFICAZIONE</b></div>
<div  style="margin-top:10px;text-align:center;font-size: 10px"><b>(art. 46 D.P.R. n. 445 del 28/12/2000)</b></div>

&nbsp; &nbsp; &nbsp; &nbsp;

<div class="nodott">Il/La sottoscritto/a</div>
<div class="dott_long"><%=proprietario.getRagioneSociale() %></div>
<div class="clear1"></div>

<div class="nodott" style="margin-top: 0px;">Nato a</div>
<div class="dott" style="margin-top: 0px;"><%=(proprietario.getRappLegale().getComuneNascita()) %></div>


<div class="nodott" style="margin-top: 0px;">il</div>
<div class="dott" style="margin-top: 0px;"><%=toDateasString(proprietario.getRappLegale().getDataNascita())%></div>
<div class="clear1"></div>

<div class="nodott" style="margin-top: 0px;">e residente in</div>
<div class="dott" style="margin-top: 0px;"><%=comuniList.getSelectedValue(proprietario.getRappLegale().getIndirizzo().getComune()) %></div>
<div class="clear1"></div>

<div class="nodott" style="margin-top: 0px;">alla via</div>
<div class="dott_long" style="margin-top: 0px;">&nbsp;<%=proprietario.getSedeLegale()%> </div>
<div class="clear1"></div>

<div class="nodott" style="margin-top: 5px;">Codice Fiscale</div>
<div class="dott" style="margin-top: 0px;"><%=proprietario.getCodFiscale() %> </div>
<div class="nodott" style="margin-top: 0px;">telefono</div>
<div class="dott" style="margin-top: 0px;">&nbsp;<%= (proprietario.getRappLegale().getTelefono1() != null)? proprietario.getRappLegale().getTelefono1() : ""%></div>
<div class="clear1"></div>
<div class="nodott" style="margin-top: 0px;">email</div>
<div class="dott" style="margin-top: 0px;">&nbsp;<%= (proprietario.getRappLegale().getEmail() != null)? proprietario.getRappLegale().getEmail() : ""%></div>

<br><br><br>

<div>consapevole delle sanzioni penali previste dall'art. 46 del D.p.r. 445/2000, nel caso di mendaci dichiarazioni, falsit&agrave; negli atti, uso o esibizione di atti falsi o contenenti dati non più rispondenti a verit&agrave;, dichiara quanto segue:</div>

<br>
<div class="clear1"></div>

<div>[ ] di prendere in affido in forma temporanea, nel caso in cui non siano ancora trascorsi 30 giorni dalla cattura/ritrovamento, il cane prelevato in data <%=(toDateasString(caneDettaglio.getDataCattura())!=null) ? toDateasString(caneDettaglio.getDataCattura()) : "_________"  %> nel Comune di <%=(comuniList.getSelectedValue(caneDettaglio.getIdComuneCattura())!=null)?comuniList.getSelectedValue(caneDettaglio.getIdComuneCattura()):"______________" %>  alla via <%=(caneDettaglio.getLuogoCattura()!=null)?toHtml(caneDettaglio.getLuogoCattura()):"______________"%> 	
registrato dai servizi veterinari in Banca Dati Anagrafe Canina Campania a nome del Sindaco del Comune di cattura/ritrovamento con <b>MICROCHIP</b> nr.<%=animale.getMicrochip() %> e si impegna a restituire il cane al proprietario che ne faccia richiesta entro i 30 giorni dalla cattura.</div>
<br>
<br>
<div>[ ] di rendersi disponibile all'affido in forma definitiva (<b>adozione</b>), trascorsi i trenta giorni dalla data di cattura/ritrovamento e previo espletamento delle attivit&agrave; sanitarie di primo livello (art 12, comma 4 comma 2 della L.R. 3/2019 e ss.mm.ii.).</div>



<br><br>
<div class="clear1"></div>

<%	
java.sql.Date timeNow = new java.sql.Date(Calendar.getInstance().getTimeInMillis()); %>
 
<div class="data">DATA </div>

<div class="datavalore"><%=dataToString( timeNow ) %></div>
 
<div class="firma">FIRMA DELL'AFFIDATARIO</div>

<div class="firmavalore">&nbsp;</div>
<br>
<div class="clear1"></div>
<br>
<br><br>
<br>


<div class="nodott">Documento di riconoscimento </div>
<div class="dott_long"><%=(proprietario.getRappLegale().getDocumentoIdentita()!=null)?proprietario.getRappLegale().getDocumentoIdentita():"."  %></div>
<br><br>

<div class="clear1"></div>
<br>
<br>
<br>

<div class="nodott" style="margin-top: 0px;">Si autorizza il trattamento dei dati personali ai sensi del G.D.P.R. 679/2016 e del D.L.vo 101 del 10 agosto 2018</div>
<div class="clear1"></div>
<div class="firma">FIRMA DELL'AFFIDATARIO</div>

<div class="firmavalore">&nbsp;</div>
<br>
<br>

<br/>
</body>

