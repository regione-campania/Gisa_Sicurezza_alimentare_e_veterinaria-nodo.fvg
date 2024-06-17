<%@page import="org.aspcfs.modules.suap.base.Stabilimento"%>
<%@page import="org.aspcfs.modules.suap.base.CodiciRisultatoFrontEnd"%>
<%@page import="org.aspcfs.modules.suap.base.RisultatoValidazioneRichiesta"%>
<%@page import="java.util.HashMap"%>
<jsp:useBean id="EsitoValidazione" class="org.aspcfs.modules.suap.base.RisultatoValidazioneRichiesta" scope="request"/>

<%
if(EsitoValidazione.getIdRisultato()==CodiciRisultatoFrontEnd.SCIA_VALIDAZIONE_SCELTA_CANDIDATO ||
EsitoValidazione.getIdRisultato()==CodiciRisultatoFrontEnd.SCIA_VALIDAZIONE_CARICA_IMPORT_MULTIPO)
{
	%>
	<table cellpadding="8" cellspacing="0" border="0" width="100%" class="pagedList">
	<tr>
					<%if(EsitoValidazione.getIdRisultato()==CodiciRisultatoFrontEnd.SCIA_VALIDAZIONE_SCELTA_CANDIDATO ){ %>
					<th>&nbsp;</th>
					<%} %>
					<th>ID STAB.</th>
					<th>RAGIONE SOCIALE</th>
					<th>P.IVA</th>
					<th>CF</th>
					<th>N. REG</th>
					<th>COMUNE LEGALE</th>
					<th>IND. LEGALE</th>
					<th>COMUNE SEDE OP.</th>
					<th>IND. SEDE OP.</th>
				</tr>
	
	<%
	
	HashMap<Integer,Stabilimento> candidati = EsitoValidazione.getListaAnagraficheCandidate(); 
				  boolean primo = true;
				  for(Integer idStab : candidati.keySet() )
				  {
					    Stabilimento candidato = candidati.get(idStab);
					    
				  		String ragioneSociale = candidato.getRagioneSociale();
				  		String partitaIva = candidato.getPartitaIva();
				  		String cfRappresentante = candidato.getCfRappresentante();
				  		String numeroRegistrazione = candidato.getNumeroRegistrazione();
				  		String comuneSedeLegale = candidato.getComuneSedeLegale();
				  		String indirizzoSedeLegale = candidato.getIndirizzoSedeLegale();
				  		String comuneSedeOperativa = candidato.getComuneSedeOperativa();
				  		String indirizzoSedeOperativa = candidato.getIndirizzoSedeOperativa();
%>

<tr>

<%if(EsitoValidazione.getIdRisultato()==CodiciRisultatoFrontEnd.SCIA_VALIDAZIONE_SCELTA_CANDIDATO ){ %>

<td>
<input type="radio" name="candidato_scelto" value="<%=idStab%>" descrizione="<%=ragioneSociale %>" <%=primo ? "checked=\"checked\"" : ""%>>
</td>
<%} %>
<td><%=idStab%></td>
<td><%=ragioneSociale%></td>
<td><%=partitaIva%></td>
<td><%=cfRappresentante%></td>
<td><%=numeroRegistrazione%></td>
<td><%=comuneSedeLegale%></td>
<td><%=indirizzoSedeLegale%></td>
<td><%=comuneSedeOperativa%></td>
<td><%=indirizzoSedeOperativa%></td>
</tr>
<%
primo=false;
}
				  %>
				  </table>
				  <% 
}
%>









