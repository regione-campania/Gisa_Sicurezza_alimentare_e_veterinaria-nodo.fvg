package org.aspcfs.modules.macellazionisintesis.actions;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Logger;

import net.sf.jmimemagic.MagicException;
import net.sf.jmimemagic.MagicMatchNotFoundException;
import net.sf.jmimemagic.MagicParseException;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.gestioneDocumenti.actions.GestioneAllegatiUpload;
import org.aspcfs.modules.gestioneDocumenti.util.DocumentaleUtil;
import org.aspcfs.modules.macellazionisintesis.base.CapoImport;
import org.aspcfs.modules.macellazionisintesis.base.CapoImport2test;
import org.aspcfs.modules.macellazionisintesis.base.ImportLog;
import org.aspcfs.modules.macellazionisintesis.base.ImportLogList;
import org.aspcfs.modules.opu.util.StabilimentoImportUtil;

import com.darkhorseventures.framework.actions.ActionContext;
import com.isavvix.tools.FileInfo;
import com.isavvix.tools.HttpMultiPartParser;

public final class MacellazioniImport extends CFSModule {
	Logger logger = Logger.getLogger("MainLogger");

	private boolean fileImportabile = true;
	private String logErrori = "";
	private boolean rollback = false;
	private ArrayList<CapoImport> capi = new ArrayList<CapoImport>();
	private ArrayList<CapoImport2test> capi2 = new ArrayList<CapoImport2test>();

	private String idMacello = null;
	private String vpmData = null;
	private String cdSedutaMacellazione = null;
	private String csvFile = null;

	private void resetCampi() throws IllegalArgumentException, IllegalAccessException {
		fileImportabile = true;
		logErrori = "";
		capi = new ArrayList<CapoImport>();
		idMacello = null;
		vpmData = null;
		cdSedutaMacellazione = null;
		csvFile = null;
	}

	private void resetCampi2() throws IllegalArgumentException, IllegalAccessException {
		fileImportabile = true;
		logErrori = "";
		capi2 = new ArrayList<CapoImport2test>();
		idMacello = null;
		vpmData = null;
		cdSedutaMacellazione = null;
		csvFile = null;
	}

