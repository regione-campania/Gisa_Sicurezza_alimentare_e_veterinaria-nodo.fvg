<jsp:useBean id="Mod" class="org.aspcfs.modules.pnaa.base.ModPnaa" scope="request"/>
<jsp:useBean id="Campione" class="org.aspcfs.modules.campioni.base.Ticket" scope="request"/>
<jsp:useBean id="DpaList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="StrategiaCampionamentoList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="MetodoCampionamentoList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ProgrammaControlloList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="PrincipiAdditiviList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="PrincipiAdditiviCOList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ContaminantiList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="LuogoPrelievoList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="MatriceCampioneList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SpecieVegetaleList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="MetodoProduzioneList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="StatoProdottoList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SpecieAlimentoList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="PremiscelaAdditiviList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="MangimeCompostoList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiNoList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="CampioneFinaleList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ConfezionamentoList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="CgRidottoList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="CgCrList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SequestroPartitaList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SottoprodottiList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="PrevistiConoscitivi" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="MicotossineList" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<%@ page import="org.aspcfs.utils.web.*" %>
<%@ page import="java.awt.*, java.awt.image.*,  java.util.StringTokenizer, com.itextpdf.text.pdf.*, java.io.*, java.util.*,org.aspcfs.utils.web.*, com.itextpdf.text.pdf.codec.*,org.aspcfs.modules.campioni.base.SpecieAnimali" %>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="org.aspcfs.modules.campioni.base.Analita"%>

<%@ include file="../utils23/initPage.jsp" %>

<link rel="stylesheet" type="text/css" media="screen" documentale_url="" href="pnaa/css/screen.css" />
<link rel="stylesheet" type="text/css" media="print" documentale_url="" href="pnaa/css/print.css" />

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>

<%!

public static String createBarcodeImage(String code) {

Barcode128 code128 = new Barcode128();
code128.setCode(code);
java.awt.Image im = code128.createAwtImage(Color.BLACK, Color.WHITE);
int w = im.getWidth(null);
int h = im.getHeight(null);
BufferedImage img = new BufferedImage(w, h+12, BufferedImage.TYPE_INT_ARGB);
Graphics2D g2d = img.createGraphics();
g2d.drawImage(im, 0, 0, null);
g2d.drawRect(0, h, w, 12);
g2d.fillRect(0, h+1, w, 12);
g2d.setColor(Color.WHITE);
String s = code128.getCode();
g2d.setColor(Color.BLACK);
//g2d.drawString(s,h+2,34);
g2d.drawString(s,0,34);
g2d.dispose();

ByteArrayOutputStream out = new ByteArrayOutputStream();
try {
   ImageIO.write(img, "PNG", out);
} catch (IOException e) {
  e.printStackTrace();
}
byte[] bytes = out.toByteArray();

String base64bytes = com.itextpdf.text.pdf.codec.Base64.encodeBytes(bytes);
String src = "data:image/png;base64," + base64bytes;

return src;
}; 

	public static String fixValore(String code) {
	if (code ==null || code.equals("null") || code.equals(""))
		return "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	else
		return code.toUpperCase();
	
}

public static String fixValoreLong(String code) {
	if (code ==null || code.equals("null") || code.equals(""))
		return "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	else
		return code.toUpperCase();
	
}

public static String fixValoreShort(String code) {
	if (code ==null || code.equals("null") || code.equals(""))
		return "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	else
		return code.toUpperCase();
	
}

public static boolean contiene(String[] array, int value) {
	
	for (int i = 0; i<array.length;i++){
		if (array[i].equals(value+""))
			return true;
	}
	return false;
}

%>

<script>

function calcolaCampioneGlobale(){
	
	if($('#numCE').val() != '' && $('#volume').val() != ''){
		$('#volume3').val($('#numCE').val() * $('#volume').val());
	}else{
		$('#volume3').val('');
	}
	
}

function gestisciRiduzione(valore){
	if(valore == 2){
		$('#volume2').val($('#volume3').val());
		$('#volume2').prop('readonly',true);
	}else{
		$('#volume2').prop('readonly',false);
	}
}

function gesticiNumeroCF(){
	if($('#volume2').val() != '' && $('#numeroCF').val() != ''){
		$('#quantitaGML').val($('#volume2').val() / $('#numeroCF').val() * 1000);
	}
	
	$('#numAliquoteCF').val($('#numeroCF').val());
	$('#numUnitaCampionarie').val($('#numeroCF').val());
	$('#pesoUnitaCampionaria').val($('#quantitaGML').val());
}

function verificaStatoCampione(dataChiusura){
	
	if(dataChiusura !=null && dataChiusura != '' && dataChiusura!="null"){
		var f = document.forms['addAccount'];
		for(var i=0,fLen=f.length;i<fLen;i++){

			if (f.elements[i].type == 'radio' || f.elements[i].type=='checkbox')
		    { 
		          f.elements[i].disabled = true;
		    } 
			else if (f.elements[i].type == 'submit')
		    { 
		          
		    } 
		    else {
			    
		  		f.elements[i].readOnly = true;
		  		f.elements[i].className = 'layout';
		    }
		}
		var g = document.forms['addAccount'].getElementsByTagName("textarea");
		for(var j=0; j < g.length; j++)
			 g.item(j).className = '';

		document.getElementById('salva').style.display = 'none';
	}
// 	else
// 		document.getElementById('generaPDF').style.display = 'none';

}

function setMatriceCampione(name, form){
	
	
	if (name=="mangimeComposto"){
		form.matriceCampione.value = 2;
	}
	if (name=="premiscelaAdditivi"){
		form.matriceCampione.value = 5;
	}
	if (name=="mangimeSempliceSpecifica"){
		form.matriceCampione.value = 1;
	}
	if (name=="categoriaSottoprodotti"){
		form.matriceCampione.value = 7;
	}
	
	var matriceCampione = document.getElementsByName("matriceCampione");
	for (var i=0; i<matriceCampione.length; i++)
		if (matriceCampione[i].checked){
			matriceCampione[i].click();
			break;
		}
	
	
}

function resetMatriceCampione(radio, form){
	var val = radio.value;
	
	if (val!="1") //materia prima
		form.mangimeSempliceSpecifica.value = "";
	
	if (val!="2"){ //mangime composto
		var mangimeComposto = document.getElementsByName("mangimeComposto");
		for (var i=0; i<mangimeComposto.length; i++)
			mangimeComposto[i].checked=false;
	}
	
	if (val!="5"){ //premiscela additivi
		var premiscelaAdditivi = document.getElementsByName("premiscelaAdditivi");
		for (var i=0; i<premiscelaAdditivi.length; i++)
			premiscelaAdditivi[i].checked=false;
	}
	
	if (val!="7"){ //categoria sottoprodotti
		var categoriaSottoprodotti = document.getElementsByName("categoriaSottoprodotti");
		for (var i=0; i<categoriaSottoprodotti.length; i++)
			categoriaSottoprodotti[i].checked=false;
	}
	
}

function checkCampioneMangime(cb) {

	var x = document.getElementsByName("dpa");
	for (var i = 0; i<x.length; i++)
		if (cb.checked)
			x[i].disabled = "";
		else{
			x[i].disabled = "disabled";
			x[i].checked = false;
		}
	
}

function checkConoscitivoMicotossine(radio) {

		if (radio.value == 'S' && radio.checked){
			var x = document.getElementsByName("idMicotossineTipo");
			for (var i = 0; i<x.length; i++){
				x[i].disabled = false;
			}
		} else if (radio.value == 'N' && radio.checked){
			var x = document.getElementsByName("idMicotossineTipo");
			for (var i = 0; i<x.length; i++){
				x[i].disabled = true;
				x[i].checked = false;
			}
		}		
	
}

function resetRadio(radio){
	var x = document.getElementsByName(radio);
	for (var i = 0; i<x.length; i++)
		x[i].checked = false;
}

function checkFormTemp(form){
	if (confirm('Salvare TEMPORANEAMENTE i dati inseriti?')){
		loadModalWindow();
		form.submit();
	}
}

