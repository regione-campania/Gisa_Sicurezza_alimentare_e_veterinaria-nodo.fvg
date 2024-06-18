<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<c:if test="${fcTemp.padre==null}">
	<us:contain collection="${a.fenomeniCadaverici}" item="${fcTemp}" >
		<c:forEach begin="0" end="${livello}" step="1">
			&nbsp;&nbsp;
		</c:forEach>
		<c:out value="${fcTemp.description}"/>
		<br/>
	</us:contain>
</c:if>
<c:choose>
	<c:when test="${not empty fcTemp.figli}">
		<c:set var="livello" scope="request" value="${livello+1}" />
		<c:forEach items="${fcTemp.figli}" var="fc" >		
    		<c:set var="fcTemp" scope="request" value="${fc}" />
    		<c:import url="../vam/cc/autopsie/ricorsioneFcDetail.jsp"/>						
		</c:forEach>
	</c:when>
	<c:otherwise>
		<us:contain collection="${a.fenomeniCadaverici}" item="${fcTemp}" >
			<c:forEach begin="0" end="${livello}" step="1">
				&nbsp;&nbsp;
			</c:forEach>
			${fcTemp.description}
			<br/>
		</us:contain>
	</c:otherwise>
</c:choose>