package it.us.web.action.services.felina;

import it.us.web.action.GenericAction;
import it.us.web.bean.remoteBean.RegistrazioniCanina;
import it.us.web.bean.remoteBean.RegistrazioniFelina;
import it.us.web.exceptions.AuthorizationException;

import java.util.List;

import javax.servlet.ServletOutputStream;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class ElencoRegistrazioniEffettuabili extends GenericAction
{
	private static GsonBuilder gb;
	private static Gson gson;

	@Override
	public void can() throws AuthorizationException
	{
		
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
	}

	static
	{
		gb = new GsonBuilder();
		gb.setDateFormat( "yyyy-MM-dd HH:mm:ss" );
		gb.setPrettyPrinting();
		gb.setVersion( 1.5 );
		gson = gb.create();
			
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void execute() throws Exception
	{
		String mc = stringaFromRequest( "mc" );
		String json = "{}";
		
		List<RegistrazioniFelina> reList = persistence.getNamedQuery("GetRegistrazioniFelina")
			.setString( "identificativo", mc ).list();
		
		if( reList.size() > 0 )
		{
			RegistrazioniFelina re = reList.get( 0 );
			re.setErrorCode( 0 );
			json = gson.toJson( re );
		}
		
		ServletOutputStream out =  res.getOutputStream();
		out.println( json );
		out.flush();
	}
}
