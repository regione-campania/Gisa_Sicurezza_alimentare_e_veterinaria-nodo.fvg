<% if ("true".equalsIgnoreCase(org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("NUOVA_GESTIONE_CAMPIONI_MACELLI"))){ %>

<jsp:include page="home_new.jsp" />

<% } else { %>

<jsp:include page="home_old.jsp" />

<% } %>