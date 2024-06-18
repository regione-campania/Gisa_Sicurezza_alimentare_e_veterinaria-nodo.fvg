package it.us.web.action.test;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import it.us.web.action.GenericAction;
import it.us.web.bean.remoteBean.RegistrazioniCanina;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.UrlUtil;
import it.us.web.util.properties.Application;

public class Smarrimento extends GenericAction
{
	@Override
	public void can() throws AuthorizationException
	{
		
	}

	@Override
	public void execute() throws Exception
	{
		String url = "http://62.149.222.66:8280/service/canina/SmarrimentoCane.do?responseType=JSON&mc=" + stringaFromRequest( "mc" );
		String json = UrlUtil.getUrlResponse( url );
		
		GsonBuilder gb = new GsonBuilder();
		gb.setDateFormat( "yyyy-MM-dd HH:mm:ss" );
		Gson gson = gb.create();
		
		RegistrazioniCanina regs = gson.fromJson( json, RegistrazioniCanina.class );
		
		System.out.println( json );
		System.out.println( "adozione: " + regs.getAdozione() );
		System.out.println( "cattura: " + regs.getRicattura() );
		System.out.println( "trasferimento: " + regs.getTrasferimento() );
	}

	@Override
	public void setSegnalibroDocumentazione() {
		// TODO Auto-generated method stub
		
	}
}
