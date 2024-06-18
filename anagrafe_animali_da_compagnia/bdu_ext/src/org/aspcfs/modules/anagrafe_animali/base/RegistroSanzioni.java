package org.aspcfs.modules.anagrafe_animali.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Logger;

import org.aspcfs.modules.admin.base.User;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.GestoreConnessioni;
import org.aspcfs.utils.web.PagedListInfo;

public class RegistroSanzioni 
{
	Logger logger = Logger.getLogger("MainLogger");

	private int idAnimale;

	private String microchip;
	private String microchipMadre;
	private int idAnimaleMadre;
	private String tatuaggio;
	private int idProprietario;
	private int idProprietarioProvenienza;
	private int idEvento;
	private int idAslProprietario;
	private int idAslCedente;
	private Timestamp dataInserimentoRegistrazione;
	private Timestamp dataRegistrazione;
	private String aslProprietario;
	private String aslCedente;
	private String tipologia;
	private String proprietario;
	private String proprietarioProvenienza;
	private String idCu;
	private String numeroSanzione;
	private PagedListInfo pagedListInfo = null;
	private Timestamp dataNascita;
	private Timestamp dataChiusura;
	private String utenteInserimento;
	private String utenteChiusura;
	private String razza;
	private boolean sanzioneCedente;
	private boolean sanzioneProprietario;	
	private String stato;
	private String soggettoSanzionato;
	private boolean statoApertura;
	private String soggettoSanzionatoCode;
	private String comuneProprietario;
	private String comuneCedente;
	
	public void setPagedListInfo(PagedListInfo tmp) {
		this.pagedListInfo = tmp;
	}
	public PagedListInfo getPagedListInfo() {
		return pagedListInfo;
	}
	
	public int getIdAnimale() {
		return idAnimale;
	}

	public void setIdAnimale(int idAnimale) {
		this.idAnimale = idAnimale;
	}
	
	public String getMicrochip() {
		return microchip;
	}

	public void setMicrochip(String microchip) {
		this.microchip = microchip;
	}
	
	public String getMicrochipMadre() {
		return microchipMadre;
	}

	public void setMicrochipMadre(String microchipMadre) {
		this.microchipMadre = microchipMadre;
	}

	public String getTatuaggio() {
		return tatuaggio;
	}

	public void setTatuaggio(String tatuaggio) {
		this.tatuaggio = tatuaggio;
	}
	
	public String getStato() {
		return stato;
	}

	public void setStato(String stato) {
		this.stato = stato;
	}
	
	public String getSoggettoSanzionato() {
		return soggettoSanzionato;
	}

	public void setSoggettoSanzionato(String soggettoSanzionato) {
		this.soggettoSanzionato = soggettoSanzionato;
	}
	
	public int getIdAnimaleMadre() {
		return idAnimaleMadre;
	}

	public void setIdAnimaleMadre(int idAnimaleMadre) {
		this.idAnimaleMadre = idAnimaleMadre;
	}

	public int getIdProprietarioProvenienza() {
		return idProprietarioProvenienza;
	}

	public void setIdProprietarioProvenienza(int idProprietarioProvenienza) {
		this.idProprietarioProvenienza = idProprietarioProvenienza;
	}
	
	public int getIdProprietario() {
		return idProprietario;
	}

	public void setIdProprietario(int idProprietario) {
		this.idProprietario = idProprietario;
	}
	
	public String getProprietario() {
		return proprietario;
	}

	public void setProprietario(String proprietario) {
		this.proprietario = proprietario;
	}
	
	public String getProprietarioProvenienza() {
		return proprietarioProvenienza;
	}

	public void setProprietarioProvenienza(String proprietarioProvenienza) {
		this.proprietarioProvenienza = proprietarioProvenienza;
	}

	public String getRazza() {
		return razza;
	}

	public void setRazza(String razza) {
		this.razza = razza;
	}

	public boolean getSanzioneCedente() {
		return sanzioneCedente;
	}

	public void setSanzioneCedente(boolean sanzioneCedente) {
		this.sanzioneCedente = sanzioneCedente;
	}
	
	public boolean getSanzioneProprietario() {
		return sanzioneProprietario;
	}

	public void setSanzioneProprietario(boolean sanzioneProprietario) {
		this.sanzioneProprietario = sanzioneProprietario;
	}
	
