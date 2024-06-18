package it.us.web.tag.vam;

import java.io.IOException;

import it.us.web.bean.vam.lookup.LookupSoglieEsami;
import it.us.web.tag.GenericTag;

import javax.servlet.jsp.JspWriter;

public class SoglieOutput extends GenericTag
{
	private static final long serialVersionUID = 1L;
	
	private String proprieta;
	
	private boolean scriptGenerationMode = false;
	
	public int doStartTag()
	{
		Soglie				soglieTag	= (Soglie) findAncestorWithClass( this, Soglie.class );
		LookupSoglieEsami	soglia		= soglieTag.getSoglia( proprieta );
		Float				valore		= soglieTag.getValue( proprieta );
		
		String sogliaText	= "";
		String colore		= "";
		String valueToPrint	= "&nbsp";
		
		boolean outRange		= false;
		boolean thereIsARange	= false;
		
		if( soglia != null )
		{
			if( soglia.getMin() != null )
			{
				sogliaText = ( "min=" + soglia.getMin());
				if( valore != null )
				{
					outRange		= ( valore < soglia.getMin() );
					thereIsARange	= true;
				}
			}
			
			if( soglia.getMax() != null )
			{
				sogliaText += ( (soglia.getMin() == null) ? ("") : (", ") + "max=" + soglia.getMax() );
				if( valore != null )
				{
					outRange		= outRange || ( valore > soglia.getMax() );
					thereIsARange	= true;
				}
			}
			
		}
		else if( scriptGenerationMode )
		{
			soglieTag.insertLookupSoglia( proprieta );
		}
		
		if( outRange )
		{
			colore = "red";
		}
		else if( thereIsARange )
		{
			colore = "00c000";
		}
		
		if( valore != null )
		{
			valueToPrint = valore.toString();
		}
		
		JspWriter o = pageContext.getOut();
		
		try
		{
			o.write( "<font color=\"" + colore + ( (sogliaText.length() == 0) ? ("") : ("\" title=\"" + sogliaText) ) + "\">" + valueToPrint + "</font>" );
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
		
		return SKIP_BODY;
	}
	
		
	public int doEndTag()
	{
		return EVAL_BODY_INCLUDE;
	}


	public String getProprieta() {
		return proprieta;
	}


	public void setProprieta(String proprieta) {
		this.proprieta = proprieta;
	}

}