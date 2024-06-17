<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<jsp:useBean id="ListaGiacenza" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="RagioneSociale" class="java.lang.String" scope="request"/>
<jsp:useBean id="NumRegistrazioneStab" class="java.lang.String" scope="request"/>

<jsp:useBean id="TipiSeme" class="org.aspcfs.utils.web.LookupList" scope="request" />

<%@page import="org.aspcfs.modules.registrocaricoscarico.base.*"%>

<%@ include file="../../utils23/initPage.jsp"%>

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

<link rel="stylesheet" type="text/css" media="screen" documentale_url="" href="registrocaricoscarico/css/style.css" />

<table class="detailsRecapito" cellpadding="10" cellspacing="10" width="100%">
<tr>
<th>GIACENZA REGISTRO CARICO/SCARICO RECAPITI</th>
</tr>
</table>

<table class="detailsRecapito" cellpadding="10" cellspacing="10" id ="tblGiacenza" width="100%" style="border-collapse: collapse">

<tr>
<th>MATRICOLA</th>
<th>NOME CAPO</th>
<th>TIPO SEME</th>
<th>DOSI/EMBRIONI ACQUISTATE</th>
<th>DOSI/EMBRIONI VENDUTE</th>
<th>DOSI/EMBRIONI DISTRUTTE</th>
<th>GIACENZA</th>
</tr>


<%
	for (int i = 0; i< ListaGiacenza.size(); i++){
	Giacenza g = (Giacenza) ListaGiacenza.get(i);
%>

<tr class="row<%=i%2%>">
<td><%=toHtml(g.getMatricola()) %></td>
<td><%=toHtml(g.getNomeCapo()) %></td>
<td><%=g.getIdTipoSeme() > 0 ? TipiSeme.getSelectedValue(g.getIdTipoSeme()) : "" %></td>
<td><%=g.getDosiAcquistate() %></td>
<td><%=g.getDosiVendute() %></td>
<td><%=g.getDosiDistrutte() %></td>
<td><%=g.getGiacenza()%></td>
</tr>

<% } %>
 
</table>

<br/><br/><br/>

<%--  <%@ include file="../../csvutils/csvexport.jsp" %> --%>
<!-- <center>  -->
<%-- <input type="button" style="width:250px; height: 50px; font-size: 20px; word-wrap: break-word; display: inline-block;" onclick="exportCSV_6('tblGiacenza', 'GiacenzaRecapito_<%=NumRegistrazioneStab %>')" value="Esporta in excel"/> --%>
<!-- </center> -->
