<%@page import="it.us.web.bean.vam.Trasferimento"%>
<%@page import="it.us.web.bean.vam.Animale"%>
<%@page import="it.us.web.constants.Specie"%>
<%@page import="it.us.web.bean.vam.lookup.LookupPersonaleInterno"%>
<%@page import="java.util.List"%>
<%@page import="it.us.web.bean.SuperUtente"%>
<%@page import="it.us.web.constants.IdOperazioniBdr"%>
<%@page import="it.us.web.constants.IdRichiesteVarie"%>
<%@page import="it.us.web.util.vam.AnimaliUtil"%>
<%@page import="it.us.web.bean.vam.AnimaleAnagrafica"%>
<%@page import="it.us.web.bean.vam.lookup.LookupMantelli"%>
<%@page import="it.us.web.bean.vam.lookup.LookupRazze"%>
<%@page import="it.us.web.bean.vam.lookup.LookupTaglie"%>
<%@page import="it.us.web.constants.SpecieAnimali"%>
<%@page import="it.us.web.bean.vam.CartellaClinica"%>
<%@page import="java.util.Date"%>
<%@page import="it.us.web.util.vam.RegistrazioniUtil"%>
<%@page import="java.util.Iterator"%>
<%@page import="it.us.web.bean.vam.lookup.LookupOperazioniAccettazione"%>
<%@page import="it.us.web.bean.vam.Accettazione"%>
<%@page import="it.us.web.bean.BUtente"%>
<%@page import="it.us.web.util.vam.CaninaRemoteUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="it.us.web.bean.vam.Trasferimento"%>

<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/fn.tld" prefix="fn" %>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<script type='text/javascript' src='dwr/engine.js'></script>
<script type='text/javascript' src='dwr/interface/TestBdr.js'></script>
<script type='text/javascript' src='dwr/util.js'></script>

<script language="JavaScript" type="text/javascript" src="js/vam/accettazione/smaltimentoCarogna.js"></script>

<h4 class="titolopagina">
     Dettaglio Modifica 
</h4> 



<table class="tabella" style="width: 99%">

		<c:forEach items="${modifica.modifiche}" var="m">
			<tr><th colspan="2">${m.bean}</th></tr>
			<c:set var="modifiche2" value="${fn:split(m.modifiche, '&&&&&&')}" />
			<c:set var="i" value='1' />
			<c:forEach items="${modifiche2}" var="m2">
				<c:set var="m3" value="${fn:split(m2, '||||||')}" />
				<tr class="${i % 2 == 0 ? 'odd' : 'even'}">
					<td>
						${m3[0]}
					</td>
					<td>
						${m3[1]}
					</td>
				</tr>
				<c:set var="i" value='${i+1}' />
			</c:forEach>
		</c:forEach>

</table>

 



