package org.aspcfs.modules.registrocaricoscarico.base.seme;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.darkhorseventures.framework.actions.ActionContext;

public class ScaricoSeme {

	private int id = -1;
	private int idCarico = -1;
	private Timestamp entered = null;
	private int enteredBy= -1;
	private String noteHd = null;
	private Timestamp trashedDate = null;
	private int trashedBy= -1;

	private int indice = -1;
	
	private String numRegistrazione = null;

	private String dataVendita = null;

	private String codiceDestinatario = null;
	private int dosiVendute = 0;
	private int dosiDistrutte = 0;
	
	private String documentoTrasportoUscita = null;

	public ScaricoSeme() {
	}
	
	public ScaricoSeme(ResultSet rs) throws SQLException {
		buildRecord(rs);
	}
	
	public ScaricoSeme(ActionContext context) {
		this.id = Integer.parseInt(context.getRequest().getParameter("idScarico"));
		this.idCarico = Integer.parseInt(context.getRequest().getParameter("idCarico"));

		this.numRegistrazione = context.getRequest().getParameter("numRegistrazione");

		this.codiceDestinatario = context.getRequest().getParameter("codiceDestinatario");
		
		try { this.dosiVendute = Integer.parseInt(context.getRequest().getParameter("dosiVendute")); } catch (Exception e){}
		try { this.dosiDistrutte = Integer.parseInt(context.getRequest().getParameter("dosiDistrutte")); } catch (Exception e){}
		
		this.dataVendita = context.getRequest().getParameter("dataVendita");
		
		this.documentoTrasportoUscita = context.getRequest().getParameter("documentoTrasportoUscita");

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

		this.codiceDestinatario = rs.getString("codice_destinatario");
		this.dosiVendute = rs.getInt("dosi_vendute");
		this.dosiDistrutte = rs.getInt("dosi_distrutte");
		this.dataVendita = rs.getString("data_vendita");
		this.documentoTrasportoUscita = rs.getString("documento_trasporto_uscita");

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


	public String getDataVendita() {
		return dataVendita;
	}


	public void setDataVendita(String dataVendita) {
		this.dataVendita = dataVendita;
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


	public String getDocumentoTrasportoUscita() {
		return documentoTrasportoUscita;
	}


	public void setDocumentoTrasportoUscita(String documentoTrasportoUscita) {
		this.documentoTrasportoUscita = documentoTrasportoUscita;
	}


	public static ArrayList<ScaricoSeme> getListaScarico(Connection db, int idCarico) throws SQLException {
			ArrayList<ScaricoSeme> lista = new ArrayList<ScaricoSeme>(); 
			PreparedStatement pst = db.prepareStatement("select * from registro_scarico_seme where id_carico = ? and enabled and trashed_date is null order by indice asc"); 
			pst.setInt(1, idCarico);
			ResultSet rs = pst.executeQuery();  
			while (rs.next()){
				ScaricoSeme scarico = new ScaricoSeme(rs);
				lista.add(scarico);
			}
			return lista;
		}

	public void upsert(Connection db, int userId) throws SQLException {
		PreparedStatement pst = db.prepareStatement("select * from upsert_registro_scarico_seme (?, ?, ?, ?, ?, ?, ?, ?);");
		int i = 0;
		
		pst.setInt(++i, id);
		pst.setInt(++i, idCarico);
		pst.setInt(++i, userId);
		
		pst.setString(++i, dataVendita);
		pst.setString(++i, codiceDestinatario);
		pst.setInt(++i, dosiVendute);
		pst.setInt(++i, dosiDistrutte);
		pst.setString(++i, documentoTrasportoUscita);
		
		System.out.println("[REGISTRO SCARICO SEME UPSERT] " + pst.toString());
		
		ResultSet rs = pst.executeQuery();
		
		if (rs.next())
			this.id = rs.getInt(1);
		
	}
	
	public ScaricoSeme(Connection db, int id) throws SQLException {
		
		PreparedStatement pst = db.prepareStatement("select * from registro_scarico_seme where id = ? and trashed_date is null");
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
		PreparedStatement pst = db.prepareStatement("select * from delete_registro_scarico_seme (?, ?);");
		int i = 0;
		
		pst.setInt(++i, id);
		pst.setInt(++i, userId);
		
		System.out.println("[REGISTRO SCARICO SEME DELETE] " + pst.toString());
		
		ResultSet rs = pst.executeQuery();
		
		if (rs.next())
			this.id = rs.getInt(1);
		
	}
}
