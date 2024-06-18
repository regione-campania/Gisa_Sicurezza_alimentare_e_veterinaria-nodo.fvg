<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/fn.tld" prefix="fn" %>

<!--  input type="button" name="stampa" id="stampa" value="Stampa" onclick="javascript:window.print();" /-->

<c:if test="${tipo=='stampaDecesso'}">
<input type="button" name="downloadPdf2" id="downloadPdf2" value="Stampa Certificato Decesso" onclick="javascript:sceltaStampa2()"/>
</c:if>
<c:if test="${tipo=='stampaVerbalePrelievo' && a!=null && utente.clinica.id == a.modifiedBy.clinica.id && fn:length(a.dettaglioEsami)>0 }">
<input type="button" name="downloadPdf2" id="downloadPdf2" value="Stampa Verbale Prelievo" onclick="javascript:sceltaStampa2()"/>
</c:if>

<!--<us:can f="AMMINISTRAZIONE" sf="MAIN" og="MAIN" r="w">-->
	<!--<input type="button" name="gestionePdf2" id="gestionePdf2" value="Gestione Stampe" onclick="location.href='documentale.Lista.us?cc=${cc.id}&tipo=${tipo}&action='+location.href;" />-->
<!--</us:can>-->

<div id="scelta_stampa2" title="Selezionare la stampa">
	
	 <table class="tabella">		
        <tr class='odd'>
    		<td>
    			<input type="button" name="downloadPdfNew2" id="downloadPdfNew2" value="Nuovo Documento" 
	    			<c:if test="${tipo=='stampaDecesso'}">
						onclick="location.href='documentale.DownloadNewPdf.us?tipo=${tipo}&glifo='+document.getElementById('glifo2').checked+'&idAccettazione='+${accettazione.id};"
					</c:if>
					<c:if test="${tipo=='stampaVerbalePrelievo' && a!=null && utente.clinica.id==a.modifiedBy.clinica.id && fn:length(a.dettaglioEsami)>0 }">
						onclick="location.href='documentale.DownloadNewPdf.us?tipo=${tipo}&glifo='+document.getElementById('glifo2').checked+'&idEsame='+${a.id};"
					</c:if>
    			/><input type="checkbox" name="glifo2" id="glifo2" value="glifo" style="display:none;"><!-- input type="text" disabled value="Glifo"/-->
    			
    			<!-- 
    			<input type="button" name="downloadPdfLast2" id="downloadPdfLast2" value="Ultimo Documento Generato" onclick="location.href='documentale.DownloadLastGenerate.us?tipo=${tipo}&idEsame=${a.id}+idAccettazione=${accettazione.id }&idCc=${cc.id }';"
    			/>  -->
    			
    		</td>
        </tr>
        
      </table>
 </div>

<script type="text/javascript">

$(function() 
		{
			$( "#scelta_stampa2" ).dialog({
				height: screen.height/4,
				modal: true,
				autoOpen: false,
				closeOnEscape: true,
				show: 'blind',
				resizable: true,
				draggable: true,
				width: screen.width/3,
				buttons: {
					"Chiudi": function() {
						$( this ).dialog( "close" );
					}
				}
		});
});

function sceltaStampa2()
{
$( '#scelta_stampa2' ).dialog( 'open' );
}

</script>