function checkForm(form){
	
	var formTest = true;
	var messaggio = "";
	
	// x ogni if(non compilato)
	// evidenziare
	// else - togliere l'evidenziazione
	// quando formTest = true
	// togliere tutti i campi rossi
	
	if ((!form.campioneMangime.checked && form.dpa.value=='' && !form.campioneSottoprodotti.checked) || (form.campioneMangime.checked && form.dpa.value=='') ){
		$('#intestazione-dpa').prop('class','campo-error');
		formTest = false;
		messaggio += "Campioni di alimento.\n";
	}else{
		$('#intestazione-dpa').prop('class','');
	}
	if (form.strategiaCampionamento.value==''){
		formTest = false;
		messaggio += "A1. Strategia di campionamento\n";
	}
		
	if (form.metodoCampionamento.value==''){
		$('#intestazione-metodoCampionamento').prop('class','campo-error');
		formTest = false;
		messaggio += "A2. Metodo di campionamento\n";
	}else{
		$('#intestazione-metodoCampionamento').prop('class','');
	}
	
	if (form.programmaControllo.value=='3' || form.programmaControllo.value=='16' || form.programmaControllo.value=='17'){ //TITOLO, USO VIETATO, USO NON PRESCRITTO
		
		if (form.principiAdditivi.value==''){
			$('#intestazione-programmaControllo').prop('class','campo-error');
			formTest = false;
			messaggio += "A3. Programma di controllo nell'ambito del Pnaa e accertamenti richiesti - Principi additivi.\n"
		}else{
			$('#intestazione-programmaControllo').prop('class','');
		}
		
		if (form.principiAdditivi.value=='1' && form.programmaControlloFASpecifica.value == ''){
			$('#intestazione-programmaControllo').prop('class','campo-error');
			formTest = false;
			messaggio += "A3. Programma di controllo nell'ambito del Pnaa e accertamenti richiesti - Principi additivi - FA additivi (Specifica).\n"
		}else{
			$('#intestazione-programmaControllo').prop('class','');
		}
		if (form.principiAdditivi.value=='2' && form.programmaControlloANSpecifica.value == ''){
			$('#intestazione-programmaControllo').prop('class','campo-error');
			formTest = false;
			messaggio += "A3. Programma di controllo nell'ambito del Pnaa e accertamenti richiesti - Principi additivi - AN additivi (Specifica).\n"
		}else{
			$('#intestazione-programmaControllo').prop('class','');
		}
		if (form.principiAdditivi.value=='3' && form.programmaControlloCISpecifica.value == ''){
			$('#intestazione-programmaControllo').prop('class','campo-error');
			formTest = false;
			messaggio += "A3. Programma di controllo nell'ambito del Pnaa e accertamenti richiesti - Principi additivi - CI additivi (Specifica).\n"
		}else{
			$('#intestazione-programmaControllo').prop('class','');
		}
		if (form.principiAdditivi.value=='16' && form.programmaControlloATSpecifica.value == ''){
			$('#intestazione-programmaControllo').prop('class','campo-error');
			formTest = false;
			messaggio += "A3. Programma di controllo nell'ambito del Pnaa e accertamenti richiesti - Principi additivi - AT additivi (Specifica).\n"
		}else{
			$('#intestazione-programmaControllo').prop('class','');
		}
		if (form.principiAdditivi.value=='17' && form.programmaControlloAOSpecifica.value == ''){
			$('#intestazione-programmaControllo').prop('class','campo-error');
			formTest = false;
			messaggio += "A3. Programma di controllo nell'ambito del Pnaa e accertamenti richiesti - Principi additivi - AO additivi (Specifica).\n"
		}else{
			$('#intestazione-programmaControllo').prop('class','');
		}
		if (form.principiAdditivi.value=='6' && form.programmaControlloAZSpecifica.value == ''){
			$('#intestazione-programmaControllo').prop('class','campo-error');
			formTest = false;
			messaggio += "A3. Programma di controllo nell'ambito del Pnaa e accertamenti richiesti - Principi additivi - AZ additivi (Specifica).\n"
		}else{
			$('#intestazione-programmaControllo').prop('class','');
		}
	
	}
	
	if (form.programmaControllo.value=='12' ){
		
		if (form.micotossineSpecifica.value==''){
			$('#intestazione-programmaControllo').prop('class','campo-error');
			formTest = false;
			messaggio += "A3. Programma di controllo nell'ambito del Pnaa e accertamenti richiesti - Micotossine (Specifica)\n"
		}else{
			$('#intestazione-programmaControllo').prop('class','');
		}
		
		if (form.conoscitivoMicotossineS != null && form.conoscitivoMicotossineN != null && !$('input[name=conoscitivoMicotossine]:checked').length > 0){
			formTest = false;
			messaggio += "A3. Aliquota conoscitiva per Micotossine\n";
		}
		
		if (form.conoscitivoMicotossineS != null && form.conoscitivoMicotossineS.checked && !$('input[name=idMicotossineTipo]:checked').length > 0){
			formTest = false;
			messaggio += "A3. Tipo conoscitivo Micotossine\n";
		}
		
	}
	
	if (form.programmaControllo.value=='10'){
		
		if (form.principiAdditiviCO.value==''){
			$('#intestazione-programmaControllo').prop('class','campo-error');
			formTest = false;
			messaggio += "A3. Programma di controllo nell'ambito del Pnaa e accertamenti richiesti - Principi additivi CARRY OVER.\n"
		}else{
			$('#intestazione-programmaControllo').prop('class','');
		}
		
		if (form.principiAdditiviCO.value=='1' && form.programmaControlloCOFASpecifica.value == ''){
			$('#intestazione-programmaControllo').prop('class','campo-error');
			formTest = false;
			messaggio += "A3. Programma di controllo nell'ambito del Pnaa e accertamenti richiesti - Principi additivi CARRY OVER - FA additivi (Specifica).\n"
		}else{
			$('#intestazione-programmaControllo').prop('class','');
		}
		if (form.principiAdditiviCO.value=='2' && form.programmaControlloCOCISpecifica.value == ''){
			$('#intestazione-programmaControllo').prop('class','campo-error');
			formTest = false;
			messaggio += "A3. Programma di controllo nell'ambito del Pnaa e accertamenti richiesti - Principi additivi CARRY OVER - CI additivi (Specifica).\n"
		}else{
			$('#intestazione-programmaControllo').prop('class','');
		}
		
	}
	
	if (form.programmaControllo.value=='14'){ // Contaminanti inorganici
		
		if (form.contaminanti.value==''){
			$('#intestazione-programmaControllo').prop('class','campo-error');
			formTest = false;
			messaggio += "A3. Programma di controllo nell'ambito del Pnaa e accertamenti richiesti - Contaminanti.\n"
		}else{
			$('#intestazione-programmaControllo').prop('class','');
		}
		if (form.conoscitivoNitratiS != null && form.conoscitivoNitratiN != null && !$('input[name=conoscitivoNitrati]:checked').length > 0){
			formTest = false;
			messaggio += "A3. Aliquota conoscitiva per Nitrati\n";
		}
		if (form.conoscitivoRadionuclidiS != null && form.conoscitivoRadionuclidiN != null && !$('input[name=conoscitivoRadionuclidi]:checked').length > 0){
			formTest = false;
			messaggio += "A3. Aliquota conoscitiva per Radionuclidi\n";
		}
	}	
	
	if (form.programmaControllo.value=='18'){
		if (form.conoscitivoCromoS != null && form.conoscitivoCromoN != null && !$('input[name=conoscitivoCromo]:checked').length > 0){
			formTest = false;
			messaggio += "A3. Aliquota conoscitiva per Cromo\n";
		}
	}
	if (form.programmaControllo.value=='19'){
		
		if (form.altroSpecifica.value==''){
			$('#intestazione-programmaControllo').prop('class','campo-error');
			formTest = false;
			messaggio += "A3. Programma di controllo nell'ambito del Pnaa e accertamenti richiesti - Altro (Specifica).\n"
		}else{
			$('#intestazione-programmaControllo').prop('class','');
		}
			
	}
	
	if (form.luogoPrelievo.value==''){
		$('#intestazione-luogoPrelievo').prop('class','campo-error');
		formTest = false;
		messaggio += "A5. Luogo di prelievo\n"
	}else{
		$('#intestazione-luogoPrelievo').prop('class','');
	}
	
	if (form.telefono.value==''){
		$('#telefono').prop('class','editField-error');
		formTest = false;
		messaggio += "A16. Telefono\n"
	}else{
		$('#telefono').prop('class','editField');
	}
	
	if (form.matriceCampione.value==''){
		$('#intestazione-matriceCampione').prop('class','campo-error');
		formTest = false;
		messaggio += "B1. Matrice del campione\n";
	}else{
		
		if (form.matriceCampione.value=='1' && form.mangimeSempliceSpecifica.value==''){
			$('#intestazione-matriceCampione').prop('class','campo-error');
			formTest = false;
			messaggio += "B1. Matrice del campione - Materia prima/mangime semplice\n";
		}else{
			$('#intestazione-matriceCampione').prop('class','');
		}
		if (form.matriceCampione.value=='2' && form.mangimeComposto.value==''){
			$('#intestazione-matriceCampione').prop('class','campo-error');
			formTest = false;
			messaggio += "B1. Matrice del campione - Mangime composto\n";
		}else{
			$('#intestazione-matriceCampione').prop('class','');
		}
		if (form.matriceCampione.value=='5' && form.premiscelaAdditivi.value==''){
			$('#intestazione-matriceCampione').prop('class','campo-error');
			formTest = false;
			messaggio += "B1. Matrice del campione - Premiscela di additivi\n";
		}else{
			$('#intestazione-matriceCampione').prop('class','');
		}
		if (form.matriceCampione.value=='7' && form.categoriaSottoprodotti.value==''){
			$('#intestazione-matriceCampione').prop('class','campo-error');
			formTest = false;
			messaggio += "B1. Matrice del campione - Categoria sottoprodotti\n";
		}else{
			$('#intestazione-matriceCampione').prop('class','');
		}
	}
	
	if (form.trattamentoMangime.value==''){
		$('#trattamentoMangime').prop('class','editField-error');
		formTest = false;
		messaggio += "B2. Trattamento applicato al mangime prelevato\n"
	}else{
		$('#trattamentoMangime').prop('class','editField');
	}
	
	if (form.confezionamento.value==''){
		$('#intestazione-confezionamento').prop('class','campo-error');
		formTest = false;
		messaggio += "B3. Confezionamento\n"
	}else{
		$('#intestazione-confezionamento').prop('class','');
	}
	if (form.ragioneSocialeDittaProduttrice.value==''){
		$('#ragioneSocialeDittaProduttrice').prop('class','editField-error');
		formTest = false;
		messaggio += "B4. Ragione sociale ditta produttrice\n"
	}else{
		$('#ragioneSocialeDittaProduttrice').prop('class','editField');
	}
	if (form.indirizzoDittaProduttrice.value==''){
		$('#indirizzoDittaProduttrice').prop('class','editField-error');
		formTest = false;
		messaggio += "B5. Indirizzo ditta produttrice\n"
	}else{
		$('#indirizzoDittaProduttrice').prop('class','editField');
	}
	
	var specieAlimentoDestinatoCheck = false;
	var checkboxesSpecieAlimentoDestinato = form.querySelectorAll('input[type=checkbox]');
	for (var i=0; i<checkboxesSpecieAlimentoDestinato.length; i++){
		if (checkboxesSpecieAlimentoDestinato[i].name.startsWith("specieAlimentoDestinato") && checkboxesSpecieAlimentoDestinato[i].checked){
			specieAlimentoDestinatoCheck=true;
			break;
		}
	}
	
	if (!specieAlimentoDestinatoCheck){
		$('#intestazione-specieAlimentoDestinato').prop('class','campo-error');
		formTest = false;
		messaggio += "B6. Specie e categoria animale a cui l'alimento e' destinato\n"
	}else{
		$('#intestazione-specieAlimentoDestinato').prop('class','');
	}
	if (form.metodoProduzione.value==''){
		$('#intestazione-metodoProduzione').prop('class','campo-error');
		formTest = false;
		messaggio += "B7. Metodo di produzione\n"
	}else{
		$('#intestazione-metodoProduzione').prop('class','');
	}
	if (form.nomeCommercialeMangime.value==''){
		$('#nomeCommercialeMangime').prop('class','editField-error');
		formTest = false;
		messaggio += "B8. Nome commerciale del mangime\n"
	}else{
		$('#nomeCommercialeMangime').prop('class','editField');
	} 
	
	var statoProdottoCheck = false;
	var checkboxesStatoProdotto = form.querySelectorAll('input[type=checkbox]');
	for (var i=0; i<checkboxesStatoProdotto.length; i++){
		if (checkboxesStatoProdotto[i].name.startsWith("statoProdottoPrelievo") && checkboxesStatoProdotto[i].checked){
			statoProdottoCheck=true;
			break;
		}
	}
	
	if (!statoProdottoCheck){
		$('#intestazione-statoProdottoPrelievo').prop('class','campo-error');
		formTest = false;
		messaggio += "B9. Stato del prodotto al momento del prelievo\n"
	}else{
		$('#intestazione-statoProdottoPrelievo').prop('class','');
	}			
	if (form.responsabileEtichettatura.value==''){
		$('#responsabileEtichettatura').prop('class','editField-error');
		formTest = false;
		messaggio += "B10. Ragione sociale responsabile etichettatura\n"
	}else{
		$('#responsabileEtichettatura').prop('class','editField');
	}
	if (form.indirizzoResponsabileEtichettatura.value==''){
		$('#indirizzoResponsabileEtichettatura').prop('class','editField-error');
		formTest = false;
		messaggio += "B11. Indirizzo responsabile etichettatura\n"
	}else{
		$('#indirizzoResponsabileEtichettatura').prop('class','editField');
	}
	if (form.paeseProduzione.value==''){
		$('#paeseProduzione').prop('class','editField-error');
		formTest = false;
		messaggio += "B12. Paese di produzione\n"
	}else{
		$('#paeseProduzione').prop('class','editField');
	}
	if (form.dataProduzione.value==''){
		$('#dataProduzione').prop('class','editField-error');
		formTest = false;
		messaggio += "B13. Data di produzione\n"
	}else{
		$('#dataProduzione').prop('class','editField');
	}
	if (form.dataScadenza.value==''){
		$('#dataScadenza').prop('class','editField-error');
		formTest = false;
		messaggio += "B14. Data di scadenza\n"
	}else{
		$('#dataScadenza').prop('class','editField');
	}
	if (form.numLotto.value==''){
		$('#numLotto').prop('class','editField-error');
		formTest = false;
		messaggio += "B15. Numero di lotto\n"
	}else{
		$('#numLotto').prop('class','editField');
	}
	if (form.dimensioneLotto.value==''){
		$('#dimensioneLotto').prop('class','editField-error');
		formTest = false;
		messaggio += "B16. Dimensione di lotto\n"
	}else{
		$('#dimensioneLotto').prop('class','editField');
	}
	if (form.ingredienti.value==''){
		$('#ingredienti').prop('class','editField-error');
		formTest = false;
		messaggio += "B17. Ingredienti\n"
	}else{
		$('#ingredienti').prop('class','editField');
	}
	
	if (form.allegaCartellino.value==''){
		$('#intestazione-allegaCartellino').prop('class','campo-error');
		formTest = false;
		messaggio += "D. Informazioni cartellino\n"
	}else{
		$('#intestazione-allegaCartellino').prop('class','');
	}
	if (form.descrizioneAttrezzature.value==''){
		$('#descrizioneAttrezzature').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Descrizione attrezzature\n"
	}else{
		$('#descrizioneAttrezzature').prop('class','editField');
	}
	if (form.numPunti.value==''){
		$('#numPunti').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Num punti\n"
	}else{
		$('#numPunti').prop('class','editField');
	}
	if (form.numCE.value==''){
		$('#numCE').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Num CE\n"
	}else{
		$('#numCE').prop('class','editField');
	}
	if (form.volume.value==''){
		$('#volume').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Peso/Volume\n"
	}else{
		$('#volume').prop('class','editField');
	}
	if (form.operazioni.value==''){
		$('#operazioni').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Operazioni\n"
	}else{
		$('#operazioni').prop('class','editField');
	}
	if (form.volume3.value==''){
		$('#volume3').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Volume finale\n"
	}else{
		$('#volume3').prop('class','editField');
	}
	if (form.cgRidotto.value==''){
		$('#intestazione-cgRidotto').prop('class','campo-error');
		formTest = false;
		messaggio += "D. CG Ridotto\n"
	}else{
		$('#intestazione-cgRidotto').prop('class','');
	}
	if (form.volume2.value==''){
		$('#volume2').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Peso/Volume Ridotto\n"
	}else{
		$('#volume2').prop('class','editField');
	}
	if (form.operazioni2.value==''){
		$('#operazioni2').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Operazioni campione globale\n"
	}else{
		$('#operazioni2').prop('class','editField');
	}
	if (form.numeroCF.value==''){
		$('#numeroCF').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Numero CF\n"
	}else{
		$('#numeroCF').prop('class','editField');
	}
	if (form.quantitaGML.value==''){
		$('#quantitaGML').prop('class','editField-error');
		formTest = false;
		messaggio += "D. CF G/ML\n"
	}else{
		$('#quantitaGML').prop('class','editField');
	}
	if (form.dichiarazione.value==''){
		$('#dichiarazione').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Dichiarazione proprietario o detentore\n"
	}else{
		$('#dichiarazione').prop('class','editField');
	}
	if (form.numCampioniFinaliInvio.value==''){
		$('#numCampioniFinaliInvio').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Numero campioni finali\n"
	}else{
		$('#numCampioniFinaliInvio').prop('class','editField');
	}
	if (form.numCopieInvio.value==''){
		$('#numCopieInvio').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Numero copie del verbale\n"
	}else{
		$('#numCopieInvio').prop('class','editField');
	}
	if (form.destinazioneInvio.value==''){
		$('#destinazioneInvio').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Destinazione invio copie del verbale\n"
	}else{
		$('#destinazioneInvio').prop('class','editField');
	}
	if (form.dataInvio.value==''){
		$('#dataInvio').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Data invio\n"
	}else{
		$('#dataInvio').prop('class','editField');
	}
	if (form.conservazioneCampione.value==''){
		$('#conservazioneCampione').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Conservazione del campione\n"
	}else{
		$('#conservazioneCampione').prop('class','editField');
	}
	if (form.numCopie.value==''){
		$('#numCopie').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Numero copie del verbale (Campione)\n"
	}else{
		$('#numCopie').prop('class','editField');
	}
	if (form.numCampioniFinali.value==''){
		$('#numCampioniFinali').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Numero campioni finali\n"
	}else{
		$('#numCampioniFinali').prop('class','editField');
	}
	if (form.custode.value==''){
		$('#custode').prop('class','editField-error');
		formTest = false;
		messaggio += "D. Custode campione\n"
	}else{
		$('#custode').prop('class','editField');
	}
	
	if (form.campioneFinale.value==''){
		if(form.numCopie.value=='0' && form.numCampioniFinali.value=='0'){
			$('#intestazione-campioneFinale').prop('class','');
			$('#campioneFinale1').prop('disabled',true);
			$('#campioneFinale2').prop('disabled',true);
						

		}else {
			formTest = false;
			$('#campioneFinale1').prop('disabled',false);
			$('#campioneFinale2').prop('disabled',false);

			messaggio += "D. Per conto di\n"
		}
	}
	
	if(form.numCopie.value=='0' && form.numCampioniFinali.value=='0' && form.campioneFinale.value!='') {
		$('#campioneFinale1').prop('checked',false);
		$('#campioneFinale2').prop('checked',false);
		$('#campioneFinale1').prop('disabled',true);
		$('#campioneFinale2').prop('disabled',true);
	}



	<% if(Mod.getIdProgrammaControllo() !=7) { %> 
	if (form.rinunciaCampione.value==''){
		$('#intestazione-rinunciaCampione').prop('class','campo-error');
		formTest = false;
		messaggio += "D. Rinuncia per controversia/controperizia\n"
	}else{
		$('#intestazione-rinunciaCampione').prop('class','');
	}
	<% } %>
	if (form.sequestroPartita.value==''){
		$('#intestazione-sequestroPartita').prop('class','campo-error');
		formTest = false;
		messaggio += "D. Sequestro partita\n"
	}else{
		$('#intestazione-sequestroPartita').prop('class','');
	}
	
	<% if(Mod.getIdProgrammaControllo() ==7) { %>
	
	if (form.numAliquoteCF.value==''){
		$('#numAliquoteCF').prop('class','editField-error');
		formTest = false;
		messaggio += "Numero Aliquote Campione Finale\n"
	}else{
		$('#numAliquoteCF').prop('class','editField');
	}
	
	if (form.numUnitaCampionarie.value==''){
		$('#numUnitaCampionarie').prop('class','editField-error');
		formTest = false;
		messaggio += "Numero Unita' Campionarie\n"
	}else{
		$('#numUnitaCampionarie').prop('class','editField');
	}
	
	if (form.pesoUnitaCampionaria.value==''){
		$('#pesoUnitaCampionaria').prop('class','editField-error');
		formTest = false;
		messaggio += "Peso Unita' Campionarie\n"
	}else{
		$('#pesoUnitaCampionaria').prop('class','editField');
	}
	
	if (form.dataInizioAnalisi.value==''){
		$('#dataInizioAnalisi').prop('class','editField-error');
		formTest = false;
		messaggio += "Data Inizio Analisi\n"
	}else{
		$('#dataInizioAnalisi').prop('class','editField');
	}
	
	if (form.oraInizioAnalisi.value==''){
		$('#oraInizioAnalisi').prop('class','editField-error');
		formTest = false;
		messaggio += "Ora Inizio Analisi\n"
	}else{
		$('#oraInizioAnalisi').prop('class','editField');
	}
	<% } %>
	
	if (!formTest){
		alert("I dati non possono essere salvati. Controllare i seguenti errori o campi non valorizzati: \n\n" + messaggio);
		return false;
	}
	
	if (confirm('Salvare i dati inseriti?')){
		loadModalWindow();
		form.bozza.value = 'false';
		form.submit();
	}
					
}

