Linee di attiività modificate!

<% 
	String commit = (String)request.getAttribute("commit");
%>
<script>
<%
	if(commit==null || commit.equals("") || commit.equals("null"))
	{
%>
		window.opener.loadModalWindow();
		window.opener.location.reload();
<%
	}
%>
window.close();
</script>