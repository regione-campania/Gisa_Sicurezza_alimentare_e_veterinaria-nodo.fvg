package org.aspcfs.modules.registrocaricoscarico.base.recapiti;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.darkhorseventures.framework.actions.ActionContext;

public class CaricoRecapiti {

	private int id = -1;
	private int idRegistro = -1;
	private Timestamp entered = null;
	private int enteredBy= -1;
	private String noteHd = null;
	private Timestamp trashedDate = null;
	private int trashedBy= -1;

	private int indice = -1;

	private String numRegistrazione = null;
	private String dataRegistrazioneEntrata = null;
	private String codiceMittente = null;
	private int idSpecie = -1;
	private int idRazza = -1;
	private String nomeCapo = null;
	private String matricolaRiproduttoreMaschio = null;
	private String matricolaRiproduttoreFemmina = null;
	private String identificazionePartita = null;
	private int idTipoSeme = -1;
	private int dosiAcquistate = 0;
	private String documentoCommercialeEntrata = null;

	private ArrayList<ScaricoRecapiti> listaScarico = new ArrayList<ScaricoRecapiti>();
	
	public CaricoRecapiti() {
	}
	
	public CaricoRecapiti(ResultSet rs) throws SQLException {
		buildRecord(rs);
	}
	
	
	public CaricoRecapiti(ActionContext context) {
		this.id = Integer.parseInt(context.getRequest().getParameter("idCarico")); 
		this.idRegistro = Integer.parseInt(context.getRequest().getParameter("idRegistro"));

		this.numRegistrazione = context.getRequest().getParameter("numRegistrazione");
		
		this.dataRegistrazioneEntrata = context.getRequest().getParameter("dataRegistrazioneEntrata");
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
		this.matricolaRiproduttoreFemmina = context.getRequest().getParameter("matricolaRiproduttoreFemmina");

		this.identificazionePartita = context.getRequest().getParameter("identificazionePartita");

		try { this.idTipoSeme = Integer.parseInt(context.getRequest().getParameter("idTipoSeme")); } catch (Exception e){}
		try { this.dosiAcquistate = Integer.parseInt(context.getRequest().getParameter("dosiAcquistate")); } catch (Exception e){}
	
		this.documentoCommercialeEntrata = context.getRequest().getParameter("documentoCommercialeEntrata");

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
		this.dataRegistrazioneEntrata = rs.getString("data_registrazione_entrata");
		this.codiceMittente = rs.getString("codice_mittente");
		this.idSpecie = rs.getInt("id_specie");
		this.idRazza = rs.getInt("id_razza");
		this.nomeCapo = rs.getString("nome_capo");
		this.matricolaRiproduttoreMaschio = rs.getString("matricola_riproduttore_maschio");
		this.matricolaRiproduttoreFemmina = rs.getString("matricola_riproduttore_femmina");
		this.identificazionePartita = rs.getString("identificazione_partita");
		this.idTipoSeme = rs.getInt("id_tipo_seme");
		this.dosiAcquistate = rs.getInt("dosi_acquistate");
		this.documentoCommercialeEntrata = rs.getString("documento_commerciale_entrata");

	}

	public static ArrayList<CaricoRecapiti> getListaCarico(Connection db, int idRegistro) throws SQLException {
		ArrayList<CaricoRecapiti> lista = new ArrayList<CaricoRecapiti>(); 
		PreparedStatement pst = db.prepareStatement("select * from registro_carico_recapito where id_registro = ? and enabled and trashed_date is null order by indice asc"); 
		pst.setInt(1, idRegistro);
		ResultSet rs = pst.executeQuery();  
		while (rs.next()){
			CaricoRecapiti carico = new CaricoRecapiti(rs);
			ArrayList<ScaricoRecapiti> scarico = new ArrayList<ScaricoRecapiti>();
			scarico = ScaricoRecapiti.getListaScarico(db, carico.getId()); 
			carico.setListaScarico(scarico);
			lista.add(carico);
		}
		return lista;
	}
	
