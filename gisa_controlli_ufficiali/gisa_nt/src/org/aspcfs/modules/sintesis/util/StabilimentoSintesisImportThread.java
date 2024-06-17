package org.aspcfs.modules.sintesis.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.opu.util.StabilimentoImportUtil;
import org.aspcfs.modules.sintesis.base.LogImport;
import org.aspcfs.modules.sintesis.base.SintesisRelazioneLineaProduttiva;
import org.aspcfs.modules.sintesis.base.SintesisStabilimento;
import org.aspcfs.modules.sintesis.base.StabilimentoSintesisImport;
import org.aspcfs.utils.GestoreConnessioni;
import org.json.JSONObject;

import com.darkhorseventures.framework.actions.ActionContext;

public class StabilimentoSintesisImportThread extends CFSModule implements Runnable {
	
	public static String markerIniziale = "STATO SEDE OPERATIVA";
	public static String markerFinale = "LEGENDA";
	private ActionContext context = null;
	private String xlsFile = null;
	private String dataSintesis = null;
	private int idUtente = -1;
	private int idImport = -1;
	
	public StabilimentoSintesisImportThread(ActionContext context, String xlsFile, String dataSintesis, int idImport, int idUtente) {
		this.context = context;
		this.xlsFile = xlsFile;
		this.dataSintesis = dataSintesis;
		this.idUtente = idUtente;
		this.idImport = idImport;

	}


	public JSONObject importaDaFile() throws IllegalArgumentException, IllegalAccessException, IOException, EncryptedDocumentException, InvalidFormatException{
		
		JSONObject toReturn = new JSONObject();
		 StabilimentoSintesisImportThread imp = new StabilimentoSintesisImportThread(context, xlsFile, dataSintesis, idImport, idUtente);
		 
		 Thread t = new Thread(imp);
		 t.start();
		 
		return toReturn;
	}

