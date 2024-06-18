<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>
<%@ page
	import="java.util.*,org.aspcfs.modules.opu.base.*,org.aspcfs.modules.base.*,org.aspcfs.modules.registrazioniAnimali.base.*"%>

<jsp:useBean id="listaRegistrazioni"
	class="org.aspcfs.modules.opu.base.RegistrazioniOperatoreList" scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean"
	scope="session" />
<jsp:useBean id="registrazioniListInfo"
	class="org.aspcfs.utils.web.PagedListInfo" scope="session" />

<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>



<script src="https://code.jquery.com/jquery-1.8.2.js"></script>
<script src="https://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>

<script type="text/javascript">
//Per filtrare cessioni da asl di ingresso
function changeAsl(){
	
	$("#getRegistrazioni").attr("action", "OperatoreAction.do?command=ListaModificheIndirizzoIngressoAsl" );
	$("#getRegistrazioni").submit();
	
}
</script>


<dhv:evaluate if="<%=!isPopup(request)%>">
	<%-- Trails --%>
	<table class="trails" cellspacing="0">
		<tr>
			<td>
				<dhv:label name="">Registrazioni di modifica in ingresso</dhv:label>
		</td>
		</tr>
	</table>
	<%-- End Trails --%>
</dhv:evaluate>
<dhv:pagedListStatus title='<%= showError(request, "actionError") %>' object="registrazioniListInfo"/>

<form name="getRegistrazioni" id="getRegistrazioni"
	action="OperatoreAction.do?command=ListaModificheIndirizzoIngressoAsl&auto-populate=true<%=addLinkParams(request, "popup|popupType|actionId")%>"
	method="post">

<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<tr>
		<!--  th>
        &nbsp;
      </th--> <%int numeroCessioniAutomatiche = 0; %>
      				<%
      				AslList
								.setJsEvent("onChange=\"javascript:changeAsl();\"");
				%>
 				
   Filtra per asl origine:   <%=AslList.getHtmlSelect("searchcodeidAslOrigine", listaRegistrazioni.getIdAslOrigine())  %>


		<th width="5%" valign="center" align="left"><strong>Identificativo</strong>
		</th>
		<th><b><dhv:label name="">Data inserimento in BDU</dhv:label></b></th>
		<th><b><dhv:label name="">Data della registrazione</dhv:label></b></th>
		<th width="15%"><b><dhv:label name="">Proprietario</dhv:label></b>
		</th>
	</tr>
	<%
		Iterator j = listaRegistrazioni.iterator();
		if (j.hasNext()) {
			// int rowid = 0;
			int i = 0;
			while (j.hasNext()) {
				i++;
				//  rowid = (rowid != 1?1:2);
				RegistrazioneOperatore thisEvento = (RegistrazioneOperatore) j.next();
	%>
	<tr class="">

     

									


		<td><%=toDateasString(thisEvento.getEntered())%>&nbsp;</td>
		<td><%=toDateasString(thisEvento
											.getDataRegistrazione())%>&nbsp;</td>
		<td>
		<%
			Operatore proprietario = thisEvento
							.getIdProprietarioOriginarioRegistrazione();
					if (proprietario != null) {
						Stabilimento stab = (Stabilimento) (proprietario
								.getListaStabilimenti().get(0));
						LineaProduttiva linea = (LineaProduttiva) (stab
								.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=AggiungiRegistrazioni&opId=<%=linea.getId()%>&popup=false&modulo=accettazione"><%=toHtml(proprietario
												.getRagioneSociale())%>&nbsp;</a> <!-- a href="LineaProduttivaAction.do?command=Details&lineaId=<%=linea.getId()%>"><%=toHtml(proprietario
												.getRagioneSociale())%></a--> <%
 	} else {
 %> -- <%
 	}
 %> 		</td>
	
		<td><%=AslList.getSelectedValue(thisEvento.getIdAslInserimentoRegistrazione())%></td>
	</tr>

	<%
		}
	%>
	<%
		} else {
	%>
	<tr class="containerBody">
		<td colspan="9"><dhv:label name="">Nessuna registrazione individuata.</dhv:label>
		</td>
	</tr>
	<%
		}
	%>
</table>
</br>
</br>
</form>
<br>

<dhv:pagedListControl object="registrazioniListInfo" />
