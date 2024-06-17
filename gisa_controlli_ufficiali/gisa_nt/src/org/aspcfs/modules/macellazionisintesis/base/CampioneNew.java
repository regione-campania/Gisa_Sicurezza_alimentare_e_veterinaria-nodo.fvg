package org.aspcfs.modules.macellazionisintesis.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.darkhorseventures.framework.beans.GenericBean;

public class CampioneNew extends GenericBean
{
	private static final long serialVersionUID = 8313006891554941893L;

	private int id;
	private int idCampione;
	private int idCapo;
	private String matricola;
	private int idMacello;
	private String dataPrelievo;
	private String numeroVerbale;
	private int	idMotivo;
	private String descrizioneMotivo;
	private int	idPiano;
	private String descrizionePiano;
	private int	idMatrice;
	private String descrizioneMatrice;
	private String	tipoAnalisi;
	private String descrizioneAnalisi;
	private int 		idLaboratorio;
	private String descrizioneLaboratorio;
	private String		note;

	public CampioneNew(ResultSet res) throws SQLException {
		buildRecord(res);
	}

	public CampioneNew() {
		// TODO Auto-generated constructor stub
	}

	public static void aggiornaCampioniCapo(Connection db, int idCapo, String matricola, String[] idCampioni, int idUtente) throws SQLException {
		String listaCampioni = "";
		
		for (int i = 0; i<idCampioni.length; i++){
			if (i>0)
				listaCampioni+=",";
			listaCampioni+=idCampioni[i];
		}
			
		PreparedStatement pst = db.prepareStatement("select * from aggiorna_campioni_vpm_new(?, ?, ?, ?)");
		int i = 0;
		pst.setInt(++i, idCapo);
		pst.setString(++i, matricola);
		pst.setString(++i, listaCampioni);
		pst.setInt(++i, idUtente);
		ResultSet rs = pst.executeQuery();
		
	}
	
	public String insert(Connection db, int idUtente) throws SQLException{

		String jsonResult = "";
		
			PreparedStatement pst = db.prepareStatement("select * from insert_campione_vpm_new(?::integer, ?::integer, ?::text, ?::text, ?::text, ?::integer, ?::integer, ?::integer, ?::text, ?::integer, ?::text, ?::integer);");
			int j = 0;
			pst.setInt(++j, idCapo);
			pst.setInt(++j, idMacello);
			pst.setString(++j, matricola);
			pst.setString(++j, dataPrelievo);
			pst.setString(++j, numeroVerbale);
			pst.setInt(++j, idMotivo);
			pst.setInt(++j, idPiano);
			pst.setInt(++j, idMatrice);
			pst.setString(++j, tipoAnalisi);
			pst.setInt(++j, idLaboratorio);
			pst.setString(++j, note);
			pst.setInt(++j, idUtente);
			
			ResultSet rs = pst.executeQuery();
			if (rs.next()){
				jsonResult = rs.getString(1);
			}
			return jsonResult;
	
	}

	

	public static ArrayList<CampioneNew> load(Connection db, int idCapo ) throws SQLException
	{

		ArrayList<CampioneNew>	ret		= new ArrayList<CampioneNew>();
		PreparedStatement			stat	= null;
		ResultSet					res		= null;
	
			stat	= db.prepareStatement( "SELECT * FROM get_vpm_campioni_new(?)" );
			stat.setInt( 1, idCapo );
			res		= stat.executeQuery();
			while( res.next() )
			{
				CampioneNew c = new CampioneNew(res);
				ret.add(c);
			}
		
		
		return ret;
	
	}

