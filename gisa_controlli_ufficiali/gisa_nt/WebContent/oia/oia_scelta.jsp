
 <%
 String contesto = (String) application.getAttribute("SUFFISSO_TAB_ACCESSI");
	if (contesto!=null && contesto.equals("_ext"))
		contesto="Suap";
	else
		contesto = "Gisa";
 %>

<%-- Trails --%>
	<table class="trails" cellspacing="0">
	<tr>
		<td>AUTORITA' COMPETENTI</td>
	</tr>
	</table>
<%-- Trails --%>
<br>
<div align="center">
<dhv:permission name="oia-oia-vigilanza"> 
    <!-- di default andiamo sul nodo regione? -->
	<input type="button" class="yellowBigButton" style="width: 450px;" 
		   value="INSERISCI CONTROLLO UFFICIALE" onclick="window.location.href='OiaVigilanza.do?command=Add&orgId=1043661&idNodo=-1';"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
</dhv:permission>

<dhv:permission name="oia-view"> 
	<input type="button" class="yellowBigButton" style="width: 300px;" 
		value="RICERCA CONTROLLO UFFICIALE" onclick="window.location.href='Oia.do?command=SearchForm';"/>
</dhv:permission>
</div>
<br>
