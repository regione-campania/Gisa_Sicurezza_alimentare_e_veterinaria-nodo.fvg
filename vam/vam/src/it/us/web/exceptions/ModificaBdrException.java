package it.us.web.exceptions;

public class ModificaBdrException extends AuthorizationException {
	
	private static final long serialVersionUID = -8297953010637899587L;
	private String message;
	
	public ModificaBdrException()
	{
		
	}
	
	public ModificaBdrException( String message ) 
	{
		this.message = message;
	}
	
	public String getMessage()
	{
		return message;
	}
	
	public void setMessage( String message )
	{
		this.message = message;
	}
}
