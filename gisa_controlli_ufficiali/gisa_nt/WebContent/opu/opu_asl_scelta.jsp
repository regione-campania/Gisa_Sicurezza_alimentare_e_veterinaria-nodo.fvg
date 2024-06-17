<jsp:useBean id="newStabilimento" class="org.aspcfs.modules.opu.base.Stabilimento" scope="request" />
<jsp:useBean id="fissa" class="java.lang.String" scope="request" />

<link rel="stylesheet" href="css/jquery-ui.css" />






<script>
function selezionaOperazione(operazione, form){
	
	if (operazione=='new'){
		form.action='OpuStab.do?command=Add';
	}
	else{
		form.action='OpuStab.do?command=Add';
	}
	
	form.submit();
	
}


</script>




<div class="info">
In questa sezione puoi effettuare più operazioni a livello SUAP. Per ogni azione, il sistema ti 
propone un bottone richiamando tra parentesi tonda il paragrafo della
<a href="#" onClick="window.open('http://www.gisacampania.it/manualisuap/Allegato%20D.G.R.C.%20318.2015.pdf')"> Delibera 318/15<img src="gestione_documenti/images/pdf_icon.png" width="25px"/>
</a>
</div>


<h3><%=newStabilimento.getTipoInserimentoScia() == newStabilimento.TIPO_SCIA_RICONOSCIUTI
                                        ? "Riconoscimento"
                                        : newStabilimento.getStato() == 0 ? "Inserimento Stabilimento Non Registrato" : "Inserimento"%></h3>
<br>
<br>
<form id="example-advanced-form" name="addstabilimento" action="OpuStab.do?command=Add" method="post">
        <input type="hidden" name="stato" id="stato" value="<%=newStabilimento.getStato()%>"> 
        <input type="hidden" name="tipoInserimentoScia" id="tipoInserimentoScia" value="<%=newStabilimento.getTipoInserimentoScia()%>"> 
        <input type="hidden" name="sovrascrivi" id="sovrascrivi" value="n.d">
        <input type="hidden" name="idOperatore" id="idOperatore" value="n.d">
        <input type="hidden" name="idStabilimento" id="idStabilimento" value="<%=newStabilimento.getIdStabilimento()%>"> 
        <input type="hidden" name="idStabilimentoAdd" id="idStabilimentoAdd" value="<%=newStabilimento.getIdStabilimento()%>">
        <input type="hidden" name="operazioneScelta" id="operazioneScelta" value="">
        <input type="hidden" name="pratica_completa" id="pratica_completa" value="0">
        <input type="hidden" name="documentazione_parziale" id="documentazione_parziale" value="0"> 
        <input type="hidden" name="methodRequest" id="methodRequest" value="new">
        <div style="display: none;"> 
            &nbsp;&nbsp;<img id="calImg" src="images/cal.gif" alt="Popup" class="trigger"> 
        </div>
        <h3>OPERAZIONE</h3>
       <!--  <fieldset>  -->
                <!-- <legend>INDICARE IL TIPO DI OPERAZIONE CHE SI VUOLE ESEGUIRE</legend> -->
                <center>
                <table>
                <tr>
                        <td><input type="button" class="yellowBigButton" 
                                 value="INSERIMENTO &#x00A;NUOVO STABILIMENTO)"
                                onclick="selezionaOperazione('new', this.form)" style="width:400px !important;"></td>
                </tr>
        </table>
        <table>
                <tr>
                        <td><input type="button" class="yellowBigButton" 
                                   value="AGGIUNTA DI UNA O PIU' &#x00A;LINEE DI ATTIVITA'" style="width: 400px !important;"
                                   
                                   <% if (fissa!=null && fissa.equals("false")){ %>
                                onclick="alert('Attenzione! L\'aggiunta di una o più linee di attività mobili è possibile SOLO registrando una nuova SCIA cliccando sul bottone\n INSERIMENTO NUOVO STABILIMENTO ')" >   
                                   <%} else { %>
                                onclick="selezionaOperazione('ampliamento', this.form)">
                                <%} %>
                                </td>
                 </tr>
        </table>
        <table>
                <tr>
                        <td><input type="button" class="yellowBigButton"
                                value="VARIAZIONE&#x00A; TITOLARITA' DI STABILIMENTO (2.4)" style="width: 400px !important;"
                                onclick="alert('Attenzione! La variazione di titolarita consiste in: \n 1) Cessazione attuale stabilimento \n 2) Inserimento di una nuova Richiesta.');selezionaOperazione('cambioTitolarita', this.form)" width="100%">
                        </td>
                </tr>
        </table>
        <table>
                <tr>
                        <td><input type="button" class="yellowBigButton"
                            value="CHIUSURA STABILIMENTO O&#x00A;DI UNA o PIU' LINEE DI ATTIVITA' (2.5)"
                                onclick="selezionaOperazione('cessazione', this.form)" style="width: 400px !important;"></td>
                </tr>
        </table>
                </center>
                <!-- </fieldset> -->
       
       
        
</form>


