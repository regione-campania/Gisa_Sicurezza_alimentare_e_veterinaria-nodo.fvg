<%-- 
  - Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. DARK HORSE
  - VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id: accounts_search.jsp 18543 2007-01-17 02:55:07Z matt $
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page
	import="org.aspcfs.modules.base.Constants,org.aspcfs.utils.web.*, java.util.*"%>
<jsp:useBean id="SearchOrgListInfo"
	class="org.aspcfs.utils.web.PagedListInfo" scope="session" />
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>

<jsp:useBean id="MotivoAudit" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<jsp:useBean id="OggettoAudit" class="org.aspcfs.utils.web.LookupList"
	scope="request" />	
	
<jsp:useBean id="lookupTipologia"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="lookupASL" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
	<jsp:useBean id="lookupAudit" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<script type="text/javascript" src="dwr/interface/PopolaCombo.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>


<%@ include file="../utils23/initPage.jsp"%>
<script>


function mostraOggettoAudit(value)
{
	if (value=='22')
	{
		document.getElementById("tr_oggetto").style.display="none";
		document.getElementById("tr_motivo").style.display="none";
		document.getElementById("tr_auditFollowup").style.display="none";
		
		document.getElementById("searchexactauditTipo").value="-1";
		document.getElementById("searchcodeoggettoAudit").value="-1";
		
		
	}
	else
	{
			document.getElementById("tr_oggetto").style.display="";
			document.getElementById("tr_motivo").style.display="";
			document.getElementById("tr_auditFollowup").style.display="";
			document.getElementById('searchauditFollowupCb').checked=false;

	}
}
function doSubmit()
{
	formTest=true;
	array =$( "#searchgrouptipologia_struttura option:selected" );
	if (array.length>1)
		{
		for (i=0;i<array.length;i++)
			{
			if (array[i].value=="-1")
				{
				alert('Assicurarsi di non aver scelto la voce TUTTE insieme a una struttura');
				formTest = false;
				}
			}
		}
	
// 	if(document.searchAccount.searchcodeid_asl.value=='-1')
// 	{
// 		alert('Selezionare la struttura soggetta al controllo');
// 		formTest=false;
// 	}
	
	if (formTest==true){
		loadModalWindow();
		document.searchAccount.submit();
	}

}

// function doSubmitInserimentoCU(){
	
// 	var orgId = document.getElementById('searchcodeid_asl').value;
// 	if  (orgId == 891406) {
// 		idAsl = 201;
// 	}else if (orgId == 891407) {
// 		idAsl = 202;
// 	}else if(orgId == 891408){
// 		idAsl = 203;
// 	}else if(orgId == 891409){
// 		idAsl = 204;
// 	}else if(orgId == 891410){
// 		idAsl = 205;
// 	}else if(orgId == 891411){
// 		idAsl = 206;
// 	}else if(orgId == 891412){
// 		idAsl = 207;
// 	}else if(orgId == 1043661) {
// 		idAsl = 14;
// 	};
	
// 	if (orgId==-1){
// 		alert('Selezionare OPERATORE SOTTOPOSTO A CONTROLLO');
// 		return false;
// 	}
// 	document.searchAccount.action='OiaVigilanza.do?command=Add&idAsl='+idAsl;
// 	loadModalWindow();
// 	document.searchAccount.submit();
// }

function setComboNodi()
{
		

		idasl = document.getElementById('searchcodeid_asl').value ;
		anno = document.getElementById('searchexactanno').value ;
		PopolaCombo.getValoriComboStruttureOia(idasl,anno,setComboNodiCallBack);
	   
}

 function setComboNodiCallBack(returnValue)
 {
	 //alert ("returnValue: "+returnValue);
    	var select = document.getElementById("searchgrouptipologia_struttura"); //Recupero la SELECT
     

     //Azzero il contenuto della seconda select
     for (var i = select.length - 1; i >= 0; i--)
   	  select.remove(i);
    	
     
     /* Aggiunta TUTTE*/
     idasl = document.getElementById('searchcodeid_asl').value ;
     
     var NewOpt = document.createElement('option');
     NewOpt.value = -1; // Imposto il valore
     
     if (idasl > 0) {
     	NewOpt.text ='Tutte'; // Imposto il testo
     	NewOpt.title = 'Tutte';
     	}
     else {
      	NewOpt.text ='LISTA UNITA COMPLESSE'; // Imposto il testo
      	NewOpt.title = 'LISTA UNITA COMPLESSE';
      }
     
     try { 
  		select.add(NewOpt, null); //Metodo Standard, non funziona con IE
  		} catch(e){
	    select.add(NewOpt); // Funziona solo con IE
  		}
     
     indici = returnValue [0];
     valori = returnValue [1];
     //Popolo la seconda Select
     if (indici.length==0)
     {
    	
      }
     else
     {
     for(j =0 ; j<indici.length; j++){
     //Creo il nuovo elemento OPTION da aggiungere nella seconda SELECT
     var NewOpt = document.createElement('option');
     NewOpt.value = indici[j]; // Imposto il valore
     if(valori[j] != null)
     	NewOpt.text = valori[j]; // Imposto il testo
     	NewOpt.title = valori[j];
     //Aggiungo l'elemento option
     try
     {
   	  	select.add(NewOpt, null); //Metodo Standard, non funziona con IE
     }catch(e){
   	  select.add(NewOpt); // Funziona solo con IE
     }
     }

     }


 }


