<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>

<script type="text/javascript" src="dwr/interface/PopolaCombo.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>
<script>

function getContenutoCombo()
{
	table = document.getElementById('tabella').value ;
	PopolaCombo.getContenutoCombo(table,getContenutoComboCallback);
}
function getContenutoComboCallback(value)
{
	descrizioni = value [0] ;
	valori = value[1];
	var select = document.getElementById("valori"); //Recupero la SELECT
    

    //Azzero il contenuto della seconda select
    for (var i = select.length - 1; i >= 0; i--)
  	  select.remove(i);
	 for(j =0 ; j<valori.length; j++){
         //Creo il nuovo elemento OPTION da aggiungere nella seconda SELECT
         var NewOpt = document.createElement('option');
         NewOpt.value = valori[j]; // Imposto il valore
         if(valori[j] != null)
         	NewOpt.text = descrizioni[j]; // Imposto il testo
         	NewOpt.title = descrizioni[j];
         //Aggiungo l'elemento option
         try
         {
       	  	select.add(NewOpt, null); //Metodo Standard, non funziona con IE
         }catch(e){
       	  select.add(NewOpt); // Funziona solo con IE
         }
         }

	 document.getElementById("riga_valori").style.display="";
	
}


</script>

<form method="post" action="Tree.do?command=SalvaLivello">
<table border = "1">
<%
int idPadre = (Integer)request.getAttribute("idPadre");
int livello = (Integer)request.getAttribute("livello");
String nomeTabella = (String)request.getAttribute("nomeTabella");
/*lista di tutte le combo*/
if(request.getAttribute("listaLookup")!=null)
{
	ArrayList<String> listaCombo = (ArrayList<String> )request.getAttribute("listaLookup") ;
	%>
	
<tr><td>Seleziona Combo</td><td>
<SELECT name = "tabella" id = "tabella" onchange="getContenutoCombo()">
	<option value = "-1">SELEZIONA VOCE</option>
	<%
		for(String tabella : listaCombo)
		{
			%>
			<option value = "<%=tabella %>"><%=tabella %></option>
			<%
		}
	%>
	</SELECT>
	</td></tr>
	<%
}
else
{
	%>
	<tr><td>Combo</td><td>
	<input type = "text" readonly="readonly" name = "tabella" value = "<%=request.getAttribute("lookup") %>">
	</td></tr>
<%
}
	/*lista dei valori della combo gia presente*/
	if(request.getAttribute("ValoriLookup")!=null)
	{
		HashMap<Integer,String> valori = (HashMap<Integer,String>)request.getAttribute("ValoriLookup");
		Iterator<Integer> itKey = valori.keySet().iterator();
		%>
		<tr><td>Elementi</td><td>
		<select name = "valori" multiple="multiple">
		<%
		while(itKey.hasNext())
		{
			int key = itKey.next();
			String value = valori.get(key);
			%>
			<option value = "<%=key %>"><%=value %></option>
			<%
			
		}
		%>
		
		</select>
		</td></tr>
		<%
	}
	else
	{
		%>
		<tr id = "riga_valori" style="display: none"><td>Elementi</td><td>
		<select name = "valori" id = "valori" multiple="multiple" >
		
		</select>
		</td></tr>
		<%
		
	}
%>
<tr><td>id Padre</td><td><%=idPadre %></td></tr>
<tr><td>id Livello</td><td><%=livello %></td></tr>
<tr><td>nomeTabella</td><td><%=nomeTabella %></td></tr>
<input type = "hidden" name = "nomeTabella" value = "<%=nomeTabella %>"/>
<input type = "hidden" name = "idPadre" value = "<%=idPadre %>"/>
<input type = "hidden" name = "livello" value = "<%=livello %>"/>
<tr><td colspan="2"><input type = "submit" value ="Salva"></td></tr>

</table>

</form>

	
