<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>

<%@page import="org.aspcfs.modules.stabilimenti.base.PermessoVisibilitaStabilimenti"%>
<%@page import="org.aspcfs.utils.web.LookupElement"%><jsp:useBean id="StatiStabilimenti" class="org.aspcfs.utils.web.LookupList" scope="request" />

<%
ArrayList<PermessoVisibilitaStabilimenti> lista_permessi = (ArrayList<PermessoVisibilitaStabilimenti>) request.getAttribute("lista_permessi");
%>

<form method="post" action="Stabilimenti.do?command=SavePermessiVisibilita">
<br/>
<table class = "details">
<tr>
<th>Ruolo</th>
<th colspan="<%=lista_permessi.size() %>">Visibilità su Stati</th>
</tr>
<tr class = "containerBody">
<td>&nbsp;</td>
<input type = "hidden" name = "numRuoli" value = "<%=lista_permessi.size() %>"/>
<input type = "hidden" name = "numStati" value = "<%=StatiStabilimenti.size() %>"/>
<%

for(int i = 0 ; i <StatiStabilimenti.size(); i++)
{
	LookupElement tmp = (LookupElement)StatiStabilimenti.get(i) ;
	if(tmp.getCode()!=0)
	{
%>
<td><%=tmp.getDescription() %></td>
<%		
}
}
%>
</tr>
<%
int indiceRuolo = 0 ;
for(PermessoVisibilitaStabilimenti permesso : lista_permessi)
{
	%>
	<tr>
	<td class = "formLabel">
		<input type = "hidden" name = "ruolo_<%=indiceRuolo %>" value = "<%=permesso.getIdRuolo() %>">
		<%=permesso.getDescrizioneRuolo() %>
	</td>
	<%
		for(int i = 0; i<StatiStabilimenti.size(); i++)
		{
			LookupElement tmp = (LookupElement)StatiStabilimenti.get(i) ;
			if(tmp.getCode()!=0)
			{
			%>
			<td>
				<input type="checkbox" name="permesso_<%=indiceRuolo %>_<%=i %>" <%if(permesso.getLista_stati().contains(tmp.getCode())){ %>checked="checked" <%} %> value="<%=tmp.getCode() %>">
			</td>
			<%
			}
		}
	
	%>
	
	</tr>
	
	
	<%
	indiceRuolo ++ ;
}
%>
</table>
<input type = "submit" value = "Salva">
</form>
