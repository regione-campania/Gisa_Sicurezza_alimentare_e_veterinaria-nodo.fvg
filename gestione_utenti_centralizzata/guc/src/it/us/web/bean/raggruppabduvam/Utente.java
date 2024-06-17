package it.us.web.bean.raggruppabduvam;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



public class Utente {
	
	private static final long serialVersionUID = 2L;
	
	private String codiceFiscale = null;
	private String username = null;
	private int idAsl = -1;
	private String descrizioneAsl = null;
	private int idUtente = -1;
	private String sistema = null;
	private int idRuolo = -1;
	private String descrizioneRuolo = null;
	
	
	public Utente() {
	} 
	
	public Utente(ResultSet rs) throws SQLException {
		buildRecord(rs);
	}
	 
		private void buildRecord(ResultSet rs) throws SQLException {
			
			codiceFiscale = rs.getString("codice_fiscale");
			username = rs.getString("username");
			idAsl = rs.getInt("id_asl");
			descrizioneAsl = rs.getString("descrizione_asl");
			idUtente = rs.getInt("id_utente");
			sistema = rs.getString("sistema");
			idRuolo = rs.getInt("id_ruolo");
			descrizioneRuolo = rs.getString("descrizione_ruolo");
		}

		public String getCodiceFiscale() {
			return codiceFiscale;
		}

		public void setCodiceFiscale(String codiceFiscale) {
			this.codiceFiscale = codiceFiscale;
		}

		public String getUsername() {
			return username;
		}

		public void setUsername(String username) {
			this.username = username;
		}

		public int getIdAsl() {
			return idAsl;
		}

		public void setIdAsl(int idAsl) {
			this.idAsl = idAsl;
		}

		public String getDescrizioneAsl() {
			return descrizioneAsl;
		}

		public void setDescrizioneAsl(String descrizioneAsl) {
			this.descrizioneAsl = descrizioneAsl;
		}

		public int getIdUtente() {
			return idUtente;
		}

		public void setIdUtente(int idUtente) {
			this.idUtente = idUtente;
		}

		public String getSistema() {
			return sistema;
		}

		public void setSistema(String sistema) {
			this.sistema = sistema;
		}

		public int getIdRuolo() {
			return idRuolo;
		}

		public void setIdRuolo(int idRuolo) {
			this.idRuolo = idRuolo;
		}

		public String getDescrizioneRuolo() {
			return descrizioneRuolo;
		}

		public void setDescrizioneRuolo(String descrizioneRuolo) {
			this.descrizioneRuolo = descrizioneRuolo;
		}

		public static String raggruppa(Connection db, int utenteBDU, int utenteVAM, int ruoloBDU, int ruoloVAM, String usernameRIF) throws SQLException {
			// TODO Auto-generated method stub
			String esito = "";
			PreparedStatement pst = db.prepareStatement("select * from raggruppa_utente_vam_bdu_asl (?, ?, ?, ?, ?)");
			int i = 0;
			pst.setInt(++i, utenteBDU);
			pst.setInt(++i, ruoloBDU);
			pst.setInt(++i, utenteVAM);
			pst.setInt(++i, ruoloVAM);
			pst.setString(++i, usernameRIF);
			ResultSet rs = pst.executeQuery();
			if (rs.next())
				esito = rs.getString(1);
			return esito;
			
		}		

	
	
}

