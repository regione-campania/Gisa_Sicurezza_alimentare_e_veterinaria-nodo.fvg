package org.aspcfs.modules.gestioneml.util;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;

public class MasterListImportExcel {

private ArrayList<MasterListImportRiga> righe = new ArrayList<MasterListImportRiga>();
private int idFlussoOriginale = -1;
private String errore = "";

public ArrayList<MasterListImportRiga> getRighe() {
	return righe;
}

public void setRighe(ArrayList<MasterListImportRiga> righe) {
	this.righe = righe;
}

public MasterListImportExcel() {
	
}

//public MasterListImportExcel(XSSFSheet sheetToUse) {
//	 Iterator<Row> iterator = sheetToUse.iterator();
//     
//     while (iterator.hasNext()) {
//         Row nextRow = iterator.next();
//         MasterListImportRiga riga = new MasterListImportRiga(nextRow);
//         righe.add(riga);
//         }
//}

public void aggiungiRighe(int indiceFoglio, XSSFSheet sheetToUse) {
	Iterator<Row> iterator = sheetToUse.iterator();
    int indexRow = 0;
    while (iterator.hasNext()) {
    	
        Row nextRow = iterator.next();
        if (indexRow>0){
        	MasterListImportRiga riga = new MasterListImportRiga(indiceFoglio, nextRow);
        
	        if (idFlussoOriginale == -1)
				riga.setIdFlussoOriginale();
			else
				riga.setIdFlussoOriginale(idFlussoOriginale);
        
	        righe.add(riga);
        }
        indexRow++;
        }
}


public void importaSuDb(Connection db){
	
	for (int i = 0; i< righe.size(); i++){
		MasterListImportRiga riga = (MasterListImportRiga) righe.get(i);
		//riga.setIdFlussoOriginale(idFlussoOriginale);
		
		if (riga.getCodiceSezione()!=null && riga.getCodiceAttivita()!=null && riga.getCodiceProdottoSpecie()!=null) {
			try {
				riga.insertMacroarea(db);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				riga.insertAggregazione(db);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				riga.insertLineaAttivita(db);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				riga.insertAllegati(db);
				setErrore(riga.getErrore());
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				riga.insertLivelliAggiuntivi(db);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
}


public String getErrore() {
	return errore;
}
public void setErrore(String errore) {
	this.errore = this.errore + "; "+errore;
}

public int getIdFlussoOriginale() {
	return idFlussoOriginale;
}

public void setIdFlussoOriginale(int idFlussoOriginale) {
	this.idFlussoOriginale = idFlussoOriginale;
}	

	
	
	
}
