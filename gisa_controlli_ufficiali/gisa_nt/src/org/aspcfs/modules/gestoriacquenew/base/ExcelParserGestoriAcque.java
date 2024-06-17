package org.aspcfs.modules.gestoriacquenew.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.aspcfs.modules.login.beans.UserBean;

public class ExcelParserGestoriAcque {
	
	public static String getCellValueSafe(Cell cella)
	{
		DataFormatter df = new DataFormatter();
		String toRet = null;
		if(cella != null)
		{
			toRet = df.formatCellValue(cella);
			if(toRet != null)
			{
				toRet = toRet.replaceAll("\u00A0","");
				toRet = toRet.trim();
			}
		}
		if(toRet != null)
		{
			String toRetTrimmed = toRet.trim();
			return toRetTrimmed;
		}
		else
			return toRet;	
		
	}
	
	public static String getCellValueSafeFormula(Cell cella)
	{
		String toRet = null;
		if(cella != null)
		{
			toRet = cella.getStringCellValue();
			if(toRet != null)
			{
				toRet = toRet.replaceAll("\u00A0","");
				toRet = toRet.trim();
			}
		}
		if(toRet != null)
		{
			String toRetTrimmed = toRet.trim();
			return toRetTrimmed;
		}
		else
			return toRet;
	}
	
	public static Timestamp getDateSafe(Cell cella, String nomeCampo) throws ParseException 
	{
		Date value = null;
		try
		{
			value = cella.getDateCellValue();
		}
		catch(Exception e)
		{
			String valueString = cella.getStringCellValue();
			if(valueString != null)
			{
				if((valueString.substring(2).equals("/") && valueString.substring(5).equals("/")))
				{
					SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
					return new Timestamp(sdf.parse(valueString).getTime());
				}
				else
					throw new ParseException(nomeCampo, 0);
			}
			else
				return null;
		}
		if(value != null)
			return new Timestamp(cella.getDateCellValue().getTime());
		return null;
	}
	
	
	public static HashMap<String,GestoreAcque> parseSheetPerImportMassivoPuntiPrelievoDifferentiGestori(org.apache.poi.ss.usermodel.Workbook wb,Connection db,ArrayList<String> alEsitiParsingFile)
	{
		
		HashMap<String,GestoreAcque> gestoriAcque = new HashMap<String,GestoreAcque>() ; //[k : denominazione gestore , v : gestore]
	 
		
		org.apache.poi.ss.usermodel.Sheet sheet = wb.getSheetAt(0);
		
		for(int ir = 1; ir< sheet.getLastRowNum();ir++)
		{
			try
			{
				org.apache.poi.ss.usermodel.Row row = sheet.getRow(ir);
				int u = 0;
				 
				
				
//				String descrAsl = getCellValueSafe(row.getCell(u++));
				/*cambiamento : la descr asl non la prendiamo piu' dal file ma la inferiamo dall'id comune */
				
				String descComune =  getCellValueSafe(row.getCell(u++));
//				if(descComune == null || descComune.trim().length() == 0)
//					throw new EccezioneDati("Comune Mancante");
				
				String descrAsl = null;
				Integer idAsl = null;
				try
				{
					Object[] t = getIdDescAslFromDescComune(db, descComune);
					descrAsl = (String)t[1];
					idAsl = (Integer)t[0];
					if(descrAsl == null || descrAsl.trim().length() == 0 || idAsl == null)
					{
						//throw new Exception();
					}
					
				}
				catch(Exception ex)
				{
					//throw new EccezioneDati("Impossibile ottenere ID ASL/ DESC DA desc Comune("+descComune+")");
				}
				
				
				
				String indirizzoDaNormalizzare = getCellValueSafe(row.getCell(u++));
				String denominazionePuntoPrelievo =  getCellValueSafe(row.getCell(u++));
				String descrizioneTipologia =  getCellValueSafe(row.getCell(u++));
				String denominazioneGestore =  getCellValueSafe(row.getCell(u++));
				
				if(denominazioneGestore == null || denominazionePuntoPrelievo == null ) /*riga vuota */
					throw new Exception();
				String stato = getCellValueSafe(row.getCell(u++));
				String codicePuntoPrelievo =  getCellValueSafe(row.getCell(u++));
				
				/*codice non piu' obbligatorio */
				/*
				if(codicePuntoPrelievo == null || codicePuntoPrelievo.trim().length() == 0)
				{
					throw new EccezioneDati("Codice Mancante");
				}
				*/
				if(descComune == null || descComune.trim().length() == 0)
				{
					throw new EccezioneDati("Comune Punto di Prelievo mancante");
				}
				
				if(gestoriAcque.containsKey(denominazioneGestore) == false)
				{
					GestoreAcque gest = new GestoreAcque(denominazioneGestore,db,0,false); /*ritrovo il gestore, non mi interessano i punti prelievo poiche' li stiamo inserendo noi ora da file e neanche i controlli*/
					gest.puntiPrelievo = new ArrayList<PuntoPrelievo>(); /*li resetto */
					gestoriAcque.put(denominazioneGestore, gest);
				}
				
				/* costruisco il nesting dei bean, m anon avvio ancora nessun inserimento ricorsivo */
				GestoreAcque gest = gestoriAcque.get(denominazioneGestore.trim());
				/*per hp non ci sono punti prelievo duplicati per gestore */
				PuntoPrelievo ppToAdd = new PuntoPrelievo();
				ppToAdd.setDescrizioneAsl(descrAsl!= null ? descrAsl.trim() : null);
				ppToAdd.getIndirizzo().setDescrizioneComune(descComune!= null ? descComune.trim() : null);
				ppToAdd.getIndirizzo().setVia(indirizzoDaNormalizzare); /*poi verra' spacchettato in fase di inserimento */
				ppToAdd.setDenominazione(denominazionePuntoPrelievo.trim());
				ppToAdd.setDescrizioneTipologia(descrizioneTipologia.trim());
				ppToAdd.setStato(stato);
				ppToAdd.setCodice(codicePuntoPrelievo);
				ppToAdd.gestorePadre = gest;
				ppToAdd.setIdGestore(gest.getId());
				
				gest.puntiPrelievo.add(ppToAdd);
			}
			catch(GestoreNotFoundException ex)
			{
				alEsitiParsingFile.add("<font color=\"orange\"><br>RIGA "+ir+" SALTATA: GESTORE NON TROVATO IN ANAGRAFICA</font>");
			}
			catch(EccezioneDati ex)
			{
				alEsitiParsingFile.add("<font color=\"orange\"><br>RIGA "+ir+" SALTATA: "+ex.getMessage()+"</font>");
			}
			catch(Exception ex)
			{
//				ex.printStackTrace(s);;
//				ex.printStackTrace();
				alEsitiParsingFile.add("<font color=\"orange\"><br>RIGA "+ir+" SALTATA</font>");
			}
			
		}
		
		try
		{
			wb.close();
		}
		catch(Exception ex)
		{
			
		}
		
		return gestoriAcque;
	}
	
	
	
	
	
	
	/*Metodo per analizzare il foglio excel per l'import delle anagrafiche massive di tutti i gestori */
	/*Scorre sul file, e prende i gestori e li mette nell'hashmap.
	 * Gli inserimenti sono fatti solo alla fine, poiche' se un gestore compare piu' di una volta, vuol dire che 
	 * esiste piu' di un'anagrafica per esso, quindi tutte le anagrafiche vengono prima raccolte e poi vengono aggiunte tutte le anagrafiche alla fine
	 */
	
