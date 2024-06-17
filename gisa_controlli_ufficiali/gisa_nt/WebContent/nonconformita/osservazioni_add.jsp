<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<jsp:useBean id="Macrocategorie" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<link href="css/osservazioni.css" rel="stylesheet" type="text/css" />
<!-- FINE CODICE PER POPUP MODALE JQUERY -->
<link href="css/nonconformita.css" rel="stylesheet" type="text/css" />



<div class="tabber">
<div class="tabbertab">
 <%@ include file="osservazioni_formali_add.jsp" %>

</div>
<div class="tabbertab">

 <%@ include file="osservazioni_significative.jsp" %>

</div>
 
 <div class="tabbertab">
 <%@ include file="osservazioni_gravi.jsp" %>

 </div>
 </div>


<input type = "hidden" name = "idIspezione" value = "<%=CU.getTipoIspezione() %>">




<script>
resetElementi(0,0,0,1,1,1);
</script>





