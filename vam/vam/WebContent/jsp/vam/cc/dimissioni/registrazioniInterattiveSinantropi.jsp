<%@page import="it.us.web.util.vam.CaninaRemoteUtil"%>
<%@page import="it.us.web.bean.BUtente"%>
<script type='text/javascript' src='dwr/engine.js'></script>
<script type='text/javascript' src='dwr/interface/TestBdr.js'></script>
<script type='text/javascript' src='dwr/util.js'></script>
<script language="JavaScript" type="text/javascript" src="js/vam/bdr/registrazioniInterattive.js"></script>
<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>

<h4 class="titolopagina">
     		Dimissioni
    </h4>
    
Operazione da registrare: ${cc.destinazioneAnimale.description }
<br/><br/>

<input type="button" value="Operazione Completata" onclick="javascript:attendere(),anagrafeCompletata();" />
<input type="button" value="Annulla" onclick="javascript:if(myConfirm('Sicuro di voler annullare l\'operazione?')){ annulla(); };" />

<br/>&nbsp;<br/>

<iframe 
	id="myFrame" name="myFrame"  frameborder="0"  vspace="0"  
	hspace="0" marginwidth="0" marginheight="0"
	width="95%"  scrolling=yes  height="900"
	style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; Z-INDEX: 999; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid;"
	src="sinantropi.Detail.us?interactiveMode=y&&idSinantropo=${sinantropo.id }">
</iframe>

<script type="text/javascript">
function annulla()
{
	location.href='vam.cc.dimissioni.RegistrazioniInterattiveInserite.us?idTipoRegBdr=${idTipoRegBdr}';
};

function anagrafeCompletata()
{
	location.href='vam.cc.dimissioni.RegistrazioniInterattiveInserite.us?idTipoRegBdr=${idTipoRegBdr}';
};
</script>

<script>
dwr.engine.setErrorHandler(errorHandler);
dwr.engine.setTextHtmlHandler(errorHandler);

function errorHandler(message, exception){
    //Session timedout/invalidated

    if(exception && exception.javaClassName== 'org.directwebremoting.impl.LoginRequiredException'){
        alert(message);
        //Reload or display an error etc.
        window.location.href=window.location.href;
    }
    else
        alert('Errore Nella Chiamata Remota : '+exception.javaClassName);
 }
</script>