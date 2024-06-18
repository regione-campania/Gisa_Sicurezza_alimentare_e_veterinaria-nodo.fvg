<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%@page import="it.us.web.bean.BUtente"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.util.HashMap"%> 
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.TreeMap"%>


<% 
Date adesso = new Date();

HashMap<String,String> listaUtenti = new HashMap<String,String>();
listaUtenti.put("g.balzano", "g.balzano");
listaUtenti.put("c.paolillo", "c.paolillo");
listaUtenti.put("rita.mele", "rita.mele");
listaUtenti.put("m.mazzone", "m.mazzone");
listaUtenti.put("b.sansone", "b.sansone");
listaUtenti.put("s.pane", "s.pane");
listaUtenti.put("w.amante", "w.amante");
listaUtenti.put("s.squitieri", "s.squitieri");
listaUtenti.put("v.spina", "v.spina");

HashMap<String, HttpSession> utenti = null;

utenti = (HashMap<String, HttpSession>)request.getSession().getServletContext().getAttribute("utenti");

if(utenti != null && !utenti.isEmpty())
{
	Set<String> utentiUS = null;
	if(!listaUtenti.keySet().isEmpty())
		utentiUS = listaUtenti.keySet();
	
	if(utentiUS!=null)
	{
		for(String utente : utentiUS)
		{
			if(utenti.containsKey(utente))
			{
				HttpSession sessione = utenti.get(utente);
				BUtente utenteLoggato = null;
				if(sessione!=null && sessione.getAttribute("utente")!=null)
				{
					utenteLoggato =  (BUtente)sessione.getAttribute("utente");
					try
					{
							sessione.invalidate();
					}
					catch(Exception e)
					{
						System.out.println("Errore cleanutenti -->"+e.getMessage());
					}
				}
			}
		}
	}
}


%>

<script>
window.location.href='checkUtenti.jsp?numeroMinuti=<%= request.getParameter("numeroMinuti") %>';
</script>