	public String executeCommandImportDaFile(ActionContext context) throws SQLException, IllegalArgumentException,
			IllegalAccessException, IOException, MagicParseException, MagicMatchNotFoundException, MagicException {

		resetCampi();

		// String filePath = this.getPath(context, "macelli_import");
		String filePath = getWebInfPath(context, "tmp_macelli_import");

		String fileName = "";
		String fileSize = "";

		HttpMultiPartParser multiPart = new HttpMultiPartParser();

		HashMap parts = null;
		try {
			parts = multiPart.parseData(context.getRequest(), filePath);
		} catch (IllegalArgumentException | IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		idMacello = (String) parts.get("idMacello");
		vpmData = (String) parts.get("vpmData");
		cdSedutaMacellazione = (String) parts.get("cdSedutaMacellazione");

		if ((Object) parts.get("file") instanceof FileInfo) {
			// Update the database with the resulting file
			FileInfo newFileInfo = (FileInfo) parts.get("file");
			// Insert a file description record into the database
			com.zeroio.iteam.base.FileItem thisItem = new com.zeroio.iteam.base.FileItem();
			thisItem.setLinkModuleId(Constants.ACCOUNTS);
			thisItem.setEnteredBy(getUserId(context));
			thisItem.setModifiedBy(getUserId(context));
			thisItem.setClientFilename(newFileInfo.getClientFileName());
			thisItem.setFilename(newFileInfo.getRealFilename());
			fileName = newFileInfo.getRealFilename();
			thisItem.setVersion(1.0);
			thisItem.setSize(newFileInfo.getSize());
			fileSize = String.valueOf(newFileInfo.getSize());
		}

		csvFile = filePath + fileName;
		
		ArrayList<String> listaFile = new ArrayList<String>();
		listaFile.add("text/csv");
		listaFile.add("text/plain");
		String esito = DocumentaleUtil.mimeType(csvFile, listaFile);
		if(esito != null)
			if(esito.equals("errore")){
				context.getRequest().setAttribute("Error", "Formato file non valido!");
				return ("SystemError");
			}
		

		// LEGGO DAL FILE E POPOLO LISTA DEI CAPI

		leggiDaFile(context);
		

		Connection db = null;

		try {
			db = this.getConnection(context);
			
			ImportLog log = new ImportLog();
			log.setIdMacello(idMacello);
			log.setDataMacellazione(vpmData);
			log.setFileImport(csvFile);
			log.setUtenteImport(this.getUserId(context));
			log.insert(db);

			if (fileImportabile) {
				for (CapoImport c : capi) {
					c.setIdImport(log.getId());

					if (c.getErroreImport() != null && !c.getErroreImport().equals(""))
						logErrori += "[Riga " + c.getNumeroRiga() + "] " + c.getCd_matricola() + ": "
								+ c.getErroreImport() + "<br/>";

					c.insert(db);
				}
			} else {
				for (CapoImport c : capi) {
					if (!c.isImportabile())
						logErrori += "[Riga " + c.getNumeroRiga() + "] " + c.getCd_matricola() + ": "
								+ c.getErroreImport() + "<br/>";
				}
			}

			log.setEsitoImport(fileImportabile);
			log.setErroriImport(logErrori);
			log.updateEsito(db);

			System.out.println("MACELLAZIONI Import terminato");

			/* ALLEGO IL FILE INVOCANDO IL DOCUMENTALE */
			inviaADocumentale(csvFile, log.getIdMacello(), fileName, fileSize, log.getDataMacellazione(), context);

			context.getRequest().setAttribute("altId", idMacello);
			context.getRequest().setAttribute("tipo", "1");
			context.getRequest().setAttribute("comboSessioniMacellazione", "-1"); // Faccio
																					// tornare
																					// a
																					// CAPI
																					// NON
																					// MACELLATI

			String messaggio = "";

			if (fileImportabile) {
				messaggio = "<font color=\"green\">Import terminato con successo</font>";
			} else {
				messaggio = "<font color=\"red\">Import fallito per questi errori:<br/>" + logErrori + "</font>";
			}

			context.getRequest().setAttribute("messaggioImport", messaggio);

			Macellazioni m = new Macellazioni();
			return m.executeCommandList(context);

		} catch (Exception e) {

			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			// GestoreConnessioni.freeConnectionImportatori(dbImportatori);

			this.freeConnection(context, db);
		}
	}

	public String executeCommandImportDaFile2(ActionContext context) throws SQLException, IllegalArgumentException,
			IllegalAccessException, IOException, MagicParseException, MagicMatchNotFoundException, MagicException {

		resetCampi();
		rollback = false;

		// String filePath = this.getPath(context, "macelli_import");
		String filePath = getWebInfPath(context, "tmp_macelli_import");
		ImportLog log = new ImportLog();

		String fileName = "";
		String fileSize = "";
		ArrayList<String> matricole = new ArrayList<String>();

		HttpMultiPartParser multiPart = new HttpMultiPartParser();

		HashMap parts = null;
		try {
			parts = multiPart.parseData(context.getRequest(), filePath);
		} catch (IllegalArgumentException | IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		idMacello = (String) parts.get("idMacello");
		vpmData = (String) parts.get("vpmData");
		cdSedutaMacellazione = (String) parts.get("cdSedutaMacellazione");

		if ((Object) parts.get("file") instanceof FileInfo) {
			// Update the database with the resulting file
			FileInfo newFileInfo = (FileInfo) parts.get("file");
			// Insert a file description record into the database
			com.zeroio.iteam.base.FileItem thisItem = new com.zeroio.iteam.base.FileItem();
			thisItem.setLinkModuleId(Constants.ACCOUNTS);
			thisItem.setEnteredBy(getUserId(context));
			thisItem.setModifiedBy(getUserId(context));
			thisItem.setClientFilename(newFileInfo.getClientFileName());
			thisItem.setFilename(newFileInfo.getRealFilename());
			fileName = newFileInfo.getRealFilename();
			thisItem.setVersion(1.0);
			thisItem.setSize(newFileInfo.getSize());
			fileSize = String.valueOf(newFileInfo.getSize());
		}

		csvFile = filePath + fileName;
		ArrayList<String> listaFile = new ArrayList<String>();
		listaFile.add("text/csv");
		listaFile.add("text/plain");
		String esito = DocumentaleUtil.mimeType(csvFile, listaFile);
		if(esito != null)
			if(esito.equals("errore")){
				context.getRequest().setAttribute("Error", "Formato file non valido!");
				return ("SystemError");
			}
		Connection db = null;
		// LEGGO DAL FILE E POPOLO LISTA DEI CAPI
		try {
			db = this.getConnection(context);

			log.setIdMacello(idMacello);
			log.setDataMacellazione(vpmData);
			log.setFileImport(csvFile);
			log.setUtenteImport(this.getUserId(context));
			log.insert(db);

		} catch (Exception e) {

			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			// GestoreConnessioni.freeConnectionImportatori(dbImportatori);

			this.freeConnection(context, db);
		}

		leggiDaFile2(context);

		int totale = 0;
		int non_mac = 0;
		int non_mac1 = 0;
		int mac = 0;
		int verifica;

		for (CapoImport2test c : capi2) {

			try {
				db = this.getConnection(context);

				System.out.println("ROLLBACK 0:" + rollback);

				c.setIdImport(log.getId());
				c.insert(db);
				System.gc();
				if (!c.insertdbiControl(db)) {
					rollback = true;
				}
				System.out.println("ROLLBACK 1:" + rollback);

				matricole.add(c.getCd_matricola());
				if (!c.controllaValiditaRiga(db, matricole)) {
					System.out.println("ROLLBACK 2:" + rollback);

					rollback = true;
				}
				System.out.println("ERRORE IMP:" + c.getErroreImport());

				if (c.getErroreImport() != null && !c.getErroreImport().equals("")) {
					logErrori += "[Riga " + c.getNumeroRiga() + "] " + c.getCd_matricola() + ": " + c.getErroreImport()
							+ "<br/><br/>";
					System.out.println("LOG ERRORI:" + logErrori);
				}

				System.out.println("ROLLBACK 3:" + rollback);

			} catch (Exception e) {

				context.getRequest().setAttribute("Error", e);
				return ("SystemError");
			} finally {
				// GestoreConnessioni.freeConnectionImportatori(dbImportatori);

				this.freeConnection(context, db);
			}

		}
		if (!rollback) {

			for (CapoImport2test c : capi2) {

				try {
					db = this.getConnection(context);

					c.insertdbi(db);

					verifica = c.logStato(db);
					switch (verifica) {
					case 1:
						non_mac++;
						totale++;
						break;
					case 2:
						non_mac1++;
						totale++;
						break;
					case 3:
						mac++;
						totale++;
						break;
					case 4:
						break;
					}
					System.out.println("VERIFICA " + verifica);

					System.out.println("TOTALE " + totale);

					System.out.println("non_mac " + non_mac);

					System.out.println("non_mac1 " + non_mac1);

				} catch (Exception e) {

					context.getRequest().setAttribute("Error", e);
					return ("SystemError");
				} finally {
					// GestoreConnessioni.freeConnectionImportatori(dbImportatori);

					this.freeConnection(context, db);
				}
			}
		}
		try {
			db = this.getConnection(context);

			log.setEsitoImport(!rollback);
			log.setErroriImport(logErrori);
			log.updateEsito(db);

			System.out.println("MACELLAZIONI Import terminato");

			/* ALLEGO IL FILE INVOCANDO IL DOCUMENTALE */
			inviaADocumentale(csvFile, log.getIdMacello(), fileName, fileSize, log.getDataMacellazione(), context);

			context.getRequest().setAttribute("altId", idMacello);
			context.getRequest().setAttribute("tipo", "1");
			context.getRequest().setAttribute("comboSessioniMacellazione", "-1"); // Faccio
																					// tornare
																					// a
																					// CAPI
																					// NON
																					// MACELLATI

			String messaggio = "";

			if (!rollback) {
				messaggio = "<button id=\"modal\" onclick=showDialogAlert(\""
						+ totale
						+ "\",\""
						+ mac
						+ "\",\""
						+ non_mac
						+ "\",\""
						+ non_mac1
						+ "\")>Visualizza riepilogo import</button></br> <script type=\"text/javascript\">document.getElementById(\"modal\").click(); $(function() {$('#modal').click();});</script> <font color=\"red\"><br/>" + logErrori + "</font>";
			} else {
				messaggio = "<font color=\"red\">Import fallito per questi errori:<br/>" + logErrori + "</font>";
			}
			
			
			
			System.out.println("MESSAGGIO: " + messaggio);

			context.getRequest().setAttribute("messaggioImport", messaggio);

			// context.getRequest().setAttribute("capiImp", totale);
			// context.getRequest().setAttribute("capiMac", (totale-non_mac));
			// context.getRequest().setAttribute("capiDaC", non_mac);

			capi2.clear();
		} catch (Exception e) {

			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			// GestoreConnessioni.freeConnectionImportatori(dbImportatori);

			this.freeConnection(context, db);
		}

		Macellazioni m = new Macellazioni();
		return m.executeCommandList(context);

	}

	
	
  	
	private void inviaADocumentale(String csvFile, int idMacello, String fileName, String fileSize,
			String dataMacellazione, ActionContext context) throws IOException {
		StabilimentoImportUtil.stampaLog("[MACELLI] Carico file sul documentale.");

		File file = new File(csvFile);
		byte[] buffer = new byte[(int) file.length()];
		InputStream ios = null;
		try {
			ios = new FileInputStream(file);
			if (ios.read(buffer) == -1) {
				throw new IOException("EOF reached while trying to read the whole file");
			}
		} finally {
			try {
				if (ios != null)
					ios.close();
			} catch (IOException e) {
			}
		}
		

		byte[] ba = buffer;
		

		GestioneAllegatiUpload gestioneAllegati = new GestioneAllegatiUpload();
		gestioneAllegati.setAltId(idMacello);
		gestioneAllegati.setTipoAllegato("IMPORT MACELLI");
		gestioneAllegati.setFilename(fileName);
		gestioneAllegati.setFileDimension(String.valueOf(fileSize));
		gestioneAllegati.setBa(ba);
		gestioneAllegati.setOggetto("IMPORT MASSIVO MACELLI_" + idMacello + "_" + dataMacellazione);
		try {
			gestioneAllegati.chiamaServerDocumentale(context);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}

	private void leggiDaFile(ActionContext context) {

		BufferedReader br = null;
		String line = "";
		String cvsSplitBy = ",";
		// String cvsSplitBy = ";";
		ArrayList<String> matricole = new ArrayList<String>();

		try {
			int i = 0;
			br = new BufferedReader(new FileReader(csvFile));
			// while ((line = br.readLine()) != null &&
			// !line.trim().replaceAll(";", "").equals("")) {
			while ((line = br.readLine()) != null && !line.trim().replaceAll(",", "").equals("")) {

				Connection db = null;
				try {
					db = this.getConnection(context);
					// use punto and virgola as separator
					String[] valori = line.split(cvsSplitBy);
					// Capi da importare se il file va bene
					CapoImport capo = null;
					capo = new CapoImport(valori);
					capo.setNumeroRiga(i);
					capo.setListaVeterinari(db);
					if (i == 0) {
						// creaFileScarti(intestazioni, idMacello, vpmData,
						// cdSedutaMacellazione);
					}
					if (capo != null && i > 0) {
						capo.setId_macello(idMacello);
						capo.setCd_seduta_macellazione(cdSedutaMacellazione);
						capo.setVpm_data(vpmData);
						capi.add(capo);
						matricole.add(capo.getCd_matricola());
						if (!capo.controllaValiditaRiga(db, matricole)) {
							fileImportabile = false;
						}
					}
					i++;
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					this.freeConnection(context, db);
				}
			}

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		}

		System.out.println("MACELLAZIONI Lettura file import terminato");
	}

	private void leggiDaFile2(ActionContext context) {

		BufferedReader br = null;
		BufferedReader br2 = null;

		String linecsv = "";
		String line = "";
		// String cvsSplitBy = ",";
		String cvsSplitBy = ";";
		ArrayList<String> matricole = new ArrayList<String>();

		try {
			br2 = new BufferedReader(new FileReader(csvFile));
			linecsv = br2.readLine();
			if (linecsv.contains(";")) {
				cvsSplitBy = ";";
			} else {
				if (linecsv.contains(",")) {
					cvsSplitBy = ",";
				} else {
					PrintWriter out = context.getResponse().getWriter();
					out.println("File non trovato o delimitatore csv errato, consultare la guida utente in caso di problemi.");
				}
			}

			int i = 0;
			br = new BufferedReader(new FileReader(csvFile));

			System.out.println("BR=" + br);
			// while ((line = br.readLine()) != null &&
			// !line.trim().replaceAll(";", "").equals("")) {
			while ((line = br.readLine()) != null && !line.trim().replaceAll(cvsSplitBy, "").equals("")) {

				Connection db = null;
				try {
					db = this.getConnection(context);
					// use punto and virgola as separator
					String[] valori = line.split(cvsSplitBy, -1);
					System.out.println("VALORI: " + valori.length);
					System.out.println("LINE: " + line);

					// Capi da importare se il file va bene
					CapoImport2test capo = null;
					capo = new CapoImport2test(valori);
					capo.setNumeroRiga(i);
					if (i == 0) {
						// creaFileScarti(intestazioni, idMacello, vpmData,
						// cdSedutaMacellazione);
					}
					if (capo != null && i > 0) {
						capo.setId_macello(idMacello);
						capo.setCd_seduta_macellazione(cdSedutaMacellazione);
						capo.setVpm_data(vpmData);
						capi2.add(capo);
						matricole.add(capo.getCd_matricola());

					}
					i++;
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					this.freeConnection(context, db);
				}
			}

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		}

		System.out.println("MACELLAZIONI Lettura file import terminato");
	}

	public String executeCommandListImport(ActionContext context) {

		int orgId = Integer.parseInt(context.getRequest().getParameter("orgId"));
		StringBuffer sql = new StringBuffer();
		sql.append("select * from m_import_storico where id_macello = ? order by data_import desc");
		PreparedStatement pst;

		Connection db = null;

		try {
			db = this.getConnection(context);
			pst = db.prepareStatement(sql.toString());
			pst.setInt(1, orgId);

			ResultSet rs = pst.executeQuery();
			ImportLogList logList = new ImportLogList();
			logList.creaElenco(rs);
			context.getRequest().setAttribute("listaImport", logList);

			org.aspcf.modules.controlliufficiali.base.Organization org = new org.aspcf.modules.controlliufficiali.base.Organization();
			org.getOnlyRagioneSociale(db, orgId);
			context.getRequest().setAttribute("OrgDetails", org);
			context.getRequest().setAttribute("orgId", String.valueOf(orgId));
			context.getRequest().setAttribute("op", context.getRequest().getParameter("op"));

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.freeConnection(context, db);
		}

		return "ImportLogListOK";
	}

	public String executeCommandDownloadImport(ActionContext context) {

		// TODO Auto-generated method stub

		int idImport = -1;
		String path_server = "", titolo = "";

		idImport = Integer.parseInt(context.getRequest().getParameter("idImport"));

		Connection db = null;

		try {
			db = this.getConnection(context);

			ImportLog log = new ImportLog(db, idImport);
			path_server = log.getFileImport();
			titolo = "Import_" + log.getId() + ".csv";

			String fileType = "";
			String fileName = path_server;

			if (new File(fileName).exists()) {
				// Find this file id in database to get file name, and file type

				// You must tell the browser the file type you are going to send
				// for example application/pdf, text/plain, text/html, image/jpg
				context.getResponse().setContentType(fileType);

				// Make sure to show the download dialog
				context.getResponse().setHeader("Content-disposition", "attachment; filename=" + titolo);

				// Assume file name is retrieved from database
				// For example D:\\file\\test.pdf

				File my_file = new File(fileName);

				// This should send the file to browser
				OutputStream out = context.getResponse().getOutputStream();
				FileInputStream in = new FileInputStream(my_file);
				byte[] buffer = new byte[4096];
				int length;
				while ((length = in.read(buffer)) > 0) {
					out.write(buffer, 0, length);
				}
				in.close();
				out.flush();
			} else {
				PrintWriter out = context.getResponse().getWriter();
				out.println("File non trovato!");
				out.println(fileName);
				out.println("Si e' verificato un problema con il recupero del file. Si prega di contattare l'HelpDesk.");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.freeConnection(context, db);
		}

		return ("-none-");

	}

	public String executeCommandLiberoConsumoVeloce(ActionContext context) {

		int idCapo = Integer.parseInt(context.getRequest().getParameter("idCapo"));
		String messaggio = "";
		boolean macellabile = true;
		int altId = -1;
		Connection db = null;

		try {
			db = this.getConnection(context);
			CapoImport c = new CapoImport(db, idCapo);
			altId = c.getId_macello();

			if (c.getVpm_data() == null) {
				macellabile = false;
				messaggio += "<font color=\"red\">Il capo " + c.getCd_matricola()
						+ " non risulta assegnato a nessuna sessione.</font>";
			}

			if (c.getIdImport() <= 0) {
				macellabile = false;
				messaggio += "<font color=\"red\">Il capo " + c.getCd_matricola()
						+ " non risulta inserito tramite import.</font>";
			}
			if (!c.getStato_macellazione().toLowerCase().contains("incompleto")) {
				macellabile = false;
				messaggio += "<font color=\"red\">Il capo " + c.getCd_matricola()
						+ " non risulta in uno stato macellabile.</font>";
			}

			if (macellabile) {
				c.setStato_macellazione("OK.");
				c.setVpm_esito(1);
				c.aggiornaLiberoConsumo(db);
				messaggio = "<font color=\"green\">Capo " + c.getCd_matricola()
						+ " correttamente macellato in libero consumo alla data " + c.getVpm_dataString() + ".</font>";
			}

			context.getRequest().setAttribute("messaggioLiberoConsumo", messaggio);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.freeConnection(context, db);
		}

		context.getRequest().setAttribute("altId", String.valueOf(altId));
		context.getRequest().setAttribute("tipo", "1");
		context.getRequest().setAttribute("comboSessioniMacellazione", "-1");

		Macellazioni m = new Macellazioni();
		return m.executeCommandList(context);

	}

}
