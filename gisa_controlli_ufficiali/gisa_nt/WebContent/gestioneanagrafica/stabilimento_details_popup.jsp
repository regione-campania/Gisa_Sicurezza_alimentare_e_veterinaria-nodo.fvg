<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<table style="top:0;left: 0;width:100%;height: 100%; " cellpadding="5">
<tr>
<td style="vertical-align: top; position: relative;" align="center">
<iframe 
	scrolling="no" 
	src="GestioneAnagraficaAction.do?command=TemplateDetails&altId=${altId}" 
	id="dettaglioTemplate" 
	style="width: 100%; height: 100%; border: none; " 
	onload="this.style.height=(this.contentDocument.body.scrollHeight)+'px';"></iframe>
</td>
</tr>
</table>