</script>


<form name="addAccount"	action="GestionePnaa.do?command=Save&auto-populate=true" method="post">

<!-- INTESTAZIONE -->

<%@ include file="mod_pnaa_header.jsp" %>

<!-- DETTAGLIO CAMPIONE -->

L'anno <label class="layout"><%= fixValoreShort(Mod.getCampioneAnno())%></label> addi' <label class="layout"><%= fixValoreShort(Mod.getCampioneGiorno())%></label> del mese di <label class="layout"><%= fixValoreShort(Mod.getCampioneMese())%></label> alle ore <input type="text" class="editField" size="5" id="ore" name="ore" value="<%= toHtml(Mod.getCampioneOre())%>"/> alla presenza del Sig. <input type="text" class="editField" name="campionePresente" id="campionePresente" value="<%=toHtml(Mod.getCampionePresente())%>"/>, nella sua qualita' di titolare/rappresentante/detentore della merce, i sottoscritti dr. <label class="layout"><%= fixValore(Mod.getCampioneSottoscritto())%></label>, dopo essersi qualificati e aver fatto conoscere lo scopo della visita, hanno proceduto al prelievo di n. <input type="number" class="editField" size="4" min="0" step="1" name="numPrelevati" id="numPrelevati" value="<%= fixValore(Mod.getCampioneNumPrelevati())%>"/> :<br/> 


