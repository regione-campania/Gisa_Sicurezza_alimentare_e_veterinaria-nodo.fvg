package com.anagrafica_noscia.prototype.base_beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class LookupPair {
	private int code;
	private String desc;

	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}

	
	
	public LookupPair(){}
	public LookupPair(int code, String desc)
	{
		this.code = code;
		this.desc = desc;
	}
	
	
	 
	public static LookupPair buildByCode(Connection conn, String tableName, String codeFieldName, String descFieldName ,int code, String condition) throws Exception
	{
		
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		try
		{
			pst = conn.prepareStatement("select * from "+tableName+" where "+codeFieldName+"= "+code+" "+(condition != null ? " and "+condition : ""));
			rs = pst.executeQuery();
			rs.next();
			String desc = rs.getString(descFieldName);
			LookupPair pair = new LookupPair(code,desc);
			return pair;
			
		}
		catch(Exception ex)
		{
			System.out.println("Impossibile ottenere lookup pair su tabella "+tableName+" per code "+code);
			throw ex;
		}
		finally
		{
			try{ pst.close();  } catch(Exception ex){}
			try{ rs.close();  } catch(Exception ex){}
		}
	}
	
	public static LookupPair buildByDesc(Connection conn, String tableName, String codeFieldName, String descFieldName, String desc, String condition) throws Exception
	{
		
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		try
		{
			pst = conn.prepareStatement("select * from "+tableName+" where lower("+descFieldName+")= "+desc.toLowerCase()+" "+(condition != null ? " and "+condition : ""));
			rs = pst.executeQuery();
			Integer code = rs.getInt(codeFieldName);
			LookupPair pair = new LookupPair(code,desc);
			return pair;
			
		}
		catch(Exception ex)
		{
			throw ex;
		}
		finally
		{
			try{ pst.close();  } catch(Exception ex){}
			try{ rs.close();  } catch(Exception ex){}
		}
	}
	
	
	
	public static ArrayList<LookupPair> getAll(Connection conn, String tableName, String codeFieldName, String descFieldName, String restriz) throws Exception
	{
		ArrayList<LookupPair> toRet = new ArrayList<LookupPair>();
		ResultSet rs = null;
		PreparedStatement pst = null;
		
		try
		{
			pst = conn.prepareStatement("select "+codeFieldName+", "+descFieldName+" from "+tableName+" "+(restriz != null ? " where "+restriz : ""));
			rs = pst.executeQuery();
			while(rs.next())
			{
				int code = rs.getInt(codeFieldName);
				String desc = rs.getString(descFieldName);
				LookupPair pair = new LookupPair(code,desc);
				toRet.add(pair);
			}
		}
		catch(Exception ex)
		{
			throw ex;
			
		}
		finally
		{
			try{rs.close();}catch(Exception ex){}
			try{pst.close();}catch(Exception ex){}
		}
		
		return toRet;
	}
}