	public static ArrayList<GestoreAcque> parseSheetPerImportMassivoAnagDifferentiGestori(org.apache.poi.ss.usermodel.Workbook wb,Connection db,ArrayList<String> alEsitiParsingFile)
	{
		
		HashMap<String,GestoreAcque> gestoriToAdd = new HashMap<String,GestoreAcque>(); /*[k: denominazione gestore, v : gestore] */
		
		org.apache.poi.ss.usermodel.Sheet sheet = wb.getSheetAt(0);
		
		for(int ir = 1; ir<= sheet.getLastRowNum();ir++) /*ogni riga di questo file excel rappresenta un'anagrafica gestore associata ad un gestore (un gestore puo' averne piu' di una) */
		{
			try
			{
				org.apache.poi.ss.usermodel.Row row = sheet.getRow(ir);
				int u = 0;
				
				/*qui sono i dati del gestore a cui e' associata la riga presente che rappresenta l'anagrafica del gestore */
				
				/*denominazione gestore OBBLIGATORIA*/
				String denominazioneGestore = getCellValueSafe(row.getCell(u++));
				
				if(denominazioneGestore == null || denominazioneGestore.trim().equals(""))
					throw new Exception();
				
				if(!gestoriToAdd.containsKey(denominazioneGestore))
				{
					GestoreAcque toAdd = new GestoreAcque();
					toAdd.setNome(denominazioneGestore);
					gestoriToAdd.put(denominazioneGestore, toAdd);
				}
//				else  
//				{
//					continue;
//				}
				
				GestoreAcque toinsert = gestoriToAdd.get(denominazioneGestore);
				
				/*qui iniziano i dati dell'anagrafica del gestore, rappresentati dalla riga */
				
				/*indirizzo */
				String indirizzoDaNormalizzare = getCellValueSafe(row.getCell(u++));
				
				/*comune --> se il comune e' vuoto, lascio comune , id comune e asl vuoti
				 * se invece c'e', potrebbe schiattare perche' non riesce ad associargli asl, e in quel caso
				 * gli setto fuori do fuori regione automaticamente*/
				String descComune =  getCellValueSafe(row.getCell(u++));
				Integer idComune = null;
				Integer idAsl = null; 
				
				if(descComune != null && descComune.trim().length() > 0)
				{
					try
					{
						idComune = ControlloInterno.getCodeFromLookupDesc(db, "comuni1", "id", "nome", descComune, ""); /*puo 'lanciare eccezione qua se non troviamo il comune in comuni1 quindi no id */
						/*se trova id comune allora prova a matchare un'asl campana, se non ci riesce, automaticamente la funzione getIdDescAslFromIdComune ritorna fuori regione */
						Object[] t = getIdDescAslFromIDComune(db,idComune);
						idAsl = (Integer)t[0];
						
					}
					catch(Exception ex)
					{
						/*se non e' riuscito a trovar eil comune in tabella */
						System.out.println("-----------Non e' stato possibile trovare il comune inserito per gestore("+denominazioneGestore+"). Setto comune, asl vuoti"); 
						idAsl = 0;
						idComune = -1;
					}
				}
				else
				{ /*per chiarezza di lettura */
					
					idAsl = 0;
					idComune = -1;
				}
				 
				 
				
				/*provincia*/
				String descProvincia =  getCellValueSafe(row.getCell(u++));
//				
				/*telefono */
				String telefono = getCellValueSafe(row.getCell(u++));
				
//				String nominativoRappLegale = ""; /*non compare piu' nella nuova versione del file al 15/09/2017//getCellValueSafe(row.getCell(u++)); */
				
				/*dom digitale */
				String domDigitale = getCellValueSafe(row.getCell(u++));
				
				
				/*TODO COMUNI COPERTI
				 * E' STATA CHIESTA L'ELIMINAZIONE -> NB: se due diverse righe del file excel, associate allo stesso gestore, contengono comuni diversi,
				 * questi vanno in union stretta (no duplicati) */
				/***********
				 * 
				 * 
				 * *****************************
				 */
				/*
				String allComuniCopertiStr = getCellValueSafe(row.getCell(u++));
				HashMap<String,Integer> descComuniToId = toinsert.getComuniAccettatiPerPP();//new HashMap<String,Integer>();  quella che dovremo mettere nel gestore acque  
				if(allComuniCopertiStr == null || allComuniCopertiStr.trim().length() == 0)
					throw new EccezioneDati("Lista Comuni accettati non valida");
				
				String[] comunis = allComuniCopertiStr.split(",");
				for(String comuneStr : comunis)
				{
					try
					{
						comuneStr = comuneStr.trim();
						int idComuneAccettato = ControlloInterno.getCodeFromLookupDesc(db, "comuni1", "id", "nome", comuneStr, "");
						descComuniToId.put(comuneStr, idComuneAccettato);
					}
					catch(Exception ex)
					{
						ex.printStackTrace();
					}
				}
				if(descComuniToId.keySet().size() == 0)
				{
					//non sono riuscito a raccogliere neanche un comune, quindi lancio errore 
					throw new EccezioneDati("Lista Comuni accettati non valida");
				}
				 
				*/
				
				if(denominazioneGestore == null || denominazioneGestore.trim().length() == 0 ) /*riga vuota */
					throw new Exception();
				
				AnagraficaGestore toAppend = new AnagraficaGestore(); /*questa e' l'anagrafica, rappresentata dalla riga del file excel, agganciata a quel gestore */
				toAppend.setIndirizzo(indirizzoDaNormalizzare);
				toAppend.setIdComune(idComune);
				toAppend.setIdAsl(idAsl);
				toAppend.setTelefono(telefono);
//				toAppend.setNominativoRappLegale(nominativoRappLegale); /*non ci sta piu' nel file al 15/09/2017 */
				toAppend.setDomicilioDigitale(domDigitale);
				toAppend.setProvincia(descProvincia);
				toinsert.getAnagraficheDelGestore().add(toAppend);
				
				
				
			}
			catch(EccezioneDati ex)
			{
				alEsitiParsingFile.add("<font color=\"orange\"><br>RIGA "+ir+" SALTATA: "+ex.getMessage()+"</font>");
			}
			catch(Exception ex)
			{
//				ex.printStackTrace(s);;
//				ex.printStackTrace();
				alEsitiParsingFile.add("<font color=\"orange\"><br>RIGA "+ir+" SALTATA</font>");
			}
			
		}
		
		try
		{
			wb.close();
		}
		catch(Exception ex)
		{
			
		}
		
		/*trasformo l'hash map di appoggio in un array list da ritornare */
		
		ArrayList<GestoreAcque> toRet = new ArrayList<GestoreAcque>();
		for(Map.Entry<String,GestoreAcque> gestore : gestoriToAdd.entrySet())
		{
			toRet.add(gestore.getValue());
		}
		return  toRet;
	}
	
	
	
	
	
