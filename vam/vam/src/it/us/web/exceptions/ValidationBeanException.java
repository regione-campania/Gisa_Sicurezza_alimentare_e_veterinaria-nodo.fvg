package it.us.web.exceptions;

import it.us.web.action.Action;

public class ValidationBeanException extends Exception{

	private static final long serialVersionUID = -2403325587841993550L;
	private String message;
	private Action actionToGo;
	
	public ValidationBeanException( String message, Action actionToGo) 
	{
		this.message = message;
		this.actionToGo = actionToGo;
	}
	
	public String getMessage()
	{
		return message;
	}
	
	public void setMessage( String message )
	{
		this.message = message;
	}
	
	public Action getActionToGo()
	{
		return actionToGo;
	}
	
	public void setActionToGo( Action actionToGo )
	{
		this.actionToGo = actionToGo;
	}

}
