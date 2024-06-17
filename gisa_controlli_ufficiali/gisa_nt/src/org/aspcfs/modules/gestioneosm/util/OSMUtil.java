package org.aspcfs.modules.gestioneosm.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class OSMUtil {
	
	  public static int contaOccorrenze (String cerca, String testo) {
	        
	        int count = 0, fromIndex = 0;
	        
	        while ((fromIndex = testo.indexOf(cerca, fromIndex)) != -1 ){
	        	count++;
	            fromIndex++;
	            
	        }
	        
	        return count;
	  }

	
	public static String estraiDaPattern(String inizio, String fine, String stringa, int indiceOccorrenza){
		if (stringa==null)
			return "";
		Pattern pattern;
		Matcher matcher; 
		pattern = Pattern.compile(inizio+"(.+?)"+fine, Pattern.DOTALL);
		matcher = pattern.matcher(stringa);
		
		for (int i = 1; i<= indiceOccorrenza; i++)
			matcher.find();
		try {return matcher.group(1);} catch (Exception e) {}
		return "";
	}
	
	public static String fixXmlResponse(String stringa){
		
		String output = "";
		
		if (stringa==null)
			return "";
		
		Matcher m = Pattern.compile("<(\\w+)(?:[>]|$)").matcher(stringa);
		while (m.find()) {
			String inizio = "<"+m.group(1)+">";
			String fine = "</"+m.group(1)+">";
			
			Pattern p = Pattern.compile(inizio+"(.+?)"+fine, Pattern.DOTALL);
			
			Matcher m2 = p.matcher(stringa);
			m2.find();
			
			String match = "";
			
			try {match = m2.group(1);} catch (Exception e) {}

			output = output + inizio + match + fine + "\n";
		}
		return output;
	}

}
