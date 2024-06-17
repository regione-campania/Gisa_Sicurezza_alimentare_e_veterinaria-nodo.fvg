package com.anagrafica_noscia.prototype.base_beans;

import java.sql.PreparedStatement;

import org.json.JSONObject;

public class Utilities {
	
	
	
	/*metodo che evita l'eccezione di quando si accede ad un JSONObject per
	 * una chiave inesistente
	 */
	public static String getNullableFieldAsString(String key,JSONObject ob)
	{
		String s = null;
		if(ob.has(key))
			s = ob.getString(key);
		return s;
	}
	
	
	
	
	
	/*metodo che se una chiave in un oggetto non esiste, ritorna null per quel campo
	 * se invece esiste ma ha valore stringa vuota, ritorna comunque null
	 */
	public static String getAsNullIfEmpty(String key, JSONObject ob)
	{
		String value = getNullableFieldAsString(key, ob);
		
		if(value != null && value.trim().length( )== 0)
			value = null;
		
		return value;
	}
	
	
	
	/*metodo che evita l'eccezione quando si chiama sul pst un setX con un valore null
	 * e in tal caso lo setta a null con setNull */
	public static <T> void setNullable(int tipo, int index, Object value, PreparedStatement pst) throws Exception
	{
		if(tipo == java.sql.Types.VARCHAR )
		{
			if (value == null)
			{
				pst.setNull(index, java.sql.Types.VARCHAR);
			}
			else
			{
				pst.setString(index, (String)value);
			}
		}
		else if(tipo == java.sql.Types.INTEGER)
		{
			if(value == null)
			{
				pst.setNull(index, java.sql.Types.INTEGER);
			}
			else
			{
				pst.setInt(index, (Integer)value);
			}
		}
		else if(tipo == java.sql.Types.DOUBLE)
		{
			if(value == null)
			{
				pst.setNull(index, java.sql.Types.DOUBLE);
			}
			else
			{
				pst.setDouble(index, (Double)value);
			}
		}
		else if(tipo == java.sql.Types.TIMESTAMP)
		{
			if(value == null)
			{
				pst.setNull(index, java.sql.Types.TIMESTAMP);
			}
			else
			{
				pst.setTimestamp(index, (java.sql.Timestamp)value);
			}
		}
	}
	
	

	 
	
}
