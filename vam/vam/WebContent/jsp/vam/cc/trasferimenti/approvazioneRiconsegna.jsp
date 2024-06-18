<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@page import="java.util.Date"%>
<script language="JavaScript" type="text/javascript" src="js/vam/cc/rickettsiosi/add.js"></script>


<form action="vam.cc.trasferimenti.ApprovazioneRiconsegna.us" method="post" name="myForm" onsubmit="javascript:return checkForm(this);">
	
	<input type="hidden" name="idTrasferimento" value="${trasferimento.id }" />
	
	<h4 class="titolopagina">
	   	Approvazione Riconsegna
	</h4>
	
	<table class="tabella">
		
		<tr>
        	<th colspan="2">
        		Dati Approvazione Riconsegna
        	</th>
        </tr>
        
        <tr>
        	<td colspan="2" style="text-align: center;">
        	Rientro da <strong>${trasferimento.clinicaDestinazione.nome }</strong> a <strong>${trasferimento.clinicaOrigine.nome }</strong>
        	</td>
        </tr>
			
		<tr class="even">
    		<td style="text-align: right; width: 40%">
    			 <strong>Data</strong>
    		</td>
    		<td style="text-align: left;">
    			<fmt:formatDate type="date" value="<%=new Date() %>" pattern="dd/MM/yyyy" var="dataOdierna"/>
    			${dataOdierna }
    			<input type="hidden" name="dataApprovazioneRiconsegna" value="${dataOdierna }" />
    		</td>
        </tr>
		
		<tr>
			<td style="text-align: right;"><strong>Nota Criuv</strong> <font color="red">* </font></td>
			<td style="text-align: left;">
				<textarea rows="10" cols="60" name="notaApprovazioneRiconsegna"></textarea>
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
	if( document.myForm.notaApprovazioneRiconsegna.value != "" )
	{
		return true;
	}
	else
	{
		alert( "Inserire nota Criuv" );
		return false;
	}
}
</script>

