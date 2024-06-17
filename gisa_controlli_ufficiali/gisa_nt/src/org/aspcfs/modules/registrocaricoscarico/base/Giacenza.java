package org.aspcfs.modules.registrocaricoscarico.base;

import java.sql.ResultSet;
import java.sql.SQLException;


public class Giacenza {

	private String matricola = null;
	private String nomeCapo = null;
	private int idTipoSeme = -1;
	private int dosiProdotte = -1;
	private int dosiAcquistate = -1;
	private int dosiVendute = -1;
	private int dosiDistrutte = -1;
	private int giacenza = -1;
		
	public Giacenza() {
	}

	public String getMatricola() {
		return matricola;
	}

	public void setMatricola(String matricola) {
		this.matricola = matricola;
	}

	public int getIdTipoSeme() {
		return idTipoSeme;
	}

	public void setIdTipoSeme(int idTipoSeme) {
		this.idTipoSeme = idTipoSeme;
	}

	public int getGiacenza() {
		return giacenza;
	}

	public void setGiacenza(int giacenza) {
		this.giacenza = giacenza;
	}

	public int getDosiProdotte() {
		return dosiProdotte;
	}

	public void setDosiProdotte(int dosiProdotte) {
		this.dosiProdotte = dosiProdotte;
	}

	public int getDosiAcquistate() {
		return dosiAcquistate;
	}

	public void setDosiAcquistate(int dosiAcquistate) {
		this.dosiAcquistate = dosiAcquistate;
	}

	public int getDosiVendute() {
		return dosiVendute;
	}

	public void setDosiVendute(int dosiVendute) {
		this.dosiVendute = dosiVendute;
	}

	public int getDosiDistrutte() {
		return dosiDistrutte;
	}

	public void setDosiDistrutte(int dosiDistrutte) {
		this.dosiDistrutte = dosiDistrutte;
	}

	public String getNomeCapo() {
		return nomeCapo;
	}

	public void setNomeCapo(String nomeCapo) {
		this.nomeCapo = nomeCapo;
	}

	public void buildRecord(ResultSet rs) throws SQLException {
		try{ if(rs.findColumn("nome_capo")>0) this.nomeCapo = rs.getString("nome_capo"); } catch (SQLException e){}
		try{ if(rs.findColumn("matricola")>0) this.matricola = rs.getString("matricola"); } catch (SQLException e){}
		try{ if(rs.findColumn("id_tipo_seme")>0) this.idTipoSeme = rs.getInt("id_tipo_seme"); } catch (SQLException e){}
		try{ if(rs.findColumn("dosi_prodotte")>0) this.dosiProdotte = rs.getInt("dosi_prodotte"); } catch (SQLException e){}
		try{ if(rs.findColumn("dosi_acquistate")>0) this.dosiAcquistate = rs.getInt("dosi_acquistate"); } catch (SQLException e){}
		try{ if(rs.findColumn("dosi_vendute")>0) this.dosiVendute = rs.getInt("dosi_vendute"); } catch (SQLException e){}
		try{ if(rs.findColumn("dosi_distrutte")>0) this.dosiDistrutte = rs.getInt("dosi_distrutte"); } catch (SQLException e){}
		try{ if(rs.findColumn("giacenza")>0) this.giacenza = rs.getInt("giacenza"); } catch (SQLException e){}

		}
	
	
	
	
}
