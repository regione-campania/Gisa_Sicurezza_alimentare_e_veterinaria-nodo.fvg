<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>

<input type="button" value="Home" onclick="attendere(), location.href='Home.us'">

<h4 class="titolopagina">
     		Lista Segnalazioni
</h4>
 	    			 
<div class="area-contenuti-2">
	<form action="vam.helpDesk.List.us" method="post">
				
		<jmesa:tableModel items="${t}" id="tt" var="tt" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>
					<jmesa:htmlColumn filterable="false" property="id" title="Numero Segnalazione"/>
											
					<jmesa:htmlColumn filterEditor="org.jmesa.view.html.editor.DroplistFilterEditor"  property="stato" 	title="Stato"/>	
										
					<jmesa:htmlColumn property="entered" 	title="Data di apertura" filterEditor="it.us.web.util.jmesa.DateFilterEditor">
						<fmt:formatDate value="${tt.entered}" pattern="dd/MM/yyyy" var="dataApertura"/>
    			 		<c:out value="${dataApertura}"></c:out>					
					</jmesa:htmlColumn>
										
					<jmesa:htmlColumn property="enteredBy" 	title="Aperto da"/>
					
					<jmesa:htmlColumn filterEditor="org.jmesa.view.html.editor.DroplistFilterEditor"  sortable="false" property="lookupTickets.description" 	title="Tipologia segnalazione"/>
											
					<jmesa:htmlColumn filterable="false" 	sortable="false"			title="Dettaglio Segnalazione">
							<a href="vam.helpDesk.Detail.us?idTicket=${tt.id}">Vai al dettaglio</a>										
					</jmesa:htmlColumn>
					
				</jmesa:htmlRow>
			</jmesa:htmlTable>
		</jmesa:tableModel>
	</form>
	
	<script type="text/javascript">
		function onInvokeAction(id)
		{
			setExportToLimit(id, '');
			createHiddenInputFieldsForLimitAndSubmit(id);
		}
		function onInvokeExportAction(id)
		{
			var parameterString = createParameterStringForLimit(id);
			location.href = 'vam.helpDesk.List.us?' + parameterString;
		}
	</script>
</div>