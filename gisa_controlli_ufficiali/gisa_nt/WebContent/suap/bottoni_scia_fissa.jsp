
<center>
  		
  		  <%boolean isRiconosciuto = (newStabilimento.getTipoInserimentoScia() == newStabilimento.TIPO_SCIA_RICONOSCIUTI); %>
  	      <table>
                <tr>
                        <td><input type="button" class="yellowBigButton" 
                                 value="<%=!isRiconosciuto ? SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_NUOVO_STABILIMENTO)
                                		 : SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_NUOVO_STABILIMENTO).replace("SCIA","") %>"
                                onclick="selezionaOperazione('new', this.form)" style="width:400px !important;"></td>
                </tr>
        </table>
        <% 
      String contestoApplicativo = (String) application.getAttribute("SUFFISSO_TAB_ACCESSI");
	if (contestoApplicativo!=null && !contestoApplicativo.equals("") && contestoApplicativo.equals("_ext")){
		if(newStabilimento.getOperatore().getTipo_impresa()!=7 )
		{	
	
		%>
	
        <table>
                <tr>
                        <td><input type="button" class="yellowBigButton" 
                                   value="<%=!isRiconosciuto ? SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_AMPLIAMENTO)
                                		   : SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_AMPLIAMENTO).replace("SCIA","") %>" style="width: 400px !important;"
                                onclick="selezionaOperazione('ampliamento', this.form)">
                               
                         </td>
                 </tr>
        </table>
        <%} %>
        <table>
                <tr>
                        <td><input type="button" class="yellowBigButton"
                                value="<%=!isRiconosciuto ? SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_VARIAZIONE_TITOLARITA) 
                                		:  SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_VARIAZIONE_TITOLARITA).replace("SCIA","")%>" style="width: 400px !important;"
                                onclick="selezionaOperazione('cambioTitolarita', this.form)" width="100%">
                        </td>
                </tr>
        </table>
        <table>
                <tr>
                        <td><input type="button" class="yellowBigButton"
                                value="<%=!isRiconosciuto ? SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_MODIFICA_STATO_LUOGHI)
                                		: SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_MODIFICA_STATO_LUOGHI).replace("SCIA","") %>" style="width: 400px !important;"
                                onclick="selezionaOperazione('modificaStatoLuoghi', this.form)" width="100%">
                        </td>
                </tr>
        </table>
        <table>
                <tr>
                        <td><input type="button" class="yellowBigButton"
                            value="<%=!isRiconosciuto ? SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_CESSAZIONE) :
                            	SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_CESSAZIONE).replace("SCIA","") %>"
                                onclick="selezionaOperazione('cessazione', this.form)" style="width: 400px !important;"></td>
                </tr>
                
                <%
                if (isRiconosciuto)
                {
                	%>
                	 <tr>
                        <td><input type="button" class="yellowBigButton"
                            value="<%=SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_SOSPENSIONE).replace("SCIA","")  %>"
                                onclick="selezionaOperazione('sospensione', this.form)" style="width: 400px !important;"></td>
                </tr>
                	<%
                }
                %>
                
        </table>
        <%} %>
  
               
  </center>