	/*analizza foglio excel per fare import delle anagrafiche e dei punti di prelievo del solo gestore associato all'utente loggato .Quindi il campo
	 * del gestore sul foglio excel E' IGNORATO
	 Ritorna gestore acque popolato con I SOLI PUNTI PRELIEVO NUOVI PARSED DAL FILE
	 */
	public static ArrayList<PuntoPrelievo> parseSheetPerImportGestoreLoggato(org.apache.poi.ss.usermodel.Workbook wb,Connection db,ArrayList<String> alEsitiParsingFile, GestoreAcque gest)
	{
	 
		/*elimino i punti di prelievo gia' associati, gli metto solo i nuovi presi dal file, e uso le funzionalita' del bean per inserirli.
		 * 
		 */
		
		ArrayList<PuntoPrelievo> toRet = new ArrayList<PuntoPrelievo>();
		
		org.apache.poi.ss.usermodel.Sheet sheet = wb.getSheetAt(0);
		
		int contatoreRiga=2;
		
		//Questo ArrayList contiene i codici del punto di prelievo gia' inseriti nel file
		ArrayList<String> codiciPuntoPrelievo = new ArrayList<String>();
		for(int ir = 1; ir<= sheet.getLastRowNum();ir++)
		{
			try
			{
				org.apache.poi.ss.usermodel.Row row = sheet.getRow(ir);
				int u = 0;
				
				//Controllo che la riga sia popolata, altrimenti si interrompe l'elaborazione
				if(!rigaValorizzata(row,9))
				{
					break;
				}
				 
//				String descrAsl = getCellValueSafe(row.getCell(u++));
				/*CAMBIATO ORA LA DESCR ASL E' PRESA DAL COMUNE */
				String descComune =  getCellValueSafe(row.getCell(u++));
				String indirizzoDaNormalizzare = getCellValueSafe(row.getCell(u++));
				String denominazionePuntoPrelievo =  getCellValueSafe(row.getCell(u++));
				String descrizioneTipologia =  getCellValueSafe(row.getCell(u++));
				String nomeGestoreDummy = getCellValueSafe(row.getCell(u++)); 
				String stato = getCellValueSafe(row.getCell(u++));
				String codicePuntoPrelievo =  getCellValueSafe(row.getCell(u++));
				String latitudine =  getCellValueSafe(row.getCell(u++));
				String longitudine =  getCellValueSafe(row.getCell(u++));
				
				
				
				Integer idAsl = null;
				String descAsl = null;
				Object[] t = getIdDescAslFromDescComune(db, descComune);
				
				try
				{
					idAsl = (Integer)t[0];
					descAsl = (String)t[1];
					if(idAsl == null || descAsl == null || descAsl.trim().length() == 0)
					{
						throw new Exception("Il comune specificato nel record non e' stato trovato nel sistema. Comune: "+descComune);
					}
				}
				catch(Exception ex)
				{
					throw new EccezioneDati(ex.getMessage());
				}
				
				
				
				
				if(  denominazionePuntoPrelievo == null ) /*riga vuota */
					throw new Exception();
				
				
				if(!nomeGestoreDummy.trim().equalsIgnoreCase(gest.getNome()))
				{
					throw new EccezioneDati("Per il record e' specificato un nome gestore differente da quello dell'utente loggato");
				}
				
				if(codicePuntoPrelievo == null || codicePuntoPrelievo.trim().length() == 0)
				{
					throw new EccezioneDati("Codice Mancante");
				}
				
				ArrayList<PuntoPrelievo> punti = PuntoPrelievo.search(db, gest.getId(), false, null, codicePuntoPrelievo);
				if(!punti.isEmpty())
					throw new EccezioneDati("Codice punto prelievo gia' esistente per il gestore ");
				
				if(codiciPuntoPrelievo.contains(codicePuntoPrelievo.toUpperCase()))
					throw new EccezioneDati("Codice punto prelievo gia' presente nel file");
					
				/* costruisco il nesting dei bean, m anon avvio ancora nessun inserimento ricorsivo */
			 
				/*per hp non ci sono punti prelievo duplicati per gestore */
				
				double longitudineD = 0;
				double latitudineD  = 0;
				try 
				{
					longitudineD = Double.parseDouble(longitudine.replace(',', '.'));
					latitudineD  = Double.parseDouble(latitudine.replace(',', '.'));
					
				} 
				catch (Exception e) 
				{
					throw new EccezioneDati("Coordinate in formato non corretto");
				}
				if(latitudineD < 39.988475  || latitudineD > 41.503754)
				{
					throw new EccezioneDati("Valore errato per la colonna Latitudine, il valore deve essere compreso tra 39.988475 e 41.503754");
		   		}
				if(longitudineD < 13.7563172 || longitudineD > 15.8032837)
				{
					throw new EccezioneDati("Valore errato per la colonna Longitudine, il valore deve essere compreso tra 13.7563172 e 15.8032837");
			   	}
					
				PuntoPrelievo ppToAdd = new PuntoPrelievo();
				ppToAdd.setDescrizioneAsl(descAsl);
				ppToAdd.getIndirizzo().setLongitudine(longitudine);
				ppToAdd.getIndirizzo().setLatitudine(latitudine);
				ppToAdd.getIndirizzo().setDescrizioneComune(descComune);
				ppToAdd.getIndirizzo().setVia(indirizzoDaNormalizzare); /*poi verra' spacchettato in fase di inserimento */
				ppToAdd.setDenominazione(denominazionePuntoPrelievo);
				ppToAdd.setDescrizioneTipologia(descrizioneTipologia);
				ppToAdd.setStato(stato);
				ppToAdd.setCodice(codicePuntoPrelievo);
				ppToAdd.gestorePadre = gest;
				ppToAdd.setIdGestore(gest.getId());
				
				codiciPuntoPrelievo.add(codicePuntoPrelievo.toUpperCase());
				toRet.add(ppToAdd);
			}
			catch(EccezioneDati ex)
			{
				alEsitiParsingFile.add("<font color=\"orange\"><br>RIGA "+(contatoreRiga+1)+" SALTATA: "+ex.getMessage()+"</font>");
			}
			catch(Exception ex)
			{
//				ex.printStackTrace(s);;
//				ex.printStackTrace();
				alEsitiParsingFile.add("<font color=\"orange\"><br>RIGA "+(contatoreRiga+1)+" SALTATA</font>");
			}
			
			contatoreRiga++;
		}
		
		try
		{
			wb.close();
		}
		catch(Exception ex)
		{
			
		}
		
		return toRet;
	}
	
	
	public static HashMap<String,PuntoPrelievo> parseSheetPerImportControlliDecreto28(Workbook wb, Connection db,
			ArrayList<String> esitiErroriParsingfile, GestoreAcque gest,UserBean user) {
		System.out.println("PARSER EXCEL");
		HashMap<String,PuntoPrelievo> controlliPerCodicePP = new HashMap<String,PuntoPrelievo>(); // [k : codice punto prelievo , v : PuntoPrelievo con  ]
		
		org.apache.poi.ss.usermodel.Sheet sheet = wb.getSheetAt(0);
		
		Iterator<Row> iterator = sheet.iterator();
        
        int rigaIniziale = 0;
        int rigaFinale = 0;
        int contatoreRiga= 0;
        
        ArrayList<String> ternaCodicecodiciPuntoPrelievo = new ArrayList<String>();
        
        while (iterator.hasNext()) 
        {
            Row row = iterator.next();
             
            //Non considero le prime righe
            if(contatoreRiga>3)
            {

    			try
    			{ 
    				int u = 0;
    				 
    				//Controllo che la riga sia popolata, altrimenti si interrompe l'elaborazione
    				if(!rigaValorizzata(row,43))
    				{
    					break;
    				}
    	    				
    				//sez codice campione
    				String id_univoco_campione = getCellValueSafeFormula(row.getCell(u++));
    				String codice_interno_lab = getCellValueSafe(row.getCell(u++));
    				
    				//sez zona fornitura
    				String codice_pdp = getCellValueSafe(row.getCell(u++)); /*usato per fare il match col pp */
    				String fornitura_denominazioneZona =  getCellValueSafe(row.getCell(u++));
    				String fornitura_denominazioneGestore =  getCellValueSafe(row.getCell(u++));
    				
    				//sez finalita' generali del prelievo
    				String ambito_prelievo = getCellValueSafe(row.getCell(u++));
    				String campione_finalitaMisura =  getCellValueSafe(row.getCell(u++));
    				String campione_notaFinalitaMisura =  getCellValueSafe(row.getCell(u++));
    				String campione_motivoPrelievo =  getCellValueSafe(row.getCell(u++));
    				String campione_notaMotivoPrelievo =  getCellValueSafe(row.getCell(u++));
    				
    				//sez dati prelievo
    				String campionamento_chi =  getCellValueSafe(row.getCell(u++));
    				Timestamp campione_dataPrelievo =  getDateSafe (row.getCell(u++), "Data Prelievo");
    				
    				//sez dati sul punto di prelievo (pdp)
    				String numero_punti_prelievo = getCellValueSafe(row.getCell(u++));
    				String numero_progressivo_pdp = getCellValueSafe(row.getCell(u++));
    				String campionamento_numeroPrelievi =  getCellValueSafe(row.getCell(u++));
    				String numero_progressivo_prelievo_annuo = getCellValueSafe(row.getCell(u++));
    				
    				//sez altre info sul pdp
    				String tipologia_pdp = getCellValueSafe(row.getCell(u++));
    				String campione_codiceGisa = getCellValueSafe(row.getCell(u++));
    				String comune_pdp_desc = getCellValueSafe(row.getCell(u++));
    				String indirizzo_pdp = getCellValueSafe(row.getCell(u++));
    				String punto_tipoAcqua = getCellValueSafe(row.getCell(u++));
    				String latitudine = getCellValueSafe(row.getCell(u++));
    				String longitudine = getCellValueSafe(row.getCell(u++));
    				
    				//sez alfa tot
    				String DI_alfaTotaleMar =  getCellValueSafe(row.getCell(u++));
    				String DI_alfaTotaleMisura =  getCellValueSafe(row.getCell(u++));
    				String DI_alfaTotaleIncertezza =  getCellValueSafe(row.getCell(u++));
    				String DI_alfaTotaleDataMisura =  getCellValueSafe(row.getCell(u++));
    				String DI_alfaTotaleLaboratorio =  getCellValueSafe(row.getCell(u++));
    				String DI_alfaTotaleMetodoProva =  getCellValueSafe(row.getCell(u++));
    				
    				//sez beta tot
    				String DI_betaTotaleMar =  getCellValueSafe(row.getCell(u++));
    				String DI_betaTotaleMisura =  getCellValueSafe(row.getCell(u++));
    				String DI_betaTotaleIncertezza =  getCellValueSafe(row.getCell(u++));
    				String DI_betaTotaleDataMisura =  getCellValueSafe(row.getCell(u++));
    				String DI_betaTotaleLaboratorio =  getCellValueSafe(row.getCell(u++));
    				String DI_betaTotaleMetodoProva =  getCellValueSafe(row.getCell(u++));
    				
    				//sez beta res
    				String DI_betaResiduaMar =  getCellValueSafe(row.getCell(u++));
    				String DI_betaResiduaMisura =  getCellValueSafe(row.getCell(u++));
    				String DI_betaResiduaIncertezza =  getCellValueSafe(row.getCell(u++));
    				String DI_betaResiduaDataMisura =  getCellValueSafe(row.getCell(u++));
    				String DI_betaResiduaLaboratorio =  getCellValueSafe(row.getCell(u++));
    				String DI_betaResiduaMetodoProva =  getCellValueSafe(row.getCell(u++));
    				String DI_betaResiduoValoreDeterminato =  getCellValueSafe(row.getCell(u++));
    				String DI_betaResiduoIncertezza =  getCellValueSafe(row.getCell(u++));
    				
    				//sez radon
    				String Radon_concentrazioneMar =  getCellValueSafe(row.getCell(u++));
    				String Radon_concentrazioneMisura =  getCellValueSafe(row.getCell(u++));
    				String Radon_concentrazioneIncertezza =  getCellValueSafe(row.getCell(u++));
    				String Radon_concentrazioneDataMisura =  getCellValueSafe(row.getCell(u++));
    				String Radon_concentrazioneLaboratorio =  getCellValueSafe(row.getCell(u++));
    				String Radon_concentrazioneMetodoProva =  getCellValueSafe(row.getCell(u++));
    				
    				//sez trizio
    				String Trizio_concentrazioneMar =  getCellValueSafe(row.getCell(u++));
    				String Trizio_concentrazioneMisura =  getCellValueSafe(row.getCell(u++));
    				String Trizio_concentrazioneIncertezza =  getCellValueSafe(row.getCell(u++));
    				String Trizio_concentrazioneDataMisura =  getCellValueSafe(row.getCell(u++));
    				String Trizio_concentrazioneLaboratorio =  getCellValueSafe(row.getCell(u++));
    				String Trizio_concentrazioneMetodoProva =  getCellValueSafe(row.getCell(u++));
    				
    				//sez note e superamenti
    				String campione_note = getCellValueSafe(row.getCell(u++));
    				String alfaTotale_superato = getCellValueSafeFormula(row.getCell(u++));
    				String betaTotale_superato = getCellValueSafeFormula(row.getCell(u++));
    				String betaResidua_superato = getCellValueSafeFormula(row.getCell(u++));
    				String misureApprofondimento = "";
    				
    				String Radio226_concentrazioneMar = getCellValueSafe(row.getCell(u++));
    				String Radio226_concentrazioneMisura = getCellValueSafe(row.getCell(u++));
    				String Radio226_concentrazioneIncertezza = getCellValueSafe(row.getCell(u++));
    				String Radio226_concentrazioneDataMisura = getCellValueSafe(row.getCell(u++));
    				String Radio226_concentrazioneLaboratorio = getCellValueSafe(row.getCell(u++));
    				String Radio226_concentrazioneMetodoProva = getCellValueSafe(row.getCell(u++));
    				String Radio226_concentrazioneRapporto = getCellValueSafe(row.getCell(u++));
    				
    				String Radio228_concentrazioneMar = getCellValueSafe(row.getCell(u++));
    				String Radio228_concentrazioneMisura = getCellValueSafe(row.getCell(u++));
    				String Radio228_concentrazioneIncertezza = getCellValueSafe(row.getCell(u++));
    				String Radio228_concentrazioneDataMisura = getCellValueSafe(row.getCell(u++));
    				String Radio228_concentrazioneLaboratorio = getCellValueSafe(row.getCell(u++));
    				String Radio228_concentrazioneMetodoProva = getCellValueSafe(row.getCell(u++));
    				String Radio228_concentrazioneRapporto = getCellValueSafe(row.getCell(u++));
    				
    				String Uranio234_concentrazioneMar = getCellValueSafe(row.getCell(u++));
    				String Uranio234_concentrazioneMisura = getCellValueSafe(row.getCell(u++));
    				String Uranio234_concentrazioneIncertezza = getCellValueSafe(row.getCell(u++));
    				String Uranio234_concentrazioneDataMisura = getCellValueSafe(row.getCell(u++));
    				String Uranio234_concentrazioneLaboratorio = getCellValueSafe(row.getCell(u++));
    				String Uranio234_concentrazioneMetodoProva = getCellValueSafe(row.getCell(u++));
    				String Uranio234_concentrazioneRapporto = getCellValueSafe(row.getCell(u++));
    				
    				String Uranio238_concentrazioneMar = getCellValueSafe(row.getCell(u++));
    				String Uranio238_concentrazioneMisura = getCellValueSafe(row.getCell(u++));
    				String Uranio238_concentrazioneIncertezza = getCellValueSafe(row.getCell(u++));
    				String Uranio238_concentrazioneDataMisura = getCellValueSafe(row.getCell(u++));
    				String Uranio238_concentrazioneLaboratorio = getCellValueSafe(row.getCell(u++));
    				String Uranio238_concentrazioneMetodoProva = getCellValueSafe(row.getCell(u++));
    				String Uranio238_concentrazioneRapporto = getCellValueSafe(row.getCell(u++));
    				
    				String Piombo210_concentrazioneMar = getCellValueSafe(row.getCell(u++));
    				String Piombo210_concentrazioneMisura = getCellValueSafe(row.getCell(u++));
    				String Piombo210_concentrazioneIncertezza = getCellValueSafe(row.getCell(u++));
    				String Piombo210_concentrazioneDataMisura = getCellValueSafe(row.getCell(u++));
    				String Piombo210_concentrazioneLaboratorio = getCellValueSafe(row.getCell(u++));
    				String Piombo210_concentrazioneMetodoProva = getCellValueSafe(row.getCell(u++));
    				String Piombo210_concentrazioneRapporto = getCellValueSafe(row.getCell(u++));
    				
    				String Polonio210_concentrazioneMar = getCellValueSafe(row.getCell(u++));
    				String Polonio210_concentrazioneMisura = getCellValueSafe(row.getCell(u++));
    				String Polonio210_concentrazioneIncertezza = getCellValueSafe(row.getCell(u++));
    				String Polonio210_concentrazioneDataMisura = getCellValueSafe(row.getCell(u++));
    				String Polonio210_concentrazioneLaboratorio = getCellValueSafe(row.getCell(u++));
    				String Polonio210_concentrazioneMetodoProva = getCellValueSafe(row.getCell(u++));
    				String Polonio210_concentrazioneRapporto = getCellValueSafe(row.getCell(u++));

    				String Radionuclide1_concentrazioneSimbolo = getCellValueSafe(row.getCell(u++));
    				String Radionuclide1_concentrazioneMar = getCellValueSafe(row.getCell(u++));
    				String Radionuclide1_concentrazioneMisura = getCellValueSafe(row.getCell(u++));
    				String Radionuclide1_concentrazioneIncertezza = getCellValueSafe(row.getCell(u++));
    				String Radionuclide1_concentrazioneDataMisura = getCellValueSafe(row.getCell(u++));
    				String Radionuclide1_concentrazioneLaboratorio = getCellValueSafe(row.getCell(u++));
    				String Radionuclide1_concentrazioneMetodoProva = getCellValueSafe(row.getCell(u++));
    				String Radionuclide1_concentrazioneDerivata = getCellValueSafe(row.getCell(u++));
    				String Radionuclide1_concentrazioneRapporto = getCellValueSafe(row.getCell(u++));
    				
    				String Radionuclide2_concentrazioneSimbolo = getCellValueSafe(row.getCell(u++));
    				String Radionuclide2_concentrazioneMar = getCellValueSafe(row.getCell(u++));
    				String Radionuclide2_concentrazioneMisura = getCellValueSafe(row.getCell(u++));
    				String Radionuclide2_concentrazioneIncertezza = getCellValueSafe(row.getCell(u++));
    				String Radionuclide2_concentrazioneDataMisura = getCellValueSafe(row.getCell(u++));
    				String Radionuclide2_concentrazioneLaboratorio = getCellValueSafe(row.getCell(u++));
    				String Radionuclide2_concentrazioneMetodoProva = getCellValueSafe(row.getCell(u++));
    				String Radionuclide2_concentrazioneDerivata = getCellValueSafe(row.getCell(u++));
    				String Radionuclide2_concentrazioneRapporto = getCellValueSafe(row.getCell(u++));
    				
    				String Radionuclide3_concentrazioneSimbolo = getCellValueSafe(row.getCell(u++));
    				String Radionuclide3_concentrazioneMar = getCellValueSafe(row.getCell(u++));
    				String Radionuclide3_concentrazioneMisura = getCellValueSafe(row.getCell(u++));
    				String Radionuclide3_concentrazioneIncertezza = getCellValueSafe(row.getCell(u++));
    				String Radionuclide3_concentrazioneDataMisura = getCellValueSafe(row.getCell(u++));
    				String Radionuclide3_concentrazioneLaboratorio = getCellValueSafe(row.getCell(u++));
    				String Radionuclide3_concentrazioneMetodoProva = getCellValueSafe(row.getCell(u++));
    				String Radionuclide3_concentrazioneDerivata = getCellValueSafe(row.getCell(u++));
    				String Radionuclide3_concentrazioneRapporto = getCellValueSafe(row.getCell(u++));
    				
    				String DI_MSV_Inferiore = getCellValueSafe(row.getCell(u++));
    				
    				String rapportoRa226 = getCellValueSafe(row.getCell(u++));
    				String rapportoRa228 = getCellValueSafe(row.getCell(u++));
    				String rapportoU234 = getCellValueSafe(row.getCell(u++));
    				String rapportoU238 = getCellValueSafe(row.getCell(u++));
    				String rapportoPb210 = getCellValueSafe(row.getCell(u++));
    				String rapportoPo210 = getCellValueSafe(row.getCell(u++));
    				String rapportoRN1 = getCellValueSafe(row.getCell(u++));
    				String rapportoRN2 = getCellValueSafe(row.getCell(u++));
    				String rapportoRN3 = getCellValueSafe(row.getCell(u++));
    				
    				String DI_MSV_Superiore = getCellValueSafe(row.getCell(u++));
    				String approfondimentoNote = getCellValueSafe(row.getCell(u++));
    				
    				//per il flusso 326 il campo ore non viene piu' utilizzato
    				String campione_oraPrelievo =  "00:00";

    				//String punto_note =  getCellValueSafe(row.getCell(u++));
    				
    				//String testCella = getCellValueSafe(row.getCell(u++));
    				//System.out.println("HAI INSERITO: " + testCella);
    				
    				//flusso 326
    				
    				if(ambito_prelievo.equalsIgnoreCase("E") && !numero_punti_prelievo.equalsIgnoreCase("1")){
    					throw new Exception("Dati sul punto di prelievo - Per i controlli esterni il numero di punti di prelievo deve essere 1");
    				}
    				
    				controlloObbligatorio(campione_codiceGisa, "Altre informazioni sul punto di prelievo - Codice del punto di prelievo");
    				controlloObbligatorio(campione_dataPrelievo, "Dati Prelievo - Data del Prelievo");
    				//controlloObbligatorio(campione_oraPrelievo, "Identificativi del campione prelevato - Ora Prelievo");
    				controlloObbligatorio(campione_finalitaMisura, "Finalita' generali e motivi specifici del prelievo - Finalita' generali del prelievo");

    				if (campione_finalitaMisura.equalsIgnoreCase("C") || campione_finalitaMisura.equalsIgnoreCase("D"))
        				controlloObbligatorio(campione_notaFinalitaMisura, "Finalita' generali e motivi specifici del prelievo - Nota sulle finalita' generali del prelievo");
    				
    				controlloObbligatorio(campione_motivoPrelievo, "Finalita' generali e motivi specifici del prelievo - Motivo specifico del prelievo");
    				
    				if (campione_motivoPrelievo.equalsIgnoreCase("D"))
        				controlloObbligatorio(campione_notaMotivoPrelievo, "Finalita' generali e motivi specifici del prelievo - Nota sul motivo del prelievo");
    				
    				controlloObbligatorio(fornitura_denominazioneZona, "Zona di Fornitura (ZdF) - Denominazione della ZdF");
    				controlloObbligatorio(fornitura_denominazioneGestore, "Zona di Fornitura (ZdF) - Gestore Zdf");

    				//controlloObbligatorio(punto_tipoAcqua, "Altre informazioni sul punto di prelievo - Tipologia delle fonti");

    				controlloObbligatorio(DI_alfaTotaleMar, "Controlli Dose Indicativa (DI) - Attivita' alfa totale - Valore MAR");
    				//controlloObbligatorio(DI_alfaTotaleMisura, "Controlli Dose Indicativa (DI) - Attivita' alfa totale - Risultato misura");
    				//controlloObbligatorio(DI_alfaTotaleIncertezza, "Controlli Dose Indicativa (DI) - Attivita' alfa totale - Incertezza sull'attivita' alfa totale");
    				controlloObbligatorio(DI_alfaTotaleDataMisura, "Controlli Dose Indicativa (DI) - Attivita' alfa totale - Data della misura");
    				controlloObbligatorio(DI_alfaTotaleLaboratorio, "Controlli Dose Indicativa (DI) - Attivita' alfa totale - Laboratorio che ha effettuato la misura");
    				controlloObbligatorio(DI_alfaTotaleMetodoProva, "Controlli Dose Indicativa (DI) - Attivita' alfa totale - Metodo di prova utilizzato");

    				controlloObbligatorio(DI_betaTotaleMar, "Controlli Dose Indicativa (DI) - Attivita' beta totale - Valore MAR");
    				//controlloObbligatorio(DI_betaTotaleMisura, "Controlli Dose Indicativa (DI) - Attivita' beta totale - Risultato misura");
    				//controlloObbligatorio(DI_betaTotaleIncertezza, "Controlli Dose Indicativa (DI) - Attivita' beta totale - Incertezza sull'attivita' beta totale");
    				controlloObbligatorio(DI_betaTotaleDataMisura, "Controlli Dose Indicativa (DI) - Attivita' beta totale - Data della misura");
    				controlloObbligatorio(DI_betaTotaleLaboratorio, "Controlli Dose Indicativa (DI) - Attivita' beta totale - Laboratorio che ha effettuato la misura");
    				controlloObbligatorio(DI_betaTotaleMetodoProva, "Controlli Dose Indicativa (DI) - Attivita' beta totale - Metodo di prova utilizzato");
    				
    				controlloObbligatorio(DI_betaResiduaMar, "Controlli Dose Indicativa (DI) - Attivita' beta residua - Valore MAR");
    				//controlloObbligatorio(DI_betaResiduaMisura, "Controlli Dose Indicativa (DI) - Attivita' beta residua - Risultato misura");
    				//controlloObbligatorio(DI_betaResiduaIncertezza, "Controlli Dose Indicativa (DI) - Attivita' beta residua - Incertezza sull'attivita' beta residua");
    				controlloObbligatorio(DI_betaResiduaDataMisura, "Controlli Dose Indicativa (DI) - Attivita' beta residua - Data della misura");
    				controlloObbligatorio(DI_betaResiduaLaboratorio, "Controlli Dose Indicativa (DI) - Attivita' beta residua - Laboratorio che ha effettuato la misura");
    				controlloObbligatorio(DI_betaResiduaMetodoProva, "Controlli Dose Indicativa (DI) - Attivita' beta residua - Metodo di prova utilizzato");
    				
    				/* flusso 326: le colonne relative al radon non sono piu' obbligatorie
    				controlloObbligatorio(Radon_concentrazioneMar, "Controllo della concentrazione di attivita' di radon - Valore MAR");
    				//controlloObbligatorio(Radon_concentrazioneMisura, "Controllo della concentrazione di attivita' di radon - Risultato misura");
    				controlloObbligatorio(Radon_concentrazioneIncertezza, "Controllo della concentrazione di attivita' di radon - Incertezza sulla concentrazione");
    				controlloObbligatorio(Radon_concentrazioneDataMisura, "Controllo della concentrazione di attivita' di radon - Data della misura");
    				controlloObbligatorio(Radon_concentrazioneLaboratorio, "Controllo della concentrazione di attivita' di radon - Laboratorio che ha effettuato la misura");
    				controlloObbligatorio(Radon_concentrazioneMetodoProva, "Controllo della concentrazione di attivita' di radon - Metodo di prova utilizzato");
   					*/
    				
    				/* flusso 326: campo ore non piu' presente
    				if(!ControlloInterno.search(db, campione_codiceGisa, campione_dataPrelievo, campione_oraPrelievo, "28").isEmpty())
    					throw new EccezioneDati("Controllo con Codice Gisa punto prelievo, data e ora gia' esistente");
    				
    				if(ternaCodicecodiciPuntoPrelievo.contains(campione_codiceGisa+campione_dataPrelievo.toString()+campione_oraPrelievo.toUpperCase()))
    					throw new EccezioneDati("Controllo con Codice Gisa punto prelievo, data e ora gia' presente nel file");
    				*/
    				
    				/*scorro sulle righe, e associo i controlli ai punti di prelievo */
    				
    				if(!controlliPerCodicePP.containsKey(campione_codiceGisa))
    				{
    					PuntoPrelievo pp = PuntoPrelievo.searchByCodiceGisaPP(db, gest.getId(), campione_codiceGisa,false);
    					/*svuoto i controlli e gli metto solo quelli che sto trovando sul file */
    					pp.setControlliInterni(new ArrayList<ControlloInterno>());
    					controlliPerCodicePP.put(campione_codiceGisa,  pp);
    				}
    				PuntoPrelievo pp = controlliPerCodicePP.get(campione_codiceGisa);
    				List<ControlloInterno> controlli = pp.getControlliInterni(); /*quelli fino ad ora aggiunti, dal file, per il pp in questione */
    				
    				ControlloInterno controllo = new ControlloInterno();
    				controllo.setStatusId(1); /*aperto*/
    		
    				controllo.setPuntoPrelievoPadre(pp);
    				controllo.setSiteId(controllo.getPuntoPrelievoPadre().getIdAsl());
    				controllo.setEnteredBy(user.getUserId());
    				controllo.setModifiedBy(user.getUserId());
    				controllo.setTipologia(3); 
    				
    				controllo.setOra(campione_oraPrelievo);
    				controllo.setDataInizioControllo(campione_dataPrelievo);
    				
    				controllo.setCampione_finalitaMisura(String.valueOf(ControlloInterno.getCodeFromLookupDesc(db, "lookup_finalita_prelievo", "code", "valore_inserito", campione_finalitaMisura, "", "finalita' generali del prelievo")));
    				controllo.setCampione_notaFinalitaMisura(campione_notaFinalitaMisura);
    				controllo.setCampione_motivoPrelievo(String.valueOf(ControlloInterno.getCodeFromLookupDesc(db, "lookup_motivo_prelievo", "code", "valore_inserito", campione_motivoPrelievo, "", "motivo specifico del prelievo")));
    				controllo.setCampione_notaMotivoPrelievo(campione_notaMotivoPrelievo);

    				controllo.setFornitura_denominazioneZona(fornitura_denominazioneZona);
    				controllo.setFornitura_denominazioneGestore(fornitura_denominazioneGestore);
    				
    				if(punto_tipoAcqua.equalsIgnoreCase("ND") || punto_tipoAcqua.equals("")){
    					controllo.setPunto_tipoAcqua(punto_tipoAcqua);
    				}else{
        				controllo.setPunto_tipoAcqua(String.valueOf(ControlloInterno.getCodeFromLookupDesc(db, "lookup_tipologia_fonte", "code", "valore_inserito", punto_tipoAcqua, "", "tipologia delle fonti")));
    				}
    				//controllo.setPunto_note(punto_note);

    				controllo.setCampionamento_numeroPrelievi(campionamento_numeroPrelievi);
    				controllo.setCampionamento_chi(String.valueOf(ControlloInterno.getCodeFromLookupDesc(db, "lookup_campionamento_chi", "code", "valore_inserito", campionamento_chi, "", "chi ha effettuato il prelievo")));

    				controllo.setDI_alfaTotaleMar(DI_alfaTotaleMar);
    				controllo.setDI_alfaTotaleMisura(DI_alfaTotaleMisura);
    				controllo.setDI_alfaTotaleIncertezza(DI_alfaTotaleIncertezza);
    				controllo.setDI_alfaTotaleDataMisura(DI_alfaTotaleDataMisura);
    				controllo.setDI_alfaTotaleLaboratorio(DI_alfaTotaleLaboratorio);
    				controllo.setDI_alfaTotaleMetodoProva(DI_alfaTotaleMetodoProva);

    				controllo.setDI_betaTotaleMar(DI_betaTotaleMar);
    				controllo.setDI_betaTotaleMisura(DI_betaTotaleMisura);
    				controllo.setDI_betaTotaleIncertezza(DI_betaTotaleIncertezza);
    				controllo.setDI_betaTotaleDataMisura(DI_betaTotaleDataMisura);
    				controllo.setDI_betaTotaleLaboratorio(DI_betaTotaleLaboratorio);
    				controllo.setDI_betaTotaleMetodoProva(DI_betaTotaleMetodoProva);

    				controllo.setDI_betaResiduaMar(DI_betaResiduaMar);
    				controllo.setDI_betaResiduaMisura(DI_betaResiduaMisura);
    				controllo.setDI_betaResiduaIncertezza(DI_betaResiduaIncertezza);
    				controllo.setDI_betaResiduaDataMisura(DI_betaResiduaDataMisura);
    				controllo.setDI_betaResiduaLaboratorio(DI_betaResiduaLaboratorio);
    				controllo.setDI_betaResiduaMetodoProva(DI_betaResiduaMetodoProva);

    				controllo.setRadon_concentrazioneMar(Radon_concentrazioneMar);
    				controllo.setRadon_concentrazioneMisura(Radon_concentrazioneMisura);
    				controllo.setRadon_concentrazioneIncertezza(Radon_concentrazioneIncertezza);
    				controllo.setRadon_concentrazioneDataMisura(Radon_concentrazioneDataMisura);
    				controllo.setRadon_concentrazioneLaboratorio(Radon_concentrazioneLaboratorio);
    				controllo.setRadon_concentrazioneMetodoProva(Radon_concentrazioneMetodoProva);

    				controllo.setTrizio_concentrazioneMar(Trizio_concentrazioneMar);
    				controllo.setTrizio_concentrazioneMisura(Trizio_concentrazioneMisura);
    				controllo.setTrizio_concentrazioneIncertezza(Trizio_concentrazioneIncertezza);
    				controllo.setTrizio_concentrazioneDataMisura(Trizio_concentrazioneDataMisura);
    				controllo.setTrizio_concentrazioneLaboratorio(Trizio_concentrazioneLaboratorio);
    				controllo.setTrizio_concentrazioneMetodoProva(Trizio_concentrazioneMetodoProva);
    				
    				//flusso 326
    				
    				controllo.setIdUnivocoCampione(id_univoco_campione);
    				controllo.setCodiceInternoLab(codice_interno_lab);
    				controllo.setAmbitoPrelievo(String.valueOf(ControlloInterno.getCodeFromLookupDesc(db, "lookup_ambito_prelievo", "code", "valore_inserito", ambito_prelievo, "", "ambito del prelievo")));
    				controllo.setNumeroPuntiPrelievo(numero_punti_prelievo);
    				controllo.setNumeroProgressivoPuntoPrelievo(numero_progressivo_pdp);
    				controllo.setNumeroProgressivoPrelievoEffettuatoAnno(numero_progressivo_prelievo_annuo);
    				controllo.setTipologiaPuntoPrelievo(String.valueOf(ControlloInterno.getCodeFromLookupDesc(db, "lookup_tipologia_pdp", "code", "valore_inserito", tipologia_pdp, "", "tipologia punto di prelievo")));
    				controllo.setCodicePuntoPrelievo(codice_pdp);
    				controllo.setComunePuntoPrelievo(ControlloInterno.getCodeFromLookupDesc(db, "comuni1", "id", "nome", comune_pdp_desc, ""));
    				controllo.setIndirizzoPuntoPrelievo(indirizzo_pdp);
    				controllo.setCoordinateLatitudine(latitudine);
    				controllo.setCoordinateLongitudine(longitudine);
    				controllo.setCampioneNote(campione_note);
    				controllo.setAlfaTotale_superato(alfaTotale_superato);
    				controllo.setBetaTotale_superato(betaTotale_superato);
    				controllo.setBetaResidua_superato(betaResidua_superato);
    				controllo.setMisureApprofondimento(misureApprofondimento);
    				controllo.setDI_betaResiduoValoreDeterminato(DI_betaResiduoValoreDeterminato);
    				controllo.setDI_betaResiduoIncertezza(DI_betaResiduoIncertezza);
    				
    				controllo.setRadio226_concentrazioneMar(Radio226_concentrazioneMar);
    				controllo.setRadio226_concentrazioneMisura(Radio226_concentrazioneMisura);
    				controllo.setRadio226_concentrazioneIncertezza(Radio226_concentrazioneIncertezza);
    				controllo.setRadio226_concentrazioneDataMisura(Radio226_concentrazioneDataMisura);;
    				controllo.setRadio226_concentrazioneLaboratorio(Radio226_concentrazioneLaboratorio);
    				controllo.setRadio226_concentrazioneMetodoProva(Radio226_concentrazioneMetodoProva);
    				controllo.setRadio226_concentrazioneRapporto(Radio226_concentrazioneRapporto);
    				
    				controllo.setRadio228_concentrazioneMar(Radio228_concentrazioneMar);
    				controllo.setRadio228_concentrazioneMisura(Radio228_concentrazioneMisura);
    				controllo.setRadio228_concentrazioneIncertezza(Radio228_concentrazioneIncertezza);
    				controllo.setRadio228_concentrazioneDataMisura(Radio228_concentrazioneDataMisura);
    				controllo.setRadio228_concentrazioneLaboratorio(Radio228_concentrazioneLaboratorio);
    				controllo.setRadio228_concentrazioneMetodoProva(Radio228_concentrazioneMetodoProva);
    				controllo.setRadio228_concentrazioneRapporto(Radio228_concentrazioneRapporto);
    				
    				controllo.setUranio234_concentrazioneMar(Uranio234_concentrazioneMar);
    				controllo.setUranio234_concentrazioneMisura(Uranio234_concentrazioneMisura);
    				controllo.setUranio234_concentrazioneIncertezza(Uranio234_concentrazioneIncertezza);
    				controllo.setUranio234_concentrazioneDataMisura(Uranio234_concentrazioneDataMisura);
    				controllo.setUranio234_concentrazioneLaboratorio(Uranio234_concentrazioneLaboratorio);
    				controllo.setUranio234_concentrazioneMetodoProva(Uranio234_concentrazioneMetodoProva);
    				controllo.setUranio234_concentrazioneRapporto(Uranio234_concentrazioneRapporto);
    				
    				controllo.setUranio238_concentrazioneMar(Uranio238_concentrazioneMar);
    				controllo.setUranio238_concentrazioneMisura(Uranio238_concentrazioneMisura);
    				controllo.setUranio238_concentrazioneIncertezza(Uranio238_concentrazioneIncertezza);
    				controllo.setUranio238_concentrazioneDataMisura(Uranio238_concentrazioneDataMisura);
    				controllo.setUranio238_concentrazioneLaboratorio(Uranio238_concentrazioneLaboratorio);
    				controllo.setUranio238_concentrazioneMetodoProva(Uranio238_concentrazioneMetodoProva);
    				controllo.setUranio238_concentrazioneRapporto(Uranio238_concentrazioneRapporto);
    				
    				controllo.setPiombo210_concentrazioneMar(Piombo210_concentrazioneMar);
    				controllo.setPiombo210_concentrazioneMisura(Piombo210_concentrazioneMisura);
    				controllo.setPiombo210_concentrazioneIncertezza(Piombo210_concentrazioneIncertezza);
    				controllo.setPiombo210_concentrazioneDataMisura(Piombo210_concentrazioneDataMisura);
    				controllo.setPiombo210_concentrazioneLaboratorio(Piombo210_concentrazioneLaboratorio);
    				controllo.setPiombo210_concentrazioneMetodoProva(Piombo210_concentrazioneMetodoProva);
    				controllo.setPiombo210_concentrazioneRapporto(Piombo210_concentrazioneRapporto);
    				
    				controllo.setPolonio210_concentrazioneMar(Polonio210_concentrazioneMar);
    				controllo.setPolonio210_concentrazioneMisura(Polonio210_concentrazioneMisura);
    				controllo.setPolonio210_concentrazioneIncertezza(Polonio210_concentrazioneIncertezza);
    				controllo.setPolonio210_concentrazioneDataMisura(Polonio210_concentrazioneDataMisura);
    				controllo.setPolonio210_concentrazioneLaboratorio(Polonio210_concentrazioneLaboratorio);
    				controllo.setPolonio210_concentrazioneMetodoProva(Polonio210_concentrazioneMetodoProva);
    				controllo.setPolonio210_concentrazioneRapporto(Polonio210_concentrazioneRapporto);

    				controllo.setRadionuclide1_concentrazioneSimbolo(Radionuclide1_concentrazioneSimbolo);
    				controllo.setRadionuclide1_concentrazioneMar(Radionuclide1_concentrazioneMar);
    				controllo.setRadionuclide1_concentrazioneMisura(Radionuclide1_concentrazioneMisura);
    				controllo.setRadionuclide1_concentrazioneIncertezza(Radionuclide1_concentrazioneIncertezza);
    				controllo.setRadionuclide1_concentrazioneDataMisura(Radionuclide1_concentrazioneDataMisura);
    				controllo.setRadionuclide1_concentrazioneLaboratorio(Radionuclide1_concentrazioneLaboratorio);
    				controllo.setRadionuclide1_concentrazioneMetodoProva(Radionuclide1_concentrazioneMetodoProva);
    				controllo.setRadionuclide1_concentrazioneDerivata(Radionuclide1_concentrazioneDerivata);
    				controllo.setRadionuclide1_concentrazioneRapporto(Radionuclide1_concentrazioneRapporto);
    				
    				controllo.setRadionuclide2_concentrazioneSimbolo(Radionuclide2_concentrazioneSimbolo);
    				controllo.setRadionuclide2_concentrazioneMar(Radionuclide2_concentrazioneMar);
    				controllo.setRadionuclide2_concentrazioneMisura(Radionuclide2_concentrazioneMisura);
    				controllo.setRadionuclide2_concentrazioneIncertezza(Radionuclide2_concentrazioneIncertezza);
    				controllo.setRadionuclide2_concentrazioneDataMisura(Radionuclide2_concentrazioneDataMisura);
    				controllo.setRadionuclide2_concentrazioneLaboratorio(Radionuclide2_concentrazioneLaboratorio);
    				controllo.setRadionuclide2_concentrazioneMetodoProva(Radionuclide2_concentrazioneMetodoProva);
    				controllo.setRadionuclide2_concentrazioneDerivata(Radionuclide2_concentrazioneDerivata);
    				controllo.setRadionuclide2_concentrazioneRapporto(Radionuclide2_concentrazioneRapporto);
    				
    				controllo.setRadionuclide3_concentrazioneSimbolo(Radionuclide3_concentrazioneSimbolo);
    				controllo.setRadionuclide3_concentrazioneMar(Radionuclide3_concentrazioneMar);
    				controllo.setRadionuclide3_concentrazioneMisura(Radionuclide3_concentrazioneMisura);
    				controllo.setRadionuclide3_concentrazioneIncertezza(Radionuclide3_concentrazioneIncertezza);
    				controllo.setRadionuclide3_concentrazioneDataMisura(Radionuclide3_concentrazioneDataMisura);
    				controllo.setRadionuclide3_concentrazioneLaboratorio(Radionuclide3_concentrazioneLaboratorio);
    				controllo.setRadionuclide3_concentrazioneMetodoProva(Radionuclide3_concentrazioneMetodoProva);
    				controllo.setRadionuclide3_concentrazioneDerivata(Radionuclide3_concentrazioneDerivata);
    				controllo.setRadionuclide3_concentrazioneRapporto(Radionuclide3_concentrazioneRapporto);
    				
    				controllo.setDI_MSV_Inferiore(DI_MSV_Inferiore);
    				controllo.setDI_MSV_Superiore(DI_MSV_Superiore);
    				
    				controllo.setRapportoRa226(rapportoRa226);
    				controllo.setRapportoRa228(rapportoRa228);
    				controllo.setRapportoU234(rapportoU234);
    				controllo.setRapportoU238(rapportoU238);
    				controllo.setRapportoPb210(rapportoPb210);
    				controllo.setRapportoPo210(rapportoPo210);
    				controllo.setRapportoRN1(rapportoRN1);
    				controllo.setRapportoRN2(rapportoRN2);
    				controllo.setRapportoRN3(rapportoRN3);
    				
    				controllo.setApprofondimentoNote(approfondimentoNote);
    				
    				int idTipoControllo = ControlloInterno.getCodeFromLookupDesc(db, "lookup_tipo_controllo", "code", "description", "Controllo Interno", "");
    				if(ambito_prelievo.equalsIgnoreCase("E")){
    					idTipoControllo = ControlloInterno.getCodeFromLookupDesc(db, "lookup_tipo_controllo", "code", "description", "Controllo Interno", "");
    				}
    				controllo.setTipoControllo( idTipoControllo ); /*TODO LEVA CABLATO */
    				controllo.setOggettoIspezione(19); /*TODO LEVA CABLATO */
    				controllo.setIdComponenteNucleoIspettivo(-1); /*cablato, aggiorna */
    				
    				//Per decreto 28 il protocollo di default è sempre radioattivita'
    				controllo.setProtocolloRadioattivita(true); 
    				controllo.setTipoDecreto("28");
    				controlli.add(controllo);
    				ternaCodicecodiciPuntoPrelievo.add(campione_codiceGisa+campione_dataPrelievo.toString()+campione_oraPrelievo.toUpperCase());
    			}
    			catch(EccezioneDati ex)
    			{
    				esitiErroriParsingfile.add("<font color=\"orange\"><br>RIGA "+(contatoreRiga+1)+" SALTATA : "+ex.getMessage()+"</font>");
    			}
    			catch(ParseException ex)
    			{
    				esitiErroriParsingfile.add("<font color=\"orange\"><br>RIGA "+(contatoreRiga+1)+" SALTATA : CAMPO "+ex.getMessage()+" IN FORMATO NON CORRETTO. IL FORMATO CORRETTO E' dd/MM/yyyy </font>");
    			}
    			catch(Exception ex)
    			{
//    				ex.printStackTrace(s);;
//    				ex.printStackTrace();
    				esitiErroriParsingfile.add("<font color=\"orange\"><br>RIGA "+(contatoreRiga+1)+" SALTATA POICHE' CAMPO " + ex.getMessage() + " VUOTO </font>");
    			}
    		
            }
            
            contatoreRiga++;
          
            if (rigaIniziale>0 && rigaFinale > 0)
        	    break;
        }
		
		
		
		
		
		
		try
		{
			wb.close();
		}
		catch(Exception ex)
		{
			
		}
		
		return controlliPerCodicePP;
	}
	
