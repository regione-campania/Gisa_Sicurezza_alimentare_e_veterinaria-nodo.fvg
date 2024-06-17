<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>

<jsp:useBean id="newStabilimento" class="org.aspcfs.modules.opu.base.Stabilimento" scope="request" />
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup.js"></SCRIPT>


<SCRIPT LANGUAGE="JavaScript" ID="js19">
	var cal19 = new CalendarPopup();
	cal19.showYearNavigation();
	cal19.showYearNavigationInput();
	cal19.showNavigationDropdowns();
</SCRIPT>
<script>
function popUp(url) 
{
	  title  = '_types';
	  width  =  '500';
	  height =  '600';
	  resize =  'yes';
	  bars   =  'yes';
	  var posx = (screen.width - width)/2;
	  var posy = (screen.height - height)/2;
	  var windowParams = 'WIDTH=' + width + ',HEIGHT=' + height + ',RESIZABLE=' + resize + ',SCROLLBARS=' + bars + ',STATUS=0,LEFT=' + posx + ',TOP=' + posy + 'screenX=' + posx + ',screenY=' + posy;
	  var newwin=window.open(url, title, windowParams);
	  newwin.focus();
	  if (newwin != null) 
	  {
	    	if (newwin.opener == null)
	      		newwin.opener = self;
	  }
	}
</script>
	<table class="trails" cellspacing="0">
		<tr>
			<td width="100%">
			<dhv:label name=""><a href="<%=newStabilimento.getAction()+".do?command=SearchForm" %>" >Anagrafica Stabilimenti </a>-><a  href="<%=newStabilimento.getAction()+".do?command=Details&stabId="+newStabilimento.getIdStabilimento()%>">Scheda Impresa</a> ->Variazione Linee Produttive</dhv:label>
			</td>
		</tr>
	</table>


<%
String param = "stabId="+newStabilimento.getIdStabilimento()+"&opId=" + newStabilimento.getIdOperatore();
%>
<%
String nomeContainer = newStabilimento.getContainer();

request.setAttribute("Operatore",newStabilimento.getOperatore());
%>
<dhv:container name="<%=nomeContainer %>"  selected="variazioneLineeProuttive" object="Operatore" param="<%=param%>" >


<form method="post" action="<%=newStabilimento.getAction()%>.do?command=UpdateLineaProduttiva">
<input type = "hidden" name = "stabId"  id = "stabId" value = <%=newStabilimento.getIdStabilimento() %> />
<input type = "hidden" name = "doContinueStab" id = "doContinueStab" value ="true"/>

<input type = "hidden" id = "opId" name = "opId" value = <%=newStabilimento.getIdOperatore() %> />
<jsp:include page="./opu_linee_attivita_add.jsp" flush="true" />

<input type = "submit" value = "Salva">
</form>
</dhv:container>