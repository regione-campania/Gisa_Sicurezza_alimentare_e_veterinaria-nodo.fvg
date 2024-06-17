package org.aspcfs.modules.gestoriacquenew.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

public class StoricoImport {
	
	private int id;
	private int idUtente;
	private String nomeFile;
	private String nomeFileCompleto;
	private String codDocumento;
	private String tipoRichiesta;
	private Timestamp dataImport;
	private int gestoreAcque;
	private String nomeGestoreAcque;
	private String erroreInsert;
	private String erroreParsingFile;
	private Boolean esito;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getGestoreAcque() 
	{
		return gestoreAcque;
	}
	public void setGestoreAcque(int gestoreAcque) 
	{
		this.gestoreAcque = gestoreAcque;
	}
	public String getNomeGestoreAcque() 
	{
		return nomeGestoreAcque;
	}
	public void setNomeGestoreAcque(String nomeGestoreAcque) 
	{
		this.nomeGestoreAcque = nomeGestoreAcque;
	}
	public int getIdUtente() {
		return idUtente;
	}
	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
	}
	public String getNomeFile() {
		return nomeFile;
	}
	public void setNomeFile(String nomeFile) {
		this.nomeFile = nomeFile;
	}
	public String getNomeFileCompleto() {
		return nomeFileCompleto;
	}
	public void setNomeFileCompleto(String nomeFileCompleto) {
		this.nomeFileCompleto = nomeFileCompleto;
	}
	public String getCodDocumento() {
		return codDocumento;
	}
	public void setCodDocumento(String codDocumento) {
		this.codDocumento = codDocumento;
	}
	public String getTipoRichiesta() {
		return tipoRichiesta;
	}
	public void setTipoRichiesta(String tipoRichiesta) {
		this.tipoRichiesta = tipoRichiesta;
	}
	
	public Timestamp getDataImport() {
		return dataImport;
	}
	public void setDataImport(Timestamp dataImport) {
		this.dataImport = dataImport;
	}
	
	public String getErroreInsert() {
		return erroreInsert;
	}
	public void setErroreInsert(String erroreInsert) {
		this.erroreInsert = erroreInsert;
	}
	public String getErroreParsingFile() {
		return erroreParsingFile;
	}
	public void setErroreParsingFile(String erroreParsingFile) {
		this.erroreParsingFile = erroreParsingFile;
	}
	
	public ArrayList<StoricoImport> getAll(Connection conn) throws GestoreNotFoundException, Exception
	{
		ArrayList<StoricoImport> storicoImport = new ArrayList<>();
		PreparedStatement pst = null;
		ResultSet rs = null;
			
		pst = conn.prepareStatement("select * from gestori_acque_log_import order by data_import desc ");
		rs = pst.executeQuery();
		while(rs.next())
		{
			StoricoImport storicoTemp = new StoricoImport();
			storicoTemp.setId(rs.getInt("id"));
			storicoTemp.setIdUtente(rs.getInt("id_utente"));
			storicoTemp.setDataImport(rs.getTimestamp("data_import"));
			storicoTemp.setNomeFile(rs.getString("nome_file"));
			storicoTemp.setTipoRichiesta(rs.getString("tipo_richiesta"));
			storicoTemp.setNomeFileCompleto(rs.getString("nome_file_completo"));
			storicoTemp.setGestoreAcque(rs.getInt("gestore_acque"));
			storicoTemp.setErroreInsert(rs.getString("errore_insert"));
			storicoTemp.setErroreParsingFile(rs.getString("errore_parsing_file"));
			storicoTemp.setNomeGestoreAcque(new GestoreAcque(storicoTemp.getGestoreAcque(), conn).getNome());
			storicoImport.add(storicoTemp);
		}
		return storicoImport;
	}
	
	public ArrayList<StoricoImport> getStoricoUtente(Connection conn, int idUtente) throws GestoreNotFoundException, Exception
	{
		ArrayList<StoricoImport> storicoImport = new ArrayList<>();
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		if(idUtente != -1){
			pst = conn.prepareStatement("select * from gestori_acque_log_import where id_utente = ? order by data_import desc ");
			pst.setInt(1, idUtente);
		}else{
			pst = conn.prepareStatement("select * from gestori_acque_log_import where data_import > current_date - 365 order by data_import desc ");
		}
		rs = pst.executeQuery();
		while(rs.next())
		{
			StoricoImport storicoTemp = new StoricoImport();
			storicoTemp.setId(rs.getInt("id"));
			storicoTemp.setIdUtente(rs.getInt("id_utente"));
			storicoTemp.setDataImport(rs.getTimestamp("data_import"));
			storicoTemp.setNomeFile(rs.getString("nome_file"));
			storicoTemp.setTipoRichiesta(rs.getString("tipo_richiesta"));
			storicoTemp.setNomeFileCompleto(rs.getString("nome_file_completo"));
			storicoTemp.setGestoreAcque(rs.getInt("gestore_acque"));
			storicoTemp.setCodDocumento(rs.getString("cod_documento"));
			storicoTemp.setErroreInsert(rs.getString("errore_insert"));
			storicoTemp.setErroreParsingFile(rs.getString("errore_parsing_file"));
			storicoTemp.setNomeGestoreAcque(new GestoreAcque(storicoTemp.getGestoreAcque(), conn).getNome());
			storicoImport.add(storicoTemp);
		}
		return storicoImport;
	}
	
	public StoricoImport getStorico(Connection conn,int id) throws GestoreNotFoundException, Exception
	{
		StoricoImport storicoTemp = new StoricoImport();
		PreparedStatement pst = null;
		ResultSet rs = null;
			
		pst = conn.prepareStatement("select * from gestori_acque_log_import where id = ? order by data_import desc ");
		pst.setInt(1, id);
		rs = pst.executeQuery();
		while(rs.next())
		{
			storicoTemp.setId(rs.getInt("id"));
			storicoTemp.setIdUtente(rs.getInt("id_utente"));
			storicoTemp.setDataImport(rs.getTimestamp("data_import"));
			storicoTemp.setNomeFile(rs.getString("nome_file"));
			storicoTemp.setTipoRichiesta(rs.getString("tipo_richiesta"));
			storicoTemp.setNomeFileCompleto(rs.getString("nome_file_completo"));
			storicoTemp.setGestoreAcque(rs.getInt("gestore_acque"));
			storicoTemp.setErroreInsert(rs.getString("errore_insert"));
			storicoTemp.setErroreParsingFile(rs.getString("errore_parsing_file"));
			storicoTemp.setNomeGestoreAcque(new GestoreAcque(storicoTemp.getGestoreAcque(), conn).getNome());
		}
		return storicoTemp;
	}
	
	
}
