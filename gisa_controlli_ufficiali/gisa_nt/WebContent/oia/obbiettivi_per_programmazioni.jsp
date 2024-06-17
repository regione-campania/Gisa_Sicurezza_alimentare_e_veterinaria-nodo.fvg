
<%@page import="org.aspcfs.modules.programmazzionecu.base.ProgrammazioneCu"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.aspcfs.modules.programmazzionecu.base.AslCoinvolte"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.util.Iterator"%><jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="NodoCorrente" class="org.aspcfs.modules.oia.base.OiaNodo" scope="request"/>
<jsp:useBean id="ListaProgrammazioni" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="listaPiani" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="lookupASL" class="org.aspcfs.utils.web.LookupList" scope="request"/>

ciaooo
<table border = 1>

<%
for(Object o : ListaProgrammazioni)
{
ProgrammazioneCu programmazione = (ProgrammazioneCu) o ;
%>
<tr>
<td>Piano</td><td><%=listaPiani.getSelectedValue(programmazione.getPiano_monitoraggio())%></td><td></td><td></td></tr>
<%

Hashtable<String,AslCoinvolte> listaAsl = programmazione.getAsl_coinvolte();
Iterator<String> itKey = listaAsl.keySet().iterator();
while (itKey.hasNext())
{
	String kiave = itKey.next();
	AslCoinvolte asl = listaAsl.get(kiave);
	%>
	<tr><td><%=lookupASL.getSelectedValue(asl.getId_asl()) %></td>
	<td><%=asl.getCampioni_pianificati() %></td><td><%=asl.getCampioni_eseguiti()%></td>
	<td><%=asl.getCu_pianificati()%></td><td><%=asl.getCu_eseguiti()%></td>
	
	</tr>
	<%
}

}
%>




</table>
