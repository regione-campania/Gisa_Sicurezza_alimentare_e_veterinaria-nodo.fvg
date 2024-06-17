package com.anagrafica_noscia.prototype.masterlist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

public class Aggregazione {
	
	public String getAggregazione() {
		return aggregazione;
	}
	public void setAggregazione(String aggregazione) {
		this.aggregazione = aggregazione;
	}
	public Integer getIdAggregazione() {
		return idAggregazione;
	}
	public void setIdAggregazione(Integer idAggregazione) {
		this.idAggregazione = idAggregazione;
	}
	public String getCodiceAttivitaAggregazione() {
		return codiceAttivitaAggregazione;
	}
	public void setCodiceAttivitaAggregazione(String codiceAttivitaAggregazione) {
		this.codiceAttivitaAggregazione = codiceAttivitaAggregazione;
	}
	public Integer getIdFlussoOriginaleAggregazione() {
		return idFlussoOriginaleAggregazione;
	}
	public void setIdFlussoOriginaleAggregazione(Integer idFlussoOriginaleAggregazione) {
		this.idFlussoOriginaleAggregazione = idFlussoOriginaleAggregazione;
	}
	public Integer getIdMacroarea(){return this.idMacroarea;}
	public void setIdMacroarea(Integer idMacroarea){this.idMacroarea = idMacroarea;}
	
	private String aggregazione;
	private Integer idAggregazione;
	private String codiceAttivitaAggregazione;
	private Integer idFlussoOriginaleAggregazione;
	private Integer idMacroarea;
	private HashMap<Integer,Attivita> figli = new HashMap<Integer,Attivita>();
	
	public Aggregazione(){}
	
	public Aggregazione(ResultSet rs) throws SQLException
	{
		setIdAggregazione(rs.getInt("id_aggregazione"));
		setCodiceAttivitaAggregazione(rs.getString("codice_attivita_aggregazione"));
		setAggregazione(rs.getString("aggregazione"));
		setIdFlussoOriginaleAggregazione(rs.getInt("id_flusso_originale_aggregazione"));
		setIdMacroarea(rs.getInt("id_macroarea"));

	}
	public static Aggregazione getByOid(Integer oid, Connection conn) throws Exception
	{
		PreparedStatement pst = null;
		ResultSet rs = null;
		Aggregazione toRet = null;
		
		try
		{
			pst = conn.prepareStatement("select * from  MASTER_LIST_DENORM where id_aggregazione = ?");
			pst.setInt(1, oid);
			rs = pst.executeQuery();
			rs.next();
			toRet = new Aggregazione(rs);
			return toRet;
		}
		catch(Exception ex)
		{
			throw ex;
		}
		finally
		{
			try{pst.close();}catch(Exception ex){}
			try{rs.close();}catch(Exception ex){}
		}
	}
	
	public void addFiglio(Attivita toAdd)
	{
		this.figli.put(toAdd.getIdLineaAttivita(),toAdd);
	}
	
	public JSONObject asJSONOb()
	{

		JSONObject ob = new JSONObject();
		
		
		ob.put("desc", getAggregazione());
		ob.put("id", getIdAggregazione()+"");
		ob.put("campi_estesi", new JSONObject()); /*non e' necessario popolarli qui */
		
		JSONObject figliAsJSONOb = new JSONObject();
		for(Map.Entry<Integer, Attivita> figlio : figli.entrySet())
		{
			figliAsJSONOb.put (figlio.getKey()+"", figlio.getValue() .asJSONOb() );
		}
		
		ob.put("figli", figliAsJSONOb); /*no figli oltre terzo livello per ora */
		
		
		return ob;
	
	}
}
