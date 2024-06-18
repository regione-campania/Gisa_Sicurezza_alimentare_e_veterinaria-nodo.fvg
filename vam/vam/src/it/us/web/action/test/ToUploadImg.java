package it.us.web.action.test;

import it.us.web.action.GenericAction;
import it.us.web.exceptions.AuthorizationException;

public class ToUploadImg extends GenericAction
{

	@Override
	public void can() throws AuthorizationException
	{

	}

	@Override
	public void execute() throws Exception
	{
		gotoPage( "upload", "/jsp/test/uploadImg.jsp" );
	}

	@Override
	public void setSegnalibroDocumentazione() {
		// TODO Auto-generated method stub
		
	}

}
