<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/fn.tld" prefix="fn" %>

<input type="button" name="downloadPdf2" id="downloadPdf2" value="Stampa Richiesta" onclick="javascript:sceltaStampaRichiesta()"/>

<div id="scelta_stampaRichiesta" title="Selezionare la stampa">
	
	 <table class="tabella">		
        <tr class='odd'>
    		<td>

    			<input type="button" name="downloadPdfNew2" id="downloadPdfNew2" value="Nuovo Documento" 
						onclick="location.href='documentale.DownloadNewPdf.us?tipo=stampaRichiesta&glifo='+document.getElementById('glifo2').checked+'&idEsame='+${a.id};"
    			/><input type="checkbox" name="glifo2" id="glifo2" value="glifo" style="display:none;"><!-- input type="text" disabled value="Glifo"/-->
    			<!-- 
    			<input type="button" name="downloadPdfLast2" id="downloadPdfLast2" value="Ultimo Documento Generato" onclick="location.href='documentale.DownloadLastGenerate.us?tipo=${tipo}&idEsame=${a.id}';"
    			/> -->
    			
    		</td>
        </tr>
        
      </table>
 </div>

<script type="text/javascript">

$(function() 
		{
			$( "#scelta_stampaRichiesta" ).dialog({
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

function sceltaStampaRichiesta()
{
$( '#scelta_stampaRichiesta' ).dialog( 'open' );
}

</script>