<input type="checkbox" name="campioneMangime" id="campioneMangime" <%="S".equals(Mod.getCampioneMangime()) ? "checked" : ""  %> value="S" onChange="checkCampioneMangime(this)"> campioni di MANGIME/ACQUA<br/>

<% for (int i = 0; i<DpaList.size(); i++){ 
LookupElement thisElement = (LookupElement) DpaList.get(i);%>
&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="dpa" id="dpa<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>"
<%=(Mod.getIdDpa() == thisElement.getCode() ) ? "checked" : ""  %> <%=!"S".equals(Mod.getCampioneMangime()) ? "disabled" : ""  %> > <%=thisElement.getDescription() %> <br/>
<% } %>

<input type="checkbox" name="campioneSottoprodotti" id="campioneSottoprodotti" <%="S".equals(Mod.getCampioneSottoprodotti()) ? "checked" : ""  %> value="S"> campioni di Sottoprodotti di Categoria 1 - 2 - 3
<br/><br/>

<!-- SEZIONE A -->

<b>A. PARTE GENERALE</b><br/><br/>

<table width="100%">
<col width="50%">
<tr><th colspan="2"><b>A1. Strategia di campionamento</b></th></tr>
<% for (int i = 0; i<StrategiaCampionamentoList.size(); i++){ 
LookupElement thisElement = (LookupElement) StrategiaCampionamentoList.get(i);%>
<%=(i==0) ? "<tr>" : "" %>
<td>
<input type="radio" disabled name="strategiaCampionamento" id="strategiaCampionamento<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>"  
<%=(Mod.getIdStrategiaCampionamento() == thisElement.getCode() ) ? "checked" : ""  %>/>
<%=thisElement.getDescription() %>

 </td> 
<%=(i%2==1) ? "</tr><tr>" : "" %>
<% } %>
</tr></table>


<table width="100%">
<col width="50%">
<tr><th colspan="2"><b id="intestazione-metodoCampionamento">A2. Metodo di campionamento (*)</b></th></tr>
<% for (int i = 0; i<MetodoCampionamentoList.size(); i++){ 
LookupElement thisElement = (LookupElement) MetodoCampionamentoList.get(i);%>
<%=(i==0) ? "<tr>" : "" %>
<td>
<input type="radio" name="metodoCampionamento" id="metodoCampionamento<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>" 
<%=(Mod.getIdMetodoCampionamento() == thisElement.getCode() ) ? "checked" : ""  %>> <%=thisElement.getDescription() %></td>
<%=(i%2==1) ? "</tr><tr>" : "" %>
<% } %>
</tr></table>

<% 
boolean previstoConoscitivoCromo = PrevistiConoscitivi != null && PrevistiConoscitivi.size()>0 ? (Boolean) PrevistiConoscitivi.get(0) : false;
boolean previstoConoscitivoMicotossine = PrevistiConoscitivi != null && PrevistiConoscitivi.size()>1 ? (Boolean) PrevistiConoscitivi.get(1) : false;
boolean previstoConoscitivoNitrati = PrevistiConoscitivi != null && PrevistiConoscitivi.size()>2 ? (Boolean) PrevistiConoscitivi.get(2) : false;
boolean previstoConoscitivoRadionuclidi = PrevistiConoscitivi != null && PrevistiConoscitivi.size()>3 ? (Boolean) PrevistiConoscitivi.get(3) : false;
%>

<table width="100%">
<col width="50%">

<tr><th colspan="2"><b id="intestazione-programmaControllo">A3. Programma di controllo nell'ambito del Pnaa e accertamenti richiesti (*)</b></th></tr>

