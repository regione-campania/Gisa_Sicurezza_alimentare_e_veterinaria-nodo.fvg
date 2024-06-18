<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@page import="java.util.Date"%>
<script language="JavaScript" type="text/javascript" src="js/vam/cc/rickettsiosi/add.js"></script>


<form action="vam.cc.trasferimenti.AccettazioneDestinatario.us" method="post" name="myForm" onsubmit="javascript:return checkForm(this);">
	
	<input type="hidden" name="idTrasferimento" value="${trasferimento.id }" />
	
	<h4 class="titolopagina">
	   	Accettazione Trasferimento
	</h4>
	
	<table class="tabella">
		
		<tr>
        	<th colspan="2">
        		Dati Accettazione Trasferimento
        	</th>
        </tr>
			
		<tr class="even">
    		<td style="text-align: right; width: 40%">
    			 <strong>Data</strong>
    		</td>
    		<td style="text-align: left;">
    			<fmt:formatDate type="date" value="<%=new Date() %>" pattern="dd/MM/yyyy" var="dataOdierna"/>
    			 <input type="text" value="${dataOdierna}" id="dataAccettazioneDestinatario" name="dataAccettazioneDestinatario" maxlength="10" readonly="readonly" />
				 <img src="images/b_calendar.gif" alt="calendario" id="id_img_1" /> 
				 <script type="text/javascript">
						Calendar.setup({
							inputField  :    "dataAccettazioneDestinatario",      // id of the input field
							ifFormat    :    "%d/%m/%Y",  // format of the input field
							button      :    "id_img_1",  // trigger for the calendar (button ID)
							// align    :    "rl,      // alignment (defaults to "Bl")
							singleClick :    true,
							timeFormat	:   "24",
							showsTime	:   false
						});					    
				 </script> 
    		</td>
        </tr>
		
		<tr>
			<td style="text-align: right;"><strong>Nota Destinatario</strong></td>
			<td style="text-align: left;">
				<textarea rows="10" cols="60" name="notaDestinatario"></textarea>
			</td>
		</tr>
		
	<tr>
		<td colspan="2" style="text-align: center;">	
			<input type="submit" value="Salva"/>
			<input type="button" value="Annulla" onclick="attendere(), location.href='vam.cc.trasferimenti.Home.us'">
		 </td>
	 </tr>
 	</table>

</form>

<script type="text/javascript">
function checkForm( form )
{
	/*if( document.myForm.notaDestinatario.value != "" )
	{
		attendere();
		return true;
	}
	else
	{
		alert( "Inserire nota Destinatario" );
		return false;
	}*/
}
</script>

