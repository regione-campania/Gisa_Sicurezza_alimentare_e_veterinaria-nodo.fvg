package org.aspcfs.modules.sintesis.base;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;

import org.aspcfs.utils.DatabaseUtils;
import org.json.JSONObject;

public class LogImport {
	
	private int id =-1;
	private int utenteImport = -1;
	private Timestamp dataDocumentoSintesis;
	private String fileImport;
	private Timestamp entered;
	private Timestamp ended;
	private Timestamp endedLetturaFile;
	private String errore;
	private String md5;
	private JSONObject jsonScartati = new JSONObject();
	private JSONObject jsonValidazione = new JSONObject();
	private String headerFile;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public int getUtenteImport() {
		return utenteImport;
	}
	public void setUtenteImport(int utenteImport) {
		this.utenteImport = utenteImport;
	}
	public Timestamp getDataDocumentoSintesis() {
		return dataDocumentoSintesis;
	}
	public void setDataDocumentoSintesis(Timestamp dataDocumentoSintesis) {
		this.dataDocumentoSintesis = dataDocumentoSintesis;
	}
	public void setDataDocumentoSintesis(String dataDocumentoSintesis) {
		this.dataDocumentoSintesis = DatabaseUtils.parseDateToTimestamp(dataDocumentoSintesis);
	}
	