	public static HashMap<String,PuntoPrelievo> parseSheetPerImportControlliDecreto31(Workbook wb, Connection db,
			ArrayList<String> esitiErroriParsingfile, GestoreAcque gest,UserBean user) {
		
		
	 
		 
		 
		HashMap<String,PuntoPrelievo> controlliPerCodicePP = new HashMap<String,PuntoPrelievo>(); // [k : codice punto prelievo , v : PuntoPrelievo con  ]
		
		org.apache.poi.ss.usermodel.Sheet sheet = wb.getSheetAt(0);
		
		Iterator<Row> iterator = sheet.iterator();
        
        int rigaIniziale = 0;
        int rigaFinale = 0;
        int contatoreRiga= 0;
        
        ArrayList<String> ternaCodicecodiciPuntoPrelievo = new ArrayList<String>();
        
        while (iterator.hasNext()) 
        {
            Row row = iterator.next();
             
            //Non considero la prima riga
            if(contatoreRiga>0)
            {

    			try
    			{ 
    				int u = 0;
    				 
    				//Controllo che la riga sia popolata, altrimenti si interrompe l'elaborazione
    				if(!rigaValorizzata(row,12))
    				{
    					break;
    				}
 	    		
    				String codiceGisa = getCellValueSafe(row.getCell(u++)); 
    				codiceGisa = codiceGisa.trim();
    				Timestamp dataInizioControllo =  getDateSafe (row.getCell(u++), "Data Prelievo");
    				String ora =  getCellValueSafe(row.getCell(u++));
    				String protocolloRoutineStr =  getCellValueSafe(row.getCell(u++));
    				String protocolloVerificaStr =  getCellValueSafe(row.getCell(u++));
    				String protocolloReplicaMicroStr =  getCellValueSafe(row.getCell(u++));
    				String protocolloRicercaFitosanitariStr = getCellValueSafe(row.getCell(u++));
    				String cloro =  getCellValueSafe(row.getCell(u++));
    				String temperatura =  getCellValueSafe(row.getCell(u++));
    				String esito = getCellValueSafe(row.getCell(u++));
    				String parametriNonConformi = getCellValueSafe(row.getCell(u++));
    				String note = getCellValueSafe(row.getCell(u++));
    				
    				//Vecchi
    				/*
    				String protocolloReplicaChimicaStr =  getCellValueSafe(row.getCell(u++));
    				String protocolloRadioattivitaStr=  getCellValueSafe(row.getCell(u++));
    				*/
    				
    				 
    				controlloObbligatorio(codiceGisa, "Codice Gisa");
    				controlloObbligatorio(dataInizioControllo, "Data Prelievo");
    				controlloObbligatorio(temperatura, "Temperatura");
    				controlloObbligatorio(cloro, "Cloro");
    				controlloObbligatorio(ora, "Ora");
    				
    				if(!ControlloInterno.search(db, codiceGisa, dataInizioControllo, ora, "31").isEmpty())
    					throw new EccezioneDati("Controllo con Codice Gisa punto prelievo, data e ora gia' esistente");
    				
    				if(ternaCodicecodiciPuntoPrelievo.contains(codiceGisa+dataInizioControllo.toString()+ora.toUpperCase()))
    					throw new EccezioneDati("Controllo con Codice Gisa punto prelievo, data e ora gia' presente nel file");
    				
    				if(esito == null || esito.trim().length() == 0 || (!esito.equalsIgnoreCase("CONFORME") && !esito.equalsIgnoreCase("NON CONFORME")) )
    				{
    					throw new EccezioneDati("L'esito del Controllo e' obbligatorio, e i valori possibili sono \"CONFORME\" o \"NON CONFORME\"");
    				}
    				 
    				/*scorro sulle righe, e associo i controlli ai punti di prelievo */
    				
    				if(!controlliPerCodicePP.containsKey(codiceGisa))
    				{
    					PuntoPrelievo pp = PuntoPrelievo.searchByCodiceGisaPP(db, gest.getId(), codiceGisa,false);
    					/*svuoto i controlli e gli metto solo quelli che sto trovando sul file */
    					pp.setControlliInterni(new ArrayList<ControlloInterno>());
    					controlliPerCodicePP.put(codiceGisa,  pp);
    				}
    				PuntoPrelievo pp = controlliPerCodicePP.get(codiceGisa);
    				List<ControlloInterno> controlli = pp.getControlliInterni(); /*quelli fino ad ora aggiunti, dal file, per il pp in questione */
    				
    				
    				ControlloInterno controllo = new ControlloInterno();
    				
    				controllo.setCloro(cloro);
    				controllo.setStatusId(1); /*aperto*/
    				controllo.setOra(ora);
    				controllo.setTemperatura(temperatura);
//    				controllo.setIdUnitaOperativa(0); /*TODO LEVA CABLATO */
    				controllo.setEsito(esito);
    				controllo.setNonConformita(parametriNonConformi);
    				controllo.setNote(note);
    				
//    				controllo.setMotivoIspezione(4375); /*TODO LEVA CABLATO */
    				controllo.setDataInizioControllo(dataInizioControllo);
    				controllo.setPuntoPrelievoPadre(pp);
    				controllo.setSiteId(controllo.getPuntoPrelievoPadre().getIdAsl());
    				controllo.setEnteredBy(user.getUserId());
    				controllo.setModifiedBy(user.getUserId());
    				controllo.setTipologia(3); 
    				
    				int idTipoControllo = ControlloInterno.getCodeFromLookupDesc(db, "lookup_tipo_controllo", "code", "description", "Controllo Interno", "");
    				controllo.setTipoControllo( idTipoControllo ); /*TODO LEVA CABLATO */
    				controllo.setOggettoIspezione(19); /*TODO LEVA CABLATO */
    				controllo.setIdComponenteNucleoIspettivo(-1); /*cablato, aggiorna */
    				
    				int numProtocolli = 0; /*un solo protocollo e non piu' di uno */
    				/*controllo validita' protocolli */
    				numProtocolli = (protocolloRoutineStr != null && protocolloRoutineStr.trim().length() > 0) ? numProtocolli+1 : numProtocolli;
    				numProtocolli = (protocolloVerificaStr != null  && protocolloVerificaStr.trim().length() > 0) ? numProtocolli+1 : numProtocolli;
    				numProtocolli = (protocolloReplicaMicroStr != null  && protocolloReplicaMicroStr.trim().length() > 0) ? numProtocolli+1 : numProtocolli;
    				//numProtocolli = (protocolloReplicaChimicaStr != null  && protocolloReplicaChimicaStr.trim().length() > 0) ? numProtocolli+1 : numProtocolli;
    				//numProtocolli = (protocolloRadioattivitaStr != null  && protocolloRadioattivitaStr.trim().length() > 0) ? numProtocolli+1 : numProtocolli;
    				numProtocolli = (protocolloRicercaFitosanitariStr != null  && protocolloRicercaFitosanitariStr.trim().length() > 0) ? numProtocolli+1 : numProtocolli;
    				
    				if(numProtocolli > 1)
    				{
    					throw new EccezioneDati("Non e' possibile selezionare piu' di un protocollo per controllo");
    				}
    				else if(numProtocolli == 0)
    				{
    					throw new EccezioneDati("Selezionare almeno un protocollo di controllo");
    				}
    				
    				if(protocolloRoutineStr != null && protocolloRoutineStr.trim().length() > 0) { controllo.setProtocolloRoutine(true); }
    				if(protocolloVerificaStr != null  && protocolloVerificaStr.trim().length() > 0) { controllo.setProtocollVerifica(true); }
    				if(protocolloReplicaMicroStr != null  && protocolloReplicaMicroStr.trim().length() > 0) { controllo.setProtocolloReplicaMicro(true); }
    				//if(protocolloReplicaChimicaStr != null  && protocolloReplicaChimicaStr.trim().length() > 0) { controllo.setProtocolloReplicaChim(true); }
    				//if(protocolloRadioattivitaStr != null  && protocolloRadioattivitaStr.trim().length() > 0) { controllo.setProtocolloRadioattivita(true); }
    				if(protocolloRicercaFitosanitariStr != null  && protocolloRicercaFitosanitariStr.trim().length() > 0) { controllo.setProtocolloRicercaFitosanitari(true); }
    				
    				controllo.setTipoDecreto("31");
    				
    				controlli.add(controllo);
    				ternaCodicecodiciPuntoPrelievo.add(codiceGisa+dataInizioControllo.toString()+ora.toUpperCase());
    			}
    			catch(EccezioneDati ex)
    			{
    				esitiErroriParsingfile.add("<font color=\"orange\"><br>RIGA "+(contatoreRiga+1)+" SALTATA : "+ex.getMessage()+"</font>");
    			}
    			catch(ParseException ex)
    			{
    				esitiErroriParsingfile.add("<font color=\"orange\"><br>RIGA "+(contatoreRiga+1)+" SALTATA : CAMPO "+ex.getMessage()+" IN FORMATO NON CORRETTO. IL FORMATO CORRETTO E' dd/MM/yyyy </font>");
    			}
    			catch(Exception ex)
    			{
//    				ex.printStackTrace(s);;
//    				ex.printStackTrace();
    				esitiErroriParsingfile.add("<font color=\"orange\"><br>RIGA "+(contatoreRiga+1)+" SALTATA POICHE' CAMPO " + ex.getMessage() + " VUOTO </font>");
    			}
    			
    		
            }
            
            contatoreRiga++;
          
            if (rigaIniziale>0 && rigaFinale > 0)
        	    break;
        }
		
		
		
		
		
		
		
		
		
		
		
		
		try
		{
			wb.close();
		}
		catch(Exception ex)
		{
			
		}
		
		return controlliPerCodicePP;
	}
	
	
	public static Object[] getIdDescAslFromDescComune(Connection conn, String descComune) throws Exception
	{
		
		PreparedStatement pst = null;
		ResultSet rs = null;
		Integer codeAsl = null;
		String descAsl = null;
		
		try
		{
			pst = conn.prepareStatement("select asl.description, asl.code from lookup_site_id asl join comuni1 com on com.codiceistatasl = asl.code::text "
					+ " where lower(com.nome) = lower(?)");
			pst.setString(1, descComune);
			rs = pst.executeQuery();
			if(rs.next()){
				codeAsl = rs.getInt("code");
				descAsl = rs.getString("description");
			}
			return new Object[]{codeAsl,descAsl};
						
		}
		catch(Exception ex)
		{
			throw ex;
		}
		finally
		{
			
		}
	}
	