	public int getIdAslCedente() {
		return idAslCedente;
	}

	public void setIdAslCedente(int idAslCedente) {
		this.idAslCedente = idAslCedente;
	}

	public String getAslCedente() {
		return aslCedente;
	}

	public void setAslCedente(String aslCedente) {
		this.aslCedente = aslCedente;
	}
	
	public int getIdAslProprietario() {
		return idAslProprietario;
	}

	public void setIdAslProprietario(int idAslProprietario) {
		this.idAslProprietario = idAslProprietario;
	}

	public String getAslProprietario() {
		return aslProprietario;
	}

	public void setAslProprietario(String aslProprietario) {
		this.aslProprietario = aslProprietario;
	}

	public int getIdEvento() {
		return idEvento;
	}

	public void setIdEvento(int idEvento) {
		this.idEvento = idEvento;
	}
	
	public String getUtenteInserimento() {
		return utenteInserimento;
	}

	public void setUtenteInserimento(String utenteInserimento) {
		this.utenteInserimento = utenteInserimento;
	}
	
	public String getUtenteChiusura() {
		return utenteChiusura;
	}

	public void setUtenteChiusura(String utenteChiusura) {
		this.utenteChiusura = utenteChiusura;
	}

	public Timestamp getDataInserimentoRegistrazione() {
		return dataInserimentoRegistrazione;
	}

	public void setDataInserimentoRegistrazione(Timestamp dataInserimentoRegistrazione) {
		this.dataInserimentoRegistrazione = dataInserimentoRegistrazione;
	}
	
	public Timestamp getDataNascita() {
		return dataNascita;
	}

	public void setDataNascita(Timestamp dataNascita) {
		this.dataNascita = dataNascita;
	}
	
	public Timestamp getDataChiusura() {
		return dataChiusura;
	}

	public void setDataChiusura(Timestamp dataChiusura) {
		this.dataChiusura = dataChiusura;
	}

	public Timestamp getDataRegistrazione() {
		return dataRegistrazione;
	}

	public void setDataRegistrazione(Timestamp dataRegistrazione) {
		this.dataRegistrazione = dataRegistrazione;
	}

	public String getTipologia() {
		return tipologia;
	}

	public void setTipologia(String tipologia) {
		this.tipologia = tipologia;
	}

	public String getIdCu() {
		return idCu;
	}

	public void setIdCu(String idCu) {
		this.idCu = idCu;
	}
	
	public String getNumeroSanzione() {
		return numeroSanzione;
	}

	public void setNumeroSanzione(String numeroSanzione) {
		this.numeroSanzione = numeroSanzione;
	}
	
	
	
