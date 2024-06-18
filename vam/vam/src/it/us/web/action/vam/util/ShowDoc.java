package it.us.web.action.vam.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import it.us.web.action.GenericAction;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.properties.Application;

public class ShowDoc extends GenericAction
{

	final static Logger logger = LoggerFactory.getLogger(ShowDoc.class);
	
	@Override
	public void can() throws AuthorizationException
	{
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
	}

	
	@SuppressWarnings("unchecked")
	@Override
	public void execute() throws Exception
	{
		redirectTo( Application.get("DOCS_ROOT_FOLDER") + "#" + getSegnalibroDocumentazione() );
	}

}
