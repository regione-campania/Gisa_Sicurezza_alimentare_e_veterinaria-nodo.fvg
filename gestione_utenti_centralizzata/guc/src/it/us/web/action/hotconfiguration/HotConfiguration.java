package it.us.web.action.hotconfiguration;

import it.us.web.action.GenericAction;
import it.us.web.db.ApplicationProperties;
import it.us.web.exceptions.AuthorizationException;


public class HotConfiguration extends GenericAction{

	@Override
	public void can() throws AuthorizationException
	{
		isLogged();
	}

	@Override
	public void execute() throws Exception {
		can(); 
		
		try {

			for (Object chiave : ApplicationProperties.getApplicationProperties().keySet()) {
				ApplicationProperties.getApplicationProperties().setProperty(chiave.toString().trim(),
						req.getParameter(chiave.toString().trim()));
			}

			req.setAttribute("configMessage", "Configurazione a caldo avvenuta con successo");

		} catch (Exception e) {
			req.setAttribute("configMessage", "Errore durante la Configurazione a caldo");
		}
			
		
		goToAction(new toHotConfiguration(), req, res); 
	}

}
