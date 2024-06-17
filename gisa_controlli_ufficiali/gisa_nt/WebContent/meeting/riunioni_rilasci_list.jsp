<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@page import="java.util.Vector"%>
<%@page import="org.aspcfs.modules.meeting.base.Riunione"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>

<jsp:useBean id="RiunioneList" class="org.aspcfs.modules.meeting.base.RiunioneList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="listaStati" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SearchRiunioniListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="indiceRiunione" class="java.lang.String" scope="request"/>


<%@ include file="../utils23/initPage.jsp" %>
<script>



function selezionaRiunione(id, titolo, indice){
	
	window.opener.document.getElementById("idRiunione"+indice).value = id;
	window.opener.document.getElementById("titoloRiunione"+indice).innerHTML = titolo;
	if (indice>0)
		window.opener.document.getElementById("cancellaRiunione"+indice).style.display="block";

	window.close();
	
}

</script>




<table cellpadding="8" cellspacing="0" border="0" width="100%" class="pagedList">
  <tr>
   <th nowrap> <strong>Contesto</strong> </th>
      <th nowrap> <strong>Oggetto</strong> </th>
      <th nowrap> <strong>Note</strong> </th>
      <th nowrap> <strong>Luogo</strong> </th>
      <th nowrap> <strong>Data</strong> </th>
      <th nowrap> <strong>Partecipanti</strong> </th>
      <th nowrap> <strong>Stato</strong> </th>
      <th nowrap> <strong>Azione</strong> </th>
       
    
  </tr>
  
  <%
  for (Riunione riunione : (Vector<Riunione>)RiunioneList)
  {
	  
	  %>
	  <tr>
	  <td>
	  <%=toHtml(riunione.getContesto()) %>
	  </td>
	   <td> <%=riunione.getTitolo() %> </td>
      <td > <%=riunione.getDescrizioneBreve() %> </td>
      <td > <%=riunione.getLuogo() %> </td>
      <td > <%=toDateasString(riunione.getData()) %> </td>
      <td > 
      <%
      
      for (int i = 0 ; i < riunione.getListaPartecipanti().size(); i++)
      {
    	out.println(""+riunione.getListaPartecipanti().get(i)+"<br>");  
      }
      %>
      
      </td>
      
     
      <td><%=listaStati.getSelectedValue(riunione.getStato()) %></td>
      <td><a href="#" onClick="selezionaRiunione('<%=riunione.getId()%>', '<%=StringEscapeUtils.escapeJavaScript(riunione.getTitolo())+ " " + StringEscapeUtils.escapeJavaScript(riunione.getDescrizioneBreve())%>', '<%=indiceRiunione%>')">SELEZIONA</a></td>
      
     
	  </tr>
	  
	  <%
	  
  }
  %>
  
  </table>
  
  
  <div id="dettaglioRiunione"></div>