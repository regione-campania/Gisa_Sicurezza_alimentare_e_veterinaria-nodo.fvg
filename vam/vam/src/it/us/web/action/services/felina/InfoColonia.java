package it.us.web.action.services.felina;

import it.us.web.action.GenericAction;
import it.us.web.bean.remoteBean.Colonia;
import it.us.web.bean.remoteBean.Gatto;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.json.SqlTimestampConverter;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletOutputStream;

import org.hibernate.criterion.Restrictions;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class InfoColonia extends GenericAction
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
		String id = stringaFromRequest( "id" );
		String json = "{}";

		List<Colonia> colonie = persistence.createCriteria( Colonia.class )
			.add( Restrictions.eq( "id", id ) ).list();
		
		if( colonie.size() > 0 )
		{
			Colonia col = colonie.get( 0 );
			col.setErrorCode( 0 );
			json = gson.toJson( col );
		}
		
		ServletOutputStream out =  res.getOutputStream();
		out.println( json );
		out.flush();
	}
}
