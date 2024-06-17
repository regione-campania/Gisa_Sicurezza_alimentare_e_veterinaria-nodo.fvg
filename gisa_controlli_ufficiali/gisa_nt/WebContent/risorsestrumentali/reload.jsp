
<script>

var idAsl = <%=Integer.parseInt(""+ request.getAttribute("idAsl"))%>
var comboArea =  <%=Integer.parseInt(""+ request.getAttribute("comboArea"))%>
location.href='DpatRS.do?command=AddModify&idAsl='+idAsl+'&combo_area='+comboArea;
</script>