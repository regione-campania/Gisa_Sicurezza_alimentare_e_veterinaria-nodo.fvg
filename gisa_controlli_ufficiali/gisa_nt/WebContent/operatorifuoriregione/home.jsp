<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ include file="../utils23/initPage.jsp" %>

<script type="text/javascript">
function clearForm() {
    <%-- Account Filters --%>
    document.forms['searchOperatori'].targa.value="";
    document.forms['searchOperatori'].duplicati.checked="";
    
  }


	function trim(stringa){
	    while (stringa.substring(0,1) == ' '){
	        stringa = stringa.substring(1, stringa.length);
	    }
	    while (stringa.substring(stringa.length-1, stringa.length) == ' '){
	        stringa = stringa.substring(0,stringa.length-1);
	    }
	    return stringa;
	};
	
	function checkForm()
	{
		targa = document.getElementById( 'targa' ).value;
			
		all = ( "" + targa );
	
		if( trim( all ).length > 0 )
		{
			return true;
		}
		else
		{
			alert( "Selezionare almeno un filtro" );
			return false;
		}
	};
	
</script>

<form name="searchOperatori" action="OperatoriFuoriRegione.do?command=Cerca" method="post">
<%-- Trails --%>
<table class="trails" cellspacing="0">
	<tr>
		<td>
			<a href="OperatoriFuoriRegione.do?command=Add&tipoD=Autoveicolo"><dhv:label name="">Aggiungi Imprese Fuori Ambito ASL</dhv:label></a> > 
			<dhv:label name="imprese_pregresso.cerca">Cerca Impresa Alimentare Reg. Altre ASL della Campania da importare</dhv:label>
		</td>
	</tr>
</table>

<table cellpadding="2" cellspacing="2" border="0" width="100%">
  <tr>
    <td width="50%" valign="top">

      <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
        <tr>
          <th colspan="2">
            <strong><dhv:label name="imprese_pregresso.filtri">Filtri</dhv:label></strong>
          </th>
        </tr>
        <tr>
          <td class="formLabel">
            <dhv:label name="">Identificativo Veicolo</dhv:label>
          </td>
          <td>
            <input id="targa" type="text" maxlength="70" size="50" name="targa" />
          </td>
        </tr>
        
        <tr>
          <td class="formLabel">
            <dhv:label name="imprese_pregresso.duplicati">Evita Duplicati</dhv:label>
          </td>
          <td>
            <input id="duplicati" type="checkbox" name="duplicati" />
          </td>
        </tr>
        
      </table>
      
      
    </td>
    
  </tr>
  
</table>

<input onclick="return checkForm();" type="submit" value="<dhv:label name="button.search">Search</dhv:label>">
<input type="button" value="<dhv:label name="button.clear">Clear</dhv:label>" onClick="javascript:clearForm();">

</form>


