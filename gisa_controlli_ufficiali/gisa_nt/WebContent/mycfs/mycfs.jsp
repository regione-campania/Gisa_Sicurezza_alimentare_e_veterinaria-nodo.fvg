<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>

<style>
table.center {
	margin-left: auto; 
	margin-right: auto;
	width: 100%;
}
table.center-buttons {
	margin-left: auto; 
	margin-right: auto;
	width: 100%;
}

.center tr{
  	text-align: center;
}

.center-buttons tr{
  	text-align: center;
}

.center td{
  	text-align: left;
  	vertical-align: initial;
}

.center th {
	text-align: center;
	color: #FFF;
	font-weight: bold;
	background-color: #405c81;
	padding-top: 2px;
	padding-bottom: 5px;
	padding-left: 3px;
	width: 50%;
}

button.center-button {
	background-attachment: scroll;
	background-color: #4477AA;
	background-image: none;
	background-position: 0 0;
	background-repeat: repeat;
	border-bottom-color: gray;
	border-top-color: gray;
	color: white;
}
</style>

<script type="text/javascript">

function altezzaPostIt(){
	//alert($('#postit').contents().find('#postit_container').height());
	var altezza = $('#postit').contents().find('#postit_container').height();
	if(altezza < $('#postitregione').contents().find('#postit_container').height())
		altezza = $('#postitregione').contents().find('#postit_container').height();
	
	return(altezza + 100);
}

$('document').ready( function(){
	$('#postit').load( function() {
		$('#rigapostit').height( altezzaPostIt() );
		
	});
	
	$('#postitregione').load( function() {
		$('#rigapostit').height( altezzaPostIt() );
		
	});
});

function showHide(id) {

  if (document.getElementById(id).style.display == "none") {
    document.getElementById(id).style.display = "";
  } else {
    document.getElementById(id).style.display = "none";
  }

}
</script>

<table class="center">
	<tr id="rigapostit">
		<td valign="top" >
			<iframe scrolling="no" src="MyCFS.do?command=PostItVisualizza&tipo=1" id="postit" style="top:0;left: 0;width:100%;height: 100%; border: none; " ></iframe>
		</td>
		<td valign="top">
			<iframe scrolling="no" src="MyCFS.do?command=PostItVisualizza&tipo=2" id="postitregione" style="top:0;left: 0;width:100%;height: 100%; border: none; " ></iframe>
		</td>
	</tr>
</table>
<table class="center-buttons">
	<tr>
		<td>
			<dhv:permission name="myhomepage-scadenzario-view">
				<button class="center-button" onclick = "window.location.href='MyCFS.do?command=ListReport'" id="form_submit" title ="Lo scadenzario contiene: la lista dei controlli ufficiali aperti con e senza sottoattività (in arancio);la lista dei controlli ufficiali chiusi con almeno un Follow Up (in verde) e la lista dei controlli ufficiali in sorveglianza (in rosso)" style="text-align: center;" >Scadenzario Controlli Ufficiali</button>
				&nbsp;
			</dhv:permission>

			<dhv:permission name="campioni-campioni-preaccettazionesenzacampione-view">
				<button class="center-button" onclick="loadModalWindowCustom('Attendere Prego...'); window.location.href='DownloadAppMobile.do?command=SuiteAppMobile'">Suite App Mobile GISA</button>
				&nbsp;
			</dhv:permission>

			<dhv:permission name="campioni-campioni-reportpreaccettazione-view">
				<button class="center-button" onclick="loadModalWindowCustom('Attendere Prego...'); window.location.href='ReportPreaccettazione.do?command=SearchForm'">Verifica Codici Preaccettazione</button>
			</dhv:permission>
		</td>
	</tr>
</table>
<br>
<table class="center">
	<tr>
		<th>Informazioni Utili</th>
		<th>Siti di interesse</th>
	</tr>
	<tr>
		<td>
		<ul>
			<li>
				<a style="text-decoration:none;" href="#" onclick="window.open('mycfs/SUAP_GUIDA.pdf'); return false;">
					<font color="#006699" size="2px">
						<b><u>GUIDA UTENTE PRATICHE SUAP 2.0</u></b>
					</font>
				</a>
			</li>
			<li>
			<a style="text-decoration:none;" href="#" onclick="window.open('mycfs/tutorial_preaccettazione_links.jsp'); return false;">
				<font color="#006699" size="2px">
					<b><u>ISTRUZIONI PREACCETTAZIONE GISA</u></b>
				</font>
			</a>
			</li>
			<dhv:permission name="home-elenconormeviolate-view">
			<li>
				<a style="text-decoration:none;" href="#" onclick="window.open('mycfs/Elenco_atti_normativi_violabili_in_GISA.pdf'); return false;">
					<font color="#006699" size="2px">
						<b><u>ELENCO ATTI NORMATIVI VIOLABILI IN GISA</u></b>
					</font>
				</a>
			</li>
			</dhv:permission>
			<li>
				<a href="#" onclick="window.open('utils23/info.jsp', '', 'top=100,left=150,width=600,height=100'); return false;">
					<font color="#006699" size="2px">
						<b><u>Altre Info</u></b>
					</font>
				</a>
			</li>
		</ul>
		
		</td>
		<td>
		<ul>
			<li>
			<a style="text-decoration:none;" href="#" onclick="window.open('mycfs/tutorial_links.jsp', '', 'top=100,left=150,width=1000,height=400'); return false;">
				<font color="#006699" size="2px">
					<b><u>NEW! TUTORIAL</u></b>
				</font>
			</a>
			</li>
		</ul>
		</td>
	</tr>
</table>