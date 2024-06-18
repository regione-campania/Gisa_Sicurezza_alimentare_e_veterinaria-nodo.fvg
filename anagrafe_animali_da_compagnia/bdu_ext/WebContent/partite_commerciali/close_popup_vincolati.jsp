<jsp:useBean id="PartitaCommerciale" class="org.aspcfs.modules.partitecommerciali.base.PartitaCommerciale" scope="request" />
	<%
	//	request.setAttribute("PartitaCommerciale", PartitaCommerciale);
	
	%>
	
	<%=PartitaCommerciale.getListMicrochipAnimaliConVincolo().get(0) %>
<script type="text/javascript">




	function submitParent(){
	var sel = window.opener.document.forms[0].listMicrochipAnimaliConVincolo;
	window.opener.document.forms[0].listMicrochipAnimaliConVincolo.options.length = 0;
	<%for (int i = 0; i < PartitaCommerciale.getListMicrochipAnimaliConVincolo().size(); i++){
		%>
		sel.options[sel.options.length]=new Option(<%=PartitaCommerciale.getListMicrochipAnimaliConVincolo().get(i)%>,<%=PartitaCommerciale.getListMicrochipAnimaliConVincolo().get(i)%>);
	<%}
	%>
	loop_select();
	window.close();
	
}


	function loop_select() {
		 for(i=0; i<=window.opener.document.forms[0].listMicrochipAnimaliConVincolo.length-1; i++) { 
			 window.opener.document.forms[0].listMicrochipAnimaliConVincolo.options[i].selected = true; } 
		 }
</script>
<body onload="javascript:submitParent();">
