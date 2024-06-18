function mostraEsiti(riga,organoDescription,tipoDescription)
{
		var tuttiEsiti = document.getElementById('mostraTuttiEsiti').cloneNode(true);
		var esitiOrgano = document.getElementById('esitiOrganoTipo'+document.getElementById('organo'+riga).value+"---"+document.getElementById('tipo'+riga).value).value;
		esitiOrgano = esitiOrgano.replace("[","");
		esitiOrgano = esitiOrgano.replace("]","");
		esitiOrgano = esitiOrgano.split(", ");
		var esitiRiga   = document.getElementById('esiti'+riga).value;
		esitiRiga = esitiRiga.replace("[","");
		esitiRiga = esitiRiga.replace("]","");
		while(esitiRiga.indexOf(" ")>0)
			esitiRiga = esitiRiga.replace(" " , "");
		esitiRiga = esitiRiga.split(",");
		
		tuttiEsiti.id="mostraEsiti"+riga;
		tuttiEsiti.style.display="block";
		var labels = tuttiEsiti.getElementsByTagName("label");
		
		var labelDaRimuovere   = new Array(0);
		var labelDaSelezionare = new Array(0);
		
		for(var i=0;i<labels.length;i++)
		{
			labels[i].id=labels[i].id.replace("labelTuttiEsiti","");
				
			if(contains(esitiRiga,labels[i].id.split("_")[1]))
			{
				labelDaSelezionare[labelDaSelezionare.length] = labels[i];
			}
			else
			{
				labelDaRimuovere[labelDaRimuovere.length] = labels[i].id;
			}
		}
		
		var labels = tuttiEsiti.getElementsByTagName("label");
		for(var i=0;i<labels.length;i++)
		{
			labels[i].id=labels[i].id.replace("TuttiEsiti","");
		}
		
		var th = tuttiEsiti.getElementsByTagName("th")[0];
		th.innerHTML="Organo selezionato: " + organoDescription+"; Tipo esame selezionato: " + tipoDescription;
		
		document.form.appendChild(tuttiEsiti);
		
		for(var i=0;i<labelDaRimuovere.length;i++)
		{
			tuttiEsiti.childNodes[1].childNodes[1].removeChild(document.getElementById("trTuttiEsiti"+labelDaRimuovere[i]));
		}
		
		mostraPopupEsiti(riga);
}

function contains(a, obj)
{
	for(var i = 0; i < a.length; i++) 
	{
	    if(a[i] === obj)
	    {
	      return true;
	    }
	}
	return false;
}
