package org.aspcfs.modules.schedaMorsicatura.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.aspcfs.utils.DatabaseUtils;

import com.darkhorseventures.framework.beans.GenericBean;

public class Criterio extends GenericBean 
{

	private static Logger log = Logger.getLogger(Criterio.class);
	static 
	{
		if (System.getProperty("DEBUG") != null) 
		{
			log.setLevel(Level.DEBUG);
		}
	}
	
	private int id;
	private String nome;
	private boolean enabled;
	private int level;
	private String formulaCalcoloPunteggio;
	private ArrayList<Indice> indici = new ArrayList<Indice>();
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	
	public boolean isEnabled() {
		return enabled;
	}
	
	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}
	
	public String getFormulaCalcoloPunteggio() {
		return formulaCalcoloPunteggio;
	}

	public void setFormulaCalcoloPunteggio(String formulaCalcoloPunteggio) {
		this.formulaCalcoloPunteggio = formulaCalcoloPunteggio;
	}
	
	public ArrayList<Indice> getIndici() {
		return indici;
	}

	public void setIndici(ArrayList<Indice> indici) {
		this.indici = indici;
	}

	public Criterio getById(Connection db, int id) throws SQLException 
	{
		Criterio criterio = null;
		if (id == -1) 
		{
			throw new SQLException("Invalid Account");
		}

		PreparedStatement pst = db.prepareStatement("Select * from lookup_scheda_morsicatura_criteri where id = ?");
		pst.setInt(1, id);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);
		if (rs.next()) 
		{
			criterio = buildRecord(db, rs);
		}

		rs.close();
		pst.close();
		
		return criterio;
	}
	
	public ArrayList<Criterio> getAll(Connection db) throws SQLException 
	{
		ArrayList<Criterio> criteri = new ArrayList<Criterio>();
		PreparedStatement pst = db.prepareStatement("Select * from lookup_scheda_morsicatura_criteri where enabled order by level ");
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);
		while (rs.next()) 
		{
			Criterio criterio = buildRecord(db, rs);
			criterio.setIndici(indici);
			criteri.add(criterio);
		}

		rs.close();
		pst.close();
		
		return criteri;
	}

	
	public Criterio(Connection db, ResultSet rs) throws SQLException 
	{
		this.buildRecord(db, rs);
	}
	
	public Criterio() throws SQLException 
	{
	}

	private Criterio buildRecord(Connection db, ResultSet rs) throws SQLException 
	{
		Criterio criterio = new Criterio();
		criterio.setId(rs.getInt("id"));
		criterio.setNome(rs.getString("nome"));
		criterio.setEnabled(rs.getBoolean("enabled"));
		criterio.setLevel(rs.getInt("level"));
		criterio.setFormulaCalcoloPunteggio(rs.getString("formula_calcolo_punteggio"));
		return criterio;
	}

}
