<h3>LINEE DI ATTIVITA'</h3>
        <fieldset>
                <input type="hidden" value="false" id="validatelp" >
                <fieldset id="operazione">
                        <h1><center>NUOVA Richiesta</center></h1>
                </fieldset>
                <fieldset id="lineeEsistenti" style="display: none">
                        <legend>ATTIVITA PRESENTI NELLO STABILIMENTO</legend>
                </fieldset>
                <fieldset id="setAttivitaPrincipale">
                        <legend>INDICARE IL TIPO DI ATTIVITA PRINCIPALE</legend>
                        <table id="attprincipale" style="width: 100%;">
                        </table>
                        <table style="width: 100%;">
                                <tr id="trDataInizioLinea">
                                        <td>DATA INIZIO</td>
                                        <td><input type="text" size="15" name="dataInizioLinea"
                                                id="dataInizioLinea" class="required" placeholder="dd/MM/YYYY">
                                        </td>
                                </tr>
                                <tr id="trDataFineLinea">
                                        <td>DATA FINE</td>
                                        <td><input type="text" size="15" name="dataFineLinea"
                                                id="dataFineLinea" value="" placeholder="dd/MM/YYYY"></td>
                                </tr>
                        </table>
<script>
$(function() {
        $('#dataInizioLinea').datepick({dateFormat: 'dd/mm/yyyy',  maxDate: 0,  showOnFocus: false, showTrigger: '#calImg'}); 
        $('#dataFineLinea').datepick({dateFormat: 'dd/mm/yyyy', showOnFocus: false, showTrigger: '#calImg',  onClose: controlloDate         });

		

});
</script>
                </fieldset>
                <br>
                <br>
                <fieldset id="secondarie">
                        <legend>INDICARE IL TIPO DI ATTIVITA SECONDARIE</legend>
                        <table style="width: 100%;">
                                <tr>
                                        <td width="50%" align="left">Oltre l'attivita principale
                                                esistono altre Attivita secondarie ?</td>
                                        <td align="left"><input type="button" value="Aggiungi"
                                                onclick="aggiungiRiferimentoTabella(<%=newStabilimento.getTipoInserimentoScia()%>)"></td>
                                </tr>
                        </table>
                        <br>
                        <br>
                </fieldset>
        </fieldset>