<h3>FORM</h3>
        <fieldset>
                <legend>SCHEDA STABILIMENTO</legend>
                <iframe height="650px" id="test2"
                        src="./schede_centralizzate/iframe.jsp?objectId=<%=newStabilimento.getIdStabilimento()%>&objectIdName=stab_id&tipo_dettaglio=15"
                        name="test"> </iframe>
                <div align="right">
                        <img src="images/icons/stock_print-16.gif" border="0"
                                align="absmiddle" height="16" width="16" /> <input type="button"
                                title="Stampa Ricevuta" value="Stampa Ricevuta"
                                onClick="openRichiestaPDFOpu('<%=newStabilimento.getIdStabilimento()%>', '-1', '-1', '-1', '15');">
                </div>
        </fieldset>