	public String getFileImport() {
		return fileImport;
	}
	public void setFileImport(String fileImport) {
		this.fileImport = fileImport;
	}
 
public Timestamp getEntered() {
		return entered;
	}
	public void setEntered(Timestamp entered) {
		this.entered = entered;
	}
public LogImport (ResultSet rs) throws SQLException{
	buildRecord(rs);
}

private void buildRecord(ResultSet rs) throws SQLException{
	this.id = rs.getInt("id");
	this.utenteImport = rs.getInt("utente_import");
	this.dataDocumentoSintesis = rs.getTimestamp("data_sintesis");
	this.fileImport = rs.getString("file_import");
	this.entered = rs.getTimestamp("entered");
	this.ended = rs.getTimestamp("ended");
	this.endedLetturaFile = rs.getTimestamp("ended_lettura_file");
	this.errore = rs.getString("errore");
	this.headerFile = rs.getString("header_file");
	try {this.jsonScartati = new JSONObject(rs.getString("json_scartati"));} catch (Exception e) {}
	try {this.jsonValidazione = new JSONObject(rs.getString("json_validazione"));} catch (Exception e) {}
}

public LogImport (){
	
}

public LogImport (Connection db, int id) throws SQLException{
	StringBuffer sql = new StringBuffer();
	sql.append("select * from sintesis_stabilimenti_import_log where id = ?");
	int i = 0;
	PreparedStatement pst;
	pst = db.prepareStatement(sql.toString());
	pst.setInt(++i, id);
	ResultSet rs = pst.executeQuery();
	while (rs.next())
		buildRecord(rs);
}


public void insert (Connection db){

	StringBuffer sql = new StringBuffer();
	sql.append("INSERT INTO sintesis_stabilimenti_import_log("
			+ "data_sintesis,  entered, utente_import, file_import, md5 "
			+ ") values ("
			+ "?, now(), ?, ?, ? "
			+ "); ");
	int i = 0;
	PreparedStatement pst;
	try {
		pst = db.prepareStatement(sql.toString());
	
		pst.setTimestamp(++i, this.getDataDocumentoSintesis() );
		pst.setInt(++i, this.getUtenteImport());
		pst.setString(++i, this.getFileImport());
		pst.setString(++i, this.getMd5());

		pst.execute();
		this.id = DatabaseUtils.getCurrVal(db, "sintesis_stabilimenti_import_log_id_seq",id);

		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
		
}

public void update (Connection db){

	StringBuffer sql = new StringBuffer();
	sql.append("UPDATE sintesis_stabilimenti_import_log set errore = ? where id = ?");
	int i = 0;
	PreparedStatement pst;
	try {
		pst = db.prepareStatement(sql.toString());
		pst.setString(++i, errore);
		pst.setInt(++i, id);
		pst.execute();
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
		
}

public String getErrore() {
	return errore;
}
public void setErrore(String errore) {
	this.errore = errore;
}


public void calcolaMd5() throws IOException{
	File f = new File(fileImport);
	String md5 = "";
	byte[] buffer = new byte[(int) f.length()];
	InputStream ios = null;
	try {
		ios = new FileInputStream(f);
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


	MessageDigest md;
	try {
		md = MessageDigest.getInstance("MD5");
		md.update(buffer);
		byte byteData[] = md.digest();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < byteData.length; i++)
			sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
		md5 = sb.toString();
	} catch (NoSuchAlgorithmException e2) {
		// TODO Auto-generated catch block
		e2.printStackTrace();
	}
	this.md5 = md5 ;
}
public String getMd5() {
	return md5;
}
public void setMd5(String md5) {
	this.md5 = md5;
}
public boolean md5Presente(Connection db) throws SQLException {
	boolean presente = false;
	
	PreparedStatement pst = db.prepareStatement("select * from sintesis_stabilimenti_import_log where md5 = ?");
	pst.setString(1, md5);
	ResultSet rs = pst.executeQuery();
	if (rs.next())
		presente = true;
	return presente;
}
public void salvaEsiti(Connection db, JSONObject jsonScartati, JSONObject jsonValidazione, boolean isEnded, boolean isEndedLetturaFile) throws SQLException { 
	
	String sql = "update sintesis_stabilimenti_import_log set errore = null ";
	
	if (jsonScartati != null)
		sql+= ", json_scartati = ?::json";
	if (jsonValidazione != null)
		sql+= ", json_validazione = ?::json";
	if (isEnded)
		sql+= ", ended = now()";
	if (isEndedLetturaFile)
		sql+= ", ended_lettura_file = now()";
	sql+= " where id = ?";
	
	PreparedStatement pst = db.prepareStatement(sql);
	int i = 0;
	
	if (jsonScartati != null)
		pst.setString(++i, jsonScartati.toString());
	if (jsonValidazione != null)
		pst.setString(++i, jsonValidazione.toString());
	pst.setInt(++i, id); 

	pst.executeUpdate();
}
public JSONObject getJsonScartati() {
	return jsonScartati;
}
public void setJsonScartati(JSONObject jsonScartati) {
	this.jsonScartati = jsonScartati;
}
public JSONObject getJsonValidazione() {
	return jsonValidazione;
}
public void setJsonValidazione(JSONObject jsonValidazione) {
	this.jsonValidazione = jsonValidazione;
}
public void aggiornaHeaderFile(Connection db, String codDocumento) throws SQLException { 
	
	PreparedStatement pst = db.prepareStatement("update sintesis_stabilimenti_import_log set header_file = ? where id = ?");
	pst.setString(1, codDocumento);
	pst.setInt(2, id);
	pst.executeUpdate();
}
public String getHeaderFile() {
	return headerFile;
}
public void setHeaderFile(String headerFile) {
	this.headerFile = headerFile;
}
public String checkSemaforo(Connection db) throws SQLException {
	String msg = "";
	int idImport = -1;
	String dataImport = "";
	int recordDaProcessare = -1;
	Timestamp endedLetturaFile = null;
	PreparedStatement pst = db.prepareStatement("select * from get_semaforo_import_sintesis()");
	ResultSet rs = pst.executeQuery();
	if (rs.next()){
		idImport = rs.getInt("id_import");
		dataImport = rs.getString("data_import");
		recordDaProcessare = rs.getInt("record_da_processare");
		endedLetturaFile = rs.getTimestamp("ended_lettura_file");
	}
	
	if (idImport > 0){
		msg= "Attenzione.<br/>C'&egrave; una procedura di import in corso.";
		if (dataImport!=null && !"".equals(dataImport))
			msg+= "<br/>Data inizio import: "+dataImport;
		if (endedLetturaFile == null && recordDaProcessare > 0)
			msg+= "<br/>LETTURA DEL FILE IN CORSO. Righe lette: "+recordDaProcessare;
		if (endedLetturaFile != null && recordDaProcessare > 0)
			msg+= "<br/>Righe ancora da processare: "+recordDaProcessare;
		msg+= "<br/><br/>Attendere la fine della procedura.";

	}
	
	return msg;
}
public Timestamp getEnded() {
	return ended;
}
public void setEnded(Timestamp ended) {
	this.ended = ended;
}
public Timestamp getEndedLetturaFile() {
	return endedLetturaFile;
}
public void setEndedLetturaFile(Timestamp endedLetturaFile) {
	this.endedLetturaFile = endedLetturaFile;
}

public void cancellaPratiche(Connection db) throws SQLException { 
	
	PreparedStatement pst = db.prepareStatement("update sintesis_stabilimenti_import set trashed_date = now(), note_hd = concat_ws(';', note_hd, 'CANCELLATO PER RESTART') where id_import = ? and trashed_date is null");
	pst.setInt(1, id);
	pst.executeUpdate();
}
}
	
