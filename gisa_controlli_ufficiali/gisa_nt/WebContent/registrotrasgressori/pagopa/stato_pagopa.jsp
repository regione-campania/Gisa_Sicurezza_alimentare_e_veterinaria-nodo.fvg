<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ include file="../../utils23/initPage.jsp"%>
<jsp:useBean id="trasgr" class="org.aspcfs.modules.registrotrasgressori.base.Trasgressione" scope="request"/>
<jsp:useBean id="pagopa" class="org.aspcfs.modules.registrotrasgressori.base.PagoPa" scope="request"/>

<jsp:useBean id="messaggio" class="java.lang.String" scope="request"/>

  <% UserBean user = (UserBean) session.getAttribute("User");%>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %> 


<link rel="stylesheet" documentale_url="" href="registrotrasgressori/css/trasgressori_screen.css" type="text/css" media="screen" />
<link rel="stylesheet" documentale_url="" href="registrotrasgressori/css/trasgressori_print.css" type="text/css" media="print" />


<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>


<%! 
public static String getTagValue(String xml, String tagName){
	String esito = "";
    try {esito =  xml.split("<"+tagName+">")[1].split("</"+tagName+">")[0]; } catch (Exception e) {}
    return esito;
}

%>

<script>

function dettaglioPagoPa(id){
	loadModalWindow();
	window.location.href = "RegistroTrasgressori.do?command=DettaglioPagoPa&idTrasgressione="+id;
}
</script>

<% if (messaggio!=null && !messaggio.equals("")){ %>
<%-- <script> alert('<%=messaggio%>');</script> --%>

<div style="background:yellow">
<pre><xmp>
<%=getTagValue(messaggio, "faultCode")%>
<%=getTagValue(messaggio, "faultString")%>
</xmp></pre>

</div>
<%} %>


<input type="button" id="torna" value="TORNA INDIETRO" onClick="dettaglioPagoPa('<%=pagopa.getIdTrasgressione()%>')"/>

