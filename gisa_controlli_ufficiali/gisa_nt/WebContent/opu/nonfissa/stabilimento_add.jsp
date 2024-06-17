<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.opu.base.*,org.aspcfs.modules.contacts.base.*,org.aspcfs.modules.base.Constants" %>

<%@ include file="../../utils23/initPage.jsp"%>

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.1.9.1.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>
<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

<script>
function add(form, val){
	if (val=='imbarcazione')
		form.action='OpuStab.do?command=AddImbarcazione';	
	else if (val=='operatore')
		form.action='OpuStab.do?command=AddOperatoreFuoriRegione';
	else if (val=='automezzo')
		form.action='OpuStab.do?command=PrepareAddAutomezzo';
	loadModalWindow();
	form.submit();
}
</script>



<form name="addForm" id = "addForm" action="" method="post">


<input type="button" value="Aggiungi Imbarcazione" onClick="add(this.form, 'imbarcazione')"/>

<input type="button" value="Aggiungi Op. Fuori regione" onClick="add(this.form, 'operatore')"/>

<input type="button" value="Aggiungi Att. mobile/ Automezzo" onClick="add(this.form, 'automezzo')"/>


</form>