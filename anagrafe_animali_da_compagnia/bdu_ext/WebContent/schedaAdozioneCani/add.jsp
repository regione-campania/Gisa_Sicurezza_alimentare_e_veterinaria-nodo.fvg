<%@page import="org.aspcfs.modules.schedaAdozioneCani.base.Indice"%>
<%@page import="org.aspcfs.modules.schedaAdozioneCani.base.Criterio"%>
<%@page import="org.aspcfs.modules.schedaAdozioneCani.base.SchedaAdozione"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@page import="org.aspcfs.modules.anagrafe_animali.base.Animale"%>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></script>
<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session" />
<jsp:useBean id="criteri" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="indici" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="animaleDettaglio" class="org.aspcfs.modules.anagrafe_animali.base.Animale" scope="request" />

<%
String param1 = "idAnimale=" + animaleDettaglio.getIdAnimale() + "&idSpecie=" + animaleDettaglio.getIdSpecie();
%>


<form method="post" name="form" id="form" action="SchedaAdozioneCaniAction.do?command=Add">

<input type="hidden" name="idAnimale" value="<%=animaleDettaglio.getIdAnimale()%>" />


<%@ include file="../initPage.jsp"%>
<dhv:container name="animale" selected="details"
		object="animaleDettaglio" param="<%=param1%>"
		appendToUrl='<%=addLinkParams(request, "popup|popupType|actionId")%>'>
		
		<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
		<tr class="containerBody">
				<th>CRITERIO</th>
				<th>INDICE</th>
				<th>PUNTEGGIO</th>
			</tr>
<%
		int i=0;
		while(i<criteri.size())
		{
			Criterio criterio = (Criterio)criteri.get(i);
%>
			<tr class="containerBody">
				<td><dhv:label name=""><%=criterio.getNome().toUpperCase()%></dhv:label></td>
				<td>
<%
					int j=0;
					while(j<indici.size())
					{
						Indice indice = (Indice)indici.get(j);
%>
							<input value="<%=indice.getId()%>" id="indice<%=criterio.getId()%>" name="indice<%=criterio.getId()%>" onclick="document.getElementById('punteggio<%=criterio.getId()%>').value='<%=indice.getPunteggio()%>';" type="radio"   /><%=indice.getNome().toUpperCase()%>
							<br/>
<%
						j++;
					}
%>
				</td>
				<td><input disabled="true" id="punteggio<%=criterio.getId()%>" type="text" name="punteggio" /></td>
			</tr>
<%
			i++;
		}
%>
			
		<tr class="containerBody">
			<td colspan="3">
				<input type="button" onclick="if(checkForm()){document.form.submit();}" value="Salva" />
			</td>
		</tr>
			

		</table>
		</dhv:container>
		</form>
		
		
		
		<script type="text/javascript">
			function checkForm()
			{
<%
				int j=0;
				while(j<criteri.size())
				{
					Criterio criterio = (Criterio)criteri.get(j);
%>
					if(document.getElementById('punteggio<%=criterio.getId()%>').value=='')
					{
						alert('Selezionare tutti gli indici');
						return false;
					}
					
<%
					j++;
				}
%>
				return true;
			}
		</script>