	public static JSONObject processaCodaImport(ActionContext context, int idImport, int userId, boolean ignoraFlussoStati) throws SQLException {

		Connection db = null ;
		
		String msg = "";
		int codiceUscita = -1;
		SintesisRelazioneLineaProduttiva relEsistente = null;
		SintesisRelazioneLineaProduttiva rel = null;
		SintesisStabilimento stabEsistente = null;
		Object[] outputValidazione = new Object[]{codiceUscita,msg,relEsistente,rel, stabEsistente};
		
		int TOT_INSERISCI_STABILIMENTO_INSERISCI_LINEA = 0;
		int TOT_AGGIORNA_STABILIMENTO_INSERISCI_LINEA = 0;
		int TOT_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA= 0;
		int TOT_NESSUNA_VARIAZIONE= 0;
		int TOT_LINEA_NON_MAPPATA = 0;
		
		String MSG_INSERISCI_STABILIMENTO_INSERISCI_LINEA = "";
		String MSG_AGGIORNA_STABILIMENTO_INSERISCI_LINEA = "";
		String MSG_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA= "";
		String MSG_NESSUNA_VARIAZIONE = "";
		String MSG_LINEA_NON_MAPPATA = "";
			
		//BLOCCO #1: LETTURA DAL DB DELLE RICHIESTE E CREAZIONE DELL'ARRAY

		ArrayList<StabilimentoSintesisImport> listaStab = new ArrayList<StabilimentoSintesisImport>();
		
		StabilimentoImportUtil.stampaLog("[SINTESIS] Inizio a popolare la lista delle pratiche da processare.");

		try {
			db = GestoreConnessioni.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select * from sintesis_stabilimenti_import where stato_import = ? and id_import = ? and id_import > 0 and trashed_date is null order by id asc");
			PreparedStatement pst = db.prepareStatement(sql.toString());
			pst.setInt(1,StabilimentoSintesisImport.IMPORT_DA_VALIDARE);
			pst.setInt(2,idImport);
		
			ResultSet rs = pst.executeQuery();
		
			while (rs.next()){
				StabilimentoSintesisImport stab = new StabilimentoSintesisImport(rs);
				listaStab.add(stab);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			GestoreConnessioni.freeConnection(db);
		}	
			
		StabilimentoImportUtil.stampaLog("[SINTESIS] Costruita la lista delle pratiche size: "+listaStab.size()+".");
		
		//BLOCCO #2: SCORRO L'ARRAY E VALIDO OGNI RICHIESTA
		
		StabilimentoImportUtil.stampaLog("[SINTESIS] Inizio process singole pratiche.");
		
			for (int i = 0; i<listaStab.size(); i++){
				StabilimentoSintesisImport stab = (StabilimentoSintesisImport) listaStab.get(i);
				StabilimentoImportUtil.stampaLog("[SINTESIS] Processo pratica con id: "+stab.getId()+".");

				try {
					db = GestoreConnessioni.getConnection();
					stab.recuperaDatiDaSintesis(db);
//					if (stab.getOpuIdOperatore()<0){
//						stab.recuperaDatiDaOrganization(db);
//					}
					
					outputValidazione = stab.processaRichiesta(db, userId, ignoraFlussoStati);
					msg+="<br/>"+outputValidazione[1];
					
					try {
						if ((int) outputValidazione[0] == StabilimentoSintesisImport.CHECK_INSERISCI_STABILIMENTO_INSERISCI_LINEA){
							TOT_INSERISCI_STABILIMENTO_INSERISCI_LINEA++;
							MSG_INSERISCI_STABILIMENTO_INSERISCI_LINEA+= outputValidazione[1]+"<br/>";
						}
						if ((int) outputValidazione[0] == StabilimentoSintesisImport.CHECK_AGGIORNA_STABILIMENTO_INSERISCI_LINEA){
							TOT_AGGIORNA_STABILIMENTO_INSERISCI_LINEA++;
							MSG_AGGIORNA_STABILIMENTO_INSERISCI_LINEA+= outputValidazione[1]+"<br/>";
						}
						if ((int) outputValidazione[0] == StabilimentoSintesisImport.CHECK_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA){
							TOT_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA++;
							MSG_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA+= outputValidazione[1]+"<br/>";
						}
						if ((int) outputValidazione[0] == StabilimentoSintesisImport.CHECK_LINEA_NON_MAPPATA){
							TOT_LINEA_NON_MAPPATA++;
							MSG_LINEA_NON_MAPPATA+= outputValidazione[1]+"<br/>";
						}
						if ((int) outputValidazione[0] == StabilimentoSintesisImport.CHECK_NESSUNA_VARIAZIONE){
							TOT_NESSUNA_VARIAZIONE++;
							MSG_NESSUNA_VARIAZIONE+= outputValidazione[1]+"<br/>";
						}

						
						JSONObject jsonValidazione = new JSONObject();
						
						jsonValidazione.put("TOT_INSERISCI_STABILIMENTO_INSERISCI_LINEA", TOT_INSERISCI_STABILIMENTO_INSERISCI_LINEA);
						jsonValidazione.put("TOT_AGGIORNA_STABILIMENTO_INSERISCI_LINEA", TOT_AGGIORNA_STABILIMENTO_INSERISCI_LINEA);
						jsonValidazione.put("TOT_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA", TOT_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA);
						jsonValidazione.put("TOT_LINEA_NON_MAPPATA", TOT_LINEA_NON_MAPPATA);
						jsonValidazione.put("TOT_NESSUNA_VARIAZIONE", TOT_NESSUNA_VARIAZIONE);
						
						jsonValidazione.put("MSG_INSERISCI_STABILIMENTO_INSERISCI_LINEA", MSG_INSERISCI_STABILIMENTO_INSERISCI_LINEA); 
						jsonValidazione.put("MSG_AGGIORNA_STABILIMENTO_INSERISCI_LINEA", MSG_AGGIORNA_STABILIMENTO_INSERISCI_LINEA);
						jsonValidazione.put("MSG_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA", MSG_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA);
						jsonValidazione.put("MSG_LINEA_NON_MAPPATA", MSG_LINEA_NON_MAPPATA);
						jsonValidazione.put("MSG_NESSUNA_VARIAZIONE", MSG_NESSUNA_VARIAZIONE);
						
						LogImport log = new LogImport(db, idImport);
						log.salvaEsiti(db, null, jsonValidazione, false, false);

					} catch (Exception e) {}
					
					
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			finally {
				GestoreConnessioni.freeConnection(db);
			}
				StabilimentoImportUtil.stampaLog("[SINTESIS] Terminato process di pratica con id: "+stab.getId()+".");
				StabilimentoImportUtil.stampaLog("[SINTESIS] Totale processate parziale: "+(i+1)+"/"+listaStab.size());

			}
			
			JSONObject jsonValidazione = new JSONObject();
			
			jsonValidazione.put("TOT_INSERISCI_STABILIMENTO_INSERISCI_LINEA", TOT_INSERISCI_STABILIMENTO_INSERISCI_LINEA);
			jsonValidazione.put("TOT_AGGIORNA_STABILIMENTO_INSERISCI_LINEA", TOT_AGGIORNA_STABILIMENTO_INSERISCI_LINEA);
			jsonValidazione.put("TOT_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA", TOT_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA);
			jsonValidazione.put("TOT_LINEA_NON_MAPPATA", TOT_LINEA_NON_MAPPATA);
			jsonValidazione.put("TOT_NESSUNA_VARIAZIONE", TOT_NESSUNA_VARIAZIONE);
			
			jsonValidazione.put("MSG_INSERISCI_STABILIMENTO_INSERISCI_LINEA", MSG_INSERISCI_STABILIMENTO_INSERISCI_LINEA); 
			jsonValidazione.put("MSG_AGGIORNA_STABILIMENTO_INSERISCI_LINEA", MSG_AGGIORNA_STABILIMENTO_INSERISCI_LINEA);
			jsonValidazione.put("MSG_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA", MSG_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA);
			jsonValidazione.put("MSG_LINEA_NON_MAPPATA", MSG_LINEA_NON_MAPPATA);
			jsonValidazione.put("MSG_NESSUNA_VARIAZIONE", MSG_NESSUNA_VARIAZIONE);
			return jsonValidazione;
	}


	@Override
	public void run() {		
		
		Connection db = null;
		
		System.out.flush();
		StabilimentoImportUtil.stampaLog("[SINTESIS] ######## Inizio procedura di analisi del file. ######## ");
		
		JSONObject jsonScartati = new JSONObject();
		
		int TOT_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO = 0;
		int TOT_SCARTATI_STATO_ANAGRAFE = 0;
		String MSG_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO = "";
		String MSG_SCARTATI_STATO_ANAGRAFE = "";

		LogImport log = null;
		
		try {
			db =this.getConnection(context);
			log = new LogImport(db, idImport);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	finally {this.freeConnection(context, db); 
		} 
			
			StabilimentoImportUtil.stampaLog("[SINTESIS] Inizio lettura del file.");

			
		    String excelFilePath = xlsFile;
	        FileInputStream inputStream = null;
			try {
				inputStream = new FileInputStream(new File(excelFilePath));
			} catch (FileNotFoundException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	         
	        org.apache.poi.ss.usermodel.Workbook workbook = null;
			try {
				workbook = WorkbookFactory.create(inputStream);
			} catch (EncryptedDocumentException | InvalidFormatException | IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	        org.apache.poi.ss.usermodel.Sheet firstSheet = workbook.getSheetAt(0);
	        
	        Iterator<Row> iterator = firstSheet.iterator();
	        
	        int rigaIniziale = 0;
	        int rigaFinale = 0;
	        int numeroRiga= 0;
	        
	        while (iterator.hasNext()) {
	            Row nextRow = iterator.next();
	            numeroRiga = nextRow.getRowNum()+1;
	            
	            Iterator<Cell> cellIterator = nextRow.cellIterator();
	             
	            while (cellIterator.hasNext()) {
	                Cell cell = cellIterator.next();
	                if (cell.getCellType()==Cell.CELL_TYPE_STRING && cell.getStringCellValue().equalsIgnoreCase(markerIniziale) )
	                	rigaIniziale = numeroRiga;
	                if (cell.getCellType()==Cell.CELL_TYPE_STRING && cell.getStringCellValue().equalsIgnoreCase(markerFinale) )
	                	rigaFinale = numeroRiga;
	               }
	          
	          if (rigaIniziale>0 && rigaFinale > 0)
	        	  break;
	        }
	        
	        numeroRiga= 0;
	        iterator = firstSheet.iterator();
	        
	        ArrayList<StabilimentoSintesisImport> stabilimentiSintesis = new   ArrayList<StabilimentoSintesisImport>();
	        
	        while (iterator.hasNext()) {
	            Row nextRow = iterator.next();
	            numeroRiga = nextRow.getRowNum()+1;

	            if (numeroRiga > rigaFinale)
	            	break;

	            if (numeroRiga > rigaIniziale && numeroRiga < rigaFinale) {
	        		StabilimentoImportUtil.stampaLog("[SINTESIS] Leggo riga #"+numeroRiga+".");

	            	StabilimentoSintesisImport stab = new StabilimentoSintesisImport(nextRow);
	            	stab.setIdImport(log.getId());
	            	stab.setRiga(nextRow.getRowNum()+1); 
	            	try {
						stab.setMd5();
					} catch (NoSuchAlgorithmException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
	            	if (stab.getApprovalNumber() != null && !stab.getApprovalNumber().equals(""))
	            		stabilimentiSintesis.add(stab);            	
		         }
	        }
	         
	        try {
				workbook.close();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	        try {
				inputStream.close();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	    
			StabilimentoImportUtil.stampaLog("[SINTESIS] Letto fino a riga: "+numeroRiga+".");
			
			//BLOCCO #2: SCRITTURA DELLE RICHIESTE SUL DB
	
			StabilimentoImportUtil.stampaLog("[SINTESIS] Inizio a scrivere sulla tabella delle pratiche.");
	   

	        int j = 0;
	        for (int i = 0; i<stabilimentiSintesis.size(); i++){
	        	
	        	StabilimentoSintesisImport stab = (StabilimentoSintesisImport) stabilimentiSintesis.get(i);
	        	
	        	try {
					db =this.getConnection(context);
					StabilimentoImportUtil.stampaLog("[SINTESIS] Leggo da file pratica ("+(i+1)+"/"+stabilimentiSintesis.size()+ " per Approval: "+stab.getApprovalNumber() +".");

					boolean approvalTroppoLungo = stab.isApprovalTroppoLungo();
					boolean statoAnagrafe = "anagrafe".equalsIgnoreCase(stab.getStatoSedeOperativa()) ? true : false;
					
					 if (approvalTroppoLungo) {
							TOT_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO++;
							MSG_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO += textHtml("[RIGA "+(stab.getRiga())+"] [<b>SCARTATO CAUSA APPROVAL NUMBER TROPPO LUNGO</b>]<br/>"+stab.getDenominazioneSedeOperativa()+ " ("+ stab.getApprovalNumber() +")<br/>"+stab.getDescrizioneSezione() + " -> " + stab.getAttivita() + "<br/>", "red"); 
						}
						else if (statoAnagrafe) {
							TOT_SCARTATI_STATO_ANAGRAFE++;
							MSG_SCARTATI_STATO_ANAGRAFE += textHtml("[RIGA "+(stab.getRiga())+"] [<b>SCARTATO CAUSA STATO ANAGRAFE</b>]<br/>"+stab.getDenominazioneSedeOperativa()+ "( "+ stab.getApprovalNumber() +")<br/>"+stab.getDescrizioneSezione() + " -> " + stab.getAttivita() + "<br/>", "red"); 
						}
						else {
							stab.codificaLinea(db);
							stab.codificaOperatore(db);
							stab.insert(db);
							j++;
							}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        	finally {this.freeConnection(context, db);  
				} 
	        	
	        }
			
			jsonScartati.put("TOT_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO", TOT_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO);
			jsonScartati.put("TOT_SCARTATI_STATO_ANAGRAFE", TOT_SCARTATI_STATO_ANAGRAFE);
			jsonScartati.put("MSG_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO", MSG_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO);
			jsonScartati.put("MSG_SCARTATI_STATO_ANAGRAFE", MSG_SCARTATI_STATO_ANAGRAFE);
			
			try {
				db =this.getConnection(context);
				log.salvaEsiti(db, jsonScartati, null, false, true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    	finally {this.freeConnection(context, db);
			} 

			StabilimentoImportUtil.stampaLog("[SINTESIS] Terminata scrittura sulla tabella delle pratiche. Inizio process della coda.");
			StabilimentoImportUtil.stampaLog("[SINTESIS] ######## Inizio processing della coda delle pratiche ######## ");

			//BLOCCO #3: VALIDAZIONE AUTOMATICA DELLE RICHIESTE

			JSONObject jsonValidazione = new JSONObject();
			
			try {
				jsonValidazione = processaCodaImport(context, log.getId(), idUtente, true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			StabilimentoImportUtil.stampaLog("[SINTESIS] ######## Fine processing della coda delle pratiche ######## ");			

			try {
				db =this.getConnection(context);
				log.salvaEsiti(db, jsonScartati, jsonValidazione, true, false);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    	finally {this.freeConnection(context, db);
			} 
			
	}


	public ActionContext getContext() { 
		return context;
	}


	public void setContext(ActionContext context) {
		this.context = context;
	}
	
	private String textHtml(String text, String color){
		String html="";
		
		int inizio = text.indexOf("[");
		int fine = text.indexOf("]");
		
		html = "<b>"+text.substring(inizio, fine)+"</b>"+ text.substring(fine, text.length());
		
		return "<font color=\""+color+"\">"+html+"</font><br/>";
	
	}
}
