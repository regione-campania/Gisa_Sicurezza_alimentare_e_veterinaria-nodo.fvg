
<%@page import="org.aspcfs.modules.opu.base.LineaProduttiva"%>
<jsp:useBean id="ServizioCompetente" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="LookupTipoAttivita" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Carattere" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ComuniList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TipoStruttura" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ListaStati" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Operatore" class="org.aspcfs.modules.opu.base.Operatore" scope="request"/>
<jsp:useBean id="StabilimentoDettaglio" class="org.aspcfs.modules.opu.base.Stabilimento" scope="request"/>
<%@ include file="../utils23/initPage.jsp"%>

<br/>
<%
int idTipoAttivita = -1 ;
			int idCarattere= -1 ;
			int serviziocompetente = -1 ;
			String codInterno = "" ;
			String dataPResentazione = "" ;
			boolean isflagVendita=false ; 
			if (StabilimentoDettaglio.getListaLineeProduttive().size()>0)
			{
				idTipoAttivita = ((LineaProduttiva)StabilimentoDettaglio.getListaLineeProduttive().get(0)).getInfoStab().getTipoAttivita();
				idCarattere = ((LineaProduttiva)StabilimentoDettaglio.getListaLineeProduttive().get(0)).getInfoStab().getCarattere();
				serviziocompetente = ((LineaProduttiva)StabilimentoDettaglio.getListaLineeProduttive().get(0)).getInfoStab().getServizioCompetente();
				codInterno = ((LineaProduttiva)StabilimentoDettaglio.getListaLineeProduttive().get(0)).getInfoStab().getCodice_interno();
				dataPResentazione = ((LineaProduttiva)StabilimentoDettaglio.getListaLineeProduttive().get(0)).getInfoStab().getDataPresentazioneSciaString();
				isflagVendita = ((LineaProduttiva)StabilimentoDettaglio.getListaLineeProduttive().get(0)).getInfoStab().isFlag_vendita_canili();
			}
			%>
<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="details">
	<tr>
		<th colspan="2">>Informazioni Stabilimento</strong></th>
	</tr>
  
  
  	<tr>
			<td class="formLabel" nowrap>
				Tipo Attivita
			</td>
			<td>
			
			<%= LookupTipoAttivita.getSelectedValue(idTipoAttivita) %>
			</td>
		</tr>
		
		<tr>
			<td class="formLabel" nowrap>
				Carattere
			</td>
			<td>
			<%= Carattere.getSelectedValue(idCarattere) %>
			</td>
		</tr>
		
		
		<%if (idCarattere== 1){ %>
		<tr id = "dal" style="display: none">
			<td class="formLabel" nowrap>
				DaL
			</td>
			<td>
			
			
        
			</td>
		</tr>
		
		<tr id = "al" style="display: none">
			<td class="formLabel" nowrap>
				AL
			</td>
			<td>
			
			
			</td>
		</tr>
	<%} %>
		
		<tr>
			<td class="formLabel" nowrap>
				Servizio Competente
			</td>
			<td>
				<%= ServizioCompetente.getSelectedValue(serviziocompetente) %>
			</td>
		</tr>
   <dhv:evaluate if="<%=(!"".equalsIgnoreCase(dataPResentazione))%>">
  
      <tr>
    <td class="formLabel" nowrap>
      Data Presentazione Dia / Inizio Attivita
    </td>
    <td>
     <%=	toHtmlValue(dataPResentazione) %>
    </td>
  </tr>
  </dhv:evaluate>
       <tr >
    <td class="formLabel" nowrap>
      Codice Registrazione
    </td>
    <td>
     <%=	toHtmlValue(codInterno) %>
    </td>
  </tr>
  
     <dhv:evaluate if="<%=(isflagVendita==true)%>">
  
       <tr >
    <td class="formLabel" nowrap>
      Vendita con canali non convenzionali
    </td>
    <td>
     	<input type = "checkbox" disabled="disabled" value = "1" name = "flag_vendita" <%if(isflagVendita){%>checked="checked"<%} %>>
    </td>
  </tr>
  </dhv:evaluate>
    <tr >
    <td class="formLabel" nowrap>
      Categoria Rischio
    </td>
    <td>
     <%=	StabilimentoDettaglio.getCategoriaRischio()%>
    </td>
  </tr>
    <tr >
    <td class="formLabel" nowrap>
      ProssimoControllo
    </td>
    <td>
     <%= ( StabilimentoDettaglio.getDataProssimoControllo()!=null )? ""+ StabilimentoDettaglio.getDataProssimoControllo() :"" %>
    </td>
  </tr>
  

       <dhv:evaluate if="<%=(!"".equalsIgnoreCase(codInterno)
    		   && !"null".equalsIgnoreCase(codInterno)
    		   && codInterno != null
    		   )%>">
  
  
	<tr>
		<td class="formLabel" nowrap>Codice Impresa Interno</td>
		<td><%=codInterno %></td>

	</tr>	
	</dhv:evaluate>
	</table>
	<br>