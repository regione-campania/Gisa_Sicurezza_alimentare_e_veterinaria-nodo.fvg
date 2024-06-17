package org.aspcfs.modules.registrotrasgressori.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.aspcfs.modules.gestioneDocumenti.actions.GestioneAllegatiTrasgressori;
import org.aspcfs.modules.gestioneDocumenti.servlets.ServletGeneraDocumentoRicevutaPagoPA;
import org.json.JSONObject;

import com.darkhorseventures.framework.actions.ActionContext;

public class PagoPaUtil {

	public static String fixDescrizioneErrore(String descrizioneErrore) {
		if (descrizioneErrore == null || descrizioneErrore.equals(""))
			return "ERRORE NELLA COOPERAZIONE APPLICATIVA. IL SERVIZIO POTREBBE NON ESSERE RAGGIUNGIBILE. SI PREGA DI RIPROVARE.";
		else
			return descrizioneErrore.replaceAll("'", " ").replaceAll("/", "").replaceAll("(\\r|\\n|\\r\\n)+", "\\\\n");
	}

	public static String calcolaDataScadenza(String dataPartenza, String tipoNotifica, String tipoPagamento,
			String tipoRiduzione, int numeroRata) throws ParseException {
		String dataScadenza = null;

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date parsedDate = dateFormat.parse(dataPartenza);
		Timestamp dataPartenzaTimestamp = new java.sql.Timestamp(parsedDate.getTime());

		Calendar cal = Calendar.getInstance();
		cal.setTime(dataPartenzaTimestamp);

		if (tipoPagamento.equalsIgnoreCase("PV")) {
			if (tipoRiduzione.equalsIgnoreCase("U")) {
				cal.add(Calendar.DAY_OF_MONTH, 5);
			} else if (tipoRiduzione.equalsIgnoreCase("R")) {
				cal.add(Calendar.DAY_OF_MONTH, 60);
			}
		} else if (tipoPagamento.equalsIgnoreCase("NO")) {
			cal.add(Calendar.DAY_OF_MONTH, 30 * numeroRata);
		}

		Timestamp dataTimestampNew = new Timestamp(cal.getTime().getTime());
		dataScadenza = new SimpleDateFormat("yyyy-MM-dd").format(dataTimestampNew).toString();

		return dataScadenza;
	}

	public static void salvaStorico(Connection db, int idUtente, int idSanzione, int idPagamento, String operazione)
			throws SQLException {
		PreparedStatement pst = db
				.prepareStatement("insert into pagopa_storico(id_utente, id_sanzione, id_pagamento, operazione) values (?, ?, ?, ?)");
		int i = 0;
		pst.setInt(++i, idUtente);
		pst.setInt(++i, idSanzione);
		pst.setInt(++i, idPagamento);
		pst.setString(++i, operazione);
		pst.executeUpdate();
	}
	
	public static void salvaStoricoOperazioniAutomatiche(Connection db, int idSanzione, int idPagamento,
			String vecchiaDataScadenza, String nuovaDataScadenza, String messaggio) throws SQLException {
		PreparedStatement pst = db
				.prepareStatement("insert into pagopa_storico_operazioni_automatiche(id_sanzione, id_pagamento, vecchia_data_scadenza, nuova_data_scadenza, messaggio) values (?, ?, ?, ?, ?)");
		int i = 0;
		pst.setInt(++i, idSanzione);
		pst.setInt(++i, idPagamento);
		pst.setString(++i, vecchiaDataScadenza);
		pst.setString(++i, nuovaDataScadenza);
		pst.setString(++i, messaggio);
		pst.executeUpdate();
	}

public static String inviaADocumentaleConRitorno(String localFile, String urlFile, String tipoAllegato, String oggettoAllegato, int idSanzione, int idPagamento, String extra, int userId) throws IOException {
		
		File file = null;
		String codDocumento = "";
		
		if (urlFile!=null && !"".equals(urlFile)){
			
//			String idAvviso = "";
//			Pattern pattern = Pattern.compile("id=(.*?)&");
//	        Matcher matcher = pattern.matcher(urlFile);
//	        while (matcher.find()) {
//	                idAvviso = matcher.group(1);
//	            }
	       
			URL url = new URL(urlFile);
			
			String tDir = System.getProperty("java.io.tmpdir"); 
			String path = tDir + File.separator + tipoAllegato+"_"+idPagamento + ".pdf"; 
			file = new File(path); 
			file.deleteOnExit(); 
			FileUtils.copyURLToFile(url, file);

		}
		
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
		
		String fileName = file.getName();
		
		fileName = fileName.replaceAll("temp",  "");

		GestioneAllegatiTrasgressori gestioneAllegati = new GestioneAllegatiTrasgressori();
		gestioneAllegati.setTicketId(idSanzione);
		gestioneAllegati.setPagamentoId(idPagamento);
		gestioneAllegati.setTipoAllegato(tipoAllegato);
		gestioneAllegati.setFilename(fileName);
		gestioneAllegati.setFileDimension(String.valueOf(file.length()));
		gestioneAllegati.setBa(ba);
		gestioneAllegati.setOggetto(oggettoAllegato);
		gestioneAllegati.setIdUtente(userId); 
		gestioneAllegati.setExtra(URLEncoder.encode(extra, "ISO-8859-1")); 
		try {
			codDocumento = gestioneAllegati.chiamaServerDocumentaleConRitorno();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}		
		return codDocumento;
	}

