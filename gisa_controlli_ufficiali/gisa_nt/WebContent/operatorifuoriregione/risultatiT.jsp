<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ include file="../utils23/initPage.jsp" %>
<%-- Trails --%>
<%
	Vector<BOperatori> risultati = (Vector<BOperatori>)request.getAttribute( "risultati" );
%>

<%@page import="org.aspcfs.modules.operatorifuoriregione.base.BOperatori"%><table class="trails" cellspacing="0">
	<tr>
		<td>
			<a href="OperatoriFuoriRegione.do?command=DefaultASL"><dhv:label name="">Imprese Fuori Ambito ASL</dhv:label></a> > 
			<dhv:label name="">Risultati Ricerca Imprese Reg. Altre ASL della Campania da importare</dhv:label>
		</td>
	</tr>
</table>

<table cellpadding="2" cellspacing="2" border="0" width="100%">
  <tr>
    <td width="50%" valign="top">

      <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
        <tr>
          <th colspan="6">
            <strong><dhv:label name="risultati">Risultati</dhv:label></strong>
          </th>
        </tr>
        <%
        	if( risultati.size() < 1 )
        	{
        %>
        <tr>
          <td colspan="6" class="formLabel" align="left">
            Nessun Risultato
          </td>
        </tr>
    
        <%
        	}
        	else
        	{
        %>
        <tr>
          <th class="formLabel">
            <dhv:label name="camera_commercio.ragione_sociale">Ragione Sociale</dhv:label>
          </th>
          <th class="formLabel">
            <dhv:label name="camera_commercio.codice_fiscale">Partita IVA</dhv:label>
          </th>
          <th class="formLabel" width="5">&nbsp;
          </th>
        </tr>
        <%
        		for( BOperatori bc: risultati )
        		{
        %>
        
        <tr>
          <td class="formLabel">
       	  	<%=toHtml( bc.getName() ) %>
          </td>
          <td class="formLabel">
          	<%=toHtml( bc.getPartita_iva() ) %>
          </td>
           <td class="formLabel">
          	<a href="OperatoriFuoriRegione.do?command=Add&org_id=<%=bc.getOrg_id() %>">Scheda</a>
          </td>
        </tr>
       
        <%
        		}
        	}
        %>
         
        
</table>
      
    </td>
    
  </tr>
  
 <%
        	if( risultati.size() < 1 )
        	{
        %>
        <tr>
        
        <dhv:permission name="operatoriregione-operatoriregione-add"><a href="OperatoriFuoriRegione.do?command=Add"><dhv:label name="">Aggiungi Impresa Fuori Ambito ASL</dhv:label></a></dhv:permission>
        
         </tr>
        <%}%>
</table>
