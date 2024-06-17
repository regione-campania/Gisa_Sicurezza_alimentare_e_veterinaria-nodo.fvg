<%
int secondiSessione= session.getMaxInactiveInterval();
int minutiSessione = secondiSessione/60;

//A volte viene recuperato 5 minuti all'inizio. Sovrascrivo per evitare ambiguita'
if (minutiSessione <=5)
	minutiSessione = 30;
%>

<script>

// CONFIGURAZIONE
var minutiAttesaGiallo = 20;
var secondiAttesaGiallo = minutiAttesaGiallo*60;
var millisecondiAttesaGiallo = secondiAttesaGiallo*1000;

var minutiAttesaRosso = <%=minutiSessione%>-5;
var secondiAttesaRosso = minutiAttesaRosso*60;
var millisecondiAttesaRosso = secondiAttesaRosso*1000;

var secondiRefresh = 60;
var durataSessione = <%=minutiSessione%>;

var ignoraScadenza = false;
if (window.location.href.includes("RegistroTrasgressori")){ ignoraScadenza = true; }

</script>

<label id="contatoreScadenza"><%=minutiSessione %></label>

<script>

//ALERT ALLARME ROSSO (minutiAttesaRosso prima della fine sessione)
setTimeout(function(){
if (ignoraScadenza){ return false; }
alert('Attenzione. Sono passati '+minutiAttesaRosso+' minuti dall\'apertura della pagina. LA SESSIONE STA PER SCADERE! Salvare le eventuali modifiche per evitare di perderle a causa dello scadere della sessione di lavoro tra circa '+ (durataSessione-minutiAttesaRosso)  +' minuti.'); }, millisecondiAttesaRosso);

//ALERT ALLARME GIALLO (minutiAttesaGiallo dopo inizio sessione)
setTimeout(function(){
if (ignoraScadenza){ return false; }
document.getElementById("scadenzaSessione").style.display="block"; 
alert('Attenzione. Sono passati '+minutiAttesaGiallo+' minuti dall\'apertura della pagina. Salvare le eventuali modifiche per evitare di perderle a causa dello scadere della sessione di lavoro tra circa '+ (durataSessione-minutiAttesaGiallo)  +' minuti.'); }, millisecondiAttesaGiallo);

	
//REFRESH SCADENZA
setInterval(function() {
	refreshScadenza();}, secondiRefresh*1000);

function refreshScadenza(){
		var minutiRecuperati = Number(document.getElementById("contatoreScadenza").innerHTML);
		minutiRecuperati = minutiRecuperati-secondiRefresh/60;
		if (minutiRecuperati<0)
			minutiRecuperati=0;
		document.getElementById("contatoreScadenza").innerHTML=minutiRecuperati;
	}
	
function resetScadenza(){	
	document.getElementById("contatoreScadenza").innerHTML= <%=minutiSessione%>;
}
</script>



