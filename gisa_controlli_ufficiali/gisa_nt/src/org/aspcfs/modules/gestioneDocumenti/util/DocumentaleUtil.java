package org.aspcfs.modules.gestioneDocumenti.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;

import net.sf.jmimemagic.Magic;
import net.sf.jmimemagic.MagicException;
import net.sf.jmimemagic.MagicMatch;
import net.sf.jmimemagic.MagicMatchNotFoundException;
import net.sf.jmimemagic.MagicParseException;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.util.imports.ApplicationProperties;
import org.aspcfs.utils.UrlUtil;

import com.darkhorseventures.framework.actions.ActionContext;


public class DocumentaleUtil extends CFSModule {

	public DocumentaleUtil(){
		
	}
	
	public String executeCommandVerificaDocumentaleOnline(ActionContext context) throws SQLException, IOException{
		boolean esito=  verificaDocumentaleOnline(context);
		System.out.println("[GISA] Esito verifica Documentale online: "+ esito);
		context.getRequest().setAttribute("verificaDocumentaleOnline", esito);
		return "verificaDocumentaleOnlineOK";
	}
	
	public static boolean verificaDocumentaleOnline(ActionContext context) throws SQLException, IOException{
		
		Boolean documentaleDisponibile = Boolean.valueOf(ApplicationProperties.getProperty("DOCUMENTALE_DISPONIBILE"));
	
		if (!documentaleDisponibile){
			return false;
		}
		
		String esito="";
		String urlTest = "http://"+context.getRequest().getLocalAddr()+":"+context.getRequest().getLocalPort() + context.getRequest().getContextPath() + "/"+ApplicationProperties.getProperty("APP_DOCUMENTALE_TEST");
		esito = UrlUtil.getUrlResponse(urlTest);
		
		if (esito!=null && esito.toUpperCase().contains("ONLINE"))
			return true;
		return false;
	}
	
			

	public static String detectMimeType(byte[] ba, ArrayList<String> listaFile) throws MagicParseException, MagicMatchNotFoundException, MagicException 
		{
			MagicMatch match = Magic.getMagicMatch(ba);
			String mimeType = match.getMimeType();
					
			for(String elemento : listaFile)
				{
			        	  if(mimeType.equalsIgnoreCase(elemento))
			        		  return null;
			          }

			
			
			return "errore";
	}
	
	public static String mimeType(String pathFile, ArrayList<String> listaFile) throws MagicParseException, MagicMatchNotFoundException, MagicException, IOException 
	{
		File fileMime = new File (pathFile);
		byte []buffer = new byte[(int) fileMime.length()];
		InputStream ios = null;
	    try {
	        ios = new FileInputStream(fileMime);
	        if ( ios.read(buffer) == -1 ) {
	            throw new IOException("EOF reached while trying to read the whole file");
	        }        
	    } catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally { 
	        try {
	             if ( ios != null ) 
	                  ios.close();
	        } catch ( IOException e) {
	      }
	    }
		 byte[] ba = buffer;

		String esito = DocumentaleUtil.detectMimeType(ba, listaFile);
		return esito; 
		
	}

	
}
