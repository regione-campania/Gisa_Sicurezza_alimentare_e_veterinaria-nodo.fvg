package org.aspcfs.modules.izsmibr.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

public class GisaDsEsitoIBRA  {


	private DsESITOIBRIUS record;
	private String esito_invio ;
	private String tracciato_record_richiesta ;
	private String tracciato_record_risposta ;
	private Timestamp data_invio_bdn ;
	private String errore ;
	
	
	public DsESITOIBRIUS getRecord() {
		return record;
	}
	public void setRecord(DsESITOIBRIUS record) {
		this.record = record;
	}
	public String getEsito_invio() {
		return esito_invio;
	}
	public void setEsito_invio(String esito_invio) {
		this.esito_invio = esito_invio;
	}
	public String getTracciato_record_richiesta() {
		return tracciato_record_richiesta;
	}
	public void setTracciato_record_richiesta(String tracciato_record_richiesta) {
		this.tracciato_record_richiesta = tracciato_record_richiesta;
	}
	public String getTracciato_record_risposta() {
		return tracciato_record_risposta;
	}
	public void setTracciato_record_risposta(String tracciato_record_risposta) {
		this.tracciato_record_risposta = tracciato_record_risposta;
	}
	public Timestamp getData_invio_bdn() {
		return data_invio_bdn;
	}
	public void setData_invio_bdn(Timestamp data_invio_bdn) {
		this.data_invio_bdn = data_invio_bdn;
	}
	public String getErrore() {
		return errore;
	}
	public void setErrore(String errore) {
		this.errore = errore;
	}
	
	
	 public void insert(Connection db,int idInvioMassivo) throws SQLException
	    {
	    	
	    	try
	    	{
	    		
	    	
	    		
	    		PreparedStatement pst = db.prepareStatement("INSERT INTO import_ibr "
	    				+ "(ID_INVIO_MASSIVO_IBR,P_CODICE_ISTITUTO,P_CODICE_SEDE_DIAGNOSTICA,P_CODICE_PRELIEVO,"
	    				+ "P_ANNO_ACCETTAZIONE,P_NUMERO_ACCETTAZIONE,P_CODICE_AZIENDA,"+
	    				"P_ID_FISCALE_PROPRIETARIO,P_SPECIE_ALLEVATA,P_CODICE_CAPO,"
	    				+ "P_DATA_PRELIEVO,P_DATA_ESITO,P_ESITO_QUALITATIVO,esito_invio,tracciato_record_richiesta,tracciato_record_risposta,errore,data_invio_bdn,p_eibr_id,P_ANNO_CAMPAGNA"
	    				+ ") VALUES"
	    				+ "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,current_timestamp,?,?)");
	    		int i = 0 ;
	    		pst.setInt(++i, idInvioMassivo);
	    		pst.setString(++i, record.parameterslist.get(0).getPCODICEISTITUTO());
	    		pst.setString(++i, record.parameterslist.get(0).getPCODICESEDEDIAGNOSTICA());
	    		pst.setString(++i, record.parameterslist.get(0).getPCODICEPRELIEVO());
	    		pst.setString(++i, record.parameterslist.get(0).getPANNOACCETTAZIONE().toString());
	    		pst.setString(++i, record.parameterslist.get(0).getPNUMEROACCETTAZIONE());
	    		pst.setString(++i, record.parameterslist.get(0).getPCODICEAZIENDA());
	    		pst.setString(++i, record.parameterslist.get(0).getPIDFISCALEPROPRIETARIO());
	    		pst.setString(++i, record.parameterslist.get(0).getPSPECIEALLEVATA());
	    		pst.setString(++i, record.parameterslist.get(0).getPCODICECAPO());
	    		pst.setString (++i, record.parameterslist.get(0).getPDATAPRELIEVO().toString());
	    		pst.setString(++i, record.parameterslist.get(0).getPDATAESITO().toString());
	    		pst.setString(++i, record.parameterslist.get(0).getPESITOQUALITATIVO());
	    		pst.setString(++i, this.getEsito_invio());
	    		pst.setString(++i, this.getTracciato_record_richiesta());
	    		pst.setString(++i, this.getTracciato_record_risposta());
	    		pst.setString(++i, this.getErrore());
	    		pst.setBigDecimal(++i, record.parameterslist.get(0).getPEIBRID());
	    		pst.setString(++i, record.parameterslist.get(0).getPANNOACCETTAZIONE().toString());


	    		pst.execute();
	    		
	    	}
	    	catch(SQLException e)
	    	{
	    		throw e ;
	    	}
	    }
	
	
}
