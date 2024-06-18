<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.util.HashMap"%> 
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.TreeMap"%>
<%@page import="it.us.web.dao.hibernate.Persistence"%>
<%@page import="it.us.web.dao.hibernate.PersistenceFactory"%>
<%@page import="it.us.web.bean.UtentiOperazioni"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="it.us.web.action.GenericAction"%>
<%@page import="it.us.web.bean.BUtente"%>


<%
HashMap<String, HttpSession> utenti = null;
utenti = (HashMap<String, HttpSession>)request.getSession().getServletContext().getAttribute("utenti");
Date adesso = new Date();
Persistence persistence = PersistenceFactory.getPersistence();

int userId = 0;
try
{
	userId = Integer.parseInt(request.getParameter("userId"));
}
catch(Exception e)
{
	e.printStackTrace();
}
if(userId>0)
{
	try
	{
		for(String username : utenti.keySet())
		{
			UtentiOperazioni uo = null;
			Date dataUltimaOp = null;
			BUtente utente = (BUtente)utenti.get(username).getAttribute("utente");
			HttpSession sessione = (HttpSession)utenti.get(username);
			ArrayList<UtentiOperazioni> uos = (ArrayList<UtentiOperazioni>)persistence.createCriteria(UtentiOperazioni.class)
																							.add(Restrictions.eq("utente",utente))
																							.addOrder(Order.desc("entered"))
																							.list();
		   if(!uos.isEmpty())
			   dataUltimaOp = uos.get(0).getEntered();
		   
			if ( utente.getId() == userId )
			{
				sessione.invalidate();
				utenti.remove(username);
				request.getSession().getServletContext().setAttribute("utenti", utenti);
				break;
			}
		}
	}
	catch(Exception e){}
	
	PersistenceFactory.closePersistence( persistence, true );

}
%>

<script>
window.location.href='checkUtenti.jsp?numeroMinuti=<%= request.getParameter("numeroMinuti") %>';
</script>

