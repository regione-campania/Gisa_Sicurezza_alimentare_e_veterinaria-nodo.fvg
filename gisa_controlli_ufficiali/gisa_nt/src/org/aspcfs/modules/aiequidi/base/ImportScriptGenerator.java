package org.aspcfs.modules.aiequidi.base;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class ImportScriptGenerator
{
	static SimpleDateFormat from	= new SimpleDateFormat( "dd/MM/yyyy" );
	static SimpleDateFormat to		= new SimpleDateFormat( "yyyy-MM-dd" );
	
	private static String getInsertLine( String riga )
	{
		String ret = null;
		String insert_into = "INSERT INTO a_i_equidi( anno, num_accettazione, num_capi_prelevati, " +
				"num_acc_progressivo_campione, data_prelievo, data_accettazione, nomin_utente, " +
				"codazie, ragione_sociale, citta, id_capo, risultato, esito, num_rapporto ) " +
				"VALUES( ";
		riga = riga.replaceAll( "'", "''" );
		riga = riga.replaceAll( "\"", "" );
		String[] v = riga.split( "[;]" );
		
		String anno		= v[0];
		String num_acc	= v[1];
		String num_capi	= v[2];
		String num_acc_prog = v[3];
		
		try
		{
			ret = insert_into + v[0] + ", " + v[1] + ", " + v[2] + ", '" + v[3] + "', '" 
			+ data(v[4]) + "', '" + data(v[5]) + "', '" + v[6] + "', '" + v[7] + "', '" + v[8] + "', '"
			+ v[9] + "', '" + v[10] + "', '" + v[11] + "', '" + v[12] + "', " + v[13] + " );\n";
		}
		catch (ParseException e)
		{
			e.printStackTrace();
		}
		
		return ret;
	}
	
	private static String data(String data) throws ParseException
	{
		return to.format( from.parse( data ) );
	}

	public static void main(String[] args)
	{
		try
		{
			FileInputStream		fis = new FileInputStream( "C:\\AIE2012.csv" );
			FileOutputStream	fos = new FileOutputStream( "E:\\Prelievi AIE 2012 SCRIPT NEW.sql" );
			BufferedReader		br = new BufferedReader(new InputStreamReader(fis));
			String riga = br.readLine();
			while( riga != null )
			{
				fos.write( getInsertLine( riga ).getBytes() );
				riga = br.readLine();
			}
			fos.flush();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}

}
