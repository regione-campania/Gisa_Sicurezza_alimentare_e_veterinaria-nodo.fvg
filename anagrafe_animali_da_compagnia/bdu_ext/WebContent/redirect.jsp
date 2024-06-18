<%@ include file="initPage.jsp" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>
<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
  <title>Concourse Suite Community Edition</title>
<%--   <meta http-equiv="refresh" content="1;URL=<%= request.getAttribute("redirectUrl") %>"> --%>
</head>

<body onload="loadModalWindow();document.forms[0].submit();">
<form method="post" action="<%=request.getAttribute("redirectUrl")%>">
<input type="hidden" name="Message" value = "<%=request.getAttribute("Message") %>">
</form>
</body>
</html>
