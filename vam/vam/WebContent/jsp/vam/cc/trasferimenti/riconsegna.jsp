<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@page import="java.util.Date"%>
<script language="JavaScript" type="text/javascript" src="js/vam/cc/rickettsiosi/add.js"></script>

<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>

<form action="vam.cc.trasferimenti.Riconsegna.us" method="post" id="myForm" name="myForm" onsubmit="javascript:return checkForm(this);">
	
	<input type="hidden" name="idTrasferimento" value="${trasferimento.id }" />
	<fmt:formatDate value="${cc.dataApertura}" pattern="dd/MM/yyyy" var="ccDataApertura"/>
	<input type="hidden" name="dataApertura" id="dataApertura" value="${ccDataApertura}" />
	
	<h4 class="titolopagina">
	   	Riconsegna Animale Trasferito
	</h4>
	
	<table class="tabella">
		
		<tr>
        	<th colspan="2">
        		Dati Riconsegna
        	</th>
        </tr>
			
		<tr class="even">
    		<td style="text-align: right; width: 40%">
    			 <strong>Data</strong> <font color="red">* </font>
    		</td>
    		<td style="text-align: left;">
    			<input type="text" value="" id="dataRiconsegna" name="dataRiconsegna" maxlength="10" size="10" readonly="readonly" />
				 <img src="images/b_calendar.gif" alt="calendario" id="id_img_1" /> 
				 <script type="text/javascript">
						Calendar.setup({
							inputField  :    "dataRiconsegna",      // id of the input field
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
			<td style="text-align: right;"><strong>Nota Riconsegna</strong> <font color="red">* </font></td>
			<td style="text-align: left;">
				<textarea rows="10" cols="60" name="notaRiconsegna"></textarea>
			</td>
		</tr>
		
	<tr>
		<td colspan="2" style="text-align: center;">	
			<font color="red">* Campi obbligatori</font><br/> 
			<input type="submit" value="Salva"/>
			<input type="button" value="Annulla" onclick="attendere(), location.href='vam.cc.trasferimenti.List.us'">
		 </td>
	 </tr>
 	</table>

</form>

<script type="text/javascript">
function checkForm( form )
{
	if(document.getElementById('dataRiconsegna').value=='')
	{
		alert("Selezionare la data riconsegna.");
		document.getElementById('dataRiconsegna').focus();
		return false;
	}
	
	if(confrontaDate(document.getElementById('dataRiconsegna').value,document.getElementById('dataApertura').value)<0)
	{
		alert("La data riconsegna deve essere uguale o successiva alla data di apertura della CC");
		return false;
	}
	
	if( document.myForm.notaRiconsegna.value != "" )
	{
		return true;
	}
	else
	{
		alert( "Inserire nota Riconsegna" );
		return false;
	}
}
</script>