<% for (int i = 0; i<ProgrammaControlloList.size(); i++){ 
LookupElement thisElement = (LookupElement) ProgrammaControlloList.get(i);%>

<% if (i == 0) { %>
<tr>
<%} %>
<% if (i%2 == 0){ %>
</tr><tr>
<%} %>

<td valign="top">

<% if (thisElement.getCode()==3) {  //Titolo, uso illecito, uso improprio %> 
<input type="checkbox" disabled <%= (Mod.getIdProgrammaControllo()==3 || Mod.getIdProgrammaControllo()==16 || Mod.getIdProgrammaControllo()==17) ? "checked" : "" %>/> <b>Sostanze farmacologicamente attivi e additivi</b>
<%} %>

<input type="radio" disabled name="programmaControllo" id="programmaControllo<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>" 
<%=(Mod.getIdProgrammaControllo() == thisElement.getCode() ) ? "checked" : ""  %>> <b><%=thisElement.getDescription() %></b> 
<% if ((thisElement.getCode()==3 || thisElement.getCode()==16 || thisElement.getCode()==17) && Mod.getIdProgrammaControllo()==thisElement.getCode()) { //Titolo, uso illecito, uso improprio %>
 
<table width="100%">
<col width="50%">
<% for (int j = 0; j<PrincipiAdditiviList.size(); j++){ 
LookupElement thisElement2 = (LookupElement) PrincipiAdditiviList.get(j);%>
<tr>
<td>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="principiAdditivi" id="principiAdditivi<%=thisElement2.getCode() %>" value="<%=thisElement2.getCode() %>" 
<%=(Mod.getIdPrincipiAdditivi() == thisElement2.getCode() ) ? "checked" : ""  %>> <%=thisElement2.getDescription() %>

<% if (thisElement2.getCode()==1) { //Principi farm. attivi %> 
<b>( Specificare: </b> <input type="text" class="editField" name="programmaControlloFASpecifica" id="programmaControlloFASpecifica" value="<%=toHtml(Mod.getProgrammaControlloFASpecifica())%>"/> )
<%} %> 
<% if (thisElement2.getCode()==2) { //additivi nutrizionali %> 
<b>( Specificare: </b> <input type="text" class="editField" name="programmaControlloANSpecifica" id="programmaControlloANSpecifica" value="<%=toHtml(Mod.getProgrammaControlloANSpecifica())%>"/> )
<%} %> 
<% if (thisElement2.getCode()==3) { //cocciodiostatici/istomonostatici %> 
<b>( Specificare: </b> <input type="text" class="editField" name="programmaControlloCISpecifica" id="programmaControlloCISpecifica" value="<%=toHtml(Mod.getProgrammaControlloCISpecifica())%>"/> )
<%} %> 
<% if (thisElement2.getCode()==4) { //additivi tecnologici %> 
<b>( Specificare: </b> <input type="text" class="editField" name="programmaControlloATSpecifica" id="programmaControlloATSpecifica" value="<%=toHtml(Mod.getProgrammaControlloATSpecifica())%>"/> )
<%} %> 
<% if (thisElement2.getCode()==5) { //additivi organolettici %> 
<b>( Specificare: </b> <input type="text" class="editField" name="programmaControlloAOSpecifica" id="programmaControlloAOSpecifica" value="<%=toHtml(Mod.getProgrammaControlloAOSpecifica())%>"/> )
<%} %> 
<% if (thisElement2.getCode()==6) { //additivi zootecnici %> 
<b>( Specificare: </b> <input type="text" class="editField" name="programmaControlloAZSpecifica" id="programmaControlloAZSpecifica" value="<%=toHtml(Mod.getProgrammaControlloAZSpecifica())%>"/> )
<%} %> 

</td>
</tr>
<% } %>
</table>

<%} %> 
<% if (thisElement.getCode()==12 && Mod.getIdProgrammaControllo()==thisElement.getCode()) { // Micotossine %> 
<b>( Specificare: </b> <input type="text" class="editField" name="micotossineSpecifica" id="micotossineSpecifica" value="<%=toHtml(Mod.getMicotossineSpecifica())%>"/> )
<br/>
<% if (previstoConoscitivoMicotossine){ %>

<br/>Aliquota conoscitiva per MICOTOSSINE
<input type="radio" name="conoscitivoMicotossine" id="conoscitivoMicotossineS" <%="S".equals(Mod.getAliquotaConoscitivaMicotossine()) ? "checked" : ""  %> value="S" onClick="checkConoscitivoMicotossine(this)">SI
<input type="radio" name="conoscitivoMicotossine" id="conoscitivoMicotossineN" <%="N".equals(Mod.getAliquotaConoscitivaMicotossine()) ? "checked" : ""  %> value="N" onClick="checkConoscitivoMicotossine(this)">NO

<br/>
<% for (int k = 0; k<MicotossineList.size(); k++){ 
	LookupElement m = (LookupElement) MicotossineList.get(k);
	%>
<input type="radio" name="idMicotossineTipo" id="idMicotossineTipo<%=m.getCode() %>" <%=m.getCode() == Mod.getIdMicotossineTipo() ? "checked" : ""  %> <%=!"S".equals(Mod.getAliquotaConoscitivaMicotossine()) ? "disabled" : ""  %> value="<%=m.getCode()%>"><%=m.getDescription() %><br/>
<%}	%>

<%} %>

<%} %> 
<% if (thisElement.getCode()==18 && Mod.getIdProgrammaControllo()==thisElement.getCode()) { // Additivi nutrizionali %> 
<b>( Specificare: </b> <input type="text" class="editField" name="additiviNutrizionaliSpecifica" id="additiviNutrizionaliSpecifica" value="<%=toHtml(Mod.getAdditiviNutrizionaliSpecifica())%>"/> )
<br/>

<% if (previstoConoscitivoCromo){ %>
<br/>Aliquota conoscitiva per CROMO
<input type="radio" name="conoscitivoCromo" id="conoscitivoCromoS" <%="S".equals(Mod.getAliquotaConoscitivaCromo()) ? "checked" : ""  %> value="S">SI
<input type="radio" name="conoscitivoCromo" id="conoscitivoCromoN" <%="N".equals(Mod.getAliquotaConoscitivaCromo()) ? "checked" : ""  %> value="N">NO
<%} %>

<%} %> 
<% if (thisElement.getCode()==10 && Mod.getIdProgrammaControllo()==thisElement.getCode()) { //Principi farmacologicamente attivi e additivi per CARRY OVER %> 

<table width="100%">
<col width="50%">
<% for (int j = 0; j<PrincipiAdditiviCOList.size(); j++){ 
LookupElement thisElement2 = (LookupElement) PrincipiAdditiviCOList.get(j);%>
<tr>
<td>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="principiAdditiviCO" id="principiAdditiviCO<%=thisElement2.getCode() %>" value="<%=thisElement2.getCode() %>" 
<%=(Mod.getIdPrincipiAdditiviCO() == thisElement2.getCode() ) ? "checked" : ""  %>> <%=thisElement2.getDescription() %>

<% if (thisElement2.getCode()==1) { //Principi farm. attivi %> 
<b>( Specificare: </b> <input type="text" class="editField" name="programmaControlloCOFASpecifica" id="programmaControlloCOFASpecifica" value="<%=toHtml(Mod.getProgrammaControlloCOFASpecifica())%>"/> )
<%} %> 
<% if (thisElement2.getCode()==2) { //cocciodiostatici/istomonostatici %> 
<b>( Specificare: </b> <input type="text" class="editField" name="programmaControlloCOCISpecifica" id="programmaControlloCOCISpecifica" value="<%=toHtml(Mod.getProgrammaControlloCOCISpecifica())%>"/> )
<%} %> 

</td>
</tr>

<% } %>

<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;Quantita' di P.A./Coccidiostatico aggiunta in produzione nel lotto precedente</td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" class="editField" name="quantitaPa" id="quantitaPa" value="<%= toHtml(Mod.getQuantitaPa())%>"/></td></tr>

</table>

<%} %> 
<% if (thisElement.getCode()==14 && Mod.getIdProgrammaControllo()==thisElement.getCode()) { //Contaminanti inorganici e composti azotati,composti organoclorurati, radionuclidi %> 

<table width="100%">
<col width="50%">
<% for (int j = 0; j<ContaminantiList.size(); j++){ 
LookupElement thisElement2 = (LookupElement) ContaminantiList.get(j);%>
<tr>
<td>
<input type="radio" name="contaminanti" id="contaminanti<%=thisElement2.getCode() %>" value="<%=thisElement2.getCode() %>" 
<%=(Mod.getIdContaminanti() == thisElement2.getCode() ) ? "checked" : ""  %>> <%=thisElement2.getDescription() %>

</td>
</tr>
<% } %>

<% if (previstoConoscitivoRadionuclidi){ %>
<tr><td>Aliquota conoscitiva per RADIONUCLIDI 
<input type="radio" name="conoscitivoRadionuclidi" id="conoscitivoRadionuclidiS" <%="S".equals(Mod.getAliquotaConoscitivaRadionuclidi()) ? "checked" : ""  %> value="S">SI
<input type="radio" name="conoscitivoRadionuclidi" id="conoscitivoRadionuclidiN" <%="N".equals(Mod.getAliquotaConoscitivaRadionuclidi()) ? "checked" : ""  %> value="N">NO
</td></tr>
<%} %>

<% if (previstoConoscitivoNitrati){ %>
<tr><td>Aliquota conoscitiva per NITRATI 
<input type="radio" name="conoscitivoNitrati" id="conoscitivoNitratiS" <%="S".equals(Mod.getAliquotaConoscitivaNitrati()) ? "checked" : ""  %> value="S">SI
<input type="radio" name="conoscitivoNitrati" id="conoscitivoNitratiN" <%="N".equals(Mod.getAliquotaConoscitivaNitrati()) ? "checked" : ""  %> value="N">NO
</td></tr>
<%} %>

</table>

<%} %> 
<% if (thisElement.getCode()==19 && Mod.getIdProgrammaControllo()==thisElement.getCode()) { //Altro %> 
<b>( Specificare: </b> <input type="text" class="editField" name="altroSpecifica" id="altroSpecifica" value="<%=toHtml(Mod.getAltroSpecifica())%>"/> )
<%} %> 
</td>
<% } %>

</table>

<table width="100%">
<tr><th><b>A4. Prelevatore (Nome e Cognome) (*)</b></th></tr>
<tr><td><label class="layout"><%= toHtml(Mod.getPrelevatore())%></label></td></tr>
</table>

<table width="100%">
<col width="50%">
<tr><th colspan="2"><b id="intestazione-luogoPrelievo">A5. Luogo di prelievo (*)</b></th></tr>
<% for (int i = 0; i<LuogoPrelievoList.size(); i++){ 
LookupElement thisElement = (LookupElement) LuogoPrelievoList.get(i);%>
<%=(i==0) ? "<tr>" : "" %>
<td>
<input type="radio" name="luogoPrelievo" id="luogoPrelievo<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>" 
<%=(Mod.getIdLuogoPrelievo() == thisElement.getCode() ) ? "checked" : ""  %>> <%=thisElement.getDescription() %></td>
<%=(i%2==1) ? "</tr><tr>" : "" %>
<% } %>
</tr></table>

<table width="100%">
<col width="33%">
<tr><th><b>A6. Codice identificativo luogo di prelievo (*)</b></th> <th><b>Codice SINVSA</b></th>  <th><b>A7. Targa mezzo di trasporto</b></th></tr>
<tr><td><label class="layout"><%= fixValore(Mod.getCodiceLuogoPrelievo())%></label></td>
<td><label class="layout"><%= fixValore(Mod.getCampioneCodiceSinvsa())%></label></td>
<td><input type="text" class="editField" name="targaMezzo" id="targaMezzo" value="<%= toHtml(Mod.getTargaMezzo())%>"/></td></tr>
</table>

<table width="100%">
<col width="33%">
<tr><th><b>A8. Indirizzo del luogo di prelievo (*)</b></th> <th><b>A9. Comune (*)</b> </th> <th><b>A10. Provincia (*)</b></th></tr>
<tr><td><label class="layout"><%= fixValore(Mod.getIndirizzoLuogoPrelievo())%></label></td>
<td><label class="layout"><%= fixValore(Mod.getComuneLuogoPrelievo())%></label><br/></td>
<td><label class="layout"><%= fixValore(Mod.getProvinciaLuogoPrelievo())%></label></td></tr>
</table>

<table width="100%">
<col width="50%">
<tr><th colspan="2"><b>A11. Localizzazione geografica del punto di prelievo (WGS84-Formato decimale)</b></th></tr>
<tr><td> Latitudine <label class="layout"><%= fixValoreShort(Mod.getLatLuogoPrelievo())%></label></td>
<td>Longitudine <label class="layout"><%= fixValoreShort(Mod.getLonLuogoPrelievo())%></label></td></tr>
</table>

<table width="100%">
<col width="50%">
<tr><th><b>A12. Ragione sociale</b></th> <th><b>A13. Rappresentante legale (*)</b></th></tr>
<tr><td><label class="layout"><%= fixValore(Mod.getRagioneSociale())%></label></td>
<td><label class="layout"><%= fixValore(Mod.getRappresentanteLegale())%></label></td></tr>
</table>

<table width="100%">
<col width="50%">
<tr><th><b>A14. Codice fiscale (*)</b></th> <th><b>A15. Detentore (*)</b> </th></tr>
<tr><td><label class="layout"><%= fixValore(Mod.getCodiceFiscale())%></label></td>
<td><label class="layout"><%= fixValore(Mod.getDetentore())%></label></td></tr>
</table>

<table width="100%">
<tr><th>A16. Telefono (*)</b></th></tr>
<tr><td><input type="text" class="editField" name="telefono" id="telefono" value="<%= toHtml(Mod.getTelefono())%>"/></td></tr>
</table>

<br/><br/>

<div style="page-break-before:always">&nbsp; </div>

<!-- SEZIONE B -->

<b>B. INFORMAZIONI SUL CAMPIONE PRELEVATO</b><br/><br/>

