package it.us.web.action.services.felina;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletOutputStream;

import org.hibernate.criterion.Restrictions;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import it.us.web.action.GenericAction;
import it.us.web.bean.remoteBean.Gatto;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.json.SqlTimestampConverter;

public class InfoGatto extends GenericAction
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
		gb.registerTypeAdapter(Timestamp.class, new SqlTimestampConverter());
		gson = gb.create();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void execute() throws Exception
	{
		String mc = stringaFromRequest( "mc" );
		String json = "{}";

		List<Gatto> gatti = persistence.createCriteria( Gatto.class )
			.add( Restrictions.eq( "mc", mc ) ).list();
		
		if( gatti.size() > 0 )
		{
			Gatto gatto = gatti.get( 0 );
			gatto.setErrorCode( 0 );
			json = gson.toJson( gatto );
		}
		
		ServletOutputStream out =  res.getOutputStream();
		out.println( json );
		out.flush();
	}
}
