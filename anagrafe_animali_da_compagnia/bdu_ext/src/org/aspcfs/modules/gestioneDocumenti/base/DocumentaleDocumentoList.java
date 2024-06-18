package org.aspcfs.modules.gestioneDocumenti.base;

import java.util.Vector;

import org.json.JSONArray;

public class DocumentaleDocumentoList extends Vector  {
	
	
	
	public void creaElenco(JSONArray jo){
		
		 for(int i = 0 ; i < jo.length(); i++){
			    String riga = jo.get(i).toString();{
			    DocumentaleDocumento doc = new DocumentaleDocumento(riga);
			    this.add(doc);
			    }
			}
		
	}
	

}
