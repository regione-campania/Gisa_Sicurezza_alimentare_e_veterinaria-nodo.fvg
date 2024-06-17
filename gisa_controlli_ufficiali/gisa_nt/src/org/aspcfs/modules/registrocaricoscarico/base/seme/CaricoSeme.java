package org.aspcfs.modules.registrocaricoscarico.base.seme;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.darkhorseventures.framework.actions.ActionContext;

public class CaricoSeme {

	private int id = -1;
	private int idRegistro = -1;
	private Timestamp entered = null;
	private int enteredBy= -1;
	private String noteHd = null;
	private Timestamp trashedDate = null;
	private int trashedBy= -1;

	private int indice = -1;

	private String numRegistrazione = null;
	private String dataProduzione = null;
	private String codiceMittente = null;
	private int idSpecie = -1;
	private int idRazza = -1;
	private String nomeCapo = null;
	private String matricolaRiproduttoreMaschio = null;
	private String identificazionePartita = null;
	private int idTipoSeme = -1;
	
	private int dosiProdotte = 0;
	private int dosiAcquistate = 0;
	
	private String documentoTrasportoEntrata = null;
	
	private ArrayList<ScaricoSeme> listaScarico = new ArrayList<ScaricoSeme>();
	
	public CaricoSeme() {
	}
	
	public CaricoSeme(ResultSet rs) throws SQLException {
		buildRecord(rs);
	}
	
	
	public CaricoSeme(ActionContext context) {
		this.id = Integer.parseInt(context.getRequest().getParameter("idCarico")); 
		this.idRegistro = Integer.parseInt(context.getRequest().getParameter("idRegistro"));

		this.numRegistrazione = context.getRequest().getParameter("numRegistrazione");

		this.dataProduzione = context.getRequest().getParameter("dataProduzione");
		this.codiceMittente = context.getRequest().getParameter("codiceMittente");
		
		try { this.idSpecie = Integer.parseInt(context.getRequest().getParameter("idSpecie")); } catch (Exception e){}
		
		if (this.idSpecie == 1)
			this.idRazza = Integer.parseInt(context.getRequest().getParameter("idRazzaBovini"));
		if (this.idSpecie == 2)
			this.idRazza = Integer.parseInt(context.getRequest().getParameter("idRazzaSuini"));
		if (this.idSpecie == 3)
			this.idRazza = Integer.parseInt(context.getRequest().getParameter("idRazzaEquini"));
		if (this.idSpecie == 4)
			this.idRazza = Integer.parseInt(context.getRequest().getParameter("idRazzaAsini"));
		
		this.nomeCapo = context.getRequest().getParameter("nomeCapo");
		this.matricolaRiproduttoreMaschio = context.getRequest().getParameter("matricolaRiproduttoreMaschio");
		this.identificazionePartita = context.getRequest().getParameter("identificazionePartita");

		try { this.idTipoSeme = Integer.parseInt(context.getRequest().getParameter("idTipoSeme")); } catch (Exception e){}
		try { this.dosiProdotte = Integer.parseInt(context.getRequest().getParameter("dosiProdotte")); } catch (Exception e){}
		try { this.dosiAcquistate = Integer.parseInt(context.getRequest().getParameter("dosiAcquistate")); } catch (Exception e){}
	
		this.documentoTrasportoEntrata = context.getRequest().getParameter("documentoTrasportoEntrata");

	}