<table width="100%">
<col width="33%"><col width="33%">
<tr><th colspan="3"><b id="intestazione-matriceCampione">B1. Matrice del campione (*):</b></th></tr>
<% for (int i = 0; i<MatriceCampioneList.size(); i++){ 
LookupElement thisElement = (LookupElement) MatriceCampioneList.get(i);%>
<%=(i==0) ? "<tr>" : "" %>
<td>
<input type="radio" name="matriceCampione" id="matriceCampione<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>" onClick="resetMatriceCampione(this, this.form)"
<%=(Mod.getIdMatriceCampione() == thisElement.getCode() ) ? "checked" : ""  %>> <b><%=thisElement.getDescription() %></b>
<% if (thisElement.getCode()==1) {  //Materia prima/mangime semplice %> 

<b><input type="text" class="editField" name="mangimeSempliceSpecifica" id="mangimeSempliceSpecifica" value="<%=toHtml(Mod.getMangimeSempliceSpecifica())%>" onChange="setMatriceCampione(this.name, this.form)"/>

<%} %> 

<% if (thisElement.getCode()==2) { //Mangime composto %> 
<table width="100%">
<col width="50%">
<% for (int j = 0; j<MangimeCompostoList.size(); j++){ 
LookupElement thisElement2 = (LookupElement) MangimeCompostoList.get(j);%>
<tr>
<td>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="mangimeComposto" id="mangimeComposto<%=thisElement2.getCode() %>" value="<%=thisElement2.getCode() %>" onClick="setMatriceCampione(this.name, this.form)"
<%=(Mod.getIdMangimeComposto() == thisElement2.getCode() ) ? "checked" : ""  %>> <%=thisElement2.getDescription() %>
</td>
</tr>
<% } %>
</table>

<%} %> 

<% if (thisElement.getCode()==7) { //Categoria sottoprodotti %> 
(solo per la ricerca del GTH)
<table width="100%">
<col width="50%">
<% for (int j = 0; j<SottoprodottiList.size(); j++){ 
LookupElement thisElement2 = (LookupElement) SottoprodottiList.get(j);%>
<tr>
<td>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="categoriaSottoprodotti" id="categoriaSottoprodotti<%=thisElement2.getCode() %>" value="<%=thisElement2.getCode() %>" onClick="setMatriceCampione(this.name, this.form)"
<%=(Mod.getIdCategoriaSottoprodotti() == thisElement2.getCode() ) ? "checked" : ""  %>> <%=thisElement2.getDescription() %>
</td>
</tr>
<% } %>
</table>

<%} %> 

<% if (thisElement.getCode()==5) { //Premiscela di additivi (indicare le categorie di additivi che costituiscono la premiscela): %> 
(indicare le categorie di additivi che costituiscono la premiscela)
<table width="100%">
<col width="50%">
<% for (int j = 0; j<PremiscelaAdditiviList.size(); j++){ 
LookupElement thisElement2 = (LookupElement) PremiscelaAdditiviList.get(j);%>
<tr>
<td>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="premiscelaAdditivi" id="premiscelaAdditivi<%=thisElement2.getCode() %>" value="<%=thisElement2.getCode() %>" onClick="setMatriceCampione(this.name, this.form)"
<%=(Mod.getIdPremiscelaAdditivi() == thisElement2.getCode() ) ? "checked" : ""  %>> <%=thisElement2.getDescription() %>
</td>
</tr>
<% } %>
</table>

<%} %>

</td>

<% if (thisElement.getCode()==2){ %></tr><tr><%} %>
<% if (thisElement.getCode()==4){ %></tr><tr><%} %>

<% } %>
</tr>
</table>

<table width="100%">
<tr><th><b>Prelievo campioni piano OGM</b> Specie vegetale dichiarata</th> </tr>
<tr><td>
<% 
for (int i = 0; i<SpecieVegetaleList.size(); i++){ 
LookupElement thisElement = (LookupElement) SpecieVegetaleList.get(i);%>
<input type="checkbox" name="specieVegetaleDichiarata<%=thisElement.getCode() %>" id="specieVegetaleDichiarata<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>" 
<%=(Mod.getListaSpecieVegetaleDichiarata()!=null && contiene(Mod.getListaSpecieVegetaleDichiarata().split(","), thisElement.getCode()) ) ? "checked" : ""  %>> <%=thisElement.getDescription() %>
<% } %>
</td>
</tr>
</table>

<table width="100%">
<col width="50%">
<tr><th><b>B2. Trattamento applicato al mangime prelevato (*):</b></th> <th><b id="intestazione-confezionamento">B3. Confezionamento (*): </b></th> </tr>
<tr><td><input type="text" class="editField" style="width: 100%"  name="trattamentoMangime" id="trattamentoMangime" value="<%= toHtml(Mod.getTrattamentoMangime())%>"/></td>
<td><% for (int i = 0; i<ConfezionamentoList.size(); i++){ 
LookupElement thisElement = (LookupElement) ConfezionamentoList.get(i);%>
<input type="radio" name="confezionamento" id="confezionamento<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>" 
<%=(Mod.getIdConfezionamento() == thisElement.getCode() ) ? "checked" : ""  %>> <%=thisElement.getDescription() %>
<% } %>
</td>
</tr>
</table>

<table width="100%">
<col width="50%">
<tr><th><b>B4. Ragione sociale ditta produttrice (*):</b></th> <th><b>B5. Indirizzo ditta produttrice (*):</b></th> </tr>
<tr><td><input type="text" class="editField" style="width: 100%" name="ragioneSocialeDittaProduttrice" id="ragioneSocialeDittaProduttrice" value="<%= toHtml(Mod.getRagioneSocialeDittaProduttrice())%>"/></td>
<td><input type="text" class="editField" style="width: 100%" name="indirizzoDittaProduttrice" id="indirizzoDittaProduttrice" value="<%= toHtml(Mod.getIndirizzoDittaProduttrice())%>"/></td>
</tr>
</table>

<table width="100%">
<tr><th><b id="intestazione-specieAlimentoDestinato">B6. Specie e categoria animale a cui l'alimento e' destinato (*):</b></th></tr>
<tr><td>
<% for (int i = 0; i<SpecieAlimentoList.size(); i++){ 
LookupElement thisElement = (LookupElement) SpecieAlimentoList.get(i);%>
<input type="checkbox" name="specieAlimentoDestinato<%=thisElement.getCode() %>" id="specieAlimentoDestinato<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>" 
<%=(Mod.getListaSpecieAlimentoDestinato()!=null && contiene(Mod.getListaSpecieAlimentoDestinato().split(","), thisElement.getCode()) ) ? "checked" : ""  %>> <%=thisElement.getDescription() %>
<% } %>
</td>
</tr>
</table>

<table width="100%">
<col width="50%">
<tr><th><b id="intestazione-metodoProduzione">B7. Metodo di produzione (*):</b></th> <th><b>B8. Nome commerciale del mangime (*):</b></th> </tr>
<tr><td>
<% for (int i = 0; i<MetodoProduzioneList.size(); i++){ 
LookupElement thisElement = (LookupElement) MetodoProduzioneList.get(i);%>
<input type="radio" name="metodoProduzione" id="metodoProduzione<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>" 
<%=(Mod.getIdMetodoProduzione() == thisElement.getCode() ) ? "checked" : ""  %>> <%=thisElement.getDescription() %>
<% } %>
</td>
<td><input type="text" class="editField" style="width: 100%"  name="nomeCommercialeMangime" id="nomeCommercialeMangime" value="<%= toHtml(Mod.getNomeCommercialeMangime())%>"/></td>
</tr>
</table>

<table width="100%">
<tr><th><b id="intestazione-statoProdottoPrelievo">B9. Stato del prodotto al momento del prelievo (*):</b></th></tr>
<tr><td>
<% for (int i = 0; i<StatoProdottoList.size(); i++){ 
LookupElement thisElement = (LookupElement) StatoProdottoList.get(i);%>
<input type="checkbox" name="statoProdottoPrelievo<%=thisElement.getCode() %>" id="statoProdottoPrelievo<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>" 
<%=(Mod.getListaStatoProdottoPrelievo()!=null && contiene(Mod.getListaStatoProdottoPrelievo().split(","), thisElement.getCode()) ) ? "checked" : ""  %>> <%=thisElement.getDescription() %>
<% } %>
</td>
</tr>
</table>

<table width="100%">
<col width="50%">
<tr><th><b>B10. Ragione sociale responsabile etichettatura (*): </b></th> <th><b>B11. Indirizzo responsabile etichettatura (*):</b></th> </tr>
<tr><td><input type="text" class="editField" style="width: 100%"  name="responsabileEtichettatura" id="responsabileEtichettatura" value="<%= toHtml(Mod.getResponsabileEtichettatura())%>"/></td>
<td><input type="text" class="editField" style="width: 100%"  name="indirizzoResponsabileEtichettatura" id="indirizzoResponsabileEtichettatura" value="<%= toHtml(Mod.getIndirizzoResponsabileEtichettatura())%>"/></td>
</tr>
</table>

<table width="100%">
<col width="33%">
<tr><th><b>B12. Paese di produzione (*):</b></th> <th><b>B13. Data di produzione (*):</b> </th> <th><b>B14. Data di scadenza (*):</b></th></tr>
<tr><td><input type="text" class="editField" name="paeseProduzione" id="paeseProduzione" value="<%= toHtml(Mod.getPaeseProduzione())%>"/></td>
<td><input type="date" class="editField" min="1990-01-01" max="3000-12-31" onkeydown="return false" name="dataProduzione" id="dataProduzione" value="<%= toHtml(Mod.getDataProduzione())%>"/></td>
<td><input type="date" class="editField" name="dataScadenza" id="dataScadenza" min="1990-01-01" max="3000-12-31" onkeydown="return false" value="<%= toHtml(Mod.getDataScadenza())%>"/></td>
</tr>
</table>

<table width="100%">
<col width="33%"><col width="33%">
<tr><th><b>B15. Numero di lotto (*): </b></th> <th><b>B16. Dimensione di lotto (*):</b></th> <th><b>B16bis. Dimensione porzione campionata:</b></th></tr>
<tr><td><input type="text" class="editField" style="width: 100%"  name="numLotto" id="numLotto" value="<%= toHtml(Mod.getNumLotto())%>"/></td>
<td><input type="text" class="editField" style="width: 100%"  name="dimensioneLotto" id="dimensioneLotto" value="<%= toHtml(Mod.getDimensioneLotto())%>"/></td>
<td><input type="text" class="editField" style="width: 100%"  name="dimensionePorzione" id="dimensionePorzione" value="<%= toHtml(Mod.getDimensionePorzione())%>"/></td>
</tr>
</table>

<table width="100%">
<col width="50%">
<tr><th><b>B17. Ingredienti (*): </b></th> <th><b>B18. Ulteriori commenti relativi al mangime prelevato:</b></th> </tr>
<tr><td><input type="text" class="editField" style="width: 100%"  name="ingredienti" id="ingredienti" value="<%= toHtml(Mod.getIngredienti())%>"/></td>
<td><input type="text" class="editField" style="width: 100%"  name="commentiMangimePrelevato" id="commentiMangimePrelevato" value="<%= toHtml(Mod.getCommentiMangimePrelevato())%>"/></td>
</tr>
</table>  

