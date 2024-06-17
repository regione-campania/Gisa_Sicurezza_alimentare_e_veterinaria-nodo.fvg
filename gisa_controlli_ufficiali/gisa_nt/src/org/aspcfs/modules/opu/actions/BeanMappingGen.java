package org.aspcfs.modules.opu.actions;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class BeanMappingGen {

	public HashMap<String,String> campi = new HashMap<String,String>();
	
	public BeanMappingGen(ResultSet rs) throws SQLException
	{
		ResultSetMetaData rsmd =rs.getMetaData();
		for(int i=1;i<=rsmd.getColumnCount();i++)
		{
			campi.put(rsmd.getColumnName(i),rs.getString(rsmd.getColumnName(i)));
		}
		 
		 
	}
	
	
	public static  ArrayList<BeanMappingGen> buildList(ResultSet rs) throws SQLException
	{
		ArrayList<BeanMappingGen> toRet = new ArrayList<BeanMappingGen>();
		int j = 0;
		
		while(rs.next())
		{
			
			BeanMappingGen toAdd = new BeanMappingGen(rs);
			toRet.add(toAdd);
			
			
		}
		
		
		return toRet;
	}
	
	
	
}