	public CaricoRecapiti(Connection db, int id) throws SQLException {
		
		PreparedStatement pst = db.prepareStatement("select * from registro_carico_recapito where id = ? and trashed_date is null");
		pst.setInt(1, id);
		
		ResultSet rs = pst.executeQuery();
		
		if (rs.next()){
			buildRecord(rs);
			
			ArrayList<ScaricoRecapiti> scarico = ScaricoRecapiti.getListaScarico(db, id); 
			setListaScarico(scarico);
		}
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdRegistro() {
		return idRegistro;
	}

	public void setIdRegistro(int idRegistro) {
		this.idRegistro = idRegistro;
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

	public String getNumRegistrazione() {
		return numRegistrazione;
	}

	public void setNumRegistrazione(String numRegistrazione) {
		this.numRegistrazione = numRegistrazione;
	}

	public String getDataRegistrazioneEntrata() {
		return dataRegistrazioneEntrata;
	}

	public void setDataRegistrazioneEntrata(String dataRegistrazioneEntrata) {
		this.dataRegistrazioneEntrata = dataRegistrazioneEntrata;
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

	public String getNomeCapo() {
		return nomeCapo;
	}

	public void setNomeCapo(String nomeCapo) {
		this.nomeCapo = nomeCapo;
	}

	public String getMatricolaRiproduttoreMaschio() {
		return matricolaRiproduttoreMaschio;
	}

	public void setMatricolaRiproduttoreMaschio(String matricolaRiproduttoreMaschio) {
		this.matricolaRiproduttoreMaschio = matricolaRiproduttoreMaschio;
	}

	public String getMatricolaRiproduttoreFemmina() {
		return matricolaRiproduttoreFemmina;
	}

	public void setMatricolaRiproduttoreFemmina(String matricolaRiproduttoreFemmina) {
		this.matricolaRiproduttoreFemmina = matricolaRiproduttoreFemmina;
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

	public int getDosiAcquistate() {
		return dosiAcquistate;
	}

	public void setDosiAcquistate(int dosiAcquistate) {
		this.dosiAcquistate = dosiAcquistate;
	}

	public String getDocumentoCommercialeEntrata() {
		return documentoCommercialeEntrata;
	}

	public void setDocumentoCommercialeEntrata(String documentoCommercialeEntrata) {
		this.documentoCommercialeEntrata = documentoCommercialeEntrata;
	}

	public ArrayList<ScaricoRecapiti> getListaScarico() {
		return listaScarico;
	}

	public void setListaScarico(ArrayList<ScaricoRecapiti> listaScarico) {
		this.listaScarico = listaScarico;
	}

	public void upsert(Connection db, String numRegistrazioneStab, int userId) throws SQLException {
		PreparedStatement pst = db.prepareStatement("select * from upsert_registro_carico_recapiti (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
		int i = 0;
		
		pst.setInt(++i, id);
		pst.setInt(++i, idRegistro);
		pst.setString(++i, numRegistrazioneStab);
		pst.setInt(++i, userId);
		
		pst.setString(++i, dataRegistrazioneEntrata);
		pst.setString(++i, codiceMittente);
		pst.setInt(++i, idSpecie);
		pst.setInt(++i, idRazza);
		pst.setString(++i, nomeCapo);
		pst.setString(++i, matricolaRiproduttoreMaschio);
		pst.setString(++i, matricolaRiproduttoreFemmina);
		pst.setString(++i, identificazionePartita);
		pst.setInt(++i, idTipoSeme);
		pst.setInt(++i, dosiAcquistate);
		pst.setString(++i, documentoCommercialeEntrata);

		System.out.println("[REGISTRO CARICO RECAPITI UPSERT] " + pst.toString());
		
		ResultSet rs = pst.executeQuery();
		
		if (rs.next())
			this.id = rs.getInt(1);
		}
	
	public void delete(Connection db, int userId) throws SQLException {
		PreparedStatement pst = db.prepareStatement("select * from delete_registro_carico_recapiti (?, ?);");
		int i = 0;
		
		pst.setInt(++i, id);
		pst.setInt(++i, userId);
		
		System.out.println("[REGISTRO CARICO RECAPITI DELETE] " + pst.toString());
		
		ResultSet rs = pst.executeQuery();
		
		if (rs.next())
			this.id = rs.getInt(1);
		
	}
}