<div style="page-break-before:always">&nbsp; </div>  

<!-- SEZIONE C -->

<b>C. LABORATORIO</b><br/><br/>

<table width="100%">
<tr><th><b>C1. Laboratorio di destinazione del campione (Specificare): </b></th> </tr>
<tr><td><input type="text" class="editField" style="width: 100%"  name="laboratorioDestinazione" id="laboratorioDestinazione" value="<%= toHtml(Mod.getLaboratorioDestinazione())%>"/></td>
</table>

<br/><br/>

<!-- SEZIONE D -->

<b>D. ULTERIORI INFORMAZIONI RELATIVE AL CAMPIONAMENTO:</b><br/><br/>

Si allega il <label id="intestazione-allegaCartellino">cartellino (*)</label> o la sua fotocopia o il documento commerciale: <br/>

<% for (int i = 0; i<SiNoList.size(); i++){ 
LookupElement thisElement = (LookupElement) SiNoList.get(i);%>
<input type="radio" name="allegaCartellino" id="allegaCartellino<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>"
<%=(Mod.getIdAllegaCartellino() == thisElement.getCode() ) ? "checked" : ""  %>> <%=thisElement.getDescription() %> <br/>
<% } %>

(*) sempre obbligatorio per ricerca OGM<br/><br/>

Si riportano di seguito, cosi' come previsto dalla normativa vigente, le modalita' di esecuzione del campionamento, atte a garantirne la rappresentativita' e l'assenza di contaminazioni, nonche' la descrizione delle attrezzature e dei contenitori utilizzati puliti, asciutti e di materiale inerte:<br/>
<input type="text" class="editField" style="width:100%" name="descrizioneAttrezzature" id="descrizioneAttrezzature" size="150" value="<%= toHtml(Mod.getDescrizioneAttrezzature())%>"/><br/><br/>
<label class="layout" style="width:100%"><%= fixValoreLong("")%></label><br/><br/>
<label class="layout" style="width:100%"><%= fixValoreLong("")%></label><br/><br/>
 
Sono stati prelevati a caso da n. <input type="number" class="editField" size="4" min="0" step="1" name="numPunti" id="numPunti" value="<%= toHtml(Mod.getNumPunti())%>"/>  punti/sacchi n. <input type="text" class="editField" name="numCE" id="numCE" value="<%= toHtml(Mod.getNumCE())%>" onkeyup="calcolaCampioneGlobale()" onchange="calcolaCampioneGlobale()"/> CE del peso/volume di <input type="number" class="editField" size="4" min="0" step="1" name="volume" id="volume" value="<%= toHtml(Mod.getVolume())%>" onkeyup="calcolaCampioneGlobale()" onchange="calcolaCampioneGlobale()"/> kg/lt.
<span class="hint">(es. 200 G/ML = 0.2 KG/L)</span><br/><br/>

Dall'unione dei campioni elementari e' stato formato il campione globale mediante le seguenti operazioni <br/>
<input type="text" class="editField" style="width:100%" name="operazioni" id="operazioni" size="150" value="<%= toHtml(Mod.getOperazioni())%>"/><br/><br/>
<label class="layout" style="width:100%"><%= fixValoreLong("")%></label><br/><br/>
<label class="layout" style="width:100%"><%= fixValoreLong("")%></label><br/><br/>

Campione Globale di peso/volume di: <input type="number" readonly class="editField" size="4" min="0" step="1" name="volume3" id="volume3" value="<%= toHtml(Mod.getVolume3())%>"/> kg/lt.<br/><br/>
 
<label id="intestazione-cgRidotto">Il CG</label> <b>dopo opportuna miscelazione</b>

<% for (int i = 0; i<CgRidottoList.size(); i++){ 
LookupElement thisElement = (LookupElement) CgRidottoList.get(i);%>
<input type="radio" name="cgRidotto" id="cgRidotto<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>" onclick="gestisciRiduzione(<%= thisElement.getCode() %>)"
<%=(Mod.getIdCgRidotto() == thisElement.getCode() ) ? "checked" : ""  %>> <%=thisElement.getDescription() %> 
<% } %> (barrare la voce non pertinente) a CR del peso/volume di <input type="number" class="editField" size="4" min="0" step="1" name="volume2" id="volume2" value="<%= toHtml(Mod.getVolume2())%>"/> kg/lt.<br/><br/>

Il 

<% for (int i = 0; i<CgCrList.size(); i++){ 
LookupElement thisElement = (LookupElement) CgCrList.get(i);%>
<input type="radio" name="cgCr" id="cgCr<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>"
<%=(Mod.getIdCgCr() == thisElement.getCode() ) ? "checked" : ""  %>> <%=thisElement.getDescription() %> 
<% } %> <label class="documentaleNonStampare"><a href="#" onClick="resetRadio('cgCr'); return false;"><i><font size="2px">[Reset]</font></i></a></label> (barrare la voce non pertinente) e' stato sigillato e identificato con apposito cartellino e inviato per la successiva macinazione.<br/> 

Dal campione globale sono stati ottenuti i campioni finali mediante le seguenti operazioni<br/>
<input type="text" class="editField" style="width:100%" name="operazioni2" id="operazioni2" size="150" value="<%= toHtml(Mod.getOperazioni2())%>"/><br/><br/>
<label class="layout" style="width:100%"><%= fixValoreLong("")%></label><br/><br/>
<label class="layout" style="width:100%"><%= fixValoreLong("")%></label><br/><br/>
 
Dal CG sono stati ottenuti n. <input type="text" class="editField" name="numeroCF" id="numeroCF" value="<%= toHtml(Mod.getNumeroCF())%>" onchange="gesticiNumeroCF()" onkeyup="gesticiNumeroCF()"/> CF ognuno dei quali del peso/volume non inferiore a <input type="number" readonly class="editField" size="5" min="0" step="1" name="quantitaGML" id="quantitaGML" value="<%= toHtml(Mod.getQuantitaGML())%>"/> g/ml, ogni CF viene sigillato e identificato con apposito cartellino:<br/>

CF1 peso: <input type="text" class="editField" id="cf1peso" name="cf1peso" value="<%=toHtml(Mod.getCf1Peso()) %>"/>, sigillo n.:<input type="text" class="editField" id="cf1sigillo" name="cf1sigillo" value="<%=toHtml(Mod.getCf1Sigillo()) %>"/><br/>

<% if (Mod.getIdProgrammaControllo() != 7) { //salmonella %>

CF2 peso: <input type="text" class="editField" id="cf2peso" name="cf2peso" value="<%=toHtml(Mod.getCf2Peso()) %>"/>, sigillo n.:<input type="text" class="editField" id="cf2sigillo" name="cf2sigillo" value="<%=toHtml(Mod.getCf2Sigillo()) %>"/><br/>
CF3 peso: <input type="text" class="editField" id="cf3peso" name="cf3peso" value="<%=toHtml(Mod.getCf3Peso()) %>"/>, sigillo n.:<input type="text" class="editField" id="cf3sigillo" name="cf3sigillo" value="<%=toHtml(Mod.getCf3Sigillo()) %>"/><br/>
CF4 peso: <input type="text" class="editField" id="cf4peso" name="cf4peso" value="<%=toHtml(Mod.getCf4Peso()) %>"/>, sigillo n.:<input type="text" class="editField" id="cf4sigillo" name="cf4sigillo" value="<%=toHtml(Mod.getCf4Sigillo()) %>"/><br/>
CF5 peso: <input type="text" class="editField" id="cf5peso" name="cf5peso" value="<%=toHtml(Mod.getCf5Peso()) %>"/>, sigillo n.:<input type="text" class="editField" id="cf5sigillo" name="cf5sigillo" value="<%=toHtml(Mod.getCf5Sigillo()) %>"/><br/><br/>

<input type="checkbox" name="cfUteriore" id="cfUlteriore" value="S" <%="S".equals(Mod.getCfUlteriore()) ? "checked" : "" %>/> 
dal CG è stato ottenuto un ulteriore CF del peso di: <input type="text" class="editField" id="cfulteriorepeso" name="cfulteriorepeso" value="<%=toHtml(Mod.getCfUlteriorePeso()) %>"/>, adeguatamente sigillato e identificato con apposito cartellino, destinato al programma conoscitivo per la ricerca di: <input type="text" class="editField" id="cfulteriorericerca" name="cfulteriorericerca" value="<%=toHtml(Mod.getCfUlterioreRicerca()) %>"/>.
La raccolta e il confezionamento del CF conoscitivo non ha in alcun modo interferito con le operazioni di prelevamento del campione ufficiale.<br/><br/>

<% } %>

Dichiarazioni del proprietario o detentore:<br/>
<input type="text" class="editField" style="width:100%" name="dichiarazione" id="dichiarazione" value="<%= toHtml(Mod.getDichiarazione())%>"/><br/><br/>
<label class="layout" style="width:100%"><%= fixValoreLong("")%></label><br/><br/>
<label class="layout" style="width:100%"><%= fixValoreLong("")%></label><br/><br/>
 
N <input type="number" class="editField" size="4" min="0" step="1" name="numCampioniFinaliInvio" id="numCampioniFinaliInvio" value="<%= toHtml(Mod.getNumCampioniFinaliInvio())%>"/> Campioni Finali unitamente a n. <input type="number" class="editField" size="4" min="0" step="1" name="numCopieInvio" id="numCopieInvio" value="<%= toHtml(Mod.getNumCopieInvio())%>"/> copie del presente verbale vengono inviate al <input type="text" class="editField" name="destinazioneInvio" id="destinazioneInvio" value="<%= toHtml(Mod.getDestinazioneInvio())%>"/> in data <input type="date" class="editField" name="dataInvio" id="dataInvio" value="<%= toHtml(Mod.getDataInvio())%>"/><br/><br/>
 
