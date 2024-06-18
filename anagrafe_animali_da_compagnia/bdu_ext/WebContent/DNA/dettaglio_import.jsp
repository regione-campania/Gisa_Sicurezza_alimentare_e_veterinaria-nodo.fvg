<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*" %>

<%@page import="org.aspcfs.modules.DNA.base.ListaConvocazione"%>
<jsp:useBean id="circoscrizioniList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="stato" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="listaImportata" class="org.aspcfs.modules.DNA.base.ListaConvocazione" scope="request"/>
<script type="text/javascript" src="dwr/interface/DwrUtil.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>

<%@ include file="../initPage.jsp"%>
<body>

<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
  <td>
    <dhv:label name="">Dettaglio lista</dhv:label>
  </td>
</tr>
</table>
<%-- End Trails --%>
<table width="30%" cellpadding="2" cellspacing="2">
<tr class="containerBody"><td class="formLabel">Denominazione</td>
<td class="formLabel" valign="top">
<%if (listaImportata.getIdStato() == ListaConvocazione.terminato_senza_errori){ %>
<a href="ListaConvocazioneAction.do?command=DettaglioListaConvocazione&idLista=<%=listaImportata.getIdListaConvocazione()%>"> <%=listaImportata.getDenominazione() %></a>
<%}else{ %>
<%=listaImportata.getDenominazione() %>
<%} %>
<tr class="containerBody">
<td class="formLabel" valign="top">Comune</td><td class="formLabel" valign="top">

<%=comuniList.getSelectedValue(listaImportata.getIdComune()) %></td></tr>
<td class="formLabel" valign="top">Circoscrizione</td>
<td class="formLabel" valign="top"><%=circoscrizioniList.getSelectedValue(listaImportata.getIdCircoscrizione()) %></td></tr>


<tr class="containerBody">
<td class="formLabel" valign="top">Data inizio</td>
<td class="formLabel" valign="top">
<%=toDateasString(listaImportata.getDataInizio()) %></td>
		</tr><tr>	
<td class="formLabel" valign="top">Data fine</td>
<td class="formLabel" valign="top">
<%= toDateasString(listaImportata.getDataFine()) %></td>	
			</tr>
  <tr class="containerBody">
    <td class="formLabel" valign="top">
      <dhv:label name="">File</dhv:label>
    </td>
    <td class="formLabel" valign="top"><a href="ListaConvocazioneAction.do?command=VisualizzaFilesEsito&idListaConvocazione=<%=listaImportata.getIdListaConvocazione()%>"><span style="font-size: 8px">File lista nominativi</span></a></td>
        </tr>
    
   <td class="formLabel" valign="top"> Stato import </td>
   <td class="formLabel" valign="top"> <%=stato.getSelectedValue(listaImportata.getIdStato()) %>
    <a href="ListaConvocazioneAction.do?command=List"><span style="font-size: 8px">Visualizza liste</span></a>
    </td>
  </tr>
</table>
<br />

</body>
