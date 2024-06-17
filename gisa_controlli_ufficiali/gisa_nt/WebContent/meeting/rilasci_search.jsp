
<%@page import="java.util.Vector"%>
<%@page import="org.aspcfs.modules.meeting.base.Rilascio"%>
<jsp:useBean id="Rilascio" class="org.aspcfs.modules.meeting.base.Rilascio" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="listaContesti" class="org.aspcfs.utils.web.LookupList" scope="request"/>



<link rel="stylesheet" href="css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.calendars.picker.css">
<link href="javascript/datepicker/jquery.datepick.css" rel="stylesheet">
<script type="text/javascript" src="javascript/jquery.calendars.js"></script>
<script type="text/javascript" src="javascript/jquery.calendars.plus.js"></script>
<script type="text/javascript" src="javascript/jquery.plugin.js"></script>
<script type="text/javascript" src="javascript/jquery.calendars.picker.js"></script>
<script src="javascript/parsedate.js"></script>
<script src="javascript/jquery-ui.js"></script>
<script src="javascript/datepicker/jquery.plugin.js"></script>
<script src="javascript/datepicker/jquery.datepick.js"></script>
<script src="javascript/CalendarPopup2.js"></script>


<%@ include file="../utils23/initPage.jsp" %>



<script>
$( document ).ready(function() {
	calenda('dataFrom','','0');
	calenda('dataTo','','');
});



</script>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="GestioneRiunioni.do?command=SearchForm">Gestione Riunioni</a> > 
Ricerca
</td>
</tr>
</table>



<form action="GestioneRiunioni.do?command=SearchRilasci" method="post">
 <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
 <col width="10%">
        <tr>
          <th colspan="2">
            Ricerca rilascio
          </th>
        </tr>
        
        <tr >
          <td class="formLabel">	
           Data Da
          </td>
          <td>
          <input class="date_picker" type = "text" id = "dataFrom" name = "searchtimestampDataFrom">
          </td>
        </tr>
          <tr >
          <td class="formLabel">	
           Data A
          </td>
          <td>
          <input class="date_picker" type = "text" id = "dataTo" name = "searchtimestampDataTo" onclick="checkDataFine('dataFrom','dataTo')">
          </td>
        </tr>
        
       <tr>
      <td nowrap class="formLabel">
        Contesto
      </td>
      <td>
     
        <%=listaContesti.getHtmlSelect("searchcodeidContesto", -1) %>
       
      </td>
    </tr>
    
    
        <tr >
          <td class="formLabel">	
           Oggetto
          </td>
          <td>
          <input type = "text" name = "searchOggetto">
          </td>
        </tr>
        
         <tr >
          <td class="formLabel">	
           Modulo/Note
          </td>
          <td>
          <input type = "text" name = "searchAltro">
          </td>
        </tr>
        
</table>
<input type = "submit" value = "Ricerca">
</form>
       
       
      
	