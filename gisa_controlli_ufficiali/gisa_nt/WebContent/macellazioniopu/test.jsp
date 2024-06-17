<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src='javascript/jquerymini.js'></script>	
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.1.9.1.js"></script>
<script language="javascript">
$(document).ready(function() {
    $('form[name=addstabilimento]').submit(function(e){
        e.preventDefault();
        $.ajax({
            type: 'GET',
            cache: false,
            type: "GET",
	        url: "<%=request.getContextPath() %>/ServletForm",
	        async: false,
	        dataType: "json",
	        error: function(XMLHttpRequest, status, errorThrown) {
	            alert("oh no!");
	            alert(status);
	        },
            success: function(msg) {
              alert('T appo');
            }
        });
    });    
});

</script>
</head>
<body>
<form name="addstabilimento" id="addstabilimento">
<input type="submit" value="invia">
</form>
</body>
</html>

 