Conservazione del campione:  <br/>
<input type="text" class="editField" style="width:100%" name="conservazioneCampione" id="conservazioneCampione" value="<%= toHtml(Mod.getConservazioneCampione())%>"/><br/>
N. .<input type="number" class="editField" size="4" min="0" step="1" name="numCopie" id="numCopie" value="<%= toHtml(Mod.getNumCopie())%>"/> copia/e del presente verbale con n. <input type="number" class="editField" size="4" min="0" step="1" name="numCampioniFinali" id="numCampioniFinali" value="<%= toHtml(Mod.getNumCampioniFinali())%>"/> Campioni Finale/i viene/vengono consegnate al Sig <input type="text" class="editField" name="custode" id="custode" value="<%= toHtml(Mod.getCustode())%>"/> il quale <label id="intestazione-campioneFinale">custodisce</label>:<br/>

<!-- Flusso 358 -->
<!-- aggiunta opzione Aliquota Unica (3) visibile solo x PNAA salmonella -->
<% 
	int size = CampioneFinaleList.size();
	if(Mod.getIdProgrammaControllo() != 7)
		size--;
	
	for (int i = 0; i<size; i++){ 
		LookupElement thisElement = (LookupElement) CampioneFinaleList.get(i);%>
		<input type="radio" name="campioneFinale" id="campioneFinale<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>"
		<%=(Mod.getIdCampioneFinale() == thisElement.getCode() ) ? "checked" : ""  %>> <%=thisElement.getDescription() %> <br/>
<% 	} %>
<script>
$('input[type=radio][name=campioneFinale]').change(function() {
    if (this.value == '3') {
       $('#numCopie').val('0');
       $('#numCampioniFinali').val('0');
       $('#custode').val('NESSUNO');
       $('#numCopie').prop('readonly',true);
       $('#numCampioniFinali').prop('readonly',true);
       $('#custode').prop('readonly',true);
    }
    else {
    	$('#numCopie').prop('readonly',false);
        $('#numCampioniFinali').prop('readonly',false);
        $('#custode').prop('readonly',false);
    }
});

</script>
<br/>
<% if(Mod.getIdProgrammaControllo() ==7) { %> <!-- salmonella Flusso 297 -->
<!-- Qui ci va il pezzo nuovo - Flusso 297 -->
<!-- Flusso 358 -->
Essendo una analisi microbiologica, ai sensi del punto 2 dell'art. 7 del D.L.vo 27/21, viene esclusa la possibilita' di ripetizione dell'analisi in quanto inopportuna e non pertinente, e pertanto il campione e' costituito da n. <input type="number" class="editField" size="5" min="0" step="1" name="numAliquoteCF" id="numAliquoteCF" value="<%= toHtml(Mod.getNumAliquoteCF()) %>"/> aliquota 
formata da n. <input type="number" class="editField" size="5" min="0" step="1" name="numUnitaCampionarie" id="numUnitaCampionarie" value="<%= toHtml(Mod.getNumUnitaCampionarie()) %>"/> unita' campionarie
 del peso di ca. <input type="number" class="editField" size="5" min="0" step="1" name="pesoUnitaCampionaria" id="pesoUnitaCampionaria" value="<%= toHtml(Mod.getPesoUnitaCampionaria()) %>"/> g/ml cadauna.<br>
In applicazione del precetto ex art. 223 punto 1 D.L.vo 271/89 in merito alle garanzie del diritto alla difesa si comunica che in data <input type="date" class="editField" name="dataInizioAnalisi" id="dataInizioAnalisi" min="1990-01-01" max="3000-12-31" onkeydown="return false" value="<%= toHtml(Mod.getDataInizioAnalisi()) %>"/> alle ore <input type="time" class="editField" name="oraInizioAnalisi" id="oraInizioAnalisi" value="<%= toHtml(Mod.getOraInizioAnalisi()) %>"/> presso i laboratori dell'Istituto Zooprofilattico Sperimentale del Mezzogiorno, sezione di Portici in via della Salute, n. 2 Portici (NA), 
gli interessati possono assistere, anche per rappresentanza, all'inizio delle operazioni di analisi (Precetto obbligatorio per parametri microbiologici).
L'operatore potra' procedere all'eventuale controperizia ai sensi del combinato disposto: Reg. (UE) n. 2017/625 e D.L.vo 27/21.
<% } %>
<br/><br/>

L'operatore responsabile della partite/lotto dichiara di rinunciare ai campioni finali risultati conformi all'analisi e non
utilizzati per l'analisi, che al termine del periodo di conservazione previsto dalla normativa, saranno gestiti dal
Laboratorio per fini di studio e ricerca scientifici.

<br/>

<% if(Mod.getIdProgrammaControllo() !=7) { %> <!-- salmonella Flusso 297 -->
<span id="intestazione-rinunciaCampione">L'operatore rinuncia</span> ai Campioni Finali da destinare all'eventuale controperizia e controversia di cui al Regolamento (UE) n. 2017/625 <br/>
<% for (int i = 0; i<SiNoList.size(); i++){ 
LookupElement thisElement = (LookupElement) SiNoList.get(i);%>
<input type="radio" name="rinunciaCampione" id="rinunciaCampione<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>"
<%=(Mod.getIdRinunciaCampione() == thisElement.getCode() ) ? "checked" : ""  %>> <%=thisElement.getDescription() %> <br/>
<% } %>
<%} %>

<br/>
<span id="intestazione-sequestroPartita">La partita/lotto relativa al campione prelevato</span> 
<% for (int i = 0; i<SequestroPartitaList.size(); i++){ 
LookupElement thisElement = (LookupElement) SequestroPartitaList.get(i);%>
<input type="radio" name="sequestroPartita" id="sequestroPartita<%=thisElement.getCode() %>" value="<%=thisElement.getCode() %>"
<%=(Mod.getIdSequestroPartita() == thisElement.getCode() ) ? "checked" : ""  %>> <%=thisElement.getDescription() %>
<% } %> fino all'esito dell'esame,<br/><br/>

<!-- FOOTER -->

Fatto, letto e sottoscritto. <br/><br/>

FIRMA DEL PROPRIETARIO/DETENTORE &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  VERBALIZZANTI 

<br/><br/>

<%@ include file="mod_pnaa_tabella_barcode.jsp" %>

<br/><br/>

<%@ include file="/gestione_documenti/gdpr_footer.jsp" %>

<input type="hidden" id="bozza" name="bozza" value="true" />
<input type="hidden" name="idCampione" id="idCampione" value="<%=Mod.getIdCampione()%>"/>
<% if(Mod.getBozza() == true) {%>

<center>
	<input type="button" id="salva" value="SALVA DEFINITIVO" onClick="checkForm(this.form)"/> &nbsp
	<input type="button" id="salva_temporaneo" value="SALVA TEMPORANEO" onClick="checkFormTemp(this.form)"/>
</center>

<% } %>

</form>


<% if(Mod.getBozza() == false) {%>

<script type="text/javascript">
//disabilita tutti i campi

$("input").each( function(){
	$(this).prop("disabled", true);
});

</script>

<div id="stampa">
<center>
<jsp:include page="/gestione_documenti/boxDocumentaleNoAutomatico.jsp">
<jsp:param name="orgId" value="<%=request.getParameter("orgId") %>" />
<jsp:param name="stabId" value="<%=request.getParameter("idStabilimento") %>" />
<jsp:param name="tipo" value="19" />
<jsp:param name="idCU" value="<%=request.getParameter("idControllo") %>" />
<jsp:param name="url" value="<%=request.getParameter("url") %>" />
</jsp:include>
</center>
</div>

<% } %>

</form>

</dhv:permission>

<!--  PER SALVA & STAMPA -->
<div style="display:none"><iframe name="response" height="0" width="0"></iframe>
</div>





<script>

function rispondiCaso() {
	
	 var nomi = ["Rita", "Paolo", "Stefano", "Alessandro", "Uolter", "Antonio", "Carmela", "Viviana", "Valentino", "Riviezzo", "Preaccettazione", "Sintesis", "Miriam", "Gianluca", "Lorenza", "Masardona", "Battilocchio", "Rischio", "Impresa", "Vittoria", "Mandarino", "Ext", "US", "Caffe", "Altrove", "SPA", "Food", "Privata", "Coffee", "Angolo", "Bar"];
	 var inputs = document.getElementsByTagName('input');
	 var inputNamePrecedente="";
    for (i = 0; i < inputs.length; i++) {
    	    	
        if (inputs[i].type == 'radio' || inputs[i].type == 'checkbox') {
        	var random = Math.floor(Math.random() * 11);
          	 	if (random>5 || inputNamePrecedente!=inputs[i].name)
           			inputs[i].click();
        	}
        else if (inputs[i].type == 'text') {
        	if($(inputs[i]).attr("onkeyup")=='filtraInteri(this)'){
           		inputs[i].value = Math.floor((Math.random() * nomi.length-1) + 1) +''+ Math.floor((Math.random() * nomi.length-1) + 1) +''+ Math.floor((Math.random() * nomi.length-1) + 1);
        	}
        	else
           		inputs[i].value = nomi[Math.floor((Math.random() * nomi.length-1) + 1)] + " " + nomi[Math.floor((Math.random() * nomi.length-1) + 1)];
    	}
        else if (inputs[i].type == 'number') {
        	var random1 = Math.floor(Math.random() * 11);
        	var random2 = Math.floor(Math.random() * 11);

        	if($(inputs[i]).attr("step")=='.01')
	        	inputs[i].value = random1+'.'+random2;
	        else
	        	inputs[i].value = random1;
    	}
        
        else if (inputs[i].type == 'date') {
        	
        	var date = new Date();
        	var currentDate = date.toISOString().slice(0,10);
			inputs[i].value = currentDate;
    	}
        
        inputNamePrecedente = inputs[i].name;
          }
   		
}</script>

<%UserBean user = (UserBean) session.getAttribute("User");
if (user.getUserId()==5885) { %>	
<input type="button" id="caso" name="caso" style="color: black; background-color:yellow;" value="rispondi a caso a tutta la checklist (TEST)" onClick="rispondiCaso()"/>
<% } %>

<script>
verificaStatoCampione('<%=Campione.getClosed()%>');
</script>