	private void buildRecord(ResultSet rs) throws SQLException {
		id = rs.getInt("id");
		idCampione = rs.getInt("id_campione");
		idCapo = rs.getInt("id_capo");
		matricola = rs.getString("matricola");
		idMacello = rs.getInt("id_macello");
		dataPrelievo = rs.getString("data_prelievo");
		numeroVerbale = rs.getString("numero_verbale");
		idMotivo = rs.getInt("id_motivo");
		descrizioneMotivo = rs.getString("descrizione_motivo");
		idPiano = rs.getInt("id_piano");
		descrizionePiano = rs.getString("descrizione_piano");
		idMatrice = rs.getInt("id_matrice");
		descrizioneMatrice = rs.getString("descrizione_matrice");
		tipoAnalisi = rs.getString("tipo_analisi");
		descrizioneAnalisi = rs.getString("descrizione_analisi");
		idLaboratorio = rs.getInt("id_laboratorio");
		descrizioneLaboratorio = rs.getString("descrizione_laboratorio");
		note = rs.getString("note");		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdCapo() {
		return idCapo;
	}

	public void setIdCapo(int idCapo) {
		this.idCapo = idCapo;
	}

	public String getMatricola() {
		return matricola;
	}

	public void setMatricola(String matricola) {
		this.matricola = matricola;
	}

	public int getIdMacello() {
		return idMacello;
	}

	public void setIdMacello(int idMacello) {
		this.idMacello = idMacello;
	}

	public String getDataPrelievo() {
		return dataPrelievo;
	}

	public void setDataPrelievo(String dataPrelievo) {
		this.dataPrelievo = dataPrelievo;
	}

	public String getNumeroVerbale() {
		return numeroVerbale;
	}

	public void setNumeroVerbale(String numeroVerbale) {
		this.numeroVerbale = numeroVerbale;
	}

	public int getIdMotivo() {
		return idMotivo;
	}

	public void setIdMotivo(int idMotivo) {
		this.idMotivo = idMotivo;
	}

	public String getDescrizioneMotivo() {
		return descrizioneMotivo;
	}

	public void setDescrizioneMotivo(String descrizioneMotivo) {
		this.descrizioneMotivo = descrizioneMotivo;
	}

	public int getIdMatrice() {
		return idMatrice;
	}

	public void setIdMatrice(int idMatrice) {
		this.idMatrice = idMatrice;
	}

	public String getDescrizioneMatrice() {
		return descrizioneMatrice;
	}

	public void setDescrizioneMatrice(String descrizioneMatrice) {
		this.descrizioneMatrice = descrizioneMatrice;
	}

	public String getTipoAnalisi() {
		return tipoAnalisi;
	}

	public void setTipoAnalisi(String tipoAnalisi) {
		this.tipoAnalisi = tipoAnalisi;
	}

	public String getDescrizioneAnalisi() {
		return descrizioneAnalisi;
	}

	public void setDescrizioneAnalisi(String descrizioneAnalisi) {
		this.descrizioneAnalisi = descrizioneAnalisi;
	}

	public int getIdLaboratorio() {
		return idLaboratorio;
	}

	public void setIdLaboratorio(int idLaboratorio) {
		this.idLaboratorio = idLaboratorio;
	}

	public String getDescrizioneLaboratorio() {
		return descrizioneLaboratorio;
	}

	public void setDescrizioneLaboratorio(String descrizioneLaboratorio) {
		this.descrizioneLaboratorio = descrizioneLaboratorio;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public int getIdCampione() {
		return idCampione;
	}

	public void setIdCampione(int idCampione) {
		this.idCampione = idCampione;
	}

	public int getIdPiano() {
		return idPiano;
	}

	public void setIdPiano(int idPiano) {
		this.idPiano = idPiano;
	}

	public String getDescrizionePiano() {
		return descrizionePiano;
	}

	public void setDescrizionePiano(String descrizionePiano) {
		this.descrizionePiano = descrizionePiano;
	}

	public void buildFromIdCampione(Connection db, Integer idCampione) throws SQLException {

		PreparedStatement			pst	= null;
		ResultSet					rs		= null;
		pst	= db.prepareStatement( "SELECT * FROM get_vpm_campioni_new((SELECT id_capo FROM m_vpm_campioni_new where id_campione = ? and trashed_date is null))" );
		pst.setInt( 1, idCampione );
		rs		= pst.executeQuery();
		if( rs.next() )
			{
				buildRecord(rs);
			}
				
	}
	

}
