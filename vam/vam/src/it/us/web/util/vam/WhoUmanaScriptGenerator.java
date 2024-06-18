package it.us.web.util.vam;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.FileReader;

public class WhoUmanaScriptGenerator
{

	public static void main(String[] args)
	{
		try
		{
			FileReader			fr	= new FileReader( "c:\\whoUmana.csv" );
			BufferedReader		br	= new BufferedReader( fr );
			FileOutputStream	fos	= new FileOutputStream( "c:\\whoUmana.sql" );
			
			String	lastPcode	= "xxx";
			int		lastPid		= -1;
			int		id			= 0;
			
			for( String temp = br.readLine(); temp != null; temp = br.readLine() )
			{
				String sql = "";
				
				String[] splitz = temp.split( ";" );
				String pText = splitz[0].replaceAll( "\"", "" ).trim().replaceAll( "'", "''" );
				String pCode = splitz[1].replaceAll( "\"", "" ).trim().replaceAll( "'", "''" );
				String fText = splitz[2].replaceAll( "\"", "" ).trim().replaceAll( "'", "''" );
				String fCode = splitz[3].replaceAll( "\"", "" ).trim().replaceAll( "'", "''" );
				
				
				
				if( !lastPcode.equalsIgnoreCase( pCode ) ) //nuovo padre
				{
					sql = "INSERT INTO lookup_esame_istopatologico_who_umana (id, codice, description, enabled, level, padre) VALUES (";
					sql += ( ++id + ", '" );
					sql += ( pCode + "', '" + pText + "', true, " + id*10 + ", NULL );\n" );
					lastPid		= id;
					lastPcode	= pCode;

					fos.write( sql.getBytes() );
				}

				sql = "INSERT INTO lookup_esame_istopatologico_who_umana (id, codice, description, enabled, level, padre) VALUES (";
				sql += ( ++id + ", '" );
				sql += ( fCode + "', '" + fText + "', true, " + id*10 + ", " + lastPid + " );\n" );
				
				fos.write( sql.getBytes() );
				
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}

}
