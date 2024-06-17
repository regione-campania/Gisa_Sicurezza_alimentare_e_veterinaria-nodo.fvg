<%@page import="java.util.Date"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="org.aspcfs.modules.login.beans.UserBean"%>
<%@page import="java.sql.Timestamp"%>
<%

Timestamp data_operazione = new Timestamp(System.currentTimeMillis());
UserBean utenteCollegato = (UserBean)request.getSession().getAttribute("User");

String commandOld = (String)request.getAttribute("commandOld");


Timestamp timeIni =null;
if (request.getAttribute("TimeIni")!=null)
	timeIni = (Timestamp)request.getAttribute("TimeIni");
%>

<script>
function showTel(campo)
{
if (campo.checked)	
	{
	
	document.getElementById("tel").style.display="";
	}
else
	{
	document.getElementById("tel").style.display="none";
	}
	
}

</script>
<div style="display: none;width: 610px;height: 290px;" id="dialogCustomerSatisfaction" title="Sei soddisfatto di come è andata l'operazione appena eseguita ?"  >
   <table style="width: 100%" class="noborder">
   
   
   <tr>
   <td align="center"><button type ="button" style="width: 200px" value="SI" onclick="saveSatisfaction( '<%=data_operazione.getTime() %>', '<%=utenteCollegato.getUsername().replaceAll("'", "") %>', 'si', '', '<%=commandOld%>',document.getElementById('iniTime').value,document.getElementById('endTime').value)"><b>SI, CONTINUA</b><img src="images/ok.png" width="30px" height="30px"></button></td>
   <td align="center"><button type ="button" style="width: 200px" value="NO"onclick="document.getElementById('problematicaCustomerSatisfaction').style.display='';"><b>NO,VI DICO IL MOTIVO</b><img src="images/nok.png" width="30px" height="30px"></button>
   </td>
   </tr>
   
  
    <tr><td colspan="2" id ="label_tempo_esecuzione">
    
   
    </td></tr>
   
   
   <tr id="problematicaCustomerSatisfaction" style="display: none">
   <td><h3>DARE UNA BREVE DESCRIZIONE DEL PROBLEMA RISCONTRATO</h3><br>
   <input type = "checkbox" id = "check" onclick="showTel(this)">Desidererei Essere Contattato <br>
   <input type = "text" value ="" name = "tel" id = "tel" style="display:none">
   
   </td>
   <td>
   	<textarea rows="8" cols="70" id="cusatisfaction"></textarea>
   	<input type = "button" value="CONTINUA" onclick="saveSatisfaction(  '<%=data_operazione.getTime() %>', '<%=utenteCollegato.getUsername().replaceAll("'", "") %>', 'no', document.getElementById('cusatisfaction').value, '<%=commandOld%>',document.getElementById('iniTime').value,document.getElementById('endTime').value)">
   </td>
   </tr>
   
   <input type ="hidden" name = "iniTime" id = "iniTime" value = "<%=(timeIni!=null)?timeIni.getTime():"" %>"/>
  <tr></tr>
   
   </table>
</div>