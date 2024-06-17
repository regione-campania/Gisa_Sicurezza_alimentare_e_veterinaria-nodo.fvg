
<script language="javascript">
function openPopupModules(orgId, ticketId, idCU, url,tipo){
	var res;
	var result;
		window.open('PrintModulesHTML.do?command=ViewModules&orgId='+orgId+'&ticketId='+ticketId+'&idCU='+idCU+'&url='+url+'&tipo='+tipo,'popupSelect',
		'height=800px,width=1280px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	
} 

</script>
<div align="right" style="padding-left: 210px; margin-bottom: 45px">

<a href="javascript:openPopupModules('<%= OrgDetails.getOrgId() %>', '<%= TicketDetails.getId() %>', '<%= TicketDetails.getIdControlloUfficiale() %>', '<%= TicketDetails.getURlDettaglio() %>','6');">
	<font size="3px" color="#006699" style="font-weight: bold;">
		Stampa Mod.6 Verbale Superficie Ambientale</font> 
</a>
<br>			
</div>

			

	


