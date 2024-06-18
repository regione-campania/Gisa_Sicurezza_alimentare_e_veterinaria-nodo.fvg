package it.us.web.action.vam.accettazione;

import it.us.web.action.GenericAction;
import it.us.web.bean.vam.Immagine;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.json.JSONObject;

import java.io.PrintWriter;
import java.util.Date;

public class DelImg extends GenericAction
{
	
	public DelImg() {		
	}
	
	@Override
	public void can() throws AuthorizationException
	{
		
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("accettazione");
	}

	@Override
	public void execute() throws Exception
	{
    	JSONObject jsonObj = new JSONObject();
    	
		try
		{
	    	Immagine	img		= (Immagine) persistence.find( Immagine.class, interoFromRequest( "id" ));
	    	
	    	img.setTrashedDate( new Date() );
	    	img.setModified( img.getTrashedDate() );
	    	img.setModifiedBy( utente );
	    	
	    	persistence.update( img );

			jsonObj.put( "status", "ok" );
			jsonObj.put( "messaggio", "Immagine '" + img.getDisplayName() + "' eliminata con successo" );
		}
		catch ( Exception e )
		{
			e.printStackTrace();

			jsonObj.put( "status", "ko" );
			jsonObj.put( "messaggio", "Errore: " + e.getMessage() );
		}

    	PrintWriter writer = res.getWriter();
    	
    	writer.println( jsonObj );
	}

}
