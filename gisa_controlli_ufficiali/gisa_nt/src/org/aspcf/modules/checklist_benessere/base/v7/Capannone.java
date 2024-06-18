package org.aspcf.modules.checklist_benessere.base.v7;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

public class Capannone {

	private int id;
	private int enteredBy;
	private Timestamp entered;
	private int idChkBnsModIst;
	private int indice;
	private String numero;
	private String numFori;
	private String numAnimali;
	private String tipoStruttura;
	private String tipoGabbia;
	private String tipoGabbiaDesc;
	private String ventilazione;
		
	public Capannone(ResultSet rs) throws SQLException {
		this.id = rs.getInt("id");
		this.idChkBnsModIst = rs.getInt("id_chk_bns_mod_ist");
		this.enteredBy = rs.getInt("entered_by");
		this.setEntered(rs.getTimestamp("entered"));
		this.indice = rs.getInt("indice");
		this.numero = rs.getString("numero");
		this.numAnimali = rs.getString("num_animali");
		this.numFori = rs.getString("num_fori");
		this.tipoStruttura = rs.getString("tipo_struttura");
		this.tipoGabbia = rs.getString("tipo_gabbia");
		this.tipoGabbiaDesc = rs.getString("tipo_gabbia_desc");
		this.ventilazione = rs.getString("ventilazione");
			
	}
	public Capannone() {
		// TODO Auto-generated constructor stub
	}
	
	public void insert(Connection db) throws SQLException {
		int i = 0;
		PreparedStatement pst = null;
		pst = db.prepareStatement("insert into chk_bns_capannoni_v7 (id_chk_bns_mod_ist, entered_by, indice, numero, num_animali, num_fori, tipo_struttura, tipo_gabbia, tipo_gabbia_desc, ventilazione) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
		pst.setInt(++i, this.idChkBnsModIst);
		pst.setInt(++i, this.enteredBy);
		pst.setInt(++i, this.indice);
		pst.setString(++i, this.numero);
		pst.setString(++i, this.numAnimali);
		pst.setString(++i, this.numFori);
		pst.setString(++i, this.tipoStruttura);
		pst.setString(++i, this.tipoGabbia);
		pst.setString(++i, this.tipoGabbiaDesc);
		pst.setString(++i, this.ventilazione);		
		pst.executeUpdate();		
	}
	public static ArrayList<Capannone> queryListByIdChkBnsModIst(Connection db, int idChkBnsModIst) throws SQLException {
		ArrayList<Capannone> capannoni = new ArrayList<Capannone>();
		PreparedStatement pst = db.prepareStatement("select * from chk_bns_capannoni_v7 where id_chk_bns_mod_ist = ? and trashed_date is null order by indice asc");
		pst.setInt(1, idChkBnsModIst);
		ResultSet rs = pst.executeQuery();
		while (rs.next()){
			Capannone b = new Capannone(rs);
			capannoni.add(b);
		}
		return capannoni;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getEnteredBy() {
		return enteredBy;
	}
	public void setEnteredBy(int enteredBy) {
		this.enteredBy = enteredBy;
	}
	public Timestamp getEntered() {
		return entered;
	}
	public void setEntered(Timestamp entered) {
		this.entered = entered;
	}
	public int getIdChkBnsModIst() {
		return idChkBnsModIst;
	}
	public void setIdChkBnsModIst(int idChkBnsModIst) {
		this.idChkBnsModIst = idChkBnsModIst;
	}
	public int getIndice() {
		return indice;
	}
	public void setIndice(int indice) {
		this.indice = indice;
	}
	public String getNumero() {
		return numero;
	}
	public void setNumero(String numero) {
		this.numero = numero;
	}
	public String getNumFori() {
		return numFori;
	}
	public void setNumFori(String numFori) {
		this.numFori = numFori;
	}
	public String getNumAnimali() {
		return numAnimali;
	}
	public void setNumAnimali(String numAnimali) {
		this.numAnimali = numAnimali;
	}
	public String getTipoStruttura() {
		return tipoStruttura;
	}
	public void setTipoStruttura(String tipoStruttura) {
		this.tipoStruttura = tipoStruttura;
	}
	public String getTipoGabbia() {
		return tipoGabbia;
	}
	public void setTipoGabbia(String tipoGabbia) {
		this.tipoGabbia = tipoGabbia;
	}
	public String getVentilazione() {
		return ventilazione;
	}
	public void setVentilazione(String ventilazione) {
		this.ventilazione = ventilazione;
	}
	public String getTipoGabbiaDesc() {
		return tipoGabbiaDesc;
	}
	public void setTipoGabbiaDesc(String tipoGabbiaDesc) {
		this.tipoGabbiaDesc = tipoGabbiaDesc;
	}
	
	
	
	
}
