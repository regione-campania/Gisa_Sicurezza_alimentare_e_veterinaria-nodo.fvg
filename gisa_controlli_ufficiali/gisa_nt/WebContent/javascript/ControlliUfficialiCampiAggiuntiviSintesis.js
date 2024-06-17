
function recuperaLineaSottoposta(idTicket){
	PopolaCombo.recuperaLineaSottopostaCu(idTicket,{callback:recuperaLineaSottopostaCallBack,async:false});
}

function recuperaLineaSottopostaCallBack(val)
{
}

function controllaCampiAggiuntiviLinea(idLinea, idControllo) { 
	
	PopolaCombo.recuperaCampiAggiuntiviLineaTrasportoSOA(idLinea,{callback:controllaCampiAggiuntiviLineaTrasportoSOACallBack,async:false});

}


function controllaCampiAggiuntiviLineaTrasportoSOACallBack(val)
{ 
	if (document.getElementById("AutomezzoSoa")!=null){

		if (val==null){
			document.getElementById("AutomezzoSoa").innerHTML="";
	
		}
		else {
			var html = "";
			html+="<td class=\"formLabel\">Automezzo sottoposto a controllo</td><td><select id=\"automezzoSoa\" name=\"automezzoSoa\">";
			var res = val.split(";;");
			for (k=0; k<res.length-1;k++){
				var elemento = res[k];
				var elementoSingolo = elemento.split("##");
				html+="<option value=\""+elementoSingolo[0] +"\">"+elementoSingolo[1]+"</option>";		
			}
	//		html+="<option value=\"MERCATO ALL'INGROSSO\">MERCATO ALL'INGROSSO</option>";
			html+="</select></td>";
			document.getElementById("AutomezzoSoa").innerHTML=html;
	
		}
	}
	}
	