	private void buildRecord(ResultSet rs) throws SQLException{
		this.id = rs.getInt("id");
		this.idRegistro = rs.getInt("id_registro");

		this.entered = rs.getTimestamp("entered");
		this.enteredBy = rs.getInt("enteredby");
		this.trashedDate = rs.getTimestamp("trashed_date");
		this.trashedBy = rs.getInt("trashedby");
		this.noteHd = rs.getString("note_hd");
		this.indice = rs.getInt("indice");
		this.numRegistrazione = rs.getString("num_registrazione");
		this.dataProduzione = rs.getString("data_produzione");
		this.codiceMittente = rs.getString("codice_mittente");
		this.idSpecie = rs.getInt("id_specie");
		this.idRazza = rs.getInt("id_razza");
		this.nomeCapo = rs.getString("nome_capo");
		this.matricolaRiproduttoreMaschio = rs.getString("matricola_riproduttore_maschio");
		this.identificazionePartita = rs.getString("identificazione_partita");
		this.idTipoSeme = rs.getInt("id_tipo_seme");
		this.dosiProdotte = rs.getInt("dosi_prodotte");
		this.dosiAcquistate = rs.getInt("dosi_acquistate");
		this.documentoTrasportoEntrata = rs.getString("documento_trasporto_entrata");

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public int getIndice() {
		return indice;
	}

	public void setIndice(int indice) {
		this.indice = indice;
	}

	public String getNumRegistrazione() {
		return numRegistrazione;
	}

	public void setNumRegistrazione(String numRegistrazione) {
		this.numRegistrazione = numRegistrazione;
	}

	public String getDataProduzione() {
		return dataProduzione;
	}

	public void setDataProduzione(String dataProduzione) {
		this.dataProduzione = dataProduzione;
	}

	public String getCodiceMittente() {
		return codiceMittente;
	}

	public void setCodiceMittente(String codiceMittente) {
		this.codiceMittente = codiceMittente;
	}


	public int getIdSpecie() {
		return idSpecie;
	}

	public void setIdSpecie(int idSpecie) {
		this.idSpecie = idSpecie;
	}

	public int getIdRazza() {
		return idRazza;
	}

	public void setIdRazza(int idRazza) {
		this.idRazza = idRazza;
	}

	public String getMatricolaRiproduttoreMaschio() {
		return matricolaRiproduttoreMaschio;
	}

	public void setMatricolaRiproduttoreMaschio(String matricolaRiproduttoreMaschio) {
		this.matricolaRiproduttoreMaschio = matricolaRiproduttoreMaschio;
	}

	public String getIdentificazionePartita() {
		return identificazionePartita;
	}

	public void setIdentificazionePartita(String identificazionePartita) {
		this.identificazionePartita = identificazionePartita;
	}

	public int getIdTipoSeme() {
		return idTipoSeme;
	}

	public void setIdTipoSeme(int idTipoSeme) {
		this.idTipoSeme = idTipoSeme;
	}

	public int getDosiProdotte() {
		return dosiProdotte;
	}

	public void setDosiProdotte(int dosiProdotte) {
		this.dosiProdotte = dosiProdotte;
	}

	public int getDosiAcquistate() {
		return dosiAcquistate;
	}

	public void setDosiAcquistate(int dosiAcquistate) {
		this.dosiAcquistate = dosiAcquistate;
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


	public int getIdRegistro() {
		return idRegistro;
	}


	public void setIdRegistro(int idRegistro) {
		this.idRegistro = idRegistro;
	}


	public String getNomeCapo() {
		return nomeCapo;
	}


	public void setNomeCapo(String nomeCapo) {
		this.nomeCapo = nomeCapo;
	}


	public String getDocumentoTrasportoEntrata() {
		return documentoTrasportoEntrata;
	}


	public void setDocumentoTrasportoEntrata(String documentoTrasportoEntrata) {
		this.documentoTrasportoEntrata = documentoTrasportoEntrata;
	}


	public static ArrayList<CaricoSeme> getListaCarico(Connection db, int idRegistro) throws SQLException {
		ArrayList<CaricoSeme> lista = new ArrayList<CaricoSeme>(); 
		PreparedStatement pst = db.prepareStatement("select * from registro_carico_seme where id_registro = ? and enabled and trashed_date is null order by indice asc"); 
		pst.setInt(1, idRegistro);
		ResultSet rs = pst.executeQuery();  
		while (rs.next()){
			CaricoSeme carico = new CaricoSeme(rs);
			ArrayList<ScaricoSeme> scarico = new ArrayList<ScaricoSeme>();
			scarico = ScaricoSeme.getListaScarico(db, carico.getId());
			carico.setListaScarico(scarico);
			lista.add(carico);
		}
		return lista;
	}

	public CaricoSeme(Connection db, int id) throws SQLException {
		
		PreparedStatement pst = db.prepareStatement("select * from registro_carico_seme where id = ? and trashed_date is null");
		pst.setInt(1, id);
		
		ResultSet rs = pst.executeQuery();
		
		if (rs.next()){
			buildRecord(rs);
			
			ArrayList<ScaricoSeme> scarico = ScaricoSeme.getListaScarico(db, id);
			setListaScarico(scarico);
		}
	}

	public ArrayList<ScaricoSeme> getListaScarico() {
		return listaScarico;
	}

	public void setListaScarico(ArrayList<ScaricoSeme> listaScarico) {
		this.listaScarico = listaScarico;
	}

	public void upsert(Connection db, String numRegistrazioneStab, int userId) throws SQLException {
		PreparedStatement pst = db.prepareStatement("select * from upsert_registro_carico_seme (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
		int i = 0;
		
		pst.setInt(++i, id);
		pst.setInt(++i, idRegistro);
		pst.setString(++i, numRegistrazioneStab);
		pst.setInt(++i, userId);
		
		pst.setString(++i, dataProduzione);
		pst.setString(++i, codiceMittente);
		pst.setInt(++i, idSpecie);
		pst.setInt(++i, idRazza);
		pst.setString(++i, nomeCapo);
		pst.setString(++i, matricolaRiproduttoreMaschio);
		pst.setString(++i, identificazionePartita);
		pst.setInt(++i, idTipoSeme);
		pst.setInt(++i, dosiProdotte);
		pst.setInt(++i, dosiAcquistate);
		pst.setString(++i, documentoTrasportoEntrata);
		
		System.out.println("[REGISTRO CARICO SEME UPSERT] " + pst.toString());
		
		ResultSet rs = pst.executeQuery();
		
		if (rs.next())
			this.id = rs.getInt(1);
		
	}
	
	public void delete(Connection db, int userId) throws SQLException {
		PreparedStatement pst = db.prepareStatement("select * from delete_registro_carico_seme (?, ?);");
		int i = 0;
		
		pst.setInt(++i, id);
		pst.setInt(++i, userId);
		
		System.out.println("[REGISTRO CARICO SEME DELETE] " + pst.toString());
		
		ResultSet rs = pst.executeQuery();
		
		if (rs.next())
			this.id = rs.getInt(1);
		
	}
}