	public static void inviaADocumentale(String localFile, String urlFile, int idSanzione, int userId) throws IOException {
		
		File file = null;
		String tipoAllegato = "";
		String oggettoAllegato = "";

		if (localFile!=null && !"".equals(localFile)) {
			
			file = new File(localFile);
			tipoAllegato = "ArchivioPagoPA";
			oggettoAllegato ="ARCHIVIO PAGOPA "+idSanzione;
			
		} else if (urlFile!=null && !"".equals(urlFile)){
			
			String idAvviso = "";
			Pattern pattern = Pattern.compile("id=(.*?)&");
	        Matcher matcher = pattern.matcher(urlFile);
	        while (matcher.find()) {
	                idAvviso = matcher.group(1);
	            }
	       
			URL url = new URL(urlFile);
			
			String tDir = System.getProperty("java.io.tmpdir"); 
			String path = tDir + File.separator + idAvviso + ".pdf"; 
			file = new File(path); 
			file.deleteOnExit(); 
			FileUtils.copyURLToFile(url, file);
			
			tipoAllegato = "AvvisoPagoPA";
			oggettoAllegato ="AVVISO PAGOPA "+idSanzione;

		}
		
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
		
		String fileName = file.getName();
		
		fileName = fileName.replaceAll("temp",  "");

		GestioneAllegatiTrasgressori gestioneAllegati = new GestioneAllegatiTrasgressori();
		gestioneAllegati.setTicketId(idSanzione);
		gestioneAllegati.setTipoAllegato(tipoAllegato);
		gestioneAllegati.setFilename(fileName);
		gestioneAllegati.setFileDimension(String.valueOf(file.length()));
		gestioneAllegati.setBa(ba);
		gestioneAllegati.setOggetto(oggettoAllegato);
		gestioneAllegati.setIdUtente(userId); 
		try {
			gestioneAllegati.chiamaServerDocumentale();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}		
	}

	public static int aggiornaIndici(Connection db, int idSanzione) throws SQLException {
		ResultSet rs = null;
		PreparedStatement pst = db
				.prepareStatement("select COALESCE(max(indice)+1, 1) from pagopa_pagamenti where id_sanzione = ? and trashed_date is null;");
		int i = 0;
		pst.setInt(++i, idSanzione);
		rs = pst.executeQuery();
		if (rs.next()){
			return rs.getInt(1);
		}
		return 99;
	}
	
	public static void gestioneSemaforo(Connection db, int idSanzione, int idUtente, boolean inizio) throws SQLException {
		PreparedStatement pst = null;
		
		if (inizio) {
			pst = db.prepareStatement("insert into pagopa_semaforo(id_sanzione, enteredby) values (?, ?);");
			pst.setInt(1, idSanzione);
			pst.setInt(2, idUtente);
		} else {
			pst = db.prepareStatement("update pagopa_semaforo set fine = now() where id_sanzione = ? and fine is null and trashed_date is null;");
			pst.setInt(1, idSanzione);
		}
		pst.execute();
	}
	
	public static boolean verificaSemaforoAttivo(Connection db, int idSanzione) throws SQLException {
		
		boolean semaforoAttivo = false;
		ResultSet rs = null;
		PreparedStatement pst = null;
		
		pst = db.prepareStatement("select * from pagopa_semaforo where id_sanzione = ? and fine is null and trashed_date is null;");
		pst.setInt(1, idSanzione);
		rs = pst.executeQuery();
		if (rs.next())
			semaforoAttivo = true;
		return semaforoAttivo;
		
	}
	
public static JSONObject getInfoAvviso(Connection db, String iuv) throws SQLException, ParseException {
		
		JSONObject info = null;
		ResultSet rs = null;
		PreparedStatement pst = null;
		
		pst = db.prepareStatement("select * from pagopa_get_info_iuv(?);");
		pst.setString(1, iuv);
		rs = pst.executeQuery();
		if (rs.next())
			info = new JSONObject(rs.getString(1));
		return info;
		
	}
public static JSONObject getInfoSanzione(Connection db, int id) throws SQLException, ParseException {
	
	JSONObject info = null;
	ResultSet rs = null;
	PreparedStatement pst = null;
	
	pst = db.prepareStatement("select * from pagopa_get_info_sanzione(?);");
	pst.setInt(1, id);
	rs = pst.executeQuery();
	if (rs.next())
		info = new JSONObject(rs.getString(1));
	return info;
	
}

public static void aggiornaHeaderRicevuta(Connection db, int idPagamento, String codDocumentoRicevuta) throws SQLException {
	PreparedStatement pst = null;
	
	pst = db.prepareStatement("update pagopa_pagamenti set header_file_ricevuta = ? where id = ?");
	pst.setString(1, codDocumentoRicevuta);
	pst.setInt(2, idPagamento);
	pst.executeUpdate();
	
}

public static void generaPdfRicevuta(ActionContext context, HttpServletRequest request, HttpServletResponse response, Connection db, int idSanzione, int idPagamento) throws ServletException, IOException {
	
	if (context!=null){
		request = context.getRequest();
		response = context.getResponse();
	}
	request.setAttribute("tipo", "RicevutaPagoPA");
	request.setAttribute("idSanzione", idSanzione);
	request.setAttribute("idPagamento", idPagamento);
	
	ServletGeneraDocumentoRicevutaPagoPA s = new ServletGeneraDocumentoRicevutaPagoPA();
	s.service(request, response);
	
	
}
	
}
