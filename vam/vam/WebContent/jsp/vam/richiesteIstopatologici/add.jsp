<%@page import="it.us.web.util.properties.Application"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@page import="java.util.Date"%>

<script language="JavaScript" type="text/javascript" src="js/vam/cc/esamiIstopatologici/add.js"></script>


<form action="vam.richiesteIstopatologici.Add.us" name="form" method="post" class="marginezero" onsubmit="javascript:return checkform(this);">    

    <h4 class="titolopagina">
		<c:if test="${!modify }" >     
			Richiesta Esame Istopatologico
		</c:if>
		<c:if test="${modify }" >
			Modifica Esame Istopatologico richiesto da ${esame.enteredBy.nome} ${esame.enteredBy.cognome} 
    			
    			<input type="hidden" name="modify" value="on" />
    			<input type="hidden" name="id" value="${esame.id }" />
		</c:if>
    </h4>
    
    
    <input type="hidden" name="idAnimale" value="${animale.id }" />
    <input type="hidden" name="liberoProfessionista" value="${liberoProfessionista }" />
    
    <table class="tabella">
        
        <tr>
        	<th colspan="3">
        		Dati generici dell'animale
        	</th>
        </tr>
    
    	<tr class='even'>
    		<td>
    			Peso dell'animale (in Kg)
    		</td>
    		<td>
    			 <input type="text" name="peso" maxlength="6" size="6"/>
    		</td>
    		<td>
    		</td>
        </tr>
        
        <tr class='odd'>
    		<td>
    			Habitat 
    		</td>
    		<td>
    		
    			<c:forEach items="${listHabitat}" var="h" >									
							<input onclick="mutuamenteEsclusiviHabitat(this.id)" type="checkbox" name="oph_${h.id }" id="oph_${h.id }"/> ${h.description} 	
							<br>				
				</c:forEach>
    		
    		</td>
    		<td>
    		</td>
        </tr>
        
        <tr class='even'>
    		<td>
    			Alimentazione
    		</td>
    		<td>
    			<c:forEach items="${listAlimentazioni}" var="a" >									
							<input onclick="mutuamenteEsclusiviHabitatAlimentazioni(this.id);" type="checkbox" name="opa_${a.id }" id="opa_${a.id }" /> ${a.description} 	
							<br>				
				</c:forEach> 
				<c:forEach items="${listAlimentazioniQualita}" var="aq" >									
							<input onclick="mutuamenteEsclusiviHabitatAlimentazioni(this.id);" type="checkbox" name="opaq_${aq.id }" id="opaq_${aq.id }" /> ${aq.description} 	
							<br>				
				</c:forEach> 
    		</td>
    		<td>
    		</td>
        </tr>
        
        
        
        <tr>
        	<th colspan="2">
        		Richiesta
        	</th>
        </tr>
        <tr>
	        <td>
	         	Data Richiesta<font color="red"> *</font>
	        </td>    	
    		<td style="width:50%">    			
    			 <fmt:formatDate type="date" value="<%=new Date() %>" pattern="dd/MM/yyyy" var="dataOdierna"/> 		
    			 <input type="text" id="dataRichiesta" name="dataRichiesta" maxlength="32" size="50" readonly="readonly" style="width:246px;" value="${dataOdierna}"/>
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_1" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataRichiesta",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_1",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script>   
    		</td>    		
        </tr>
          

        

		<tr class="odd">
    		<td style="width:30%">
    			 Tipo Prelievo
    		</td>
    		<td style="width:70%">  
    			 <select name="idTipoPrelievo" id="idTipoPrelievo">
    			 	<c:forEach items="${tipoPrelievos }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.tipoPrelievo }">selected="selected"</c:if>>${temp.description }</option>
    			 	</c:forEach>
    			 </select>
    		</td>
        </tr> 
        
        <tr class="odd">
    		<td style="width:30%">
    			 Tumore
    		</td>
    		<td style="width:70%">  
    			  <select name="idTumore" id="idTumore">
    			 	<option value="">&lt;---Selezionare---&gt;</option>
    			 		<c:forEach items="${tumores }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.tumore }">selected="selected"</c:if>>${temp.description }</option>
    			 	</c:forEach>
    			 </select>
    		</td>
        </tr> 
        
        <tr class="odd">
    		<td style="width:30%">
    			 Sede Lesione e Sottospecifica <font color="red">*</font>
    		</td>
    		<td style="width:70%">  
    			 <select name="padreSedeLesione" id="padreSedeLesione" onchange="selezionaDivSedeLesione(this.value)">
    			 	<c:forEach items="${sediLesioniPadre }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.sedeLesione.padre || temp == esame.sedeLesione }">selected="selected"</c:if> >${temp.codice } - ${temp.description }</option>
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
			    			 			<option value="${figlio.id }" <c:if test="${figlio == esame.sedeLesione }">selected="selected"</c:if> >${figlio.codice } - ${figlio.description }</option>
			    			 		</c:if>
			    			 		<c:if test="${not empty figlio.figli}">
			    			 			<optgroup label="${figlio.description }">
			    			 				<c:forEach items="${figlio.figli }" var="nipote" >
			    			 					<option value="${nipote.id }" <c:if test="${nipote == esame.sedeLesione }">selected="selected"</c:if> >${nipote.codice } - ${nipote.description }</option>
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
    			 <input type="text" name="trattOrm" id="trattOrm" size="50" value="${esame.trattOrm }"/>
    		</td>
        </tr>  
        
        <tr class="odd">
    		<td style="width:30%">
    			 Stato generale
    		</td>
    		<td style="width:70%">  
    			   <select name="idStatoGeneraleLookup" id="idStatoGeneraleLookup">
    			 	<option value="">&lt;---Selezionare---&gt;</option>
    			 		<c:forEach items="${statoGeneraleLookups }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.statoGeneraleLookup }">selected="selected"</c:if>>${temp.description }</option>
    			 	</c:forEach>
    			 </select>
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
    			<select name="idTumoriPrecedenti" id="idTumoriPrecedenti" onchange="updateTNM(this.value);">
    			 	<c:forEach items="${tumoriPrecedentis }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.tumoriPrecedenti }">selected="selected"</c:if> >${temp.description }</option>
    			 	</c:forEach>
    			 </select>
    			 

    			 
    			 
    			 <div id="tnm" name="tnm" style="display: none">
    			 
    			 
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnosi" 
    			 	name="dataDiagnosi" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_2" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_2",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente" id="diagnosiPrecedente"   value="${esame.diagnosiPrecedente }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t" id="t"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n" id="n"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m" id="m"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	<input type="button" value="+" onclick="aggiungiRigaTNM();">
    			 </div>
    			<div id="tnm1" name="tnm1" style="display: none">
    			 <br/>
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnosi1" 
    			 	name="dataDiagnosi1" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_3" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi1",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_3",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente1" id="diagnosiPrecedente1"   value="${esame.diagnosiPrecedente1 }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t1" id="t1"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n1" id="n1"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m1" id="m1"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	
    			 </div>
    			 <div id="tnm2" name="tnm2" style="display: none">
    			 <br/>
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnosi2" 
    			 	name="dataDiagnosi2" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_4" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi2",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_4",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente2" id="diagnosiPrecedente2"   value="${esame.diagnosiPrecedente2 }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t2" id="t2"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n2" id="n2"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m2" id="m2"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	
    			 </div>
    			 <div id="tnm3" name="tnm3" style="display: none">
    			 <br/>
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnosi3" 
    			 	name="dataDiagnosi3" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_5" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi3",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_5",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente3" id="diagnosiPrecedente3"   value="${esame.diagnosiPrecedente3 }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t3" id="t3"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n3" id="n3"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m3" id="m3"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	
    			 </div>
    			 <div id="tnm4" name="tnm4" style="display: none">
    			 <br/>
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnosi4" 
    			 	name="dataDiagnosi4" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_6" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_4",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente4" id="diagnosiPrecedente4"   value="${esame.diagnosiPrecedente4 }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t4" id="t4"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n4" id="n4"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m4" id="m4"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	
    			 </div>
    			 <div id="tnm5" name="tnm5" style="display: none">
    			 <br/>
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnos5" 
    			 	name="dataDiagnosi5" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_7" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi5",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_7",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente5" id="diagnosiPrecedente5"   value="${esame.diagnosiPrecedente5 }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t5" id="t5"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n5" id="n5"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m5" id="m5"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	
    			 </div>
    		</td>
        </tr>    
        
        <tr class="odd">
    		<td style="width:30%">
    			 Dimensione (centimetri)
    		</td>
    		<td style="width:70%"> 
    			<input maxlength="3" type="text" name="dimensione" id="dimensione" size="5" value="${esame.dimensione }"/>
    		</td>
        </tr> 
        
        <tr>
    		<td style="width:30%">
    			 Interessamento Linfonodale
    		</td>
    		<td style="width:70%">  
    			<select name="idInteressamentoLinfonodale" id="idInteressamentoLinfonodale">
    			 	<c:forEach items="${interessamentoLinfonodales }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.interessamentoLinfonodale }">selected="selected"</c:if> >${temp.description }</option>
    			 	</c:forEach>
    			 </select>
       		</td>
        </tr> 
        
        <c:if test="${liberoProfessionista == false }">
        
        <tr>
        	<th colspan="2">
        		Risultato
        	</th>
        </tr>
        
        <tr>
    		<td style="width:30%">
    			  Descrizione Morfologica
    		</td>
    		<td style="width:70%">  
    			 <textarea rows="5" cols="60" name="descrizioneMorfologica" id="descrizioneMorfologica" >${esame.descrizioneMorfologica }</textarea>
    		</td>
        </tr>
        
        <tr class="odd">
    		<td style="width:30%">
    			 Diagnosi
    		</td>
    		<td style="width:70%">  
    			 <select name="idTipoDiagnosi" id="idTipoDiagnosi" onchange="selezionaDivTipoDiagnosi(this.value)">
    			 	<c:forEach items="${tipoDiagnosis }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.tipoDiagnosi }">selected="selected"</c:if>>${temp.description }</option>
    			 	</c:forEach>
    			 </select>
    			 
    			 <div id="tipoDiagnosi-1" name="tipoDiagnosi-1">
    			 	<input type="hidden" name="idWhoUmana" value="-1" />
    			 </div>
    			 
    			 <div id="whoUmanaDiv" name="whoUmanaDiv" style="display: none;">
    			 	
    			 	<input type="hidden" name="idWhoUmana" id="idWhoUmana" value="${esame.whoUmana.id }"/>
    			 	
    			 	 <select name="padreWhoUmana" id="padreWhoUmana" onchange="selezionaDivWhoUmana(this.value),updateIdWhoUmana()">
	    			 	<c:forEach items="${whoUmanaPadre }" var="temp">
	    			 		<option value="${temp.id }" <c:if test="${temp == esame.whoUmana.padre || temp == esame.whoUmana }">selected="selected"</c:if> >${temp.codice } - ${temp.description }</option>
	    			 	</c:forEach>
	    			 </select>
	    			 <c:forEach items="${whoUmanaPadre }" var="temp">
    			 	 <div <c:if test="${temp.id > 1 }"> style="display: none;" </c:if> id="div_who_umana_${temp.id }" name="div_who_umana_${temp.id }">
    			 		<c:if test="${empty temp.figli }">
    			 			<input type="hidden" name="idWhoUmana" id="idWhoUmana" value="${temp.id }" <c:if test="${temp.id > 0 }">disabled="disabled"</c:if> />
    			 		</c:if>
    			 		<c:if test="${not empty temp.figli }">
    			 			 <select name="idWhoUmana${temp.id }" id="idWhoUmana${temp.id }" disabled="disabled" onchange="updateIdWhoUmana()">
			    			 	<c:forEach items="${temp.figli }" var="figlio">
			    			 		<c:if test="${empty figlio.figli }">
			    			 			<option value="${figlio.id }" <c:if test="${figlio == esame.whoUmana }">selected="selected"</c:if> >${figlio.codice } - ${figlio.description }</option>
			    			 		</c:if>
			    			 		<c:if test="${not empty figlio.figli}">
			    			 			<optgroup label="${figlio.description }">
			    			 				<c:forEach items="${figlio.figli }" var="nipote" >
			    			 					<option value="${nipote.id }" <c:if test="${nipote == esame.whoUmana }">selected="selected"</c:if> >${nipote.codice } - ${nipote.description }</option>
			    			 				</c:forEach>
			    			 			</optgroup>
			    			 		</c:if>
			    			 	</c:forEach>
			    			 </select>
    			 		</c:if>
    			 	 </div>
    			  </c:forEach>
    			 </div>
    			 
    			 <div id="whoAnimaleDiv" name="whoAnimaleDiv" style="display: none;">
    			 	Who animale
    			 </div>
    			 
    			 <div id="nonTumoraleDiv" name="nonTumoraleDiv" style="display: none;">
    			 	<textarea rows="5" cols="60" name="diagnosiNonTumorale" id="diagnosiNonTumorale" >${esame.diagnosiNonTumorale }</textarea>
    			 </div>
    			 
    			 
    		</td>
        </tr>  
        </c:if>
        <tr>
    		<td colspan="2">    
    			<font color="red">* </font> Campi obbligatori
				<br/>			
    			
    			
    			<c:if test="${!modify }" >     
					<input type="submit" value="Richiedi" />
				</c:if>
				<c:if test="${modify }" >
					<input type="submit" value="Modifica" />
				</c:if>
    			
    			
    			<input type="button" value="Torna alla Home" onclick="location.href='Home.us'">
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
	
	
	
	function aggiungiRigaTNM()
	{
		if(document.getElementById('tnm1').style.display=='none')
		{
			document.getElementById('tnm1').style.display='block';
		}
		else if(document.getElementById('tnm2').style.display=='none')
		{
			document.getElementById('tnm2').style.display='block';
		}
		else if(document.getElementById('tnm3').style.display=='none')
		{
			document.getElementById('tnm3').style.display='block';
		}
		else if(document.getElementById('tnm4').style.display=='none')
		{
			document.getElementById('tnm4').style.display='block';
		}
		else if(document.getElementById('tnm5').style.display=='none')
		{
			document.getElementById('tnm5').style.display='block';
		}
	}
	
	function mutuamenteEsclusiviHabitatAlimentazioni(id)
	{
		
		if(id=='oph_1')
				document.getElementById('oph_2').checked=false;
		else if(id=='oph_2')
			document.getElementById('oph_1').checked=false;
		else if(id=='oph_3')
		{
			document.getElementById('oph_4').checked=false;
			document.getElementById('oph_5').checked=false;
			document.getElementById('oph_6').checked=false;
			
		}
		else if(id=='oph_4')
		{
			document.getElementById('oph_3').checked=false;
			document.getElementById('oph_5').checked=false;
			document.getElementById('oph_6').checked=false;
			
		}
		else if(id=='oph_5')
		{
			document.getElementById('oph_4').checked=false;
			document.getElementById('oph_3').checked=false;
			document.getElementById('oph_6').checked=false;
			
		}
		else if(id=='oph_6')
		{
			document.getElementById('oph_4').checked=false;
			document.getElementById('oph_5').checked=false;
			document.getElementById('oph_3').checked=false;
			
		}
		else if(id=='opa_1')
		{
			document.getElementById('opa_2').checked=false;
			document.getElementById('opa_3').checked=false;
			
		}
		else if(id=='opa_2')
		{
			document.getElementById('opa_1').checked=false;
			document.getElementById('opa_3').checked=false;
			
		}
		else if(id=='opa_3')
		{
			document.getElementById('opa_1').checked=false;
			document.getElementById('opa_2').checked=false;
			
		}
		else if(id=='opaq_1')
		{
			document.getElementById('opaq_2').checked=false;
			document.getElementById('opaq_3').checked=false;
			
		}
		else if(id=='opaq_2')
		{
			document.getElementById('opaq_1').checked=false;
			document.getElementById('opaq_3').checked=false;
			
		}
		else if(id=='opaq_3')
		{
			document.getElementById('opaq_1').checked=false;
			document.getElementById('opaq_2').checked=false;
			
		}
	}
</script>
