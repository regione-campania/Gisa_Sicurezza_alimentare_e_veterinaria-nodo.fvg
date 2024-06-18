<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>

username: ${utentex.username}

<jmesa:tableModel items="${utentex.passwords}" id="pwds" var="pwd">
	<jmesa:htmlTable>
		<jmesa:htmlRow>
			<jmesa:htmlColumn property="username" />
		</jmesa:htmlRow>
	</jmesa:htmlTable>
</jmesa:tableModel>
