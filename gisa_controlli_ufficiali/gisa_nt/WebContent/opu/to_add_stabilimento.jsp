<%@page import="org.aspcfs.modules.opu.base.Stabilimento"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

</head>
<body>

<%--
<input type = "button" value="NUOVA SCIA" onclick="location.href='OpuStab.do?command=Add&tipoInserimento=<%=Stabilimento.TIPO_SCIA_REGISTRABILI%>&stato=<%=Stabilimento.STATO_REGISTRAZIONE_ND%>'"/>
<input type = "button" title="CLICCANDO QUESTO BOTTONE, SI POTRANNO INSERIRE GLI STABILIMENTI PRESENTI SUL TERRITORIO E NON ANCORA REGISTRATI IN GISA" value="STABILIMENTO PREGRESSO" onclick="location.href='OpuStab.do?command=Add&tipoInserimento=<%=Stabilimento.TIPO_SCIA_REGISTRABILI%>&stato=<%=Stabilimento.STATO_AUTORIZZATO%>'"/>
--%>



<input type = "button" value="ATTIVITA' RICHIEDENTI SCIA" title="Operazioni SUAP a carico dell'ASL in quanto inoltrate dai SUAP dei Comuni di categoria 1 e 2" onclick="location.href='OpuStab.do?command=Add&tipoInserimento=<%=Stabilimento.TIPO_SCIA_REGISTRABILI%>&stato=<%=Stabilimento.STATO_REGISTRAZIONE_ND%>'"/>
<input type = "button" title="" value="PREGRESSO" onclick="location.href='OpuStab.do?command=CaricaImport'"/>
</body>
</html>