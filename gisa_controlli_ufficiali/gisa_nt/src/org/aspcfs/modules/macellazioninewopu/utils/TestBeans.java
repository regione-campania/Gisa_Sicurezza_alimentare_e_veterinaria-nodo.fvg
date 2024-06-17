package org.aspcfs.modules.macellazioninewopu.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Vector;

import org.aspcfs.modules.macellazioninewopu.base.StoriaCapi;

public class TestBeans
{

	public static void main(String[] args)
	{
		Connection db = null;
		
		try
		{
			Class.forName("org.postgresql.Driver");
			 db = DriverManager.getConnection("jdbc:postgresql:"+"gisa",
                     "postgres",
                     "postgres");

			Vector<StoriaCapi> sc = StoriaCapi.load( 2, db );
			
			
			
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			if( db != null )
			{
				try
				{
					db.close();
				}
				catch (SQLException e)
				{
					e.printStackTrace();
				}
			}
		}
		
	}

}
