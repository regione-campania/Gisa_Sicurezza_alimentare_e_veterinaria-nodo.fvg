<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/vam/cc/chirurgie/add.js"></script>

<%@page import="it.us.web.util.vam.CaninaRemoteUtil"%>
<%@page import="it.us.web.bean.BUtente"%>

<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>

<h4 class="titolopagina">
	Chirurgia
</h4>
    
<input type="button" value="Nuovo inserimento" onclick="location.href='vam.cc.chirurgie.ToAdd.us'" />
<br/><br/>