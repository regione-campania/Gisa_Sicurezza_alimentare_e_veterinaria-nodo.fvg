<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<c:if test="${fcTemp.padre==null}">
	<c:forEach begin="0" end="${livello}" step="1">
		&nbsp;&nbsp;
	</c:forEach>
	<c:out value="${fcTemp.description}"/>
	<br/>
</c:if>
<c:choose>
	<c:when test="${not empty fcTemp.figli}">
		<c:set var="livello" scope="request" value="${livello+1}" />
		<c:forEach items="${fcTemp.figli}" var="fc" >		
    		<c:set var="fcTemp" scope="request" value="${fc}" />
    		<c:import url="../vam/cc/autopsie/ricorsioneFcEdit.jsp"/>						
		</c:forEach>
	</c:when>
	<c:otherwise>
		<c:if test="${fcTemp.sceltaSingola}">
			<c:forEach begin="0" end="${livello}" step="1">
				&nbsp;&nbsp;
			</c:forEach>
			<input type="radio" id="fc_${fcTemp.id}"
				<c:if test="${fcTemp.padre==null}">
					name="fc_root"
				</c:if>
				<c:if test="${fcTemp.padre!=null}">
					name="fc_${fcTemp.padre.id}"
				</c:if>
			<us:contain collection="${a.fenomeniCadaverici}" item="${fcTemp}" >checked="checked"</us:contain>
			value="${fcTemp.id}" /> 
			<label for="fc_${fcTemp.id}">${fcTemp.description}</label>		
	    	<br/>
		</c:if>
		<c:if test="${!fcTemp.sceltaSingola}">
	    	<c:forEach begin="0" end="${livello}" step="1">
				&nbsp;&nbsp;
			</c:forEach>
			<input type="checkbox" id="fc_${fcTemp.id}" name="fc_${fcTemp.id}" 
			<us:contain collection="${a.fenomeniCadaverici}" item="${fcTemp}" >checked="checked"</us:contain>
			value="${fcTemp.id}" /> <label for="fc_${fcTemp.id}">${fcTemp.description}</label>	
			<br/>
	    </c:if>
	</c:otherwise>
</c:choose>