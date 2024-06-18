<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>


<script language="JavaScript" TYPE="text/javascript" SRC="dwr/interface/Animale.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>

<script type="text/javascript">


function getAnimale(mc)
{
		var controlloMc;

		Animale.cercaAnimale(mc, {
			callback:function(data) {
			if (data != null){
				controlloMc =  data;
			}
			},
			timeout:8000,
			async:false

			});
		
		return controlloMc;
}




function openCampioni(){
	var res;
	var result;
		window.open('AnimaleAction.do?command=PrintRichiestaCampioni&microchip='+microchip+'&idSpecie='+idSpecie,'popupSelect',
		'height=595px,width=842px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}

function test(){
	
	formOK = true;
	
	if(((document.getElementById("microchip").value.length)<15)&&((document.getElementById("microchip").value!=null)||(document.getElementById("microchip").value==null)))
	{
		alert("Il microchip deve essere di 15 caratteri");
		formOK = false;
	}
	
	
	if(formOK && getAnimale(document.getElementById("microchip").value)==null)
	{
		alert("Non è possibile procedere: il microchip non risulta in banca dati. Per inviare la richiesta di prelievo all'istituto è necessario regolarizzare le posizioni in banca dati ");
		formOK = false;
	}
	
	if (document.getElementById("tipo0").checked && formOK){
		
		//alert('popup');
		window.location.reload();
		document.form1.target = "POPUPW" ;
		POPUPW = window.open('about:blank','POPUPW','width=600,height=400');
		document.form1.submit();
	}
	else if (document.getElementById("tipo0").checked==false && formOK)
	{
		document.form1.submit();
	}
		
}


</script>

<body>

  <font size="2" face="Verdana, Arial, Helvetica, sans-serif">

  <form name="form1"  action="GeneraBarCode.do?command=SearchForm" method="get"
    >
   
  <table>
  <tr><td><b>Genera scheda</b></td></tr>
  <tr>
  <td>Scheda per l'invio dei campioni</td>
  <td><input name="tipo" type="radio" checked="checked" value="0" id="tipo0"></td>
  </tr>
  
  <tr>
  <td>Scarica solo immagine barcode</td>
  <td><input name="tipo" type="radio" checked="checked" value="1" id="tipo1"></td>
  </tr>
  </table>
 
  <br>
  <br>
  <br>
    Inserire il Microchip
  <br>
  <input name="microchip" type="text" id="microchip" maxlength="15">
  <input name="isEmpty" type="hidden" id="isEmpty" value="a">
  
  <input type="button" name="Submit" value="Invia"  onclick="test();">
  
  </form>
  </font>
  
</body>
</html>