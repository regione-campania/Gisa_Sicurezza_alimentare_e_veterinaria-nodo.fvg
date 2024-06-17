<%@ page import="org.aspcfs.modules.util.imports.ApplicationProperties" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean"
	scope="session" />

<script>
function openGuc(cfSpid){
	var url = "";
	var urlGisa = window.location.hostname;
	var urlGuc = urlGisa.replace("gisaveterinaria", "gisasca");
	window.open('https://' + urlGuc + '/guc/login.LoginNoPassword.us?cf_spid='+cfSpid+'&messaggio_home=true&endpoint=gisa&iframe=true','','scrollbars=1,width=800,height=600'); 
}

</script>


<table class="trails" cellspacing="0">
	<tr>
		<td>
			<a href="MyCFS.do?command=Home"><dhv:label name="My Home Page" mainMenuItem="true">La Mia Home Page</dhv:label></a> >
			Messaggio Home Page
		</td>
	</tr>
</table>

<div align="center">
<a href="#" onclick="openGuc('<%= User.getContact().getVisibilitaDelega().toUpperCase() %>'); return false;">MESSAGGIO</a>
<%-- <a href="#" onclick="window.open('<%=request.getScheme() %>://<%= HEADER_DOMINIO %>:8081/guc/login.LoginNoPassword.us?cf_spid=<%= User.getContact().getVisibilitaDelega().toUpperCase() %>&messaggio_home=true&endpoint=gisa&iframe=true','','scrollbars=1,width=800,height=600'); return false;">MESSAGGIO</a> --%>
</div>