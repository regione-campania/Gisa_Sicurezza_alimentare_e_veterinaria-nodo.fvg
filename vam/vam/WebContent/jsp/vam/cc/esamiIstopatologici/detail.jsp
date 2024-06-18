<%@page import="it.us.web.util.properties.Application"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>


<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
<h4 class="titolopagina">
     		Dettaglio Esame
</h4>		 

<c:set var="tipo" scope="request" value="stampaIstoSingolo"/>
<c:set var="idEsame" scope="request" value="${esame.id }"/>
<c:import url="../../jsp/documentale/home.jsp"/>
<!-- input type="button" value="Stampa JSP" onclick="location.href='vam.cc.esamiIstopatologici.StampaIstoSingolo.us?id=${esame.id }'"-->
<!-- input type="button" value="Stampa la richiesta" onclick="location.href='vam.cc.esamiIstopatologici.Pdf.us?id=${esame.id }'" /-->
<input type="button" value="Immagini" onclick="javascript:avviaPopup( 'vam.cc.esamiIstopatologici.GestioneImmagini.us?id=${esame.id }&cc=${cc.id}' );" />
<c:if test="${esame.outsideCC==false}">
<c:choose>
	<c:when test="${cc!=null}">
		<input type="button" value="Necroscopia" onclick="javascript:if(${cc.autopsia!=null}){avviaPopup( 'vam.cc.autopsie.DetailDaIsto.us?idCc=${cc.id}' );}else{if(${cc.accettazione.animale.necroscopiaNonEffettuabile==false}){alert('Necroscopia non inserita');}else{alert('Necroscopia dichiarata come non effettuabile');}}" />
	</c:when>
	<c:otherwise>
		<input type="button" value="Necroscopia" onclick="javascript:if(${esame.cartellaClinica.autopsia!=null}){avviaPopup( 'vam.cc.autopsie.DetailDaIsto.us?idCc=${esame.cartellaClinica.id}' );}else{if(${esame.cartellaClinica.accettazione.animale.necroscopiaNonEffettuabile==false}){alert('Necroscopia non inserita');}else{alert('Necroscopia dichiarata come non effettuabile');}}" />			
	</c:otherwise>
</c:choose>
</c:if>
<c:choose>
	<c:when test="${utente.ruolo!='IZSM' && utente.ruolo!='Universita' && utente.ruolo!='6' && utente.ruolo!='8'}">
								
		<input type="button" value="Modifica" onclick="if(${cc.dataChiusura!=null}){ 
			    				if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){attendere();location.href='vam.cc.esamiIstopatologici.ToAdd.us?modify=on&idEsame=${esame.id}';}
	    						}else{attendere();location.href='vam.cc.esamiIstopatologici.ToAdd.us?modify=on&idEsame=${esame.id}';}" />
	</c:when>
	<c:otherwise>
		<input type="button" value="Inserisci Esito" onclick="if(${cc.dataChiusura!=null}){ 
			    				if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?'))
			    				{
			    					attendere();location.href='vam.cc.esamiIstopatologici.ToAdd.us?modify=on&idEsame=${esame.id}&editIzsm=on';
			    				}
	    						}else{attendere();location.href='vam.cc.esamiIstopatologici.ToAdd.us?modify=on&idEsame=${esame.id}&editIzsm=on';}" />
	</c:otherwise>
</c:choose>
<input type="button" value="Lista Richieste Esami Istopatologici" onclick="attendere();location.href='vam.cc.esamiIstopatologici.List.us'">


