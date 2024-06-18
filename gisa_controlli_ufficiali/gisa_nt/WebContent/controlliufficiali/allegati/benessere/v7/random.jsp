<style>

.ovalButtonYellow {
  background-color: #ffdc54 !important;
  border: 1px solid black;
  color: black !important;
  padding: 10px 20px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 16px;
  font-size: 30px;
  font-weight: bold;
 }
.ovalButtonYellow:hover {
  background-color: black !important;
  color: #ffdc54 !important;
  border: 1px solid #ffdc54;
}

</style>

<script>

function rispondiCaso() {
	
	 var nomi = ["Rita", "Paolo", "Stefano", "Alessandro", "Uolter", "Antonio", "Carmela", "Viviana", "Valentino", "Giuseppe", "Simone", "Mirko"];
	 var cognomi = ["Verdi", "Gialli", "Arancioni", "Azzurri", "Lover", "Russo", "Rossi", "Bianchi", "Neri", "Bordeaux", "Esposito", "Dalle Marche", "Barile"];
	 
	 var soggetti = ["l'allevamento", "lo stabilimento", "il capo", "il recinto", "il box", "il capanno", "lo stallo", "il parcheggio", "il salone", "il piano", "lo stradone", "l'ingresso", "il vano", "il vagone", "il furgone", "il trattore", "il mobile", "il tavolo", "il campo", "il codice azienda"];
	 
	 var verbi = ["e'", "non e'", "risulta", "non risulta", "sembra", "non sembra", "appare", "non appare"];
	 var verbiCondizionale = ["sia", "non sia", "sia stato", "non sia stato", "venga", "non venga", "fosse stato", "non fosse stato"];

	 var esiti = ["chiuso", "aperto", "libero", "occupato", "agibile", "inagibile", "pieno", "vuoto", "pulito", "sporco", "asciutto", "allagato", "blu", "rosso", "grande", "piccolo", "buio", "luminoso", "gradevole", "sgradevole", "moderno", "antiquato"];
	 var esitiCondizionale = ["chiuso", "aperto", "liberato", "occupato", "riempito", "svuotato", "ripulito", "sporcato", "asciugato", "allagato", "ingrandito", "rimpicciolito", "spento", "illuminato"];

	 var tempo = ["spesso", "ogni tanto", "a volte", "saltuariamente", "quasi mai", "per sbaglio", "con documento firmato", "a volte si, a volte no"];
	 
	 var parole = ["tavolo", "sedia", "bottiglia", "spina", "quaderno", "libro", "tappo", "mobile", "schermo", "porta", "finestra", "pavimento", "mattonella", "lavagna"]

	 var alternative = ["e", "ma"];
	 var alternativeCondizionale = ["nonostante", "sebbene"];
	 
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
           		inputs[i].value = Math.floor((Math.random() * 100) + 1);
        	}
        	else
        		
        		if (inputs[i].getAttribute("placeholder") != null && inputs[i].getAttribute("placeholder").includes("nome")){
        			inputs[i].value = nomi[Math.floor((Math.random() * nomi.length-1) + 1)] + " " + cognomi[Math.floor((Math.random() * nomi.length-1) + 1)];	
        		}
        		else if ((inputs[i].getAttribute("placeholder") != null && inputs[i].getAttribute("placeholder").includes("descrizione")) || (inputs[i].getAttribute("placeholder") != null && inputs[i].getAttribute("placeholder").includes("note")) || (inputs[i].getAttribute("placeholder") != null && inputs[i].getAttribute("placeholder").includes("evidenze"))){
	    			
        			if (Math.round(Math.random()) < 0.3) 
        				inputs[i].value = soggetti[Math.floor((Math.random() * soggetti.length-1) + 1)] + " " + verbi[Math.floor((Math.random() * verbi.length-1) + 1)] + " " + esiti[Math.floor((Math.random() * esiti.length-1) + 1)] + " " + tempo[Math.floor((Math.random() * tempo.length-1) + 1)];
        			else if (Math.round(Math.random()) < 0.6)
        				inputs[i].value = soggetti[Math.floor((Math.random() * soggetti.length-1) + 1)] + " " + verbi[Math.floor((Math.random() * verbi.length-1) + 1)] + " " + esiti[Math.floor((Math.random() * esiti.length-1) + 1)] + " " + alternative[Math.floor((Math.random() * alternative.length-1) + 1)] + " " + soggetti[Math.floor((Math.random() * soggetti.length-1) + 1)] + " " + verbi[Math.floor((Math.random() * verbi.length-1) + 1)] + " " + esiti[Math.floor((Math.random() * esiti.length-1) + 1)];
        			else
        				inputs[i].value = soggetti[Math.floor((Math.random() * soggetti.length-1) + 1)] + " " + verbi[Math.floor((Math.random() * verbi.length-1) + 1)] + " " + esiti[Math.floor((Math.random() * esiti.length-1) + 1)] + " " + alternative[Math.floor((Math.random() * alternative.length-1) + 1)] + " " + soggetti[Math.floor((Math.random() * soggetti.length-1) + 1)] + " " + verbi[Math.floor((Math.random() * verbi.length-1) + 1)] + " " + esiti[Math.floor((Math.random() * esiti.length-1) + 1)] + " " + alternativeCondizionale[Math.floor((Math.random() * alternativeCondizionale.length-1) + 1)] + " " + soggetti[Math.floor((Math.random() * soggetti.length-1) + 1)] + " " + verbiCondizionale[Math.floor((Math.random() * verbiCondizionale.length-1) + 1)] + " " + esitiCondizionale[Math.floor((Math.random() * esitiCondizionale.length-1) + 1)]+ " " + tempo[Math.floor((Math.random() * tempo.length-1) + 1)];
	    		
        		}
        		else{
    				inputs[i].value = parole[Math.floor((Math.random() * parole.length-1) + 1)];	
    		}
            		
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
   		
}



</script>

<br/>	
<center>
<input type="button" id="caso" name="caso" class="ovalButtonYellow" value="rispondi a caso a tutta la checklist (TEST)" onClick="rispondiCaso()"/>
</center>
<br>