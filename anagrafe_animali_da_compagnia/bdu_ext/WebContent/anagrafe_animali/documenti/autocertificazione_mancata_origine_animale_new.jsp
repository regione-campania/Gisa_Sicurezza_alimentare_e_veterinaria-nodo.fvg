<!-- GESTIONE ORIGINE ANIMALE -->
<div class="clear1"></div>
<table width="100%"><tr><td>
<div style="margin-top: 0px;text-align:center;"><p style="font-size:12px"><b>DICHIARA LE SEGUENTI INFORMAZIONI SULLA PROVENIENZA DELL' ANIMALE</b></p></div>

<% 
boolean or=false;
if (thisAnimale.isFlagMancataOrigine()){ or=false; } 
if (eventoF.getProvenienza_origine()!=null && !eventoF.getProvenienza_origine().equals("")){  or=true; %>
	<div class="clear1"></div>
	<div class="nodott" style="margin-top: 0px;">- origine <%=(eventoF.getProvenienza_origine().contains("in") ? "in regione" : "fuori regione")%>,</div>
<% } %>
			
<% 
if(ApplicationProperties.getProperty("flusso_336_req2").equals("true"))
{
if(eventoF.getIdProprietarioProvenienza()>0 || (!("").equals(eventoF.getRagione_sociale_prov())&& eventoF.getRagione_sociale_prov()!=null) || ((!("").equals(eventoF.getMicrochip_madre())&& eventoF.getMicrochip_madre()!=null)  )) {  or=true; %>
	<div class="nodott" style="margin-top: 0px;"> proprietario:&nbsp;</div>	
	
	<div class="dott" style="margin-top: 0px;">
		<% Operatore proprietarioProvenienza = eventoF.getIdProprietarioProvenienzaOp();
		if (proprietarioProvenienza != null) {
			out.print(toHtml(proprietarioProvenienza.getRagioneSociale())); 
		}else{
		if (eventoF.getCodice_fiscale_proprietario_provenienza() != null && !("").equals(eventoF.getCodice_fiscale_proprietario_provenienza())) {
			out.print(toHtml(eventoF.getCodice_fiscale_proprietario_provenienza())); 
		}else{
			if (eventoF.getRagione_sociale_prov() != null && !("").equals(eventoF.getRagione_sociale_prov())) {
			out.print(toHtml(eventoF.getRagione_sociale_prov())); 
	
		}} %>

<%}%>
		</div>

<div class="nodott" style="margin-top: 0px;"> microchip madre:&nbsp;</div>
	<div class="dott" style="margin-top: 0px;">
	<%=eventoF.getMicrochip_madre()%>
	</div>
	
<% 
}}else{ 

if(eventoF.getIdProprietarioProvenienza()>0){  or=true; %>
	<div class="clear1"></div>
	<div class="nodott" style="margin-top: 0px;">- proprietario:&nbsp;</div>
	<div class="dott" style="margin-top: 0px;">
		<% Operatore proprietarioProvenienza = eventoF.getIdProprietarioProvenienzaOp();
		if (proprietarioProvenienza != null) {
			out.print(toHtml(proprietarioProvenienza.getRagioneSociale())); 
		}%></div>

<%}} %>




<% if (eventoF.getData_ritrovamento()!= null && !eventoF.getData_ritrovamento().equals("")){  or=true; %>
	<div class="clear1"></div>
	<div class="nodott" style="margin-top: 0px;">- ritrovamento in&nbsp;</div>
	<div class="dott_long" style="margin-top: 0px;"><% out.print(""+eventoF.getIndirizzo_ritrovamento()+", "+comuniList.getSelectedValue(Integer.parseInt(eventoF.getComune_ritrovamento()))+" - "+provinceList.getSelectedValue(Integer.parseInt(eventoF.getProvincia_ritrovamento()))); %></div>

	<div class="nodott" style="margin-top: 0px;"> in data </div>
	<div class="dott" style="margin-top: 0px;"><% out.print(eventoF.getData_ritrovamento()); %></div>
<% } %>

<% if(eventoF.isFlag_anagrafe_estera()){ or=true; %>
	<div class="clear1"></div>
	<div class="nodott" style="margin-top: 0px;">- nazione estera:&nbsp;</div>
	<div class="dott" style="margin-top: 0px;"><% out.print(nazioniList.getSelectedValue(Integer.parseInt(eventoF.getNazione_estera()))); %></div>
	<% if(eventoF.getNazione_estera_note()!=null && !eventoF.getNazione_estera_note().equals("")){ %>
		<div class="clear1"></div>
		<div class="nodott" style="margin-top: 0px;">Note:&nbsp;</div><div class="dott" style="margin-top: 0px;"><%	out.print(""+eventoF.getNazione_estera_note());%></div>
<% 		}
	}%>
			
<% if(eventoF.isFlag_anagrafe_fr()){ or=true;  %>
	<div class="clear1"></div>
	<div class="nodott" style="margin-top: 0px;">- anagrafe di altra regione:&nbsp;</div>
	<div class="dott" style="margin-top: 0px;"><% out.print(""+regioniList.getSelectedValue(Integer.parseInt(eventoF.getRegione_anagrafe_fr()))); %></div>
	<% if(eventoF.getRegione_anagrafe_fr_note()!=null && !eventoF.getRegione_anagrafe_fr_note().equals("")){ %>
		<div class="clear1"></div>
		<div class="nodott" style="margin-top: 0px;">Note:&nbsp;</div><div class="dott" style="margin-top: 0px;"><%	out.print(""+eventoF.getRegione_anagrafe_fr_note());%></div>
<% 		}
	} %>

<% if(eventoF.isFlag_acquisto_online()){ or=true;  %>
	<div class="clear1"></div>
	<div class="nodott" style="margin-top: 0px;">- pervenuto tramite sito web:&nbsp;</div>
	<div class="dott" style="margin-top: 0px;"><% out.print(eventoF.getSito_web_acquisto());	%></div>
	<% if(eventoF.getSito_web_acquisto_note()!=null && !eventoF.getSito_web_acquisto_note().equals("")){ %>
		<div class="clear1"></div>
		<div class="nodott" style="margin-top: 0px;">Note:&nbsp;</div><div class="dott" style="margin-top: 0px;"><%	out.print(""+eventoF.getSito_web_acquisto_note());%></div>
<% 	}
	} %> 
			
<!-- GESTIONE VECCHIA PROVENIENZA -->
<%
if (!or){
	if(thisAnimale.getIdSpecie() == Cane.idSpecie){   
		if(Cane.isFlagFuoriRegione() && Cane.getIdRegioneProvenienza() > -1){	or=true; %>
			<div class="clear1"></div>
			<div class="nodott" style="margin-top: 0px;">- anagrafe altra regione:&nbsp;</div>
			<div class="dott" style="margin-top: 0px;"><% out.print(""+regioniList.getSelectedValue(Cane.getIdRegioneProvenienza())); %></div>
			<% if(Cane.isFlagSindacoFuoriRegione()){ %>
			<div class="clear1"></div>
			<div class="nodott" style="margin-top: 0px;">Note:&nbsp;</div><div class="dott" style="margin-top: 0px;"><%=(Cane.isFlagSindacoFuoriRegione()) ? "Proprietario Sindaco" : ""%></div>
		<%}
		}
	} 
}%>

<% if(!or){ %>
	<script>document.getElementById("pr").style.display="none";</script>
	<div class="clear1"></div>
	<div class="nodott" style="margin-top: 0px;">Informazioni sull'origine dell'animale mancanti </div>
	<div class="clear1"></div>
<% } %> 
<br>
<div class="clear1"></div>

</td></tr></table>
