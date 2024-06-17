<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.opu.base.*,org.aspcfs.modules.contacts.base.*,org.aspcfs.modules.base.Constants" %>


<%@ include file="../../utils23/initPage.jsp"%>


<form name="searchAccount" id = "searchAccount" action="OpuStab.do?command=SearchNonFissa" method="post">
    <table style="border:1px solid black">
<tr><td>    
 <b>Partita IVA/ Codice fiscale</b> <br/>
 Inserire la partita iva o il cf impresa cui agganciare l'automezzo.
 </td></tr>
 <tr><td>
<input type="text" maxlength="11" size="50" name="searchpartitaIva" value=""> <input type="submit" value="CERCA"/>
</td></tr>
</table>
</form>