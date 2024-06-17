package org.aspcfs.modules.registrocaricoscarico.base.recapiti;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.darkhorseventures.framework.actions.ActionContext;

public class ScaricoRecapiti {

	private int id = -1;
	private int idCarico = -1;
	private Timestamp entered = null;
	private int enteredBy= -1;
	private String noteHd = null;
	private Timestamp trashedDate = null;
	private int trashedBy= -1;

	private int indice = -1;
	
	private String numRegistrazione = null;

	private String dataRegistrazioneUscita = null;
	private String codiceDestinatario = null;
	private int dosiVendute = 0;
	private int dosiDistrutte = 0;
	private String documentoCommercialeUscita = null;

	public ScaricoRecapiti() {
	}
	
	public ScaricoRecapiti(ResultSet rs) throws SQLException {
		buildRecord(rs);
	}
	
	public ScaricoRecapiti(ActionContext context) {
		this.id = Integer.parseInt(context.getRequest().getParameter("idScarico"));
		this.idCarico = Integer.parseInt(context.getRequest().getParameter("idCarico"));

		this.numRegistrazione = context.getRequest().getParameter("numRegistrazione");

		this.dataRegistrazioneUscita = context.getRequest().getParameter("dataRegistrazioneUscita");

		this.codiceDestinatario = context.getRequest().getParameter("codiceDestinatario");
		
		try { this.dosiVendute = Integer.parseInt(context.getRequest().getParameter("dosiVendute")); } catch (Exception e){}
		try { this.dosiDistrutte = Integer.parseInt(context.getRequest().getParameter("dosiDistrutte")); } catch (Exception e){}
			
		this.documentoCommercialeUscita = context.getRequest().getParameter("documentoCommercialeUscita");

	}

	private void buildRecord(ResultSet rs) throws SQLException{
		this.id = rs.getInt("id");
		this.idCarico = rs.getInt("id_carico");

		this.entered = rs.getTimestamp("entered");
		this.enteredBy = rs.getInt("enteredby");
		this.trashedDate = rs.getTimestamp("trashed_date");
		this.trashedBy = rs.getInt("trashedby");
		this.noteHd = rs.getString("note_hd");
		this.indice = rs.getInt("indice");
		this.numRegistrazione = rs.getString("num_registrazione");

		this.dataRegistrazioneUscita = rs.getString("data_registrazione_uscita");
		this.codiceDestinatario = rs.getString("codice_destinatario");
		this.dosiVendute = rs.getInt("dosi_vendute");
		this.dosiDistrutte = rs.getInt("dosi_distrutte");
		this.documentoCommercialeUscita = rs.getString("documento_commerciale_uscita");

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdCarico() {
		return idCarico;
	}

	public void setIdCarico(int idCarico) {
		this.idCarico = idCarico;
	}

	public Timestamp getEntered() {
		return entered;
	}

	public void setEntered(Timestamp entered) {
		this.entered = entered;
	}

	public int getEnteredBy() {
		return enteredBy;
	}

	public void setEnteredBy(int enteredBy) {
		this.enteredBy = enteredBy;
	}

	public String getNoteHd() {
		return noteHd;
	}

	public void setNoteHd(String noteHd) {
		this.noteHd = noteHd;
	}

	public Timestamp getTrashedDate() {
		return trashedDate;
	}

	public void setTrashedDate(Timestamp trashedDate) {
		this.trashedDate = trashedDate;
	}

	public int getTrashedBy() {
		return trashedBy;
	}

	public void setTrashedBy(int trashedBy) {
		this.trashedBy = trashedBy;
	}

	public int getIndice() {
		return indice;
	}

	public void setIndice(int indice) {
		this.indice = indice;
	}

	public String getDataRegistrazioneUscita() {
		return dataRegistrazioneUscita;
	}

	public void setDataRegistrazioneUscita(String dataRegistrazioneUscita) {
		this.dataRegistrazioneUscita = dataRegistrazioneUscita;
	}

	public String getCodiceDestinatario() {
		return codiceDestinatario;
	}

	public void setCodiceDestinatario(String codiceDestinatario) {
		this.codiceDestinatario = codiceDestinatario;
	}

	public int getDosiVendute() {
		return dosiVendute;
	}

	public void setDosiVendute(int dosiVendute) {
		this.dosiVendute = dosiVendute;
	}

	public int getDosiDistrutte() {
		return dosiDistrutte;
	}

	public void setDosiDistrutte(int dosiDistrutte) {
		this.dosiDistrutte = dosiDistrutte;
	}

	public String getDocumentoCommercialeUscita() {
		return documentoCommercialeUscita;
	}

	public void setDocumentoCommercialeUscita(String documentoCommercialeUscita) {
		this.documentoCommercialeUscita = documentoCommercialeUscita;
	}

	public static ArrayList<ScaricoRecapiti> getListaScarico(Connection db, int idCarico) throws SQLException { 
			ArrayList<ScaricoRecapiti> lista = new ArrayList<ScaricoRecapiti>(); 
			PreparedStatement pst = db.prepareStatement("select * from registro_scarico_recapito where id_carico = ? and enabled and trashed_date is null order by indice asc"); 
			pst.setInt(1, idCarico);
			ResultSet rs = pst.executeQuery();  
			while (rs.next()){
				ScaricoRecapiti scarico = new ScaricoRecapiti(rs);
				lista.add(scarico);
			}
			return lista;
		}

	public void upsert(Connection db, int userId) throws SQLException {
		PreparedStatement pst = db.prepareStatement("select * from upsert_registro_scarico_recapiti (?, ?, ?, ?, ?, ?, ?, ?);");
		int i = 0;
		
		pst.setInt(++i, id);
		pst.setInt(++i, idCarico);
		pst.setInt(++i, userId);
		
		pst.setString(++i, dataRegistrazioneUscita);
		pst.setString(++i, codiceDestinatario);
		pst.setInt(++i, dosiVendute);
		pst.setInt(++i, dosiDistrutte);
		pst.setString(++i, documentoCommercialeUscita);

		System.out.println("[REGISTRO SCARICO RECAPITI UPSERT] " + pst.toString());
		
		ResultSet rs = pst.executeQuery();
		
		if (rs.next())
			this.id = rs.getInt(1);
		}
	
	public ScaricoRecapiti(Connection db, int id) throws SQLException {
		
		PreparedStatement pst = db.prepareStatement("select * from registro_scarico_recapito where id = ? and trashed_date is null");
		pst.setInt(1, id);
		
		ResultSet rs = pst.executeQuery();
		
		if (rs.next()){
			buildRecord(rs);
		}
	}

	public String getNumRegistrazione() {
		return numRegistrazione;
	}

	public void setNumRegistrazione(String numRegistrazione) {
		this.numRegistrazione = numRegistrazione;
	}
	
	public void delete(Connection db, int userId) throws SQLException {
		PreparedStatement pst = db.prepareStatement("select * from delete_registro_scarico_recapiti (?, ?);");
		int i = 0;
		
		pst.setInt(++i, id);
		pst.setInt(++i, userId);
		
		System.out.println("[REGISTRO SCARICO RECAPITI DELETE] " + pst.toString());
		
		ResultSet rs = pst.executeQuery();
		
		if (rs.next())
			this.id = rs.getInt(1);
		
	}
}
