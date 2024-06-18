package it.us.web.exceptions;

import it.us.web.action.Action;

public class ValidationBeanExceptionRedirect extends Exception{

	private static final long serialVersionUID = -2403325587841993550L;
	private String message;
	private String url;
	
	public ValidationBeanExceptionRedirect( String message, String url) 
	{
		this.message = message;
		this.url = url;
	}
	
	public String getMessage()
	{
		return message;
	}
	
	public void setMessage( String message )
	{
		this.message = message;
	}
	
	public String getUrl()
	{
		return url;
	}
	
	public void setUrl( String url )
	{
		this.url = url;
	}

}
