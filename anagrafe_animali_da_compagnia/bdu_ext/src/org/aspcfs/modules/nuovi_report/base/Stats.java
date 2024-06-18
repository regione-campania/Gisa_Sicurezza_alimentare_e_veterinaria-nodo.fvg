package org.aspcfs.modules.nuovi_report.base;

import java.util.ArrayList;

public class Stats
{
	String				asl;
	int					idAsl;
	ArrayList<String>	results;
	int					currentIndex = -1;
	
	public void add( String value )
	{
		if( results == null )
		{
			results = new ArrayList<String>();
		}
		
		results.add( value );
	}
	
	public String getAsl()
	{
		return asl;
	}
	
	public void setAsl(String asl)
	{
		this.asl = asl;
	}
	
	public int getIdAsl()
	{
		return idAsl;
	}

	public void setIdAsl(int idAsl)
	{
		this.idAsl = idAsl;
	}
	
	public String get( int index )
	{
		return (getSize() <= index || index < 0) ? (null) : (results.get(index));
	}
	
	public String getNext()
	{
		return get( ++currentIndex );
	}
	
	public void resetIndex()
	{
		currentIndex = -1;
	}
	
	public int getSize()
	{
		return (results == null) ? (0) : (results.size());
	}
	
}
