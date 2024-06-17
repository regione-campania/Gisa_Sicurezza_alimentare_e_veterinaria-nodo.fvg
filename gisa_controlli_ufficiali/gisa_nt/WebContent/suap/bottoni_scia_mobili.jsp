<center>
                <table>
                <tr>
                        <td><input type="button" class="yellowBigButton" 
                                 value="<%=SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_NUOVO_STABILIMENTO)  %>"
                                onclick="selezionaOperazione('new', this.form)" style="width:400px !important;"></td>
                </tr>
        </table>
           <% 
      String contestoApplicativo2 = (String) application.getAttribute("SUFFISSO_TAB_ACCESSI");
	if (contestoApplicativo2!=null && !contestoApplicativo2.equals("") && contestoApplicativo2.equals("_ext")){
	
		%>
        <table>
                <tr>
                        <td><input type="button" class="yellowBigButton"
                            value="<%=SuapTipoScia.getSelectedValue(StabilimentoAction.SCIA_CESSAZIONE)  %>"
                                onclick="selezionaOperazione('cessazione', this.form)" style="width: 400px !important;"></td>
                </tr>
        </table>
        <%} %>
                </center>
                