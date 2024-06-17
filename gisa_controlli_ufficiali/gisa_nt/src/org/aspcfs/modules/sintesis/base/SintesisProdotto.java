package org.aspcfs.modules.sintesis.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.darkhorseventures.framework.beans.GenericBean;

public class SintesisProdotto extends GenericBean {
	
	
	
	private int id = -1;
	private int idLinea = -1;
	private int idProdotto = -1;
	private String valoreProdotto = "";
	
	private Timestamp checkedDate = null;
	private Timestamp uncheckedDate = null;
	
	private boolean checked = false;
    private String origine = "sintesis";
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdLinea() {
		return idLinea;
	}

	public void setIdLinea(int idLinea) {
		this.idLinea = idLinea;
	}


	public String getValoreProdotto() {
		if (valoreProdotto==null)
			return "";
		return valoreProdotto;
	}

	public void setValoreProdotto(String valoreProdotto) {
		if (valoreProdotto == null)
			this.valoreProdotto = "";
		else
			this.valoreProdotto = valoreProdotto;
	}

	public Timestamp getCheckedDate() {
		return checkedDate;
	}

	public void setCheckedDate(Timestamp checkedDate) {
		this.checkedDate = checkedDate;
	}

	public Timestamp getUncheckedDate() {
		return uncheckedDate;
	}

	public void setUncheckedDate(Timestamp uncheckedDate) {
		this.uncheckedDate = uncheckedDate;
	}

	public int getIdProdotto() {
		return idProdotto;
	}

	public void setIdProdotto(int idProdotto) {
		this.idProdotto = idProdotto;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public SintesisProdotto (ResultSet rs) throws SQLException{
		buildRecord(rs);
	}
	
	public SintesisProdotto() {
		// TODO Auto-generated constructor stub
	}
	public void buildRecord(ResultSet rs) throws SQLException{
		id = rs.getInt("id");
		idLinea = rs.getInt("id_linea");
		idProdotto = rs.getInt("id_prodotto");
		valoreProdotto = rs.getString("valore_prodotto");
		checkedDate = rs.getTimestamp("checked_date");
		uncheckedDate = rs.getTimestamp("unchecked_date");
		checked = (uncheckedDate != null) ? false : true;
		origine = rs.getString("origine");

	}
	public void gestisciUpdate(Connection db) throws SQLException {
		PreparedStatement pst = null;
		SintesisProdotto prod  = null;
		
		PreparedStatement pstEsistenza = db.prepareStatement("select * from sintesis_prodotti where id_prodotto = ? and id_linea = ? and origine = ? ");
		pstEsistenza.setInt(1, idProdotto);
		pstEsistenza.setInt(2, idLinea);
		pstEsistenza.setString(3, origine);

		ResultSet rsEsistenza = pstEsistenza.executeQuery();
		
		if (rsEsistenza.next())
			prod = new SintesisProdotto(rsEsistenza);
						
		if (checked){
			//SE E' SELEZIONATO
			
			
			if (prod!=null && prod.getId()>0 && !valoreProdotto.equalsIgnoreCase(prod.getValoreProdotto())){
				pst = db.prepareStatement("update sintesis_prodotti set unchecked_date = null, checked_date = now(), valore_prodotto = ? where id = ?");
				pst.setString(1, valoreProdotto);
				pst.setInt(2, prod.getId());
				pst.executeUpdate();
			}
			else if (prod!=null && prod.getId()>0){
				pst = db.prepareStatement("update sintesis_prodotti set unchecked_date = null, checked_date = now() where id = ? and unchecked_date is not null");
				pst.setInt(1, prod.getId());
				pst.executeUpdate();
			}
			else {
				pst = db.prepareStatement("insert into sintesis_prodotti (id_linea, id_prodotto, valore_prodotto, origine) values (?, ?, ?, ?)");
				pst.setInt(1, idLinea);
				pst.setInt(2, idProdotto);
				pst.setString(3, valoreProdotto);
				pst.setString(4, origine);
				pst.executeUpdate();
			}
			
			
		}
		else {
			//SE E' DESELEZIONATO
			pst = db.prepareStatement("update sintesis_prodotti set unchecked_date = now() where id_prodotto = ? and id_linea = ? and origine = ? and unchecked_date is null");
			pst.setInt(1, idProdotto);
			pst.setInt(2, idLinea);
			pst.setString(3, origine);
			pst.executeUpdate();
			
		}
		
		
	}

	public static ArrayList<SintesisProdotto> getListaProdottiPerLinea(Connection db, int idLinea, String origine) throws SQLException {
			
		ArrayList<SintesisProdotto> lista = new  ArrayList<SintesisProdotto>();
		PreparedStatement pst = db.prepareStatement("select * from sintesis_prodotti where id_linea = ? and origine = ?");
		pst.setInt(1, idLinea);
		pst.setString(2, origine);
		ResultSet rs = pst.executeQuery();
		while (rs.next()){
					SintesisProdotto prod = new SintesisProdotto(rs);
					lista.add(prod);		
		}
			
			return lista;
	}

	public String getOrigine() {
		return origine;
	}

	public void setOrigine(String origine) {
		this.origine = origine;
	}

}
