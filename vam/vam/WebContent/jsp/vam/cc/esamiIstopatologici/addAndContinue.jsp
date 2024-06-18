<%@page import="it.us.web.util.properties.Application"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@page import="java.util.Date"%>
<script language="JavaScript" type="text/javascript" src="js/vam/cc/esamiIstopatologici/addAndContinue.js"></script>


<form action="vam.cc.esamiIstopatologici.Add.us" name="form" id="form" method="post" class="marginezero" onsubmit="javascript:return checkform(this)">    

    <jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
    
    <h4 class="titolopagina">
		<c:if test="${!modify }" >     
			Nuova Richiesta Esame Istopatologico
		</c:if>
    </h4>	 
    
    <table class="tabella">
        <tr>
        	<th colspan="2">
        		Richiesta
        	</th>
        </tr>
    	<tr class="odd">
    		<td>
    			Data Richiesta<font color="red"> *</font>
    		</td>
    		<td style="width:50%">    			 
    			 <fmt:formatDate type="date" value="${esame.dataRichiesta}" pattern="dd/MM/yyyy" var="data"/>
    			 ${data}
    			 <input type="hidden" name="dataRichiesta" value="${data}" /> 
    		</td>    		
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
    			 <input type="hidden" name="lookupAutopsiaSalaSettoria" value="${esame.lass.id}" />
    		</td>
        </tr> 
        
        <tr class="even">
    		<td>
    			 Numero rif. Mittente
    		</td>
    		<td>
				 ${esame.numeroAccettazioneSigla}
				 <input type="hidden" name="tipoAccettazione" value="${esame.tipoAccettazione}" />
				 <input type="hidden" name="numeroAccettazioneSigla" value="${esame.numeroAccettazioneSigla}" />
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
    			<input type="hidden" name="idTipoPrelievo" value="${esame.tipoPrelievo.id}" />
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
    		<!--td style="width:70%">  
    			  <select name="idTumore" id="idTumore">
    			 	<option value="">&lt;---Selezionare---&gt;</option>
    			 		<c:forEach items="${tumores }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.tumore }">selected="selected"</c:if>>${temp.description }</option>
    			 	</c:forEach>
    			 </select>
    		</td -->
    		
    		
    		
    		<td style="width:70%">  
    			${esame.tumore }
    			<input type="hidden" name="idTumore" value="${esame.tumore.id}" />
    		</td>
    		
    		
        </tr> 
        <%
		}
        %>

         
        <tr class="odd">
    		<td style="width:30%">
    			 Sede Lesione e Sottospecifica<font color="red"> *</font> 
    		</td>
    		<td style="width:70%">  
    			 <select name="padreSedeLesione" id="padreSedeLesione" onchange="selezionaDivSedeLesione(this.value)">
    			 	<c:forEach items="${sediLesioniPadre }" var="temp">
    			 		<option value="${temp.id }">${temp.codice } - ${temp.description }</option>
    			 	</c:forEach>
    			 </select>
    			 <br/>
    			 <c:forEach items="${sediLesioniPadre }" var="temp">
    			 	<div <c:if test="${temp.id > 0 }"> style="display: none;" </c:if> id="div_sedi_${temp.id }" name="div_sedi_${temp.id }">
    			 		<c:if test="${empty temp.figli }">
    			 			<input type="hidden" name="idSedeLesione" id="idSedeLesione" value="${temp.id }" <c:if test="${temp.id > 0 }">disabled="disabled"</c:if> />
    			 		</c:if>
    			 		<c:if test="${not empty temp.figli }">
    			 			 <select name="idSedeLesione" id="idSedeLesione" disabled="disabled">
			    			 	<c:forEach items="${temp.figli }" var="figlio">
			    			 		<c:if test="${empty figlio.figli }">
			    			 			<option value="${figlio.id }">${figlio.codice } - ${figlio.description }</option>
			    			 		</c:if>
			    			 		<c:if test="${not empty figlio.figli}">
			    			 			<optgroup label="${figlio.description }">
			    			 				<c:forEach items="${figlio.figli }" var="nipote" >
			    			 					<option value="${nipote.id }">${nipote.codice } - ${nipote.description }</option>
			    			 				</c:forEach>
			    			 			</optgroup>
			    			 		</c:if>
			    			 	</c:forEach>
			    			 </select>
    			 		</c:if>
    			 	</div>
    			 </c:forEach>
    		</td>
        </tr> 
        
        
        <%
        //Abilitazione 287
		if(Application.get("flusso_287").equals("true"))
		{
		%>
		
        <tr class="odd">
    		<td style="width:30%">
    			 Trattamenti ormonali
    		</td>
    		<td style="width:70%">  
    			${esame.trattOrm}
    			<input type="hidden" name="trattOrm" value="${esame.trattOrm}" />
    		</td>
        </tr>  
        
        <tr class="odd">
    		<td style="width:30%">
    			 Stato generale
    		</td>
    		<td style="width:70%">  
    			${esame.statoGenerale} ${esame.statoGeneraleLookup}
    			<input type="hidden" name="idStatoGeneraleLookup" value="${esame.statoGenerale}${esame.statoGeneraleLookup.id}" />
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
    			${esame.tumoriPrecedenti.description}
    			<input type="hidden" name="idTumoriPrecedenti" value="${esame.tumoriPrecedenti.id}" /> 
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
    
    		<input type="hidden" name="t" value="${esame.t }"/>
    		<input type="hidden" name="n" value="${esame.n }"/>
    		<input type="hidden" name="m" value="${esame.m }"/>
        
         <tr class="odd">
    		<td style="width:30%" >
    			 Dimensione (centimetri)
    		</td>
    		<td style="width:70%"> 
    			${esame.dimensione }
    			<input type="hidden" name="dimensione" id="dimensione" value="${esame.dimensione }"/>
    		</td>
        </tr> 
        
        <tr>
    		<td style="width:30%">
    			 Interessamento Linfonodale
    		</td>
    		<td style="width:70%">  
    			${esame.interessamentoLinfonodale.description }  
    			<input type="hidden" name="idInteressamentoLinfonodale" id="idInteressamentoLinfonodale" value="${esame.interessamentoLinfonodale.id}"/>
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
    			${esame.tipoDiagnosi.description }: ${esame.whoUmana } ${esame.diagnosiNonTumorale } 
    		</td>
        </tr> 
        
                
        <tr>
    		<td colspan="2">    
    			<font color="red">* </font> Campi obbligatori
				<br/>
				<c:if test="${!modify }" >
					<input type="submit" value="Salva"  />
					<input type="button" value="Salva e Continua" onclick="if(checkform(document.getElementById('form'))==true){document.getElementById('form').action='vam.cc.esamiIstopatologici.AddAndContinue.us';document.getElementById('form').submit();}" />
				</c:if>
				<c:if test="${modify }" >
		    		<input type="submit" value="Salva"  />	
				</c:if>
    			
    			<!-- input
				type="button" value="Immagini"
				onclick="javascript:avviaPopup( 'vam.cc.esamiIstopatologici.GestioneImmagini.us?id=${esame.id }&cc=${cc.id}' );" / -->
    			<input type="button" value="Annulla" onclick="location.href='vam.cc.esamiIstopatologici.List.us'">
    		</td>
        </tr>
	</table>
</form>

<script type="text/javascript">

var padreSedeLesionePrecedente = -1;

function selezionaDivSedeLesione( idPadre )
{
	toggleDiv( "div_sedi_" + padreSedeLesionePrecedente );
	toggleDiv( "div_sedi_" + idPadre );

	padreSedeLesionePrecedente = idPadre;
}

function updateTNM( idTumPrec )
{
	var div = document.getElementById( "tnm" );

	if( idTumPrec == 2 )
	{
		div.style.display = "block";
		protect( div, false );
	}
	else
	{
		div.style.display = "none";
		protect( div, true );
	}
}

var padreWhoUmanaPrecedente = 1;

function selezionaDivWhoUmana( idPadre )
{
	toggleDiv( "div_who_umana_" + padreWhoUmanaPrecedente );
	toggleDiv( "div_who_umana_" + idPadre );

	padreWhoUmanaPrecedente = idPadre;
}


function updateIdWhoUmana()
{
	var indiceDiv = document.getElementById( 'padreWhoUmana' ).value;
	document.getElementById( 'idWhoUmana' ).value = document.getElementById( 'idWhoUmana' + indiceDiv ).value;
}

var padreTipoDiagnosiPrecedente = "tipoDiagnosi-1";

function selezionaDivTipoDiagnosi( idDiagnosi )
{
	var divx = "tipoDiagnosi-1";
	
	switch ( idDiagnosi )
	{
	case "1":
		divx = "whoUmanaDiv";
		break;
	case "2":
		divx = "whoAnimaleDiv";
		break;
	case "3":
		divx = "nonTumoraleDiv";
		break;
	}

	//document.getElementById( padreTipoDiagnosiPrecedente ).style.display = "none";
	//document.getElementById( divx ).style.display = "block";
	toggleDiv( padreTipoDiagnosiPrecedente );
	toggleDiv( divx );

	switch ( idDiagnosi )
	{
	case "1":
		updateIdWhoUmana();
		break;
	case "2":
		
		break;
	case "3":
		
		break;
	}

	padreTipoDiagnosiPrecedente = divx;
}


	<c:if test="${modify }">
		setTimeout( 'updateTNM(${esame.tumoriPrecedenti.id}),selezionaDivTipoDiagnosi("${esame.tipoDiagnosi.id}")', 500 );
	</c:if>
	<c:if test="${modify && esame.sedeLesione.padre != null }" >
		setTimeout( 'selezionaDivSedeLesione( ${esame.sedeLesione.padre.id } )', 600 );
	</c:if>
	<c:if test="${modify && esame.sedeLesione.padre == null }" >
		setTimeout( 'selezionaDivSedeLesione( ${esame.sedeLesione.id } )', 600 );
	</c:if>
	<c:if test="${modify && esame.whoUmana.padre != null}">
		setTimeout( 'selezionaDivWhoUmana( ${esame.whoUmana.padre.id } )', 700 );
	</c:if>
	<c:if test="${modify && esame.whoUmana.padre == null && esame.whoUmana != null}">
		setTimeout( 'selezionaDivWhoUmana( ${esame.whoUmana.id } )', 700 );
	</c:if>
</script>
