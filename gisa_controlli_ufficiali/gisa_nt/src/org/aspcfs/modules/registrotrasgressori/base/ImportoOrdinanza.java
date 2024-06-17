package org.aspcfs.modules.registrotrasgressori.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

public class ImportoOrdinanza {
	
	Logger logger = Logger.getLogger("MainLogger");

	private int id = -1;
	private int idSanzione = -1;
	private int numeroRate = -1;
	private String dataNotifica = null;
	private String importoTotaleVersamento = "0.0";

	public ImportoOrdinanza(){
		
	}
	

	public ImportoOrdinanza(Connection db, int idSanzione, int idPagatore) throws SQLException {
		PreparedStatement pst = db.prepareStatement("select * from pagopa_sanzioni_importo_ordinanza where id_sanzione = ? and trashed_date is null");
		pst.setInt(1, idSanzione);
		ResultSet rs = pst.executeQuery();
		if (rs.next()){
			buildRecord(rs);
		}
		
	}


	private void buildRecord(ResultSet rs) throws SQLException {
		this.id= rs.getInt("id");
		this.idSanzione=  rs.getInt("id_sanzione");
		this.numeroRate=rs.getInt("numero_rate");
		this.importoTotaleVersamento=rs.getString("importo_totale_versamento");
		this.dataNotifica=rs.getString("data_notifica");

		}


	public Logger getLogger() {
		return logger;
	}


	public void setLogger(Logger logger) {
		this.logger = logger;
	}



	public static void insert(Connection db, int idSanzione, String importoTotaleVersamento, int numeroRate, String dataNotifica, boolean principale, int userId) throws SQLException {
		
		PreparedStatement pst = db.prepareStatement("insert into pagopa_sanzioni_importo_ordinanza(id_sanzione, importo_totale_versamento, numero_rate, data_notifica, principale, enteredby) values (?, ?, ?, ?, ?, ?);");

		int i = 0;

		pst.setInt(++i, idSanzione);
		pst.setString(++i, importoTotaleVersamento);
		pst.setInt(++i, numeroRate);
		pst.setString(++i, dataNotifica);
		pst.setBoolean(++i, principale);
		pst.setInt(++i, userId);
		pst.executeUpdate();
		
	}
	
	public static void delete(Connection db, int idSanzione) throws SQLException {
		
		PreparedStatement pst = db.prepareStatement("update pagopa_sanzioni_importo_ordinanza set trashed_date = now() where id_sanzione = ? and trashed_date is null;");

		int i = 0;

		pst.setInt(++i, idSanzione);
		
		pst.executeUpdate();
		
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getIdSanzione() {
		return idSanzione;
	}


	public void setIdSanzione(int idSanzione) {
		this.idSanzione = idSanzione;
	}


	public int getNumeroRate() {
		return numeroRate;
	}


	public void setNumeroRate(int numeroRate) {
		this.numeroRate = numeroRate;
	}


	public String getDataNotifica() {
		return dataNotifica;
	}


	public void setDataNotifica(String dataNotifica) {
		this.dataNotifica = dataNotifica;
	}


	public String getImportoTotaleVersamento() {
		return importoTotaleVersamento;
	}


	public void setImportoTotaleVersamento(String importoTotaleVersamento) {
		this.importoTotaleVersamento = importoTotaleVersamento;
	}

	public static void updatePossibilitaRigenera (Connection db, int idSanzione, boolean possibilitaRigenera, int userId) throws SQLException {
		PreparedStatement pst = db.prepareStatement("update pagopa_sanzioni_importo_ordinanza set possibilita_rigenera = ? where id_sanzione = ? and trashed_date is null and principale");
		pst.setBoolean(1, possibilitaRigenera);
		pst.setInt(2, idSanzione);
		pst.executeUpdate();
		
	}
}


