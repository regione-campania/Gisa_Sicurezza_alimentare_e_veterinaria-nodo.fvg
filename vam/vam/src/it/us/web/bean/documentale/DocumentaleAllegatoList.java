package it.us.web.bean.documentale;

import it.us.web.util.json.JSONException;

import java.util.Vector;

public class DocumentaleAllegatoList extends Vector  {
	
	
	
	public void creaElenco(it.us.web.util.json.JSONArray jo) throws JSONException{
		
		 for(int i = 2 ; i < jo.length(); i++){
			    String riga = jo.get(i).toString();{
			    DocumentaleAllegato doc = new DocumentaleAllegato(riga);
			    this.add(doc);
			    }
			}
		
	}
	
	public DocumentaleAllegatoList dividiPagine(int iniz, int fine){
		DocumentaleAllegatoList docList = new DocumentaleAllegatoList(); 
		
		for (int i = iniz; i < fine; i++){
			docList.add(this.get(i));
		}
		
		return docList;
	}
	
	public DocumentaleAllegato cercaNome(String nome){
		
		for (int i = 0; i < this.size(); i++){
			DocumentaleAllegato doc = (DocumentaleAllegato) this.get(i);
			if (doc.getOggetto().equalsIgnoreCase(nome))
				return doc;
		}
		return null;
	}
	
	
public DocumentaleAllegato cercTipoAllegato(String tipo){
		
		for (int i = 0; i < this.size(); i++){
			DocumentaleAllegato doc = (DocumentaleAllegato) this.get(i);
			if (doc.getTipoAllegato().equalsIgnoreCase(tipo))
				return doc;
		}
		return null;
	}
	
}
