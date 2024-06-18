package it.us.web.action.services.canina;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletOutputStream;

import org.hibernate.criterion.Restrictions;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import it.us.web.action.GenericAction;
import it.us.web.bean.remoteBean.Cane;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.json.SqlTimestampConverter;

public class InfoCane extends GenericAction
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

		List<Cane> cani = persistence.createCriteria( Cane.class )
			.add( Restrictions.eq( "mc", mc ) ).list();
		
		if( cani.size() > 0 )
		{
			Cane cane = cani.get( 0 );
			cane.setErrorCode( 0 );
			json = gson.toJson( cane );
		}
		
		ServletOutputStream out =  res.getOutputStream();
		out.println( json );
		out.flush();
	}
}
