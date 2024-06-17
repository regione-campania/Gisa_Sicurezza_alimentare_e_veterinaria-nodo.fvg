<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        
    <%@ include file="../../utils23/initPage.jsp"%>
    <jsp:useBean id="messaggioPost" class="java.lang.String" scope="request"/>
    <jsp:useBean id="orgId" class="java.lang.String" scope="request"/>
    <jsp:useBean id="label" class="java.lang.String" scope="request"/>
    <jsp:useBean id="codDocumento" class="java.lang.String" scope="request"/>
    <jsp:useBean id="titolo" class="java.lang.String" scope="request"/>
    <jsp:useBean id="oggetto" class="java.lang.String" scope="request"/>
    <jsp:useBean id="nomeClient" class="java.lang.String" scope="request"/>
    <jsp:useBean id="tipoAllegato" class="java.lang.String" scope="request"/>
        

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.opu.base.*, org.aspcfs.modules.base.*" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>

  <%! public static String fixStringa(String nome)
  {
	  String toRet = nome;
	  if (nome == null || nome.equals("null"))
		  return toRet;
	  toRet = nome.replaceAll("'", "");
	  toRet = toRet.replaceAll(" ", "_");
	  toRet = toRet.replaceAll("\\?","");
	
	  return toRet;
	  
  }%>
  
<script>
function ritornaAllegato (cod, tit, ogg, nom){
		window.close();
}
function setAllegato (cod, tit, ogg, nom){
	
	var tag = "rt";
	
	<% if (tipoAllegato.equalsIgnoreCase("RegistroTrasgressoriAe")) {%>
		tag = "ae";
	<% } %>
	
	var size = parseInt(window.opener.document.getElementById('allegato_'+tag+'_size').value);
	
	var nuovoIndice = size;
	var nuovoSize = size+1;
	
	window.opener.document.getElementById('allegato_'+tag+'_size').value = nuovoSize;
	
	var nuovoDiv = document.createElement('div');
	
	var link_temp = "<a id = '"+cod+"_download' href='GestioneAllegatiTrasgressori.do?command=DownloadPDF&codDocumento="+cod+"&nomeDocumento="+nom+"'>"+ogg+"</a>";
	var cod_temp = "<input type='hidden' id='allegato_"+tag+"_"+nuovoIndice+"' name='allegato_"+tag+"_"+nuovoIndice+"' value='"+cod+"'/>";
	var ogg_temp = "<input type='hidden' id='allegato_"+tag+"_oggetto_"+nuovoIndice+"' name='allegato_"+tag+"_oggetto_"+nuovoIndice+"' value='"+ogg+"'/>";
	var nom_temp = "<input type='hidden' id='allegato_"+tag+"_nomeclient_"+nuovoIndice+"' name='allegato_"+tag+"_nomeclient_"+nuovoIndice+"' value='"+nom+"'/>";
	var eli_temp = "&nbsp; &nbsp; &nbsp; &nbsp;  <i><b>Elimina</b></i> <input type='checkbox' id='allegato_"+tag+"_elimina_"+nuovoIndice+"' name='allegato_"+tag+"_elimina_"+nuovoIndice+"' value='si'/>";
	var br_temp = "<br/><br/>";
	nuovoDiv.innerHTML =  link_temp + cod_temp + ogg_temp + nom_temp + eli_temp + br_temp;
	window.opener.document.getElementById('linkAllegati_'+tag).appendChild(nuovoDiv);
	}
</script>

	<% String param1 = "orgId=" + orgId;   
%>
<body onload="setAllegato('<%=codDocumento %>', '<%=fixStringa(titolo) %>', '<%=fixStringa(oggetto) %>', '<%=fixStringa(nomeClient)%>')">
<center><b><p><span style="color:green"><%=codDocumento %> - <%=titolo %> - <%=oggetto %> - <%=nomeClient %></span> </p></b>
<dhv:evaluate if="<%=(messaggioPost!=null) %>"> 
<label><font size="5"><%=messaggioPost %></font></label>
</dhv:evaluate>
<br/>

<input type="button" class="buttonClass" style="width:200px;height:50px" value="CHIUDI E CONTINUA" onclick="ritornaAllegato('<%=codDocumento %>', '<%=fixStringa(titolo) %>', '<%=fixStringa(oggetto) %>', '<%=fixStringa(nomeClient)%>')" />

</center>
</body>
