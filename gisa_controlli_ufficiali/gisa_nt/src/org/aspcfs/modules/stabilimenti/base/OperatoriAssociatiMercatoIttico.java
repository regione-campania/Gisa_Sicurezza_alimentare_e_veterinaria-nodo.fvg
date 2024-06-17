package org.aspcfs.modules.stabilimenti.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import org.aspcfs.modules.accounts.base.Organization;

public class OperatoriAssociatiMercatoIttico {

	public static final int TIPO_IMPRESA = 1;
	public static final int TIPO_STABILIMENTO = 3;
	public static final int TIPO_STABILIMENTO_OPU = 999;

	
	private int id = -1;
	private int idMercatoIttico = -1;
	private int idOperatore = -1;
	private int tipo = -1;
	private Timestamp entered;
	private int entered_by = -1;
	private String contenitoreMercatoIttico ; 
	private Organization impresa;
	private org.aspcfs.modules.stabilimenti.base.Organization stabilimento;
	
	
	public String getContenitoreMercatoIttico() {
		return contenitoreMercatoIttico;
	}

	public void setContenitoreMercatoIttico(String contenitoreMercatoIttico) {
		this.contenitoreMercatoIttico = contenitoreMercatoIttico;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdMercatoIttico() {
		return idMercatoIttico;
	}

	public void setIdMercatoIttico(int idMercatoIttico) {
		this.idMercatoIttico = idMercatoIttico;
	}

	public int getIdOperatore() {
		return idOperatore;
	}

	public void setIdOperatore(int idOperatore) {
		this.idOperatore = idOperatore;
	}

	public int getTipo() {
		return tipo;
	}

	public void setTipo(int tipo) {
		this.tipo = tipo;
	}

	public Timestamp getEntered() {
		return entered;
	}

	public void setEntered(Timestamp entered) {
		this.entered = entered;
	}

	public int getEntered_by() {
		return entered_by;
	}

	public void setEntered_by(int enteredBy) {
		entered_by = enteredBy;
	}
	
	public Organization getImpresa() {
		return impresa;
	}

	public org.aspcfs.modules.stabilimenti.base.Organization getStabilimento() {
		return stabilimento;
	}

	public void store (Connection db) throws SQLException 
	{
		String sql = "INSERT INTO operatori_associati_mercato_ittico(id_mercato_ittico, id_operatore, tipo_operatore, entered_by,contenitore_mercato_ittico) VALUES (?, ?, ?,?,?);";
		PreparedStatement pst = db.prepareStatement(sql);
		
		pst.setInt(1, idMercatoIttico);
		pst.setInt(2, idOperatore);
		pst.setInt(3, tipo);
		pst.setInt(4, entered_by);
		pst.setString(5, contenitoreMercatoIttico);
		
		pst.execute();
	}
	
	public static void delete(Connection db, int id) throws SQLException 
	{
		String sql = "delete from operatori_associati_mercato_ittico where id = ? ";
		PreparedStatement pst = db.prepareStatement(sql);
		pst.setInt(1, id);
		pst.execute();
		
	}
	

	
	public static ArrayList<OperatoriAssociatiMercatoIttico> getOperatoriImpreseById(Connection db,int idMercatoIttico) throws SQLException
	{
		ArrayList<OperatoriAssociatiMercatoIttico> ret = new ArrayList<OperatoriAssociatiMercatoIttico>();
		
		String sql = "select o.*,oo.employees from operatori_associati_mercato_ittico o join organization oo on oo.org_id =o.id_operatore  where id_mercato_ittico = ? and tipo_operatore = ? and contenitore_mercato_ittico ilike 'organization' order by employees";
		PreparedStatement pst = db.prepareStatement(sql);
		pst.setInt(1, idMercatoIttico);
		pst.setInt(2, TIPO_IMPRESA);
		ResultSet rs = pst.executeQuery();
		
		
		while (rs.next())
		{
			ret.add( loadRS(db, rs,"organization") );
		}
		
		return ret;
	}
	
	public static ArrayList<OperatoriAssociatiMercatoIttico> getOperatoriImpreseOpuById(Connection db,int idMercatoIttico) throws SQLException
	{
		ArrayList<OperatoriAssociatiMercatoIttico> ret = new ArrayList<OperatoriAssociatiMercatoIttico>();
		
		String sql = "select o.*,oo.employees from operatori_associati_mercato_ittico o join organization oo on oo.org_id =o.id_operatore  where id_mercato_ittico = ? and tipo_operatore = ? and contenitore_mercato_ittico ilike 'opu' order by employees";
		PreparedStatement pst = db.prepareStatement(sql);
		pst.setInt(1, idMercatoIttico);
		pst.setInt(2, TIPO_IMPRESA);
		ResultSet rs = pst.executeQuery();
		
		
		while (rs.next())
		{
			ret.add( loadRS(db, rs,"opu") );
		}
		
		return ret;
	}
	
	public static ArrayList<OperatoriAssociatiMercatoIttico> getOperatoriStabilimentiById(Connection db,int idMercatoIttico) throws SQLException
	{
		ArrayList<OperatoriAssociatiMercatoIttico> ret = new ArrayList<OperatoriAssociatiMercatoIttico>();
		
		String sql = "select o.*,oo.employees from operatori_associati_mercato_ittico o join organization oo on oo.org_id =o.id_operatore  where id_mercato_ittico = ? and tipo_operatore = ? and contenitore_mercato_ittico ilike 'organization' order by employees";
		PreparedStatement pst = db.prepareStatement(sql);
		pst.setInt(1, idMercatoIttico);
		pst.setInt(2, TIPO_STABILIMENTO);
		ResultSet rs = pst.executeQuery();
		
		
		while (rs.next())
		{
			ret.add( loadRS(db, rs,"organization") );
		}
		
		return ret;
	}
	
	
	public static ArrayList<OperatoriAssociatiMercatoIttico> getOperatoriStabilimentiOpuById(Connection db,int idMercatoIttico) throws SQLException
	{
		ArrayList<OperatoriAssociatiMercatoIttico> ret = new ArrayList<OperatoriAssociatiMercatoIttico>();
		
		String sql = "select o.*,oo.employees from operatori_associati_mercato_ittico o join organization oo on oo.org_id =o.id_operatore  where id_mercato_ittico = ? and tipo_operatore = ? and contenitore_mercato_ittico ilike 'opu' order by employees";
		PreparedStatement pst = db.prepareStatement(sql);
		pst.setInt(1, idMercatoIttico);
		pst.setInt(2, TIPO_STABILIMENTO);
		ResultSet rs = pst.executeQuery();
		
		
		while (rs.next())
		{
			ret.add( loadRS(db, rs,"opu") );
		}
		
		return ret;
	}
	
	


	private static OperatoriAssociatiMercatoIttico loadRS(Connection db, ResultSet rs,String contenitoreMercatoIttico) throws SQLException
	{
		OperatoriAssociatiMercatoIttico ret = new OperatoriAssociatiMercatoIttico();
		
		ret.setId(rs.getInt("id"));
		ret.setIdMercatoIttico(rs.getInt("id_mercato_ittico"));
		ret.setIdOperatore(rs.getInt("id_operatore"));
		ret.setTipo(rs.getInt("tipo_operatore"));
		ret.setEntered(rs.getTimestamp("entered"));
		ret.setEntered_by(rs.getInt("entered_by"));
		
		if (ret.getTipo()==TIPO_IMPRESA)
		{
			ret.impresa = new Organization(db, ret.getIdOperatore());
			ret.stabilimento = null;
		} 
		else 
		{
			ret.impresa = null;
			ret.stabilimento = new org.aspcfs.modules.stabilimenti.base.Organization(db, ret.getIdOperatore(),contenitoreMercatoIttico);
		}
		
		
		return ret;
	}
	
	public static int getIdMercatoItticoDaOperatore(Connection db,int idOperatore,String contenitoreMercatoIttico) 
	{
		int ret = -1;
		
		String sql = "select distinct id_mercato_ittico from operatori_associati_mercato_ittico where id_operatore = ? and contenitore_mercato_ittico ilike ?";
		PreparedStatement pst;
		try {
			pst = db.prepareStatement(sql);
			pst.setInt(1, idOperatore);
			pst.setString(2, contenitoreMercatoIttico);
			ResultSet rs = pst.executeQuery();
			
			if (rs.next())
				ret = rs.getInt(1);
			else
				ret = -1;
			
			rs.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return ret;
	}
	
	
}
