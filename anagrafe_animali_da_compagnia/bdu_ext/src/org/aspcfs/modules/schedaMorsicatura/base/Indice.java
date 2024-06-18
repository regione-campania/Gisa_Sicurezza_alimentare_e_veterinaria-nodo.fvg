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

public class Indice extends GenericBean 
{

	private static Logger log = Logger.getLogger(Indice.class);
	static 
	{
		if (System.getProperty("DEBUG") != null) 
		{
			log.setLevel(Level.DEBUG);
		}
	}
	
	private int id;
	private String nome;
	private int punteggio;
	private int level;
	private boolean enabled;
	private int idCriterio;
	private Criterio criterio;
	private boolean valoreManuale;
	private boolean divisore;
	
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
	
	public void setPunteggio(int punteggio) {
		this.punteggio = punteggio;
	}

	public int getPunteggio() {
		return punteggio;
	}
	
	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	
	public boolean isEnabled() {
		return enabled;
	}
	
	public int getIdCriterio() {
		return idCriterio;
	}

	public void setIdCriterio(int idCriterio) {
		this.idCriterio = idCriterio;
	}

	public void setIdCriterio(String idCriterio) {
		this.idCriterio = new Integer(idCriterio).intValue();
	}
	
	public Criterio getCriterio() {
		return criterio;
	}

	public void setCriterio(Criterio criterio) {
		this.criterio = criterio;
	}
	
	public void setValoreManuale(boolean valoreManuale) {
		this.valoreManuale = valoreManuale;
	}
	
	public boolean isValoreManuale() {
		return valoreManuale;
	}
	
	public void setDivisore(boolean divisore) {
		this.divisore = divisore;
	}
	
	public boolean isDivisore() {
		return divisore;
	}

	public ArrayList<Indice> getAll(Connection db) throws SQLException 
	{
		ArrayList<Indice> indici = new ArrayList<Indice>();
		PreparedStatement pst = db.prepareStatement("Select * from lookup_scheda_morsicatura_indici where enabled order by level");
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);
		while (rs.next()) 
		{
			Indice indice = buildRecord(db, rs);
			indici.add(indice);
		}

		rs.close();
		pst.close();
		return indici;
	}

	
	public Indice() throws SQLException 
	{
	}

	private Indice buildRecord(Connection db, ResultSet rs) throws SQLException 
	{
		Indice indice = new Indice();
		indice.setId(rs.getInt("id"));
		indice.setNome(rs.getString("nome"));
		indice.setPunteggio(rs.getInt("punteggio"));
		indice.setEnabled(rs.getBoolean("enabled"));
		indice.setLevel(rs.getInt("level"));
		indice.setIdCriterio(rs.getInt("id_criterio"));
		indice.setValoreManuale(rs.getBoolean("valore_manuale"));
		indice.setDivisore(rs.getBoolean("divisore"));
		if (indice.getIdCriterio() > 0) 
		{
			Criterio criterio = new Criterio();
			indice.setCriterio(criterio.getById(db, indice.getIdCriterio()));
		}
		return indice;
	}
	
	public Indice getById(Connection db, int id) throws SQLException 
	{
		Indice indice = null;
		if (id == -1) 
		{
			throw new SQLException("Invalid Account");
		}

		PreparedStatement pst = db.prepareStatement("Select * from lookup_scheda_morsicatura_indici where id = ?");
		pst.setInt(1, id);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);
		if (rs.next()) 
		{
			indice = buildRecord(db, rs);
		}

		rs.close();
		pst.close();
		
		return indice;
	}
	
	public ArrayList<Indice> getByCriterio(Connection db, int idCriterio) throws SQLException 
	{
		ArrayList<Indice> indici = new ArrayList<Indice>();
		if (id == -1) 
		{
			throw new SQLException("Invalid Account");
		}

		PreparedStatement pst = db.prepareStatement("Select * from lookup_scheda_morsicatura_indici where id_criterio = ?");
		pst.setInt(1, idCriterio);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);
		while (rs.next()) 
		{
			indici.add(buildRecord(db, rs));
		}

		rs.close();
		pst.close();
		
		return indici;
	}

}