<table class="tabella">
    	
        <tr>
    		<th colspan="2">
    			Esame numero ${esame.numero }	
    		</th>
    	</tr>
    	
    	<tr class='odd'>
    		<td>
    			 Laboratorio di destinazione
    		</td>
    		<td>
    			 ${esame.lass.description}
    			 <c:if test="${esame.lass.id==19}">
    			 	: ${esame.laboratorioPrivato} 
    			 </c:if>
    		</td>
    		<td>
    		</td>
        </tr>

		<tr class="even">
    		<td>
    			 Numero rif. Mittente
    		</td>
    		<td>
				 ${esame.numeroAccettazioneSigla}
    		</td>
    		<td>
    		</td>
        </tr>
        
		<tr class="odd">
    		<td style="width:30%">
    			 Tipo Prelievo
    		</td>
    		<td style="width:70%">  
    			${esame.tipoPrelievo.description }
    		</td>
        </tr> 
        
        <tr class="odd">
    		<td style="width:30%">
    			 Sede Lesione e Sottospecifica
    		</td>
    		<td style="width:70%">  
    			${esame.sedeLesione }  
    		</td>
        </tr> 
        
        
         <%
        //Abilitazione 287
		if(Application.get("flusso_287").equals("true"))
		{
		%>
		
        <tr class="odd">
    		<td style="width:30%">
    			 Tumore
    		</td>
    		<td style="width:70%">  
    			${esame.tumore.description }
    		</td>
        </tr> 
        
        
          
        
       
        
        
        <tr class="odd">
    		<td style="width:30%">
    			 Trattamenti ormonali
    		</td>
    		<td style="width:70%">  
    			${esame.trattOrm}
    		</td>
        </tr> 
        
        <tr class="odd">
    		<td style="width:30%">
    			 Stato generale
    		</td>
    		<td style="width:70%">  
    			${esame.statoGenerale} ${esame.statoGeneraleLookup}
    		</td>
        </tr>   
        
        <%
}
%>

        <tr>
    		<td style="width:30%">
    			 Tumori Precedenti
    		</td>
    		<td style="width:70%"> 
    			${esame.tumoriPrecedenti.description }  
    		</td>
        </tr>    
        
    <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t || esame.n || esame.m || esame.dataDiagnosi!=null || esame.diagnosiPrecedente)}">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente}
    		</td>
        </tr>  
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m }  
    		</td>
        </tr> 
    </c:if>
    
    
    <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t1 || esame.n1 || esame.m1 || esame.dataDiagnosi1!=null || esame.diagnosiPrecedente1)}">
         <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi1}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente1}  
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t1 }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n1 }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m1 }  
    		</td>
        </tr> 
    </c:if>
    
     <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t2 || esame.n2 || esame.m2 || esame.dataDiagnosi2!=null || esame.diagnosiPrecedente2)}">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi2}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente2}  
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t2 }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n2 }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m2 }  
    		</td>
        </tr> 
    </c:if>
    
     <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t3 || esame.n3 || esame.m3 || esame.dataDiagnosi3!=null || esame.diagnosiPrecedente3)}">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi3}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente3}  
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t3 }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n3 }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m3 }  
    		</td>
        </tr> 
    </c:if>
     <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t4 || esame.n4 || esame.m4 || esame.dataDiagnosi4!=null || esame.diagnosiPrecedente4)}">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi4}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente4}  
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t4 }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n4 }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m4 }  
    		</td>
        </tr> 
    </c:if>
    
    <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t5 || esame.n5 || esame.m5 || esame.dataDiagnosi5!=null || esame.diagnosiPrecedente5)}">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi5}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente5}  
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t5 }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n5 }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m5 }  
    		</td>
        </tr> 
    </c:if>
        
        <tr class="odd">
    		<td style="width:30%" >
    			 Dimensione (centimetri)
    		</td>
    		<td style="width:70%"> 
    			${esame.dimensione }
    		</td>
        </tr> 
        
        <tr>
    		<td style="width:30%">
    			 Interessamento Linfonodale
    		</td>
    		<td style="width:70%">  
    			${esame.interessamentoLinfonodale.description }  
    		</td>
        </tr> 
        
        <tr>
        	<th colspan="2">
        		Risultato
        	</th>
        </tr>
        <tr class="odd">
    		<td style="width:30%">
    			 Data Esito
    		</td>
    		<td style="width:70%">  
    			<fmt:formatDate type="date" value="${esame.dataEsito}" pattern="dd/MM/yyyy" /> 
    		</td>
        </tr>
        <tr>
    		<td style="width:30%">
    			 Descrizione Morfologica
    		</td>
    		<td style="width:70%">  
    			${esame.descrizioneMorfologica }  
    		</td>
        </tr>
        
        <tr class="odd">
    		<td style="width:30%">
    			 Diagnosi
    		</td>
    		<td style="width:70%">  
    			<c:if test="${esame.tipoDiagnosi.description!='- Seleziona -' && esame.tipoDiagnosi.description!=''}">
    				${esame.tipoDiagnosi.description }: ${esame.whoUmana } <c:if test="${esame.tipoDiagnosi.id==3}">${esame.diagnosiNonTumorale }</c:if> 
    			</c:if>
    			
    		</td>
        </tr> 
     </table>
    	<table class="tabella">
			<tr>
				<th colspan="3">
				       		Altre Informazioni
				 </th>
			 </tr> 	  
			<tr class="odd">
				<td>Inserito da</td>
				<td>${esame.enteredBy} il <fmt:formatDate value="${esame.entered}" pattern="dd/MM/yyyy"/></td>
			</tr>
			<c:if test="${esame.modifiedBy!=null}">
			<tr class="even">
				<td>Modificato da</td><td>${esame.modifiedBy} il <fmt:formatDate value="${esame.modified}" pattern="dd/MM/yyyy"/></td>
			</tr>
			</c:if>
		</table>
 
