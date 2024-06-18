<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<%@page import="it.us.web.util.vam.CaninaRemoteUtil"%>
<%@page import="it.us.web.bean.BUtente"%>
<%@page import="java.util.Date"%>
<script language="Javascript">
function isnum(obj) 
{
   if (obj==null || obj.value==null || obj.value=="")
   {
      alert('Inserire il numero passaporto.');
      obj.value="";
      obj.focus();
      return false;
   }
   else if(obj.value.length!=13)
   {
      alert('Il numero passaporto deve essere composto da 13 caratteri alfanumerici.');
      obj.value="";
      obj.focus();
      return false;
   }
   return true;
}

function checkform()
{
	if(isnum(document.getElementById('numeroPassaporto')))
		if(myConfirm('Sicuro di voler procedere col salvataggio della registrazione di rilascio passaporto in BDR?'))
			location.href='vam.bdr.canina.Passaporto.us?idAccettazione='+document.getElementById('idAccettazione').value+'&dataPassaporto='+document.getElementById('dataPassaporto').value+'&numeroPassaporto='+document.getElementById('numeroPassaporto').value+'&notePassaporto='+document.getElementById('notePassaporto').value;
}




</script>

<form action="vam.bdr.canina.Passaporto.us" method="post">

	<input type="button" value="Procedi" onclick="checkform();" />
	
	<fieldset>
		<legend>Registrazione Rilascio Passaporto ${accettazione.animale.lookupSpecie.description } ${accettazione.animale.identificativo }</legend>
		
		<input type="hidden" id="idAccettazione" name="idAccettazione" value="${accettazione.id }" />
		
		<table class="tabella">
			<tr class="even" >
				<td>Data Rilascio Passaporto</td>
				<td>
					<input 
						type="text" 
						value="<fmt:formatDate type="date" value="<%=new Date() %>" pattern="dd/MM/yyyy" />"
						id="dataPassaporto" 
						name="dataPassaporto" 
						id="dataPassaporto" 
						maxlength="10" 
						size="10" 
						readonly="readonly" />
						<img src="images/b_calendar.gif" alt="calendario" id="id_img_1" />
						<script type="text/javascript">
							Calendar.setup({
								inputField  :    "dataPassaporto",      // id of the input field
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
			<tr class="odd" >
				<td>Numero Passaporto</td>
				<td> <input id="numeroPassaporto" type="text" size="30" maxlength="13" name="numeroPassaporto"/> </td>
			</tr>
			<tr class="even" >
				<td>Note Passaporto</td>
				<td>
					<textarea rows="3" cols="30" name="notePassaporto" id="notePassaporto" maxLength="300" ></textarea>
				</td>
			</tr>
		</table>
	</fieldset>
	
	<br/>
	<input type="button" value="Procedi" onclick="checkform();" />
	
</form>
