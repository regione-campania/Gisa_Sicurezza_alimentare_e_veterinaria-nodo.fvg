package it.us.web.action;

import java.net.InetAddress;
import java.util.HashMap;

import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.Configuratore;
import it.us.web.util.properties.Application;

public class IndexContatti extends GenericAction
{
	
	private String system;
	
	public IndexContatti() {		
	}
	
	public IndexContatti (String system) {
		this.system = system;
	}
	@Override
	public void can() throws AuthorizationException
	{

	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("login");
	}

	@Override
	public void execute() throws Exception
	{
				
		String BDU_PORTALE_URL 		= "http://";
		//String BDU_URL 		  		= InetAddress.getByName(Application.get("BDU_URL_PUBLIC")).getHostAddress();
		//String BDU_URL 		  		= ((HashMap<String, InetAddress>)req.getServletContext().getAttribute("hosts")).get("srvBDUW").getHostAddress();
		//String BDU_PORT 		  		= Application.get("BDU_PORT");
		//String BDU_APPLICATION_NAME 	= Application.get("BDU_APPLICATION_NAME");
		//BDU_PORTALE_URL = BDU_PORTALE_URL + BDU_URL + ":" + BDU_PORT + "/" + BDU_APPLICATION_NAME;
		//req.setAttribute("BDU_PORTALE_URL", BDU_PORTALE_URL);
		
		/* Se il sistema di riferimento è in sessione ha la precedenza,
		 * altrimenti sarà fornito al sistema (e quindi in sessione)
		 * mediante il costruttore della Index*/
		if (session.getAttribute("system") != null)
			system = (String) session.getAttribute("system");
		else
			session.setAttribute("system", system);
		
		if (system == null || (system.equalsIgnoreCase("vam") && utente == null) ) {
			gotoPage( "homePageVAM", "/jsp/public/indexVContatti.jsp" );
		}
		else if (system.equalsIgnoreCase("vam") && utente != null) {
			goToAction( new Home() );
		}
		else if (system.equalsIgnoreCase("sinantropi") && utente == null) {
			session.setAttribute("entrypointSinantropi",req.getParameter("entrypointSinantropi"));
			gotoPage( "homePageSinantropi", "/jsp/public/indexSContatti.jsp" );
		}
		else if (system.equalsIgnoreCase("sinantropi") && utente != null) {
			session.setAttribute("entrypointSinantropi",req.getParameter("entrypointSinantropi"));
			goToAction( new Home() );
		}
		else {
			gotoPage( "homePageVAM", "/jsp/public/indexVContatti.jsp" );
		}

		//Versione precedenete (Unico Sistema....VAM)
		//if( utente == null )
		//{
		//	gotoPage( "public", "/jsp/public/index.jsp" );
		//}
		//else
		//{
		//	goToAction( new Home() );
		//}
		
	}

}
