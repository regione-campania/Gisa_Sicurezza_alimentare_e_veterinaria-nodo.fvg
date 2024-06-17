
<center>
  
       <%if(StabilimentoSoggettoAScia.getOperatore().getTipo_impresa()!=9 && StabilimentoSoggettoAScia.getOperatore().getTipo_impresa()!=10){ %>
        <table>
                <tr>
                        <td><input type="button" class="yellowBigButton" 
                                   value="<%=SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_AMPLIAMENTO)  %>" style="width: 400px !important;"
                                onclick="selezionaOperazione('ampliamento', this.form)">
                               
                         </td>
                 </tr>
        </table>
        <%} %>
        <table>
                <tr>
                        <td><input type="button" class="yellowBigButton"
                                value="<%=SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_VARIAZIONE_TITOLARITA)  %>" style="width: 400px !important;"
                                onclick="selezionaOperazione('cambioTitolarita', this.form)" width="100%">
                        </td>
                </tr>
        </table>
        <table>
                <tr>
                        <td><input type="button" class="yellowBigButton"
                                value="<%=SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_MODIFICA_STATO_LUOGHI)  %>" style="width: 400px !important;"
                                onclick="selezionaOperazione('modificaStatoLuoghi', this.form)" width="100%">
                        </td>
                </tr>
        </table>
        <table>
                <tr>
                        <td><input type="button" class="yellowBigButton"
                            value="<%=SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_CESSAZIONE)  %>"
                                onclick="selezionaOperazione('cessazione', this.form)" style="width: 400px !important;"></td>
                </tr>
                
                <%
                if (newStabilimento.getTipoInserimentoScia() == newStabilimento.TIPO_SCIA_RICONOSCIUTI)
                {
                	%>
                	 <tr>
                        <td><input type="button" class="yellowBigButton"
                            value="<%=SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_SOSPENSIONE)  %>"
                                onclick="selezionaOperazione('sospensione', this.form)" style="width: 400px !important;"></td>
                </tr>
                	<%
                }
                %>
                
        </table>
  
               
  </center>