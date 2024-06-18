package it.us.web.action.test;

import java.io.InputStream;
import java.util.Hashtable;
import java.util.Map;

import javax.servlet.ServletOutputStream;

import it.us.web.action.GenericAction;
import it.us.web.bean.vam.Accettazione;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.report.PdfReport;

public class FormFilling extends GenericAction
{

	@Override
	public void can() throws AuthorizationException
	{

	}

	@Override
	public void execute() throws Exception
	{
		//modello di report scopiazzato da canina
		InputStream template = this.getClass().getResourceAsStream( "Modello Report.pdf" );
		
		Object bean = persistence.find( Accettazione.class, 1 );
		Map<String, Object> mappaProprietaAddizionali = new Hashtable<String, Object>();
		mappaProprietaAddizionali.put( "report", true );
		mappaProprietaAddizionali.put( "filtri", "bananarama" );
		
		res.setContentType( "application/pdf" );
		res.setHeader( "Content-Disposition","attachment; filename=\"pippo.pdf\";" );
		ServletOutputStream sout = res.getOutputStream();
		sout.write( PdfReport.fillDocument( template, bean, mappaProprietaAddizionali ) );
		sout.flush();
	}

	@Override
	public void setSegnalibroDocumentazione() {
		// TODO Auto-generated method stub
		
	}

}
