<%
String link = request.getParameter("link");
String suffisso = application.getInitParameter("context_starting");
String guida = "";

if (suffisso!=null && suffisso.equalsIgnoreCase("bdu_ext"))
	guida = "guida_ext_jsp.jsp";
else
	guida = "guida_jsp.jsp";
guida += "#"+link;
%>

<script>
document.location.href='<%=guida%>'
</script>