package it.us.web.action.services.felina;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletOutputStream;

import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import it.us.web.action.GenericAction;
import it.us.web.bean.remoteBean.ProprietarioCane;
import it.us.web.bean.remoteBean.ProprietarioGatto;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.json.SqlTimestampConverter;

public class InfoProprietario extends GenericAction
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
	
	final static Logger logger = LoggerFactory.getLogger(InfoProprietario.class);
	
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
		String id = stringaFromRequest( "is" );
		logger.info("Ricerca proprietario per gatto con id = " + id);
		String json = "{}";

		List<ProprietarioGatto> props = persistence.createCriteria( ProprietarioGatto.class )
			.add( Restrictions.eq( "id", id ) ).list();
		
		
		if( props.size() > 0 )
		{
			logger.info("E' stato costruito correttamente il bean Gatto");
			ProprietarioGatto prop = props.get( 0 );
			logger.info("E' stato trovato il seguente proprietario per il Gatto interessato: " + prop.getNome() + " " + prop.getCognome());
			prop.setErrorCode( 0 );
			json = gson.toJson( prop );
		}
		
		ServletOutputStream out =  res.getOutputStream();
		out.println( json );
		out.flush();
	}
}
