<%@ page import="java.util.*" %>

<%@page import="org.aspcfs.modules.anagrafe_animali.base.Animale"%>



<jsp:useBean id="animale" class="org.aspcfs.modules.anagrafe_animali.base.Animale" scope="request"/>
<jsp:useBean id="lookupMantello" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="lookupRazza" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList" scope="request"/>


<%@ include file="../initPage.jsp"%>

<html>
<head>
	<title>Dettagli animale</title>
</head>

<body>
<table  border="1">
<%if ((animale.getMicrochip() != null && animale.getMicrochip() != "")  || (animale.getTatuaggio() != null && animale.getTatuaggio() != "")){ %>
  <tr>
    <th>
      <strong>Microchip</strong>
    </th>
    <td>
      <%= toHtml(animale.getMicrochip()) %>
      
	</td>
  </tr>
  <tr>
    <th>
      <strong>Tatuaggio</strong>
    </th>
    <td>
      <%= toHtml(animale.getTatuaggio()) %>
      
	</td>
  </tr>
    <tr>
    <th>
      <strong>Specie</strong>
    </th>
    <td>
      <%= toHtml(animale.getNomeSpecieAnimale()) %>
      
	</td>
  </tr>
  
  <tr>
    <th>
      <strong>Razza</strong>
    </th>
     <td>
     <%=lookupRazza.getSelectedValue(animale.getIdRazza()) %>
     </td>
  </tr>
  <tr>
    <th>
      <strong>Asl di Riferimento</strong>
    </th>
    <td>
     <%= toHtml(AslList.getSelectedValue(animale.getIdAslRiferimento())) %>
    </td>
  </tr>
  <tr>
    <th>
      <strong>Mantello</strong>
    </th>
    <td>
    <%=toHtml(lookupMantello.getSelectedValue(animale.getIdTipoMantello())) %>
	</td>
  </tr>
  
  <tr>
  	<td colspan="2">
  		<a href="javascript: history.go(-1)">Indietro</a> 
  	<td>
  </tr>
  <%} else { %>
  <tr>
      <td>
        Nessun cane trovato.
        <%= showAttribute(request, "microchip") %>
      </td>
      <td>
  		<a href="javascript: history.go(-1)">Indietro</a> 
  	  <td>
    </tr>
   <%} %>
 </table>
</body>
</html>