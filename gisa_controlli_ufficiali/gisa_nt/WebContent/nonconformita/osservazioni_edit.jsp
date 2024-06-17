<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<link href="css/nonconformita.css" rel="stylesheet" type="text/css" />

<jsp:useBean id="Macrocategorie" class="org.aspcfs.utils.web.LookupList" scope="request"/>



<div class="tabber">
<div class="tabbertab">
 <%@ include file="osservazioni_formali_edit.jsp" %>

</div>
<div class="tabbertab">
 <%@ include file="osservazioni_significative_edit.jsp" %>

</div>
 
 <div class="tabbertab">
 <%@ include file="osservazioni_gravi_edit.jsp" %>

 </div>
 </div>


<input type = "hidden" id ="abilita_formali" name = "abilitanc_formali" value = "<%=request.getAttribute("abilita_formali") %>">
<input type = "hidden" id = "abilita_significative" name = "abilitanc_significative"  value = "<%=request.getAttribute("abilita_significative") %>">
<input type = "hidden" id = "abilita_gravi" name = "abilitanc_gravi"  value = "<%=request.getAttribute("abilita_gravi") %>">
<input type = "hidden" id ="formali" name = "formali" value = "<%=request.getAttribute("Formali") %>">
<input type = "hidden" name = "idIspezione" value = "<%=CU.getTipoIspezione() %>">

<script>
resetElementi(0,0,0,1,1,1);
</script>


