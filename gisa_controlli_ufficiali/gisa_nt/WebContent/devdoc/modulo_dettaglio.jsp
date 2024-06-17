<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<%@page import="java.util.Vector"%>
<%@page import="org.aspcfs.modules.devdoc.base.Modulo"%>
<%@page import="org.aspcfs.modules.devdoc.base.ModuloNote"%>

<%@page import="org.aspcfs.modules.gestioneDocumenti.base.DocumentaleAllegatoModulo"%>
<%@page import="org.aspcfs.modules.gestioneDocumenti.base.DocumentaleAllegatoModuloList"%> 

<jsp:useBean id="Modulo" class="org.aspcfs.modules.devdoc.base.Modulo" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="listaTipiModulo" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<jsp:useBean id="listaAllegati" class="org.aspcfs.modules.gestioneDocumenti.base.DocumentaleAllegatoModuloList" scope="request"/>


<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>


<style>

.lettura {
 background-color: transparent; 
 border:none;
}

</style>






 <%! public static String fixData(String timestring)
  {
	  String toRet = "";
	  if (timestring == null || timestring.equals("null"))
		  return toRet;
	  String anno = timestring.substring(0,4);
	  String mese = timestring.substring(5,7);
	  String giorno = timestring.substring(8,10);
	  String ora = timestring.substring(11,13);
	  String minuto = timestring.substring(14,16);
	  String secondi = timestring.substring(17,19);
	  toRet =giorno+"/"+mese+"/"+anno+" "+ora+":"+minuto;
	  return toRet;
	  
  }%>
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



<%@ include file="../utils23/initPage.jsp" %>


<table class="trails" cellspacing="0">
<tr>
<td>
<a href="GestioneFlussoSviluppo.do?command=Dashboard">Richiesta documentale sviluppo software</a> > 
Dettaglio Modulo
</td>
</tr>
</table>

<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong>Informazioni Modulo</strong>
    </th>
  </tr>
  
 	 <tr class="containerBody">
			<td nowrap class="formLabel">
      			Richiesta
			</td>
			<td>
         		<%= Modulo.getIdFlusso() %>&nbsp;
			</td>
		</tr>  
		

	
	 <tr class="containerBody">
			<td nowrap class="formLabel">
      			Documenti
			</td>
			<td>
			
			<table width="100%">
					
			<tr>
			<th>Nome</th>
			<th>Progressivo</th>
			<th>Caricato da</th>
			<th>Caricato il</th>
			</tr>
			
         	<%
	
	if (listaAllegati.size()>0)
		for (int i=0;i<listaAllegati.size(); i++){
			DocumentaleAllegatoModulo doc = (DocumentaleAllegatoModulo) listaAllegati.get(i);
			%>
				
			<tr <%=(i==0) ? "style=\"background:yellow\"" : "" %>>
			<td>
			<a href="GestioneAllegatiUpload.do?command=DownloadPDF&codDocumento=<%=doc.getIdHeader()%>&idDocumento=<%=doc.getIdDocumento() %>&tipoDocumento=<%=doc.getEstensione()%>&nomeDocumento=<%=fixStringa(doc.getNomeClient())%>">
			<%=doc.getNomeClient() %></a>
			</td>
			<td><%=doc.getRevisione() %></td>
			<td><dhv:username id="<%= doc.getUserId()%>" /></td>
			<td><%=fixData(doc.getDataCreazione()) %></td>
			
			<%
				
		} else {%>
					<tr>
			<td colspan="4">Non sono presenti file in questa cartella.</td> 
		</tr>
		<%}%>
		</table>
		
			</td>
		</tr>
	
					
 <tr class="containerBody">
			<td nowrap class="formLabel">
      			Data
			</td>
			<td>
         		<%= toDateasString(Modulo.getData()) %>&nbsp;
			</td>
		</tr>



 <tr class="containerBody">
			<td nowrap class="formLabel">
      			Utente
			</td>
			<td>
         		<dhv:username id="<%= Modulo.getIdUtente() %>" /> &nbsp;
			</td>
		</tr>
	
		</table>
		
		
		<br/><br/>       
    
	