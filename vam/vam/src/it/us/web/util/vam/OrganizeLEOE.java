package it.us.web.util.vam;

import it.us.web.bean.vam.lookup.LookupEsameObiettivoEsito;
import it.us.web.bean.vam.lookup.LookupEsameObiettivoTipo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class OrganizeLEOE {
	
	
	public static void organize (ArrayList<LookupEsameObiettivoEsito> listEsameObiettivo) {
		
		 	HashMap<LookupEsameObiettivoEsito, ArrayList<LookupEsameObiettivoEsito>> hash = new HashMap<LookupEsameObiettivoEsito, ArrayList<LookupEsameObiettivoEsito>>();
			
		 	LookupEsameObiettivoEsito leoePadre;
			LookupEsameObiettivoEsito leoeFiglio;
			
			ArrayList<LookupEsameObiettivoEsito> listaFigli = null; 
		 	
		 	for (int i=0;i<listEsameObiettivo.size();i++) {
		 		leoePadre = (LookupEsameObiettivoEsito) listEsameObiettivo.get(i);
		 		//System.out.println("Padre" + leoePadre.getDescription());
		 		
		 		for(int j=0;j<listEsameObiettivo.size();j++) {
		 			
		 			listaFigli = new ArrayList();
		 			
		 			leoeFiglio = (LookupEsameObiettivoEsito)listEsameObiettivo.get(j);
		 			//System.out.println("Figlio" + leoeFiglio.getDescription());
		 			
		 			if(leoeFiglio.getLookupEsameObiettivoEsito()!=null){
						if(leoeFiglio.getLookupEsameObiettivoEsito().getId()==leoePadre.getId()) {
							System.out.println(leoeFiglio.getDescription() +"è figlio di"+ leoePadre.getDescription());
							listaFigli.add(leoeFiglio);
						}
					}
		 		
		 		}
		 		hash.put(leoePadre, listaFigli);
		 	}
		 	
		 	
			
			Set set = hash.entrySet();
		    Iterator i = set.iterator();

		    while(i.hasNext()){
		     
		    	System.out.println("Scorro HASH");		     
		    	Map.Entry me = (Map.Entry)i.next();     
		     
		    	LookupEsameObiettivoEsito leoeK = (LookupEsameObiettivoEsito)me.getKey();
		    	
		    	System.out.println("Padre" + leoeK.getDescription());
		      
		    	ArrayList<LookupEsameObiettivoEsito> leoeV = (ArrayList<LookupEsameObiettivoEsito>)me.getValue();;
		      
		      
		    	LookupEsameObiettivoEsito leoeValue;
		      
		     
		      for(int k=0;k<leoeV.size();k++) {
		    	  
		    	  leoeValue = (LookupEsameObiettivoEsito)leoeV.get(k);
		    	  
		    	  System.out.println(leoeK.getDescription() + " : " + leoeValue.getDescription() );
		      
		      }
		    }
		
	}

}