	public RegistroSanzioni(Connection db, int idEvento) throws SQLException 
	{
		PreparedStatement pst = db.prepareStatement("select * from registro_sanzioni_proprietari_cani where id_evento = ?");
		pst.setInt(1, idEvento);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst); 
		 if (rs.next())
		 {
			 buildRecord(rs, db);
		 }
	}

	public RegistroSanzioni(){}

	private void buildRecord(ResultSet rs, Connection db) throws SQLException 
	{
		this.aslProprietario =  rs.getString("asl_proprietario");
		this.aslCedente =  rs.getString("asl_cedente");
		this.dataInserimentoRegistrazione =  rs.getTimestamp("data_inserimento_registrazione");
		this.dataRegistrazione =  rs.getTimestamp("data_registrazione");
		this.idAnimale =  rs.getInt("id_animale");
		this.idAslProprietario =  rs.getInt("id_asl_proprietario");
		this.idAslCedente =  rs.getInt("id_asl_cedente");
		this.idCu =  rs.getString("id_cu");
		this.numeroSanzione =  rs.getString("numero_sanzione");
		this.idEvento =  rs.getInt("id_evento");
		this.idProprietario =  rs.getInt("id_proprietario");
		this.idProprietarioProvenienza =  rs.getInt("id_proprietario_provenienza");
		this.microchip =  rs.getString("microchip");
		this.proprietario = rs.getString("proprietario");
		this.tatuaggio =  rs.getString("tatuaggio");
		this.dataNascita =  rs.getTimestamp("data_nascita");
		this.utenteInserimento = rs.getString("utente_inserimento");
		this.razza = rs.getString("razza");
		this.dataChiusura =  rs.getTimestamp("data_chiusura");
		this.utenteChiusura = rs.getString("utente_chiusura");
		this.sanzioneCedente = rs.getBoolean("sanzione_cedente");
		this.sanzioneProprietario = rs.getBoolean("sanzione_proprietario");
		this.stato  = rs.getString("stato");
		this.soggettoSanzionato  = rs.getString("soggetto_sanzionato"); 
		this.proprietario  = rs.getString("proprietario"); 
		this.proprietarioProvenienza  = rs.getString("proprietario_provenienza");
		this.idAnimaleMadre  = rs.getInt("id_animale_madre");
		this.microchipMadre  = rs.getString("microchip_madre");
		this.statoApertura = rs.getBoolean("stato_apertura");
		this.soggettoSanzionatoCode = rs.getString("soggetto_sanzionato_code");
		this.comuneProprietario= rs.getString("comune_proprietario");
		this.comuneCedente= rs.getString("comune_proprietario_provenienza");

	}
	
	 public PreparedStatement prepareList(Connection db, int idAsl) throws SQLException {
		    ResultSet rs = null;
		    int items = -1;
		    StringBuffer sqlCount = new StringBuffer();
		    StringBuffer sqlSelect = new StringBuffer();
		    sqlCount.append(" select count(*) AS recordcount from get_registro_sanzioni(-1,?,'Tutti') ");
		    
		    if (pagedListInfo != null) 
		    {
		      PreparedStatement pst = db.prepareStatement(sqlCount.toString() );
		      pagedListInfo.doManualOffset(db, pst);
		      
		      pst.setInt(1, idAsl);
		      
		      rs = pst.executeQuery();
		      if (rs.next()) 
		      {
		        int maxRecords = rs.getInt("recordcount");
		        pagedListInfo.setMaxRecords(maxRecords);
		      }
		      rs.close();
		      pst.close();
		      if (!pagedListInfo.getCurrentLetter().equals("")) 
		      {
		        pst = db.prepareStatement(sqlCount.toString());
		        pst.setString(++items, pagedListInfo.getCurrentLetter().toLowerCase());
		        if (pagedListInfo != null) 
		        {
		          pagedListInfo.doManualOffset(db, pst);
		        }
		        rs = pst.executeQuery();
		        
		        if (rs.next()) 
		        {
		          int offsetCount = rs.getInt("recordcount");
		          pagedListInfo.setCurrentOffset(offsetCount);
		        }
		        rs.close();
		        pst.close();
		      }

		    } 
		    if (pagedListInfo != null) 
		    {
		      pagedListInfo.appendSqlSelectHead(db, sqlSelect);
		    } 
		    else 
		    {
		      sqlSelect.append("SELECT ");
		    }
		    sqlSelect.append(" * from get_registro_sanzioni(-1,?,'Tutti') ");
		    
		    
		    
		    PreparedStatement pst = db.prepareStatement(sqlSelect.toString() );
		    
		    pst.setInt(1, idAsl);
		    
		    return pst;
		  }
	
	
	
	
	
	public RegistroSanzioniList getRegistri(Connection db, int idAsl) throws SQLException 
	{
		RegistroSanzioniList registri = new RegistroSanzioniList();
		//PreparedStatement pst = db.prepareStatement(" select * from get_registro_unico_cani_aggressori(?,?) ");
		PreparedStatement pst =db.prepareStatement("select * from get_registro_sanzioni(-1,?,'Tutti') " );
		
		pst.setInt(1, idAsl);
		
		
		ResultSet rs = DatabaseUtils.executeQuery(db, pst );  
		 
		int count = 0;
		int inseriti = 0;
		while (rs.next())
		{
			count++;
			if( inseriti < pagedListInfo.getItemsPerPage() && count> pagedListInfo.getCurrentOffset())
			{
				RegistroSanzioni reg = new RegistroSanzioni();
				reg.buildRecord(rs, db);
				registri.add(reg);
				inseriti++;
			}
			
		}
		
		 pagedListInfo.setMaxRecords(count);
		 pagedListInfo.doManualOffset(db, pst);
	     
	      pagedListInfo.setCurrentOffset(pagedListInfo.getCurrentOffset());
	      pagedListInfo.appendSqlSelectHead(db,  new StringBuffer("select * from get_registro_sanzioni(-1,?,'Tutti') offset " +  pagedListInfo.getCurrentOffset() + " limit " + pagedListInfo.getItemsPerPage()));
		
		return registri;
			 
	}
	
	
	public RegistroSanzioni getRegistri(Connection db, Integer idAnimale) throws SQLException 
	{
		RegistroSanzioni reg = null;
		PreparedStatement pst = prepareList(db,-1);
		
		pst = db.prepareStatement(" select * from get_registro_sanzioni(?,null,'Tutti') ");
		pst.setInt(1, idAnimale);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst );  
		 
		if (rs.next())
		{
			reg = new RegistroSanzioni();
			reg.buildRecord(rs, db);
		}
		
		return reg;
			 
	}
	
	public int getCountRegistri(Connection db, Integer idAsl) throws SQLException 
	{
		RegistroSanzioni reg = null;
		//PreparedStatement pst = prepareList(db,-1);
		
		PreparedStatement pst = db.prepareStatement(" select count(*) AS recordcount from get_registro_sanzioni(-1,?,'Aperta') ");
		pst.setInt(1, idAsl);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst );  
		 
		rs.next();
		return rs.getInt(1);
	}
	
	
	
	
	
	public boolean esisteRegistroSanzione(Connection db, int idAnimale, boolean soggettoSanzionatoCedente,boolean privoTracciabilita, boolean fuoriNazione) throws SQLException 
	{
		PreparedStatement pst = db.prepareStatement(" select * from esiste_registro_sanzione(?) ");
		pst.setInt(1, idAnimale);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst );  
		 
		if(rs.next())
		{
			if(soggettoSanzionatoCedente)
				return rs.getBoolean(1);
			else if(privoTracciabilita)
				return rs.getBoolean(2)==true && rs.getBoolean(3)==true ;
			else 
				return rs.getBoolean(2) && rs.getBoolean(4);
		}
		else
			return false;
	}
	
	public boolean[] esisteRegistroSanzione(Connection db, int idAnimale) throws SQLException 
	{
		PreparedStatement pst = db.prepareStatement(" select * from esiste_registro_sanzione(?) ");
		pst.setInt(1, idAnimale);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst );  
		 
		boolean toreturn[] = { false,false,false };
		
		if(rs.next())
		{
			toreturn[0] = rs.getBoolean(1);
			toreturn[1] = rs.getBoolean(2)==true && rs.getBoolean(3)==true ;
			toreturn[2] = rs.getBoolean(2) && rs.getBoolean(4);
		}
		
		return toreturn;
	}
	
	public void chiudiSanzione(Connection db, int idEvento,int User) throws SQLException 
	{
		
		PreparedStatement pst = db.prepareStatement(" update evento_registrazione_bdu set data_chiusura_sanzione=now(),utente_chiusura_sanzione=? where id_evento=?");
		pst.setInt(1, User);
		pst.setInt(2, idEvento);
		pst.execute();
		//System.out.println("QUERY REGISTRO DEBUG: "+pst);
		
	}
	
	
	public void aggiornaRegistro(Connection db, int idAnimale) throws SQLException 
	{
		
		PreparedStatement pst = db.prepareStatement(" select * from update_registro_sanzioni_proprietari_cani(?) ");
		pst.setInt(1, idAnimale);
		pst.execute();
		
	}
	
	
	public boolean isStatoApertura() {
		return statoApertura;
	}
	public void setStatoApertura(boolean statoApertura) {
		this.statoApertura = statoApertura;
	}
	public String getSoggettoSanzionatoCode() {
		return soggettoSanzionatoCode;
	}
	public void setSoggettoSanzionatoCode(String soggettoSanzionatoCode) {
		this.soggettoSanzionatoCode = soggettoSanzionatoCode;
	}
	public String getComuneProprietario() {
		return comuneProprietario;
	}
	public void setComuneProprietario(String comuneProprietario) {
		this.comuneProprietario = comuneProprietario;
	}
	public String getComuneCedente() {
		return comuneCedente;
	}
	public void setComuneCedente(String comuneCedente) {
		this.comuneCedente = comuneCedente;
	}
	
	
}


 


	