</script>
<form name="searchAccount" action="Oia.do?command=ViewVigilanza" method="post">
<%-- Trails --%>

<table class="trails" cellspacing="0">
	<tr>
		<td><a href="Oia.do?command=Home">Autorità Competenti</a>
		> Ricerca</td>
	</tr>
</table>
<%-- End Trails --%>

  
<font color="red" size="3px">&nbsp;&nbsp;&nbsp; Per l'inserimento di un AUDIT / SUPERVISIONE MEDIANTE SIMULAZIONE non va selezionato un tipo audit / simulazione come filtro di ricerca <br/>
&nbsp;&nbsp;&nbsp;  ma occorre ricercare solo la struttura a cui associare il controllo. </font>
 
 
<table cellpadding="2" cellspacing="2" border="0" width="100%">
	<tr>
		<td width="50%" valign="top">

		<table cellpadding="4" cellspacing="0" border="0" width="100%"
			class="details">
			<tr>
				<th colspan="2">Informazioni Primarie del soggetto controllato</th>
			</tr>
			
			<tr> <td class="formLabel">Anno</td> 
		<td>
		
		<% int year = Calendar.getInstance().get(Calendar.YEAR); %>
		<select name = "searchexactanno" id = "searchexactanno">
		<% for (int i = year; i>= 2010; i--) { %>
		<option value="<%=i%>" <%=i==year ? "selected" : "" %>><%=i %></option>
		<% } %>
		</select>
		</td>
		</tr>
			
			<tr >
				<td  class="formLabel">Operatore sottoposto a controllo</td>
				<td>
				<%
				
				lookupASL.setJsEvent("onChange='setComboNodi()'");
				
				if (User.getSiteId()>0)
				{
				%>
					<%=lookupASL.getHtmlSelect("searchcodeid_asl",-1) %>
				<%}else
					{%>
				<%=lookupASL.getHtmlSelect("searchcodeid_asl",-1) %>
				<%} %>
					<%lookupTipologia.removeAll(lookupTipologia);
					lookupTipologia.setMultiple(true);
					lookupTipologia.setSelectSize(7);
					lookupTipologia.addItem(-1,"Lista Unita Complesse");
					%>
<!-- 			    <input type="button" onclick='doSubmitInserimentoCU()'	value="Inserisci Controllo Ufficiale">		 -->
				</td>
				
			</tr>
			<tr> <td class="formLabel">Strutture Controllate</td> 
			 
		<td><%=lookupTipologia.getHtmlSelect("searchgrouptipologia_struttura",-1) %>
		&nbsp;	
<font color="red">Attenzione! Di seguito sono riportate tutte le strutture presenti nello strumento di calcolo per cui è stato eseguito il "Salva e Chiudi".<br>
Qualora non fossero presenti le strutture desiderate, controllare che figurino correttamente nello strumento di calcolo e che quest'ultimo sia stato Salvato/Chiuso.
</font>
		
	
		
		</td>
		</tr>
			
		
		<tr> <td class="formLabel">Tecnica di controllo</td> 
		<td>
		<%lookupAudit.setJsEvent("onchange='mostraOggettoAudit(this.value);'"); %>
		<%=lookupAudit.getHtmlSelect("searchexactaudit",-1) %></td>
		</tr>
		
		<tr id="tr_motivo"> <td class="formLabel">Motivo Audit</td> 
		<td><%=MotivoAudit.getHtmlSelect("searchexactauditTipo",-1) %></td>
		</tr>
		
		<tr id="tr_oggetto"> <td class="formLabel">Campo dell'Audit</td> 
<%-- 		<td><%=OggettoAudit.getHtmlSelect("searchcodeoggettoAudit",-1) %></td> --%>
		<%
			OggettoAudit.setMultiple(true);
			OggettoAudit.setSelectSize(9);
       
       	%>
		<td><%=OggettoAudit.getHtmlSelect("searchgroupoggetto_audit",-1) %>
		
		</tr>
			
	    <tr id = "tr_auditFollowup">
        <td class = "formLabel">Audit di follow up?</td>
         <td><input type="checkbox" id="searchauditFollowupCb" name="searchauditFollowupCb"/>
		</td>
	   </tr>

		</table>
		</td>
	</tr>

</table>

<input type="button" onclick='doSubmit()'
	value="Ricerca">
	
	
	</form>