	public static Object[] getIdDescAslFromIDComune(Connection conn, Integer idCom) 
	{
		
		PreparedStatement pst = null;
		ResultSet rs = null;
		Object[] toRet = null;
		
		try
		{
			pst = conn.prepareStatement("select asl.description, asl.code from lookup_site_id asl join comuni1 com on com.codiceistatasl = asl.code::text "
					+ " where com.id = ?");
			pst.setInt(1, idCom);
			rs = pst.executeQuery();
			rs.next();
			Integer codeAsl = rs.getInt("code");
			String descAsl = rs.getString("description");
			toRet = new Object[]{codeAsl,descAsl};
		}
		catch(Exception ex)
		{
			 System.out.println("Per il comune passato, non e' stato possibile individuare asl campana. Assegno fuori regione");
			 return new Object[]{16,"fuori regione"};
			
			
		}
		finally
		{
			try{pst.close();} catch(Exception ex){}
			try{rs.close();} catch(Exception ex){}
		}
		
		return toRet;
	}
	
	
	private static void controlloObbligatorio(Object valore, String nomeCampo) throws Exception
	{
		String valoreString = null;
		boolean isString = false;
		
		if(valore instanceof String )
		{
			valoreString = (String)valore;
			isString = true;
		}
		if(valore==null || (isString && valoreString.equals("")))
		{
			throw new Exception(nomeCampo);
		}
	}
	
	private static Double controlloNumerico(String valoreToConvert,String nomeCampo) throws EccezioneDati
	{
		Double variabile = null;
		if(valoreToConvert!=null && !valoreToConvert.equals(""))
		{
			try
			{
				valoreToConvert = valoreToConvert.replaceAll(",", ".");
				variabile =  Double.parseDouble(valoreToConvert);
			}
			catch(NumberFormatException ex)
			{
				throw new EccezioneDati("Il valore del campo " + nomeCampo + " deve essere numerico.");
			}
			return variabile;
		}
		return null;
	}
	
	private static boolean rigaValorizzata(org.apache.poi.ss.usermodel.Row row, int numMaxColonne)
	{
		int i=1;
		for(i=1;i<=numMaxColonne;i++)
		{
			Cell cella = row.getCell(i);
			String valore = null;
			if(cella!=null)
				valore = getCellValueSafe(cella);
			if(cella!=null && valore!=null && !valore.equals(""))
				return true;
		}
		return false;
	}
}
