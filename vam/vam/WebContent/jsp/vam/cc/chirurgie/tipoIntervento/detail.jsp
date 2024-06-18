<%@page import="java.util.Iterator"%>
<%@page import="it.us.web.bean.vam.lookup.LookupTipologiaAltroInterventoChirurgico"%>
<%@page import="it.us.web.bean.vam.TipoIntervento"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<%
TipoIntervento tipoIntervento = (TipoIntervento)request.getAttribute("tipoIntervento");
%>

    <jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
    <h4 class="titolopagina">
     		Dettaglio Altro Intervento
    </h4>
    
    <table class="tabella">
    	
    	<tr>
        	<th colspan="3">
        		Informazioni preliminari
        	</th>
        </tr>
    	<tr>
    		<td>
    			 Data Richiesta:&nbsp;
    			 <fmt:formatDate type="date" value="${tipoIntervento.dataRichiesta}" pattern="dd/MM/yyyy" var="dataRichiesta"/> 		
    		</td>
    		<td colspan="2">
				 ${dataRichiesta}
    		</td>
		</tr>
		<tr class='odd'>
    		<td>
    			 Operatori
    		</td>
    		<td colspan="2">
				 ${tipoIntervento.operatori}
    		</td>
        </tr>
    </table>
    	
    	<table class="tabella">
    	<tr>
        	<th colspan="3">
        		Informazioni Aggiuntive
        	</th>
        </tr>
		<tr class='odd'>
        	<td>
        		Tipologia	
        	</td>
        	<td>
<% 	
				Boolean scriviVirgola=false;
				Iterator i = tipoIntervento.getTipologie().iterator();
				LookupTipologiaAltroInterventoChirurgico lta;
				while (i.hasNext())
				{
					lta = (LookupTipologiaAltroInterventoChirurgico)i.next();
					if (scriviVirgola)
					{
						out.println("<br/>");
						
					}  
					out.println(lta.getDescrizione());
					scriviVirgola=true;
				} 
%>     
        	</td>
        </tr>
        <tr class="even">
				<td>Inserito da</td>
				<td>${tipoIntervento.enteredBy} il <fmt:formatDate value="${tipoIntervento.entered}" pattern="dd/MM/yyyy"/></td>
			</tr>
			<c:if test="${tipoIntervento.modifiedBy!=null}">
			<tr class="even">
				<td>Modificato da</td><td>${tipoIntervento.modifiedBy} il <fmt:formatDate value="${tipoIntervento.modified}" pattern="dd/MM/yyyy"/></td>
			</tr>
			</c:if>
        <tr class='even'>
        <td style="width:50%">
				Note
		</td>
    	<td class="odd">
			${tipoIntervento.note}
		</td>
		</tr>
        <tr class='even'>
    		<td colspan="3">    		
    				<input type="button" value="Modifica" onclick="if(${cc.dataChiusura!=null}){ 
    				if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){attendere();location.href='vam.cc.chirurgie.tipoIntervento.ToEdit.us?idTipoIntervento=${tipoIntervento.id}'}
    				}else{attendere();location.href='vam.cc.chirurgie.tipoIntervento.ToEdit.us?idTipoIntervento=${tipoIntervento.id}'} ">
    			<input type="button" value="Lista altri interventi" onclick="attendere(), location.href='vam.cc.chirurgie.tipoIntervento.List.us'">
    		</td>
        </tr>
	</table>
