package org.aspcfs.modules.mu_wkf.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PathWKF {

	private int idStato = -1;
	private int idPath = -1;
	private int idProssimoStato = -1;
	
	
	private boolean buildSteps = true;
	private boolean buildFields = true;

	public int getIdStato() {
		return idStato;
	}

	public void setIdStato(int idStato) {
		this.idStato = idStato;
	}

	public int getIdPath() {
		return idPath;
	}

	public void setIdPath(int idPath) {
		this.idPath = idPath;
	}

	public int getIdProssimoStato() {
		return idProssimoStato;
	}

	public void setIdProssimoStato(int idProssimoStato) {
		this.idProssimoStato = idProssimoStato;
	}

	public  ArrayList<Path> getListaPaths(Connection db) {
		ArrayList<Path> listaPossibiliPaths = new ArrayList<Path>();
		String query = "select * from mu_paths_wkf w left join mu_paths p"
				+ " on (w.id_path = p.id) where id_stato = ? and p.enabled = true";
		try {
			PreparedStatement pst = db.prepareStatement(query);
			pst.setInt(1, idStato);
			
			
			ResultSet rs = pst.executeQuery();

			while (rs.next()){
				int idPath = rs.getInt("id_path");
				Path thisPath = new Path(idPath, db, buildSteps, buildFields);
				listaPossibiliPaths.add(thisPath);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return listaPossibiliPaths;
	}
	
	
	
	public  int getProssimoStato(Connection db) {
		int idProssimoStato = -1;
		
		String query = "select * from mu_paths_wkf w "
				+ " where id_stato = ? and id_path = ?";
		try {
			PreparedStatement pst = db.prepareStatement(query);
			pst.setInt(1, idStato);
			pst.setInt(2, idPath);
			
			
			ResultSet rs = pst.executeQuery();

			if (rs.next()){
				idProssimoStato = rs.getInt("id_prossimo_stato");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return idProssimoStato;
	}

}
